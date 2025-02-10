unit Role;

interface

uses
  AppOwned;

type

  TRole = class(TAppOwned)
  // AppId для пользовательской корневой роли - ноль
  public
    function DataSetName: ShortString; override;
  end;

implementation

//------------------------------------------------------------------------------
function TRole.DataSetName: ShortString;
begin
  Result := 'Roles';
end;

end.
