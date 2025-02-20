unit Role;

interface

uses
  NamedItem;

type
  TRole = class(TNamedItem)
  public
    procedure CreateTable; override;
    procedure DropTable; override;
    function DatasetName: ShortString; override;
  end;

implementation

uses
  App, Hier, Item, List, Permission;

//------------------------------------------------------------------------------
procedure TRole.CreateTable;
var
  Perm, App, Entity: TItem;
begin
  inherited CreateTable;

  // Иерархия ролей
  with THier.Create(Self) do begin
    CreateTable;
    Free;
  end;

  // Список разрешений к приложениям
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
procedure TRole.DropTable;
var
  Perm, App, Entity: TItem;
begin
  with THier.Create(Self) do begin
    DropTable;
    Free;
  end;

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
function TRole.DatasetName: ShortString;
begin
  Result := 'Role';
end;

end.
