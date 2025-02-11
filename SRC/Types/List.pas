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
    function DatasetName: ShortString; override;
    function DatasetFields: String; override;
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
function TList.DatasetName: ShortString;
begin
  Result := Owner.DatasetName + Entity.DatasetName;
end;

//------------------------------------------------------------------------------
function TList.DatasetFields: String;
begin
  Result := inherited DatasetFields;
  // Идентификатор владельца, например, пользователь.
  Result := TextUtils.ConcatStr(Result, 'OwnerId Int', ', ');
  // Идентификатор сущностей, которые образуют список, например разрешения
  Result := TextUtils.ConcatStr(Result, 'EntityId Int', ', ');
end;

end.
