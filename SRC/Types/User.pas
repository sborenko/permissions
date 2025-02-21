unit User;

interface

uses
  Db, DbTables, NamedItem;

type
  TUser = class(TNamedItem)
  private
    QryUsrs: TQuery;

    procedure PrepDataSets;
    procedure FreeDataSets;

    procedure PrepUsrsQry;

    procedure OpenUsrs;
  public
    class function Open: TUser;
    class procedure Release(User: TUser);

    function GetUsrs: TDataSet;

    procedure CreateTable; override;
    procedure DropTable; override;

    function DatasetName: ShortString; override;
    function DecorDsName: ShortString; override;

    function FieldName(Name: ShortString): ShortString; override;
  end;

implementation

uses
  App, Item, Permission, Role, List, QryLib, SysUtils;

//------------------------------------------------------------------------------
class function TUser.Open: TUser;
begin
  Result := TUser.Create;

  with Result do begin
    PrepDataSets;
    OpenUsrs;
  end;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
class procedure TUser.Release(User: TUser);
begin
  with User do begin
    FreeDataSets;
//    FreeDataObjs;
    Free;
  end;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
procedure TUser.PrepDataSets;
begin
  PrepUsrsQry;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
procedure TUser.FreeDataSets;
begin
  QryUsrs.Free;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
procedure TUser.PrepUsrsQry;
begin
  QryUsrs := TQuery.Create(nil);
  QryUtils.InitQuery(QryUsrs);

  with QryUsrs do begin
    SQL.Text :=
      'select * ' +
      'from ' + DecorDsName + ' ' +
      'where Vkl = "Y"';
    Prepare;
  end;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
procedure TUser.OpenUsrs;
begin
  QryUsrs.Open;
end;

//------------------------------------------------------------------------------
// Доступ к данным
//------------------------------------------------------------------------------
function TUser.GetUsrs: TDataSet;
begin
  Result := QryUsrs;
end;

//------------------------------------------------------------------------------
procedure TUser.CreateTable;
var
  Perm, App, Entity: TItem;
begin
  // Не создаём, пользуемся OPI'шной
  // inherited CreateTable;

  // Список ролей
  Entity := TRole.Create;
  with TItemList.Create(Self, Entity) do begin
    CreateTable;
    Free;
  end;
  Entity.Free;

  // Список разрешений к приложениям
  Perm := TPerm.Create;
  App := TApp.Create;
  Entity := TItemList.Create(Perm, App);
  with TItemList.Create(Self, Entity) do begin
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
  with TItemList.Create(Self, Entity) do begin
    DropTable;
    Free;
  end;
  Entity.Free;

  Perm := TPerm.Create;
  App := TApp.Create;
  Entity := TItemList.Create(Perm, App);
  with TItemList.Create(Self, Entity) do begin
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
