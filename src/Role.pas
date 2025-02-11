unit Role;

interface

uses
  NamedItem, RoleOwner, PermOwner;

type

  TRole = class(TNamedItem)
  // AppId для пользовательской корневой роли - ноль
  public
    procedure Init; override;
    function DatasetName: ShortString; override;
  end;

implementation

//------------------------------------------------------------------------------
procedure TRole.Init;
begin
  inherited Init;

  with TRoleOwner.Create(Self) do begin
    Init;
    Free;
  end;

  with TPermOwner.Create(Self) do begin
    Init;
    Free;
  end;
end;

//------------------------------------------------------------------------------
function TRole.DatasetName: ShortString;
begin
  Result := 'Roles';
end;

end.
