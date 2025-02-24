program Permissions;

uses
  Forms,
  DateLib in '..\Common\DateLib.pas',
  DsLib in '..\Common\DsLib.pas',
  CdsLib in '..\Common\CdsLib.pas',
  QryLib in '..\Common\QryLib.pas',
  TextLib in '..\Common\TextLib.pas',
  ParamLib in '..\Common\ParamLib.pas',
  CmnSettings in '..\Common\AllApps\CmnSettings.pas',
  PwdTypes in '..\Common\Passwords\PwdTypes.pas',
  VersionInfo in '..\Common\VersionInfo\VersionInfo.pas',
  App in '..\Common\Permissions\App.pas',
  Hier in '..\Common\Permissions\Hier.pas',
  Item in '..\Common\Permissions\Item.pas',
  List in '..\Common\Permissions\List.pas',
  NamedItem in '..\Common\Permissions\NamedItem.pas',
  Permission in '..\Common\Permissions\Permission.pas',
  Role in '..\Common\Permissions\Role.pas',
  User in '..\Common\Permissions\User.pas',
  UserGroup in '..\Common\Permissions\UserGroup.pas',
  DATABASENAME in 'SRC\DATABASENAME.pas',
  DModMain in 'Src\DModMain.pas' {DataModule1: TDataModule},
  FormMain in 'Src\FormMain.pas' {Form1},
  FormUserList in 'Src\FormUserList.pas' {FrmUsrList},
  FormList in 'Src\FormList.pas',
  FormPermList in 'Src\FormPermList.pas' {FrmPermList},
  FormUsrGrpList in 'Src\FormUsrGrpList.pas' {FrmUsrGrpList},
  TreeMngr in 'Src\TreeMngr.pas',
  FormRoleList in 'SRC\FormRoleList.pas' {FrmRoleList},
  FormEditPerm in 'SRC\FormEditPerm.pas' {FrmEditPerm},
  CustCheckListBox in 'SRC\CustCheckListBox.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDmMain, DmMain);
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
