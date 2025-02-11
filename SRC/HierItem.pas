unit HierItem;

interface

uses
  Item;

type
  THierItem = class(TItem)
  public
    function DataSetFields: String; override;
  end;

implementation

uses
  TextLib;

//------------------------------------------------------------------------------
function THierItem.DataSetFields: String;
begin
  Result := TextUtils.ConcatStr(inherited DataSetFields, 'ParentId Int', ', ');
  Result := TextUtils.ConcatStr(Result, 'ItemId Int', ', ')
end;

end.
