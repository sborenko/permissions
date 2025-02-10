unit Permission;

interface

uses
  AppOwned;

type

  TPermission = class(TAppOwned)
  public
    function DataSetName: ShortString; override;
  end;

implementation

//------------------------------------------------------------------------------
function TPermission.DataSetName: ShortString;
begin
  Result := 'Permissions';
end;

end.
