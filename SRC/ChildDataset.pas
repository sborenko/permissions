unit ChildDataset;

interface

uses
  Item;

type
  IChildDataset = interface
    function DatasetFields: String;
  end;

  TChildDataset = class(TItem, IChildDataset)
  protected
    ParentDatasetName: ShortString;
  public
    constructor Create(Item: TItem);
    function DatasetFields: String; override;
  end;

implementation

uses
  TextLib;

//------------------------------------------------------------------------------
constructor TChildDataset.Create(Item: TItem);
begin
  Self.ParentDatasetName := Item.DatasetName;
end;

//------------------------------------------------------------------------------
function TChildDataset.DatasetFields: String;
begin
  Result := TextUtils.ConcatStr(
    inherited DatasetFields, 'ParentId Int, ItemId Int', ',');
end;

end.
