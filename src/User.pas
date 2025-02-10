unit User;

interface

uses
  RoleOwner;

type

  TUser = class(TRoleOwner)
  public
    function DataSetName: ShortString; override;
    function Generator: ShortString;
    function BeforeInsert: ShortString;
  end;

implementation

//------------------------------------------------------------------------------
function TUser.DataSetName: ShortString;
begin
  Result := 'Users';
end;

//------------------------------------------------------------------------------
function TUser.Generator: ShortString;
begin
  Result :=
    'CREATE SEQUENCE NEW_GENERATOR;'#13#10 +
    'ALTER SEQUENCE NEW_GENERATOR RESTART WITH 0';
end;

//------------------------------------------------------------------------------
function TUser.BeforeInsert: ShortString;
begin
//  Result :=
end;

end.
