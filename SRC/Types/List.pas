unit List;

interface

uses
  Item;

type
  TList = class(TItem)
  private
    Owner, Entity: TItem;
  public
    constructor Create(Owner, Entity: TItem);
    procedure CreateTable; override;

    function DatasetName: ShortString; override;
    function DecorDsName: ShortString; override;
    function FieldDefs: String; override;
  end;

implementation

uses
  TextLib;

//------------------------------------------------------------------------------
constructor TList.Create(Owner, Entity: TItem);
begin
  Self.Owner := Owner;
  Self.Entity := Entity;
end;

//------------------------------------------------------------------------------
procedure TList.CreateTable;
begin
  inherited CreateTable;

  Execute(
    'alter table ' + DecorDsName + ' ' +
      'add foreign key (' + Owner.DatasetName + 'Id) ' +
    'references ' + Owner.DecorDsName + ' (' + Owner.FieldName('Id') + ') ' +
      'on delete cascade'
  );
  Execute(
    'alter table ' + DecorDsName + ' ' +
      'add foreign key (' + Entity.DatasetName + 'Id) ' +
    'references ' + Entity.DecorDsName + ' (' + Entity.FieldName('Id') + ')' +
      'on delete cascade'
  );
end;

//------------------------------------------------------------------------------
function TList.DatasetName: ShortString;
begin
  Result := Owner.DecorDsName + '_' + Entity.DecorDsName;
end;

//------------------------------------------------------------------------------
function TList.DecorDsName: ShortString;
begin
  Result := DatasetName;
end;

//------------------------------------------------------------------------------
function TList.FieldDefs: String;
begin
  Result := inherited FieldDefs;
  // Идентификатор владельца, например, пользователь.
  Result := TextUtils.ConcatStr(Result,
    Owner.DatasetName + 'Id Integer not null', ', ');
  // Идентификатор сущностей, которые образуют список, например разрешения
  Result := TextUtils.ConcatStr(Result,
    Entity.DatasetName + 'Id Integer not null', ', ');
end;

end.
