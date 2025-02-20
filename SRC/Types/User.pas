unit User;

interface

uses
  NamedItem;

type
  TUser = class(TNamedItem)
  public
    procedure CreateTable; override;
    procedure DropTable; override;

    function DatasetName: ShortString; override;
    function DecorDsName: ShortString; override;
    
    function FieldName(Name: ShortString): ShortString; override;
  end;

implementation

uses
  App, Item, Permission, Role, List, SysUtils;

//------------------------------------------------------------------------------
procedure TUser.CreateTable;
var
  Perm, App, Entity: TItem;
begin
  // Не создаём, пользуемся OPI'шной
  // inherited CreateTable;

  // Список ролей
  Entity := TRole.Create;
  with TList.Create(Self, Entity) do begin
    CreateTable;
    Free;
  end;
  Entity.Free;

  // Список разрешений к приложениям
  Perm := TPerm.Create;
  App := TApp.Create;
  Entity := TList.Create(Perm, App);
  with TList.Create(Self, Entity) do begin
    CreateTable;
    Free;
  end;
  Perm.Free;
  App.Free;
  Entity.Free;
end;

//------------------------------------------------------------------------------
procedure TUser.DropTable;
var
  Perm, App, Entity: TItem;
begin
  Entity := TRole.Create;
  with TList.Create(Self, Entity) do begin
    DropTable;
    Free;
  end;
  Entity.Free;

  Perm := TPerm.Create;
  App := TApp.Create;
  Entity := TList.Create(Perm, App);
  with TList.Create(Self, Entity) do begin
    DropTable;
    Free;
  end;
  Perm.Free;
  App.Free;
  Entity.Free;

  // Не удаляем, она же - OPI'шная
  // inherited DropTable;
end;

//------------------------------------------------------------------------------
function TUser.DatasetName: ShortString;
begin
  // Result := 'Usr';
  // Для ОПИ
  Result := 'Usrs';
end;

//------------------------------------------------------------------------------
function TUser.DecorDsName: ShortString;
begin
  Result := DatasetName;
end;

//------------------------------------------------------------------------------
function TUser.FieldName(Name: ShortString): ShortString;
begin
  // Для ОПИ
  if Name = 'Id' then
    Result := 'KdUsr'
  else if Name = 'Name' then
    Result := 'NmUsr'
  else
    Result := Name;
end;

end.
