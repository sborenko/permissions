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
    'alter table ' + DatasetName + ' ' +
      'add foreign key (OwnerId) references ' + Owner.DatasetName +
        ' (' + Owner.FieldName('Id') + ') ' +
      'on delete cascade'
  );
  Execute(
    'alter table ' + DatasetName + ' ' +
      'add foreign key (EntityId) references ' + Entity.DatasetName +
        ' (' + Entity.FieldName('Id') + ')' +
      'on delete cascade'
  );
end;

//------------------------------------------------------------------------------
function TList.DatasetName: ShortString;
begin
  Result := Owner.DatasetName + '_' + Entity.DatasetName;
end;

//------------------------------------------------------------------------------
function TList.FieldDefs: String;
begin
  Result := inherited FieldDefs;
  // Идентификатор владельца, например, пользователь.
  Result := TextUtils.ConcatStr(Result, 'OwnerId Integer not null', ', ');
  // Идентификатор сущностей, которые образуют список, например разрешения
  Result := TextUtils.ConcatStr(Result, 'EntityId Integer not null', ', ');
end;

end.
