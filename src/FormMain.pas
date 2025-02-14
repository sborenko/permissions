unit FormMain;

interface

uses
  ActnList, Classes, ComCtrls, Controls, Dialogs, Forms, Graphics, Menus,
  Messages, ShellApi, SysUtils, Variants, Windows;

type
  TFrmMain = class(TForm)
    ActionList: TActionList;
    ActApplications: TAction;
    ActPermissions: TAction;
    ActRoles: TAction;
    ActUserGroups: TAction;
    ActUsers: TAction;
    MainMenu: TMainMenu;
    MnuRefs: TMenuItem;
    MnuApplications: TMenuItem;
    Sep1: TMenuItem;
    MnuUsers: TMenuItem;
    MnuUserGroups: TMenuItem;
    Sep2: TMenuItem;
    MnuPermissions: TMenuItem;
    MnuRoles: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure ActViewUsers(Sender: TObject);
    procedure ActViewUsrGroups(Sender: TObject);
    procedure ActViewPermiss(Sender: TObject);
    procedure ActRolesExecute(Sender: TObject);
  end;

var
  FrmMain: TFrmMain;

implementation

uses
  App, DModMain, FormRoleList, FormUsrGrpList, FormUserList, Permission, Role,
  User, UserGroup, Hier, VersionInfo, FormPermList;

{$R *.dfm}

//------------------------------------------------------------------------------
procedure TFrmMain.FormCreate(Sender: TObject);
begin
  Caption := 'Permissions ' + GetAppVersion;
end;

//------------------------------------------------------------------------------
procedure TFrmMain.ActViewUsers(Sender: TObject);
begin
  if not Assigned(FrmUsrList) then begin
    FrmUsrList := TFrmUsrList.Create(Self);
    FrmUsrList.FormStyle := fsMDIChild;
  end;
end;

//------------------------------------------------------------------------------
procedure TFrmMain.ActViewUsrGroups(Sender: TObject);
begin
  if not Assigned(FrmUsrGrpList) then begin
    FrmUsrGrpList := TFrmUsrGrpList.Create(Self);
    FrmUsrGrpList.FormStyle := fsMDIChild;
  end;
end;

//------------------------------------------------------------------------------
procedure TFrmMain.ActViewPermiss(Sender: TObject);
begin
  TFrmPermList.Create(Self).Show;
end;

procedure TFrmMain.ActRolesExecute(Sender: TObject);
begin
  TFrmRoleList.Create(Self).Show;
end;

end.
