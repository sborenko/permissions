unit UserOwner;

interface

uses
  ChildDataset;

type
  TUserOwner = class(TChildDataset)
  public
    function DatasetName: ShortString; override;
  end;

implementation

//------------------------------------------------------------------------------
function TUserOwner.DatasetName: ShortString;
begin
  Result := ParentDatasetName + 'Users';
end;

end.
