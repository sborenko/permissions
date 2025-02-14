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
  App, PermApp, Permission, Role, User, UserGroup,
  Hier;

{$R *.dfm}

//------------------------------------------------------------------------------
procedure TDmMain.DataModuleCreate(Sender: TObject);
begin
  with Database do begin
    AliasName := 'PERMISSIONS';
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
  PermApp: TPermApp;
  Perm: TPerm;
  App: TApp;
begin
  // Готовим объекты
  UsrGroup := TUsrGroup.Create;
  User := TUser.Create;
  Role := TRole.Create;
  PermApp := TPermApp.Create;
  Perm := TPerm.Create;
  App := TApp.Create;

  // Удаляем, начиная со сложных объектов
  UsrGroup.DropTable;
  User.DropTable;
  Role.DropTable;
  PermApp.DropTable;
  Perm.DropTable;
  App.DropTable;

  // Создаём, начиная с простых
  {
  App.CreateTable;
  Perm.CreateTable;
  PermApp.CreateTable;
  Role.CreateTable;
  User.CreateTable;
  UsrGroup.CreateTable;
  }

  // Освобождаем память
  UsrGroup.Free;
  User.Free;
  Role.Free;
  Perm.Free;
  App.Free;
  PermApp.Free;
end;

end.
