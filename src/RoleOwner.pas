unit RoleOwner;

interface

uses
  ChildDataset;

type
  TRoleOwner = class(TChildDataset)

  public
    function DatasetName: ShortString; override;
  end;

implementation

uses
  TextLib;

//------------------------------------------------------------------------------
function TRoleOwner.DatasetName: ShortString;
begin
  Result := ParentDatasetName + 'Roles';
end;

end.
