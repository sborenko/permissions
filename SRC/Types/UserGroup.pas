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
  Hier, Item, List, Permission, Role, User;

//------------------------------------------------------------------------------
procedure TUsrGroup.CreateTable;
var
  Entity: TItem;
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
  Entity := TPermis.Create;
  with TList.Create(Self, Entity) do begin
    CreateTable;
    Free;
  end;
  Entity.Free;
end;

//------------------------------------------------------------------------------
procedure TUsrGroup.DropTable;
var
  Entity: TItem;
begin
  with THier.Create(Self) do begin
    DropTable;
    Free;
  end;

  Entity := TUser.Create;
  with TList.Create(Self, Entity) do begin
    DropTable;
    Free;
  end;
  Entity.Free;

  Entity := TRole.Create;
  with TList.Create(Self, Entity) do begin
    DropTable;
    Free;
  end;
  Entity.Free;

  Entity := TPermis.Create;
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
  Result := 'UsrGrps';
end;

end.
