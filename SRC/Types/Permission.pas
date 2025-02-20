unit Permission;

interface

uses
  Classes, Db, DbClient, DbTables, Item, NamedItem;

type
  TPerm = class(TNamedItem)
  private
    QryPerms, QryAffApps, QryGrantUsrs: TQuery;
    CdsPermBuff: TClientDataSet;

    FilterAppId: Integer;
    App, User, PermAppList, UsrPermAppList: TItem;

    procedure PrepDataSets;
    procedure FreeDataSets;

    procedure InitDataObjs;
    procedure FreeDataObjs;

    procedure PrepPermsQry;
    procedure PrepAffAppsQry;
    procedure PrepGrantUsrsQry;

    procedure OpenPerms;
    procedure OpenAffApps(PermId: Integer);
    procedure OpenGrantUsrs;

    function GetPermBuff: TDataSet;

    procedure PermAfterScroll(DataSet: TDataSet);
  public
    // Óïðàâëåíèå ñòðóêòóðîé áîçû äàííûõ
    procedure CreateTable; override;
    procedure DropTable; override;
    function DatasetName: ShortString; override;
    function FieldDefs: String; override;

    // Ñîçäàíèå/óäàëåíèå ðàçðåøåíèÿ
    class function Open(FilterAppId: Integer = 0): TPerm;
    class procedure Release(Perm: TPerm);

    // Äîñòóï ê äàííûì
    function GetPerms: TDataSet;
    function GetAffApps: TDataSet;
    function GetGrantUsrs: TDataSet;

    // Êîìàíäû óïðàâëåíèÿ îáúåêòîì
    procedure SetFilter(AppId: Integer);

    // Êîìàíäû ìàíèïóëèðîâàíèÿ äàííûìè
    function AddPerm: TDataSet;
    function UpdatePerm: TDataSet;
    procedure DeletePerm(PermId: Integer);
    procedure ApplyUpdate;
    procedure CancelUpdate;

    procedure AddAffApp(AppId: Integer);
    procedure RevokeAff(AppId: Integer);

    procedure GrantPerm(UserId, AppId: Integer);
    procedure RevokePerm(UserId, AppId: Integer);
  end;

implementation

uses
  App, CdsLib, DsLib, List, QryLib, TextLib, User, Variants;

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
function TPerm.FieldDefs: String;
begin
  Result := inherited FieldDefs;
  // Ïðèçíàê ïðèìåíèìîñòè ðàçðåøåíèÿ êî âñåì ïðèëîæåíèÿì
  Result := TextUtils.ConcatStr(Result, 'AllApps Char(1)', ',');
end;

//------------------------------------------------------------------------------
// Ñîçäàíèå îáúåêòà ïðè ðàáîòå ïðèëîæåíèÿ.
//------------------------------------------------------------------------------
class function TPerm.Open(FilterAppId: Integer = 0): TPerm;
begin
  Result := TPerm.Create;

  with Result do begin
    InitDataObjs;
    PrepDataSets;

    OpenAffApps(0);
    SetFilter(FilterAppId);
  end;
end;

//··············································································
class procedure TPerm.Release(Perm: TPerm);
begin
  with Perm do begin
    FreeDataSets;
    FreeDataObjs;
    Free;
  end;
end;

//··············································································
procedure TPerm.InitDataObjs;
begin
  App := TApp.Create;
  User := TUser.Create;
  PermAppList := TList.Create(Self, App);
  UsrPermAppList := TList.Create(User, PermAppList);
end;

//··············································································
procedure TPerm.FreeDataObjs;
begin
  App.Free;
  User.Free;
  PermAppList.Free;
  UsrPermAppList.Free;
end;

//------------------------------------------------------------------------------
procedure TPerm.PrepDataSets;
begin
  PrepPermsQry;
  with QryPerms do begin
    CachedUpdates := true;
    UpdateObject := TUpdateSQL.Create(nil);
    AfterScroll := PermAfterScroll;
  end;

  PrepAffAppsQry;
  with QryAffApps do begin
    CachedUpdates := true;
    UpdateObject := TUpdateSQL.Create(nil);
  end;

  PrepGrantUsrsQry;
  with QryGrantUsrs do begin
    CachedUpdates := true;
    UpdateObject := TUpdateSQL.Create(nil);
  end;

  PopulateUpdSQL(Self, QryPerms.UpdateObject as TUpdateSQL);
  PopulateUpdSQL(PermAppList, QryAffApps.UpdateObject as TUpdateSQL);
