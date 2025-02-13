unit Permission;

interface

uses
  Db, DbTables, NamedItem;

type

  TPerm = class(TNamedItem)
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

    class function Run(FilterAppId: Integer): TPerm;

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
  App, Item, List, PermApp, QryLib, TextLib, User;

//------------------------------------------------------------------------------
// Ñîçäàíèå òàáëèö ïðè ïåðâîì çàïóñêå ïðèëîæåíèÿ èëè ïðè ïðèíóäèòåëüíîé
// èíèöèàëèçàöèè áàçû äàííûõ âî âðåìÿ òåñòèðîâàíèÿ.
//------------------------------------------------------------------------------
procedure TPerm.CreateTable;
var
  Entity: TItem;
begin
  inherited CreateTable;

  // Ñïèñîê ïðèëîæåíèé, ê êîòîðûì ïðèìåíèìî ðàçðåøåíèå
  Entity := TApp.Create;
  with TList.Create(Self, Entity) do begin
    CreateTable;
    Free;
  end;
  Entity.Free;
end;

//··············································································
// Óäàëåíèå òàáëèö ïðè ïðèíóäèòåëüíîé èíèöèàëèçàöèè áàçû äàííûõ âî âðåìÿ
// òåñòèðîâàíèÿ.
//··············································································
procedure TPerm.DropTable;
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

//··············································································
// Èìÿ òàáëèöû áàçû äàííûõ, ñâÿçàííîé ñ ýòîé ñóùíîñòüþ.
//··············································································
function TPerm.DatasetName: ShortString;
begin
  Result := 'Perm';
end;

//··············································································
// Ïîëÿ òàáëèöû áàçû äàííûõ.
//··············································································
function TPerm.DatasetFields: String;
begin
  Result := inherited DatasetFields;
  // Ïðèçíàê ïðèìåíèìîñòè ðàçðåøåíèÿ êî âñåì ïðèëîæåíèÿì
  Result := TextUtils.ConcatStr(Result, 'AllApps Char(1)', ',');
end;

//------------------------------------------------------------------------------
// Ñîçäàíèå îáúåêòà ïðè ðàáîòå ïðèëîæåíèÿ.
//------------------------------------------------------------------------------
class function TPerm.Run(FilterAppId: Integer): TPerm;
begin
  Result := TPerm.Create;

  with Result do begin
    PrepDataSets;
    SetFilter(FilterAppId);
  end;
end;

//··············································································
procedure TPerm.PrepDataSets;
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

//··············································································
// Çàïðîñ äëÿ ïðèëîæåíèé, ê êîòîðûì ìîæíî ïðèìåíèòü òåêóùåå â QryPerm
// ðàçðåøåíèå.
//··············································································
procedure TPerm.PrepAffAppsQry;
var
  App: TApp;
  List: TList;
begin
  App := TApp.Create;
  List := TList.Create(Self, App);

  with QryAffApps do begin
    SQL.Text :=
      'select * ' +
      'from ' + List.DatasetName + ' a  ' +
      'where a.OwnerId = :PermId';
    Prepare;
  end;

  App.Free;
  List.Free;
end;

//··············································································
// Çàïðîñ äëÿ ïîëüçîâàòåëåé, êîòîðûì ïðåäîñòàâëåíî òåêóùåå â QryPerm ðàçðåøåíèå,
// ñ ó÷¸òîì ôèëüòðà ïðèëîæåíèé.
//··············································································
procedure TPerm.PrepGrantUsrsQry;
var
  User, PermApp, List: TItem;
begin
  User := TUser.Create;
  PermApp := TPermApp.Create;
  List := TList.Create(User, PermApp);

  with QryGrantUsrs do begin
    SQL.Text :=
      'select * ' +
      'from ' + PermApp.DatasetName + ' pa ' +
        'left join ' + List.DatasetName + ' upa on upa.EntityId = pa.Id ' +
        'left join ' + User.DatasetName + ' u ' +
          'on u.' + User.FieldName('Id') + ' = pa.OwnerId ' +
      'where pa.PermId = :PermId ' +
        'and pa.AppId = :AppId or :AppId = 0';
    ;
  end;
end;

//··············································································
procedure TPerm.SetFilter(AppId: Integer);
begin
  FilterAppId := AppId;
  OpenPerms;
end;

//------------------------------------------------------------------------------
procedure TPerm.OpenPerms;
begin
end;

//------------------------------------------------------------------------------
procedure TPerm.AddPerm(PermRec: TDataSet);
begin
end;

//------------------------------------------------------------------------------
procedure TPerm.UpdatePerm(PermRec: TDataSet);
begin
end;

//------------------------------------------------------------------------------
procedure TPerm.DeletePerm(PermId: Integer);
begin
end;

//------------------------------------------------------------------------------
procedure TPerm.ClosePerms;
begin
end;

//------------------------------------------------------------------------------
procedure TPerm.OpenAffApps;
begin
end;

//------------------------------------------------------------------------------
procedure TPerm.AddAffectApp(AppId: Integer);
begin
end;

//------------------------------------------------------------------------------
procedure TPerm.RevokeApp(AppId: Integer);
begin
end;

//------------------------------------------------------------------------------
procedure TPerm.CloseAffectApps;
begin
end;

//------------------------------------------------------------------------------
procedure TPerm.OpenGrantUsrs;
begin
end;

//------------------------------------------------------------------------------
procedure TPerm.GrantUser(UserId, AppId: Integer);
begin
end;

//------------------------------------------------------------------------------
procedure TPerm.RevokePerm(UserId, AppId: Integer);
begin
end;

//------------------------------------------------------------------------------
//
//------------------------------------------------------------------------------
procedure TPerm.ApplyChanges;
begin
  // ...
  FreeDataSets;
end;

//··············································································
procedure TPerm.CancelChanges;
begin
  FreeDataSets;
end;

//··············································································
procedure TPerm.FreeDataSets;
begin
  QryPerms.UpdateObject.Free;
  QryAffApps.UpdateObject.Free;
  QryGrantUsrs.UpdateObject.Free;

  QryPerms.Free;
  QryAffApps.Free;
  QryGrantUsrs.Free;
end;

end.
