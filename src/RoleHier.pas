unit RoleHier;

interface

uses
  HierItem;

type
  TRoleHier = class(THierItem)
  public
    function DataSetName: ShortString; override;
  end;

implementation

uses
  TextLib;

//------------------------------------------------------------------------------
function TRoleHier.DataSetName: ShortString;
begin
  Result := 'RoleHier';
end;

end.
