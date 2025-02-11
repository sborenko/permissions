unit UserGroup;

interface

uses
  NamedItem;

type

  TUserGroup = class(TNamedItem)
  public
    procedure Init; override;
    function DataSetName: ShortString; override;
  end;

implementation

uses
  UserOwner, RoleOwner, PermOwner;

//------------------------------------------------------------------------------
procedure TUserGroup.Init;
begin
  inherited Init;

  with TUserOwner.Create(Self) do begin
    Init;
    Free;
  end;

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
function TUserGroup.DataSetName: ShortString;
begin
  Result := 'UserGroups';
end;

end.
