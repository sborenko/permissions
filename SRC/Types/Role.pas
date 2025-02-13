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
  Hier, Item, List, Permission;

//------------------------------------------------------------------------------
procedure TRole.CreateTable;
var
  Entity: TItem;
begin
  inherited CreateTable;

  with THier.Create(Self) do begin
    CreateTable;
    Free;
  end;

  Entity := TPerm.Create;
  with TList.Create(Self, Entity) do begin
    CreateTable;
    Free;
  end;
  Entity.Free;
end;

//------------------------------------------------------------------------------
procedure TRole.DropTable;
var
  Perm: TItem;
begin
  with THier.Create(Self) do begin
    DropTable;
    Free;
  end;

  Perm := TPerm.Create;
  with TList.Create(Self, Perm) do begin
    DropTable;
    Free;
  end;
  Perm.Free;

  inherited DropTable;
end;

//------------------------------------------------------------------------------
function TRole.DatasetName: ShortString;
begin
  Result := 'Role';
end;

end.