//  PopulateUpdSQL(GrantUsr, QryGrantUsrs.UpdateObject as TUpdateSQL);
end;

//··············································································
// Çàïðîñ íà ðàçðåøåíèÿ ñ ó÷¸òîì ôèëüòðà ïðèëîæåíèé.
//··············································································
procedure TPerm.PrepPermsQry;
begin
  QryPerms := TQuery.Create(nil);
  QryUtils.InitQuery(QryPerms);

  with QryPerms do begin
    SQL.Text :=
      'select distinct p.* ' +
      'from ' + DecorDsName + ' p ' +
        'left join ' + PermAppList.DecorDsName + ' pa ' +
          'on pa.' + DatasetName + 'Id = p.Id ' +
      'where pa.' + App.DatasetName + 'Id = :FilterAppId ' +
        'or :FilterAppId = 0';
    Prepare;
  end;
end;

//··············································································
// Çàïðîñ äëÿ ïðèëîæåíèé, ê êîòîðûì ìîæíî ïðèìåíèòü òåêóùåå â QryPerm
// ðàçðåøåíèå.
//··············································································
procedure TPerm.PrepAffAppsQry;
begin
  QryAffApps := TQuery.Create(nil);
  QryUtils.InitQuery(QryAffApps);

  with QryAffApps do begin
    SQL.Text :=
      'select * ' +
      'from ' + App.DecorDsName + ' a ' +
        'join ' + PermAppList.DecorDsName + ' pa ' +
          'on pa.' + App.DatasetName + 'Id = a.' + App.FieldName('Id') + ' ' +
      'where pa.' + DatasetName + 'Id = :PermId';
    Prepare;
  end;
end;

//··············································································
// Çàïðîñ äëÿ ïîëüçîâàòåëåé, êîòîðûì ïðåäîñòàâëåíî òåêóùåå â QryPerm ðàçðåøåíèå,
// ñ ó÷¸òîì ôèëüòðà ïðèëîæåíèé.
//··············································································
procedure TPerm.PrepGrantUsrsQry;
begin
  QryGrantUsrs := TQuery.Create(nil);
  QryUtils.InitQuery(QryGrantUsrs);

  with QryGrantUsrs do begin
    SQL.Text :=
      'select * ' +
      'from ' + User.DecorDsName + ' u ' +
        'join ' + UsrPermAppList.DecorDsName + ' upa ' +
          'on upa.' + User.DatasetName + 'Id = u.' + User.FieldName('Id') + ' ' +
        'join ' + PermAppList.DecorDsName + ' pa ' +
          'on pa.Id = upa.' + PermAppList.DatasetName + 'Id ' +
        'join ' + App.DecorDsName + ' a ' +
          'on a.' + App.FieldName('Id') + ' = pa.' + App.DatasetName + 'Id ' +
      'where pa.' + DatasetName + 'Id = :PermId ' +
        'and pa.' + App.DatasetName + 'Id = :FilterAppId or :FilterAppId = 0';
    Prepare;
  end;
end;

//··············································································
//
//··············································································
procedure TPerm.OpenPerms;
begin
  with QryPerms do begin
    DisableControls;
    Close;

    ParamByName('FilterAppId').AsInteger := FilterAppId;
    Open;

    EnableControls;
  end;
end;

//··············································································
procedure TPerm.OpenAffApps(PermId: Integer);
begin
  with QryAffApps do begin
    DisableControls;
    Close;

    ParamByName('PermId').AsInteger := PermId;
    Open;

    EnableControls;
  end;
end;

//··············································································
procedure TPerm.OpenGrantUsrs;
begin
  with QryGrantUsrs do begin
    DisableControls;
    Close;

    ParamByName('PermId').AsInteger := QryPerms.FieldByName('Id').AsInteger;
    ParamByName('FilterAppId').AsInteger := FilterAppId;
    Open;

    EnableControls;
  end;
end;

//------------------------------------------------------------------------------
// Äîñòóï ê äàííûì
//------------------------------------------------------------------------------
function TPerm.GetPerms: TDataSet;
begin
  Result := QryPerms;
end;

//··············································································
function TPerm.GetAffApps: TDataSet;
begin
  Result := QryAffApps;
end;

//··············································································
function TPerm.GetGrantUsrs: TDataSet;
begin
  Result := QryGrantUsrs;
