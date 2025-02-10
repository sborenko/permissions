unit DModMain;

interface

uses
  DB, DBTables, SysUtils, Classes;

type
  TDmMain = class(TDataModule)
    Database: TDatabase;
    procedure DataModuleCreate(Sender: TObject);
  private
    procedure EmptyDatabase;
  end;

var
  DmMain: TDmMain;

implementation

uses
  App, GroupUser, Permission, Role, RoleHier, RolePermiss, User, UserGroup,
  UsrGrpHier;

{$R *.dfm}

//------------------------------------------------------------------------------
procedure TDmMain.DataModuleCreate(Sender: TObject);
begin
  with Database do begin
    AliasName := 'PERMISSIONS';
    Connected := true;
  end;

  if LowerCase(ParamStr(1)) = 'init' then
    EmptyDatabase;
end;

//------------------------------------------------------------------------------
procedure TDmMain.EmptyDatabase;
begin
  with TApp.Create do begin
    Init;
    Free;
  end;

  with TPermission.Create do begin
    Init;
    Free;
  end;

  with TRole.Create do begin
    Init;
    Free;
  end;

  with TRolePermiss.Create do begin
    Init;
    Free;
  end;

  with TRoleHier.Create do begin
    Init;
    Free;
  end;

  with TUser.Create do begin
    Init;
    Free;
  end;

  with TUserGroup.Create do begin
    Init;
    Free;
  end;

  with TGroupUser.Create do begin
    Init;
    Free;
  end;

  with TUsrGrpHier.Create do begin
    Init;
    Free;
  end;
end;

end.
