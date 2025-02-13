unit Hier;

interface

uses
  Item;

type

  THier = class(TItem)
  private
    Entity: TItem;
  protected
    function DatasetFields: String; override;
  public
    constructor Create(Entity: TItem);
    procedure CreateTable; override;
    function DatasetName: ShortString; override;
  end;

implementation

uses
  TextLib;

//------------------------------------------------------------------------------
constructor THier.Create(Entity: TItem);
begin
  Self.Entity := Entity;
end;

//------------------------------------------------------------------------------
procedure THier.CreateTable;
begin
  inherited CreateTable;

  Execute(
    'alter table ' + DatasetName + ' ' +
      'add foreign key (EntityId) references ' + Entity.DatasetName +
        ' (' + Entity.FieldName('Id') + ')' +
      'on delete cascade'
  );
  Execute(
    'alter table ' + DatasetName + ' ' +
      'add foreign key (ParentId) references ' + DatasetName +
        ' (' + FieldName('Id') + ') ' +
      'on delete cascade'
  );
end;

//------------------------------------------------------------------------------
function THier.DatasetName: ShortString;
begin
  Result := Entity.DatasetName + 'Hier';
end;

//------------------------------------------------------------------------------
function THier.DatasetFields: String;
begin
  Result := inherited DatasetFields;
  // Идентификатор родительского элемента
  Result := TextUtils.ConcatStr(Result, 'ParentId Integer not null' , ', ');
  // Идентификатор сущности, например, роль или группа пользователей,
  // которых могут создавать иерархии
  Result := TextUtils.ConcatStr(Result, 'EntityId Integer not null' , ', ');
end;

end.
