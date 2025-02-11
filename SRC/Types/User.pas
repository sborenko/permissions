unit User;

interface

uses
  NamedItem;

type
  TUser = class(TNamedItem)
  protected
    function MapFieldName(Name: ShortString): ShortString; override;
  public
    procedure CreateTable; override;
    procedure DropTable; override;
    function DatasetName: ShortString; override;
  end;

implementation

uses
  Item, Role, Permission, List, SysUtils;

//------------------------------------------------------------------------------
procedure TUser.CreateTable;
var
  Entity: TItem;
begin
  inherited CreateTable;

  Entity := TRole.Create;
  with TList.Create(Self, Entity) do begin
    CreateTable;
    Free;
  end;
  Entity.Free;

  Entity := TPermis.Create;
  with TList.Create(Self, Entity) do begin
    CreateTable;
    Free;
  end;
  Entity.Free;
end;

//------------------------------------------------------------------------------
procedure TUser.DropTable;
var
  Entity: TItem;
begin
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
function TUser.DatasetName: ShortString;
begin
  // Result := 'Users';
  // Äëÿ ÎÏÈ
  Result := 'Usrs';
end;

//------------------------------------------------------------------------------
function TUser.MapFieldName(Name: ShortString): ShortString;
begin
  // Äëÿ ÎÏÈ
  if Name = 'Id' then
    Result := 'KdUsr'
  else if Name = 'Name' then
    Result := 'NmUsr'
  else
    Result := Name;
end;

end.
