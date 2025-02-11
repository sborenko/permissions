unit User;

interface

uses
  NamedItem;

type
  TUser = class(TNamedItem)
  public
    procedure Init; override;
    function DatasetName: ShortString; override;
  end;

implementation

uses
  RoleOwner, PermOwner;

//------------------------------------------------------------------------------
procedure TUser.Init;
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
function TUser.DatasetName: ShortString;
begin
  Result := 'Users';
end;

end.
