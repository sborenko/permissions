unit List;

interface

uses
  Item;

type
  TItemList = class(TItem)
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
constructor TItemList.Create(Owner, Entity: TItem);
begin
  Self.Owner := Owner;
  Self.Entity := Entity;
end;

//------------------------------------------------------------------------------
procedure TItemList.CreateTable;
begin
  inherited CreateTable;

  Execute(
    'alter table ' + DecorDsName + ' ' +
      'add foreign key (' + Owner.RefFldName + ') ' +
    'references ' + Owner.DecorDsName + ' (' + Owner.FieldName('Id') + ') ' +
      'on delete cascade'
  );
  Execute(
    'alter table ' + DecorDsName + ' ' +
      'add foreign key (' + Entity.RefFldName + ') ' +
    'references ' + Entity.DecorDsName + ' (' + Entity.FieldName('Id') + ')' +
      'on delete cascade'
  );
end;

//------------------------------------------------------------------------------
function TItemList.DatasetName: ShortString;
begin
  Result := Owner.DecorDsName + '_' + Entity.DecorDsName;
end;

//------------------------------------------------------------------------------
function TItemList.DecorDsName: ShortString;
begin
  Result := DatasetName;
end;

//------------------------------------------------------------------------------
function TItemList.FieldDefs: String;
begin
  Result := inherited FieldDefs;
  // Идентификатор владельца, например, пользователь.
  Result := TextUtils.ConcatStr(Result,
    Owner.RefFldName + ' Integer not null', ', ');
  // Идентификатор сущностей, которые образуют список, например разрешения
  Result := TextUtils.ConcatStr(Result,
    Entity.RefFldName + ' Integer not null', ', ');
end;

end.
