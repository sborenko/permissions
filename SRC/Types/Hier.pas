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
function THier.DatasetName: ShortString;
begin
  Result := Entity.DatasetName + 'Hier';
end;

//------------------------------------------------------------------------------
function THier.DatasetFields: String;
begin
  Result := inherited DatasetFields;
  // Идентификатор родительского элемента
  Result := TextUtils.ConcatStr('ParentId Int' , ', ');
  // Идентификатор сущности, например, роль или группа пользователей,
  // которых могут создавать иерархии
  Result := TextUtils.ConcatStr('EntityId Int' , ', ');
end;

end.