end;

//··············································································
function TPerm.GetPermBuff: TDataSet;
begin
  if CdsPermBuff = nil then
    CdsPermBuff := CdsUtils.CreateCds(QryPerms);

  Result := CdsPermBuff;
end;

//··············································································
// Ïî èçìåíåíèè ïîçèöèè â Ðàçðåøåíèÿõ, ïåðåçàãðóæàåì ïðèëîæåíèÿ
//··············································································
procedure TPerm.PermAfterScroll(DataSet: TDataSet);
begin
  OpenAffApps(DataSet.FieldByName('Id').AsInteger);
end;

//------------------------------------------------------------------------------
// Êîìàíäû óïðàâëåíèÿ îáúåêòîì
//------------------------------------------------------------------------------
procedure TPerm.SetFilter(AppId: Integer);
begin
  FilterAppId := AppId;

  OpenPerms;
  OpenGrantUsrs;
end;

//------------------------------------------------------------------------------
// Êîìàíäû ìàíèïóëèðîâàíèÿ äàííûìè
//------------------------------------------------------------------------------
function TPerm.AddPerm: TDataSet;
begin
  Result := GetPermBuff;
  Result.Append;
  Result.FieldByName('AllApps').AsString := ' ';
end;

//··············································································
function TPerm.UpdatePerm: TDataSet;
begin
  Result := GetPermBuff;
  Result.Edit;
  DsUtils.CopyRecord(QryPerms, Result);
end;

//··············································································
procedure TPerm.ApplyUpdate;
var
  NewRec: Boolean;
begin
  with GetPermBuff do begin
    Post;

    NewRec := FieldByName('Id').AsInteger = 0;

    with QryPerms do begin
      if NewRec then
        Append
      else
        Edit;

      DsUtils.CopyRecord(CdsPermBuff, QryPerms);

      if NewRec then
        FieldByName('Id').AsInteger := QryUtils.GenerateId(DecorDsName);

      Post;

      Database.ApplyUpdates([QryPerms]);
      CommitUpdates;
    end;

    Delete;
  end;
end;

//··············································································
procedure TPerm.CancelUpdate;
begin
  with GetPermBuff do begin
    Cancel;

    if RecordCount > 0 then
      Delete;
  end;
end;

//··············································································
procedure TPerm.DeletePerm(PermId: Integer);
begin
  QryPerms.Delete;
end;

//··············································································
procedure TPerm.AddAffApp(AppId: Integer);
begin
  with QryAffApps do begin
    Append;
    FieldByName('Id').AsInteger := QryUtils.GenerateId(DecorDsName);

    FieldByName(DatasetName + 'Id').AsInteger :=
      QryPerms.FieldByName('Id').AsInteger;

    FieldByName(App.DatasetName + 'Id').AsInteger := AppId;
    Post;

    Database.ApplyUpdates([QryAffApps]);
    CommitUpdates;
  end;
end;

//··············································································
procedure TPerm.RevokeAff(AppId: Integer);
begin
  with QryAffApps do begin
    Locate(
      DatasetName + 'Id;' + App.DatasetName + 'Id',
      VarArrayOf([QryPerms.FieldByName('Id').AsInteger, AppId]), []
    );
    Delete;

    Database.ApplyUpdates([QryAffApps]);
    CommitUpdates;
  end;
end;

//··············································································
procedure TPerm.GrantPerm(UserId, AppId: Integer);
begin
  with QryGrantUsrs do begin
    Append;
    FieldByName('Id').AsInteger := QryUtils.GenerateId(DecorDsName);

    FieldByName(User.DatasetName + 'Id').AsInteger :=
      QryPerms.FieldByName('Id').AsInteger;
      
    FieldByName(App.DatasetName + 'Id').AsInteger := AppId;
    Post;

    Database.ApplyUpdates([QryGrantUsrs]);
    CommitUpdates;
  end;
end;

//··············································································
procedure TPerm.RevokePerm(UserId, AppId: Integer);
begin
end;

//------------------------------------------------------------------------------
procedure TPerm.FreeDataSets;
begin
  QryPerms.UpdateObject.Free;
  QryAffApps.UpdateObject.Free;
  QryGrantUsrs.UpdateObject.Free;

  QryPerms.Free;
  QryAffApps.Free;
  QryGrantUsrs.Free;

  if CdsPermBuff <> nil then
    CdsPermBuff.Free;
end;

end.
