program Permissions;

uses
  Forms,
  TextLib in '..\Common\TextLib.pas',
  ParamLib in '..\Common\ParamLib.pas',
  FormMain in 'Src\FormMain.pas' {Form1},
  DModMain in 'Src\DModMain.pas' {DataModule1: TDataModule},
  TreeMngr in 'Src\TreeMngr.pas',
  App in 'Src\App.pas',
  Item in 'Src\Item.pas',
  NamedItem in 'Src\NamedItem.pas',
  AppOwned in 'Src\AppOwned.pas',
  Permission in 'Src\Permission.pas',
  Role in 'Src\Role.pas',
  RoleChild in 'Src\RoleChild.pas',
  RoleHier in 'Src\RoleHier.pas',
  RoleOwner in 'Src\RoleOwner.pas',
  User in 'Src\User.pas',
  UserGroup in 'Src\UserGroup.pas',
  UsrGrpChild in 'Src\UsrGrpChild.pas',
  GroupUser in 'Src\GroupUser.pas',
  UsrGrpHier in 'Src\UsrGrpHier.pas',
  FormUserList in 'Src\FormUserList.pas' {FrmUsrList},
  FormUsrGrpList in 'Src\FormUsrGrpList.pas' {FrmUsrGrpList},
  FormList in 'Src\FormList.pas',
  PermApps in 'Src\PermApps.pas',
  FormPermList in 'Src\FormPermList.pas' {FormPermissions},
  QryLib in '..\Common\QryLib.pas',
  DateLib in '..\Common\DateLib.pas',
  DsLib in '..\Common\DsLib.pas',
  DATABASENAME in 'SRC\DATABASENAME.pas',
  CmnSettings in '..\Common\AllApps\CmnSettings.pas',
  PwdTypes in '..\Common\Passwords\PwdTypes.pas',
  VersionInfo in '..\Common\VersionInfo\VersionInfo.pas',
  HierItem in 'SRC\HierItem.pas',
  ChildDataset in 'SRC\ChildDataset.pas',
  PermOwner in 'SRC\PermOwner.pas',
  UserOwner in 'SRC\UserOwner.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDmMain, DmMain);
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TFormPermissions, FormPermissions);
  Application.Run;
end.
