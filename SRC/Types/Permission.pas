unit Permission;

interface

uses
  Db, DbClient, DbTables, Item, NamedItem;

type

  TPerm = class(TNamedItem)
  private
    QryPerms, QryAffApps, QryGrantUsrs: TQuery;
    CdsPermBuff: TClientDataSet;

    FilterAppId: Integer;
    App, PermApp, User: TItem;

    procedure PrepDataSets;
    procedure FreeDataSets;

    procedure PrepDataObjs;
    procedure FreeDataObjs;

    procedure PrepPermsQry;
    procedure PrepAffAppsQry;
    procedure PrepGrantUsrsQry;

    procedure OpenPerms;
    procedure OpenAffApps;
    procedure OpenGrantUsrs;

    function GetPermBuff: TDataSet;
  public
    destructor Destroy; override;
    
    procedure CreateTable; override;
    procedure DropTable; override;
    function DatasetName: ShortString; override;
    function DatasetFields: String; override;

    class function Run(FilterAppId: Integer): TPerm;

    procedure SetFilter(AppId: Integer);

    function AddPerm: TDataSet;
    function UpdatePerm: TDataSet;
    procedure DeletePerm(PermId: Integer);
    procedure ApplyUpdate;
    procedure CancelUpdate;

    procedure AddAffectApp(AppId: Integer);
    procedure RevokeAff(AppId: Integer);

    procedure GrantPerm(UserId, AppId: Integer);
    procedure RevokePerm(UserId, AppId: Integer);
  end;

implementation

uses
  App, CdsLib, DsLib, List, PermApp, QryLib, TextLib, User, Variants;

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
    PrepDataObjs;
    PrepDataSets;

    SetFilter(FilterAppId);
  end;
end;

//··············································································
destructor TPerm.Destroy;
begin
  FreeDataSets;
  FreeDataObjs;
end;

//··············································································
procedure TPerm.PrepDataObjs;
begin
  App := TApp.Create;
  PermApp := TPermApp.Create;
  User := TUser.Create;
end;

//------------------------------------------------------------------------------
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

  PrepPermsQry;
  PrepAffAppsQry;
  PrepGrantUsrsQry;
end;

//··············································································
// Çàïðîñ íà ðàçðåøåíèÿ ñ ó÷¸òîì ôèëüòðà ïðèëîæåíèé.
//··············································································
procedure TPerm.PrepPermsQry;
var
  List: TItem;
begin
  List := TList.Create(Self, App);

  with QryPerms do begin
    SQL.Text :=
      'select * ' +
      'from ' + List.DatasetName + ' pa ' +
        'left join ' + DatasetName + ' p ' +
          'on p.Id = pa.OwnerId ' +
      'where pa.EntityId = :FilterAppId or :FilterAppId = 0';
    Prepare;
  end;
end;

//··············································································
// Çàïðîñ äëÿ ïðèëîæåíèé, ê êîòîðûì ìîæíî ïðèìåíèòü òåêóùåå â QryPerm
// ðàçðåøåíèå.
//··············································································
procedure TPerm.PrepAffAppsQry;
var
  List: TItem;
begin
  List := TList.Create(Self, App);

  with QryAffApps do begin
    SQL.Text :=
      'select * ' +
      'from ' + List.DatasetName + ' pa  ' +
        'left join ' + App.DataSetName + ' a ' +
          'on a.' + App.FieldName('Id') + ' = pa.EntityId ' +
      'where pa.OwnerId = :PermId';
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
  List: TItem;
begin
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
//
//··············································································
procedure TPerm.OpenPerms;
begin
  with QryPerms do begin
    DisableControls;
    Close;

    ParamByName('AppId').AsInteger := FilterAppId;
    Open;

    EnableControls;
  end;
end;

//··············································································
function TPerm.GetPermBuff: TDataSet;
begin
  if CdsPermBuff = nil then
    CdsPermBuff := CdsUtils.CreateCds(QryPerms);

  Result := CdsPermBuff;
end;

//··············································································
procedure TPerm.OpenAffApps;
begin
  with QryAffApps do begin
    DisableControls;
    Close;

    ParamByName('PermId').AsInteger := QryPerms.FieldByName('Id').AsInteger;
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
    ParamByName('AppId').AsInteger := FilterAppId;
    Open;

    EnableControls;
  end;
end;

//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
procedure TPerm.SetFilter(AppId: Integer);
begin
  FilterAppId := AppId;
  
  OpenPerms;
  OpenGrantUsrs;
end;

//··············································································
function TPerm.AddPerm: TDataSet;
begin
  Result := GetPermBuff;
  Result.Append;
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
begin
  with GetPermBuff do begin
    Post;

    with QryPerms do begin
      Edit;
      DsUtils.CopyRecord(CdsPermBuff, QryPerms);
      Post;
      
      CommitUpdates;
      ApplyUpdates;
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
procedure TPerm.AddAffectApp(AppId: Integer);
begin
  with QryAffApps do begin
    Append;
    FieldByName('Id').AsInteger := QryUtils.GenerateId(DatasetName);
    FieldByName('OwnerId').AsInteger := QryPerms.FieldByName('Id').AsInteger;
    FieldByName('EntityId').AsInteger := AppId;
    Post;

    CommitUpdates;
    ApplyUpdates;
  end;
end;

//··············································································
procedure TPerm.RevokeAff(AppId: Integer);
begin
  with QryAffApps do begin
    Locate('OwnerId;EntityId', VarArrayOf([
      QryPerms.FieldByName('Id').AsInteger,
      QryPerms.FieldByName('Id').AsInteger]), []
    );
    Delete;

    CommitUpdates;
    ApplyUpdates;
  end;
end;

//··············································································
procedure TPerm.GrantPerm(UserId, AppId: Integer);
begin
  with QryGrantUsrs do begin
    Append;
    FieldByName('Id').AsInteger := QryUtils.GenerateId(DatasetName);
    FieldByName('OwnerId').AsInteger := QryPerms.FieldByName('Id').AsInteger;
    FieldByName('EntityId').AsInteger := AppId;
    Post;

    CommitUpdates;
    ApplyUpdates;
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

//··············································································
procedure TPerm.FreeDataObjs;
begin
  App.Free;
  PermApp.Free;
  User.Free;
end;

end.
