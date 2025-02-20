unit DModMain;

interface

uses
  DB, DBTables, SysUtils, Classes;

type
  TDmMain = class(TDataModule)
    Database: TDatabase;
    procedure DataModuleCreate(Sender: TObject);
  private
    procedure InitDatabase;
  end;

var
  DmMain: TDmMain;

implementation

uses
  App, DATABASENAME, Hier, Permission, Role, User, UserGroup;

{$R *.dfm}

//------------------------------------------------------------------------------
procedure TDmMain.DataModuleCreate(Sender: TObject);
begin
  with Database do begin
    AliasName := DATABASE_ALIAS;
    DatabaseName := DATABASE_NAME;
    Connected := true;
  end;

  if LowerCase(ParamStr(1)) = 'init' then
    InitDatabase;
end;

//------------------------------------------------------------------------------
procedure TDmMain.InitDatabase;
var
  UsrGroup: TUsrGroup;
  User: TUser;
  Role: TRole;
  Perm: TPerm;
  App: TApp;
begin
  // ������� �������
  UsrGroup := TUsrGroup.Create;
  User := TUser.Create;
  Role := TRole.Create;
  Perm := TPerm.Create;
  App := TApp.Create;

  // �������, ������� �� ������� ��������
  {
  UsrGroup.DropTable;
  User.DropTable;
  Role.DropTable;
  Perm.DropTable;
  // �� �������, ��� �� - OPI'����
  // App.DropTable;
  }

  // ������, ������� � �������
  {
  // �� ������. ���������� OPI'����
  // App.CreateTable;
  Perm.CreateTable;
  Role.CreateTable;
  User.CreateTable;
  UsrGroup.CreateTable;
  }

  // ������� �������
  UsrGroup.Free;
  User.Free;
  Role.Free;
  Perm.Free;
  App.Free;
end;

end.
