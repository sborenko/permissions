program Permissions;

uses
  Forms,
  DateLib in '..\Common\DateLib.pas',
  DsLib in '..\Common\DsLib.pas',
  ParamLib in '..\Common\ParamLib.pas',
  QryLib in '..\Common\QryLib.pas',
  TextLib in '..\Common\TextLib.pas',
  App in 'Src\Types\App.pas',
  Hier in 'SRC\Types\Hier.pas',
  Item in 'Src\Types\Item.pas',
  List in 'SRC\Types\List.pas',
  NamedItem in 'Src\Types\NamedItem.pas',
  Permission in 'Src\Types\Permission.pas',
  Role in 'Src\Types\Role.pas',
  User in 'Src\Types\User.pas',
  UserGroup in 'Src\Types\UserGroup.pas',
  DModMain in 'Src\DModMain.pas' {DataModule1: TDataModule},
  FormMain in 'Src\FormMain.pas' {Form1},
  FormUserList in 'Src\FormUserList.pas' {FrmUsrList},
  FormList in 'Src\FormList.pas',
  FormPermList in 'Src\FormPermList.pas' {FrmPermList},
  FormUsrGrpList in 'Src\FormUsrGrpList.pas' {FrmUsrGrpList},
  TreeMngr in 'Src\TreeMngr.pas',
  DATABASENAME in 'SRC\DATABASENAME.pas',
  CmnSettings in '..\Common\AllApps\CmnSettings.pas',
  PwdTypes in '..\Common\Passwords\PwdTypes.pas',
  VersionInfo in '..\Common\VersionInfo\VersionInfo.pas',
  PermApp in 'SRC\Types\PermApp.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDmMain, DmMain);
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
