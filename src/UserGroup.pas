unit UserGroup;

interface

uses
  RoleOwner;

type

  TUserGroup = class(TRoleOwner)
  public
    function DataSetName: ShortString; override;
  end;
  
implementation

//------------------------------------------------------------------------------
function TUserGroup.DataSetName: ShortString;
begin
  Result := 'UserGroups';
end;

end.
