unit UserGroup;

interface

uses
  NamedItem;

type

  TUsrGroup = class(TNamedItem)
  public
    procedure CreateTable; override;
    procedure DropTable; override;
    function DataSetName: ShortString; override;
  end;

implementation

uses
  App, Hier, Item, List, Permission, Role, User;

//------------------------------------------------------------------------------
procedure TUsrGroup.CreateTable;
var
  Perm, App, Entity: TItem;
begin
  inherited CreateTable;

  // Иерархия групп пользователей
  with THier.Create(Self) do begin
    CreateTable;
    Free;
  end;

  // Список пользователей
  Entity := TUser.Create;
  with TList.Create(Self, Entity) do begin
    CreateTable;
    Free;
  end;
  Entity.Free;

  // Список ролей
  Entity := TRole.Create;
  with TList.Create(Self, Entity) do begin
    CreateTable;
    Free;
  end;
  Entity.Free;

  // Список разрешений
//  Entity := TPermApp.Create;
  Perm := TPerm.Create;
  App := TApp.Create;
  Entity := TList.Create(Perm, App);
  with TList.Create(Self, Entity) do begin
    CreateTable;
    Free;
  end;
  Entity.Free;
end;

//------------------------------------------------------------------------------
procedure TUsrGroup.DropTable;
var
  Perm, App, Entity: TItem;
begin
  // Иерархия групп пользователей
  with THier.Create(Self) do begin
    DropTable;
    Free;
  end;

  // Список пользователей
  Entity := TUser.Create;
  with TList.Create(Self, Entity) do begin
    DropTable;
    Free;
  end;
  Entity.Free;

  // Список ролей
  Entity := TRole.Create;
  with TList.Create(Self, Entity) do begin
    DropTable;
    Free;
  end;
  Entity.Free;

  // Список разрешений к приложениям
//  Entity := TPermApp.Create;
  Perm := TPerm.Create;
  App := TApp.Create;
  Entity := TList.Create(Perm, App);
  with TList.Create(Self, Entity) do begin
    DropTable;
    Free;
  end;
  Entity.Free;

  inherited DropTable;
end;

//------------------------------------------------------------------------------
function TUsrGroup.DataSetName: ShortString;
begin
  Result := 'UsrGrp';
end;

end.
