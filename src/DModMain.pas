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
  App, Permission, Role, User, UserGroup,
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
    EmptyDatabase;
end;

//------------------------------------------------------------------------------
procedure TDmMain.EmptyDatabase;
var
  UsrGroup: TUsrGroup;
  User: TUser;
  Role: TRole;
  Perm: TPermis;
  App: TApp;
begin
  UsrGroup := TUsrGroup.Create;
  User := TUser.Create;
  Role := TRole.Create;
  Perm := TPermis.Create;
  App := TApp.Create;

  // Удаляем, начиная со сложных объектов
  UsrGroup.DropTable;
  User.DropTable;
  Role.DropTable;
  Perm.DropTable;
  App.DropTable;

  App.CreateTable;
  Perm.CreateTable;
  Role.CreateTable;
  User.CreateTable;
  UsrGroup.CreateTable;

  UsrGroup.Free;
  User.Free;
  Role.Free;
  Perm.Free;
  App.Free;
end;

end.
