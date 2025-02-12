unit Permission;

interface

uses
  Db, DbTables, NamedItem;

type

  TPermis = class(TNamedItem)
  private
    QryPerms, QryAffApps, QryGrantUsrs: TQuery;

    FilterAppId: Integer;

    procedure PrepDataSets;
    procedure FreeDataSets;

    procedure PrepAffAppsQry;
    procedure PrepGrantUsrsQry;
  public
    procedure CreateTable; override;
    procedure DropTable; override;
    function DatasetName: ShortString; override;
    function DatasetFields: String; override;

    procedure SetFilter(AppId: Integer);
    procedure OpenPerms;
    procedure AddPerm(PermRec: TDataSet);
    procedure UpdatePerm(PermRec: TDataSet);
    procedure DeletePerm(PermId: Integer);
    procedure ClosePerms;

    procedure OpenAffApps;
    procedure AddAffectApp(AppId: Integer);
    procedure RevokeApp(AppId: Integer);
    procedure CloseAffectApps;

    procedure OpenGrantUsrs;
    procedure GrantUser(UserId, AppId: Integer);
    procedure RevokePerm(UserId, AppId: Integer);

    procedure ApplyChanges;
    procedure CancelChanges;
  end;

implementation

uses
  App, Item, List, QryLib, TextLib;

//------------------------------------------------------------------------------
procedure TPermis.CreateTable;
var
  Entity: TItem;
begin
  inherited CreateTable;

  // Список приложений, к которым применимо разрешение
  Entity := TApp.Create;
  with TList.Create(Self, Entity) do begin
    CreateTable;
    Free;
  end;;
  Entity.Free;
end;

//------------------------------------------------------------------------------
procedure TPermis.DropTable;
var
  Entity: TItem;
begin
  Entity := TApp.Create;
  with TList.Create(Self, Entity) do begin
    DropTable;
    Free;
  end;;
  Entity.Free;

  inherited DropTable;
end;

//------------------------------------------------------------------------------
function TPermis.DatasetName: ShortString;
begin
  Result := 'Permiss';
end;

//------------------------------------------------------------------------------
function TPermis.DatasetFields: String;
begin
  Result := inherited DatasetFields;
  // Признак применимости разрешения ко всем приложениям
  Result := TextUtils.ConcatStr(Result, 'AllApps Char(1)', ',');
end;

//------------------------------------------------------------------------------
procedure TPermis.PrepDataSets;
begin
  QryPerms := TQuery.Create(nil);
  QryUtils.InitQuery(QryPerms);
  QryPerms.UpdateObject := TUpdateSQL.Create(nil);

  QryAffApps := TQuery.Create(nil);
  QryUtils.InitQuery(QryAffApps);
  QryAffApps.UpdateObject := TUpdateSQL.Create(nil);

  QryGrantUsrs := TQuery.Create(nil);
  QryUtils.InitQuery(QryGrantUsrs);
  QryGrantUsrs.UpdateObject := TUpdateSQL.Create(nil);

  PrepAffAppsQry;
  PrepGrantUsrsQry;
end;

//------------------------------------------------------------------------------
procedure TPermis.PrepAffAppsQry;
begin
  with QryAffApps do begin
    SQL.Text :=
      'select * ' +
      'from ' + DatasetName + ' ' +

    ;
  end;
end;

//------------------------------------------------------------------------------
procedure TPermis.PrepGrantUsrsQry;
begin
end;

//------------------------------------------------------------------------------
procedure TPermis.SetFilter(AppId: Integer);
begin
  FilterAppId := AppId;
  OpenPerms;
end;

//------------------------------------------------------------------------------
procedure TPermis.OpenPerms;
begin
end;

//------------------------------------------------------------------------------
procedure TPermis.AddPerm(PermRec: TDataSet);
begin
end;

//------------------------------------------------------------------------------
procedure TPermis.UpdatePerm(PermRec: TDataSet);
begin
end;

//------------------------------------------------------------------------------
procedure TPermis.DeletePerm(PermId: Integer);
begin
end;

//------------------------------------------------------------------------------
procedure TPermis.ClosePerms;
begin
end;

//------------------------------------------------------------------------------
procedure TPermis.OpenAffApps;
begin
end;

//------------------------------------------------------------------------------
procedure TPermis.AddAffectApp(AppId: Integer);
begin
end;

//------------------------------------------------------------------------------
procedure TPermis.RevokeApp(AppId: Integer);
begin
end;

//------------------------------------------------------------------------------
procedure TPermis.CloseAffectApps;
begin
end;

//------------------------------------------------------------------------------
procedure TPermis.OpenGrantUsrs;
begin
end;

//------------------------------------------------------------------------------
procedure TPermis.GrantUser(UserId, AppId: Integer);
begin
end;

//------------------------------------------------------------------------------
procedure TPermis.RevokePerm(UserId, AppId: Integer);
begin
end;

//------------------------------------------------------------------------------
procedure TPermis.ApplyChanges;
begin
  // ...
  FreeDataSets;
end;

//------------------------------------------------------------------------------
procedure TPermis.CancelChanges;
begin
  FreeDataSets;
end;

//------------------------------------------------------------------------------
procedure TPermis.FreeDataSets;
begin
  QryPerms.UpdateObject.Free;
  QryAffApps.UpdateObject.Free;
  QryGrantUsrs.UpdateObject.Free;

  QryPerms.Free;
  QryAffApps.Free;
  QryGrantUsrs.Free;
end;

end.
