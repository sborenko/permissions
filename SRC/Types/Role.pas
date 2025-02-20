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
  Hier, Item, List, PermApp;

//------------------------------------------------------------------------------
procedure TRole.CreateTable;
var
  Entity: TItem;
begin
  inherited CreateTable;

  // Иерархия ролей
  with THier.Create(Self) do begin
    CreateTable;
    Free;
  end;

  // Список разрешений к приложениям
  Entity := TPermApp.Create;
  with TList.Create(Self, Entity) do begin
    CreateTable;
    Free;
  end;
  Entity.Free;
end;

//------------------------------------------------------------------------------
procedure TRole.DropTable;
var
  Entity: TItem;
begin
  with THier.Create(Self) do begin
    DropTable;
    Free;
  end;

  Entity := TPermApp.Create;
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
  Result := DATASET_PREFIX + 'Role';
end;

end.
