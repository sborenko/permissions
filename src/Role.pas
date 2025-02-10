unit Role;

interface

uses
  AppOwned;

type

  TRole = class(TAppOwned)
  // AppId ��� ���������������� �������� ���� - ����
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
