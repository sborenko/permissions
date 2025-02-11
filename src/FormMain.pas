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
    procedure ActUsersExecute(Sender: TObject);
    procedure ActUserGroupsExecute(Sender: TObject);
  end;

var
  FrmMain: TFrmMain;

implementation

uses
  App, DModMain, FormUsrGrpList, FormUserList, Permission, Role,
  User, UserGroup, Hier, VersionInfo;

{$R *.dfm}

//------------------------------------------------------------------------------
procedure TFrmMain.FormCreate(Sender: TObject);
var
  Msg: String;
begin
  Application.Title := 'Permissions' + GetAppVersion;

  Msg := '';


  ShowMessage(Msg);
end;

//------------------------------------------------------------------------------
procedure TFrmMain.ActUsersExecute(Sender: TObject);
begin
  if not Assigned(FrmUsrList) then begin
    FrmUsrList := TFrmUsrList.Create(Self);
    FrmUsrList.FormStyle := fsMDIChild;
  end;
end;

//------------------------------------------------------------------------------
procedure TFrmMain.ActUserGroupsExecute(Sender: TObject);
begin
  if not Assigned(FrmUsrGrpList) then begin
    FrmUsrGrpList := TFrmUsrGrpList.Create(Self);
    FrmUsrGrpList.FormStyle := fsMDIChild;
  end;
end;

end.
