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
    App, PermApp, User, PermAppsList, UsrPermAppsList: TItem;

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
    // ���������� ���������� ���� ������
    procedure CreateTable; override;
    procedure DropTable; override;
    function DatasetName: ShortString; override;
    function FieldDefs: String; override;

    // ��������/�������� ����������
    class function Open(FilterAppId: Integer = 0): TPerm;
    class procedure Release(Perm: TPerm);

    // ������ � ������
    function GetPerms: TDataSet;
    function GetAffApps: TDataSet;
    function GetGrantUsrs: TDataSet;

    // ������� ���������� ��������
    procedure SetFilter(AppId: Integer);

    // ������� ��������������� �������
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
  App, CdsLib, DsLib, List, PermApp, QryLib, TextLib, User, Variants;

//------------------------------------------------------------------------------
// �������� ������ ��� ������ ������� ���������� ��� ��� ��������������
// ������������� ���� ������ �� ����� ������������.
//------------------------------------------------------------------------------
procedure TPerm.CreateTable;
var
  Entity: TItem;
begin
  inherited CreateTable;

  // ������ ����������, � ������� ��������� ����������
  Entity := TApp.Create;
  with TList.Create(Self, Entity) do begin
    CreateTable;
    Free;
  end;
  Entity.Free;
end;

//������������������������������������������������������������������������������
// �������� ������ ��� �������������� ������������� ���� ������ �� �����
// ������������.
//������������������������������������������������������������������������������
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

//������������������������������������������������������������������������������
// ��� ������� ���� ������, ��������� � ���� ���������.
//������������������������������������������������������������������������������
function TPerm.DatasetName: ShortString;
begin
  Result := DATASET_PREFIX + 'Perm';
end;

//������������������������������������������������������������������������������
// ���� ������� ���� ������.
//������������������������������������������������������������������������������
function TPerm.FieldDefs: String;
begin
  Result := inherited FieldDefs;
  // ������� ������������ ���������� �� ���� �����������
  Result := TextUtils.ConcatStr(Result, 'AllApps Char(1)', ',');
end;

//------------------------------------------------------------------------------
// �������� ������� ��� ������ ����������.
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

//������������������������������������������������������������������������������
class procedure TPerm.Release(Perm: TPerm);
begin
  with Perm do begin
    FreeDataSets;
    FreeDataObjs;
    Free;
  end;
end;

//������������������������������������������������������������������������������
procedure TPerm.InitDataObjs;
begin
  App := TApp.Create;
  PermApp := TPermApp.Create;
  User := TUser.Create;
  PermAppsList := TList.Create(Self, App);
  UsrPermAppsList := TList.Create(User, PermApp);
end;

//������������������������������������������������������������������������������
procedure TPerm.FreeDataObjs;
begin
  App.Free;
  PermApp.Free;
  User.Free;
  PermAppsList.Free;
  UsrPermAppsList.Free;
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
  PopulateUpdSQL(PermAppsList, QryAffApps.UpdateObject as TUpdateSQL);
//  PopulateUpdSQL(GrantUsr, QryGrantUsrs.UpdateObject as TUpdateSQL);
end;

//������������������������������������������������������������������������������
// ������ �� ���������� � ������ ������� ����������.
//������������������������������������������������������������������������������
procedure TPerm.PrepPermsQry;
begin
  QryPerms := TQuery.Create(nil);
  QryUtils.InitQuery(QryPerms);

  with QryPerms do begin
    SQL.Text :=
      'select distinct p.* ' +
      'from ' + DatasetName + ' p ' +
        'left join ' + PermAppsList.DatasetName + ' pa ' +
          'on pa.OwnerId = p.Id ' +
      'where pa.EntityId = :FilterAppId or :FilterAppId = 0';
    Prepare;
  end;
end;

//������������������������������������������������������������������������������
// ������ ��� ����������, � ������� ����� ��������� ������� � QryPerm
// ����������.
//������������������������������������������������������������������������������
procedure TPerm.PrepAffAppsQry;
begin
  QryAffApps := TQuery.Create(nil);
  QryUtils.InitQuery(QryAffApps);

  with QryAffApps do begin
    SQL.Text :=
      'select * ' +
      'from ' + PermAppsList.DatasetName + ' pa  ' +
        'left join ' + App.DataSetName + ' a ' +
          'on a.' + App.FieldName('Id') + ' = pa.EntityId ' +
      'where pa.OwnerId = :PermId';
    Prepare;
  end;
end;

//������������������������������������������������������������������������������
// ������ ��� �������������, ������� ������������� ������� � QryPerm ����������,
// � ������ ������� ����������.
//������������������������������������������������������������������������������
procedure TPerm.PrepGrantUsrsQry;
begin
  QryGrantUsrs := TQuery.Create(nil);
  QryUtils.InitQuery(QryGrantUsrs);

  with QryGrantUsrs do begin
    SQL.Text :=
      'select * ' +
      'from ' + PermApp.DatasetName + ' pa ' +
        'left join ' + UsrPermAppsList.DatasetName + ' upa ' +
          'on upa.EntityId = pa.Id ' +
        'left join ' + User.DatasetName + ' u ' +
          'on u.' + User.FieldName('Id') + ' = upa.OwnerId ' +
        'left join ' + App.DatasetName + ' ' +
          'on pa.AppId = ' + App.FieldName('Id') + ' ' +
      'where pa.PermId = :PermId ' +
        'and pa.AppId = :FilterAppId or :FilterAppId = 0';
    Prepare;
  end;
end;

//������������������������������������������������������������������������������
//
//������������������������������������������������������������������������������
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

//������������������������������������������������������������������������������
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

//������������������������������������������������������������������������������
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
// ������ � ������
//------------------------------------------------------------------------------
function TPerm.GetPerms: TDataSet;
begin
  Result := QryPerms;
end;

//������������������������������������������������������������������������������
function TPerm.GetAffApps: TDataSet;
begin
  Result := QryAffApps;
end;

//������������������������������������������������������������������������������
function TPerm.GetGrantUsrs: TDataSet;
begin
  Result := QryGrantUsrs;
end;

//������������������������������������������������������������������������������
function TPerm.GetPermBuff: TDataSet;
begin
  if CdsPermBuff = nil then
    CdsPermBuff := CdsUtils.CreateCds(QryPerms);

  Result := CdsPermBuff;
end;

//������������������������������������������������������������������������������
// �� ��������� ������� � �����������, ������������� ����������
//������������������������������������������������������������������������������
procedure TPerm.PermAfterScroll(DataSet: TDataSet);
begin
  OpenAffApps(DataSet.FieldByName('Id').AsInteger);
end;

//------------------------------------------------------------------------------
// ������� ���������� ��������
//------------------------------------------------------------------------------
procedure TPerm.SetFilter(AppId: Integer);
begin
  FilterAppId := AppId;

  OpenPerms;
  OpenGrantUsrs;
end;

//------------------------------------------------------------------------------
// ������� ��������������� �������
//------------------------------------------------------------------------------
function TPerm.AddPerm: TDataSet;
begin
  Result := GetPermBuff;
  Result.Append;
  Result.FieldByName('AllApps').AsString := ' ';
end;

//������������������������������������������������������������������������������
function TPerm.UpdatePerm: TDataSet;
begin
  Result := GetPermBuff;
  Result.Edit;
  DsUtils.CopyRecord(QryPerms, Result);
end;

//������������������������������������������������������������������������������
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
        FieldByName('Id').AsInteger := QryUtils.GenerateId(DatasetName);

      Post;

      Database.ApplyUpdates([QryPerms]);
      CommitUpdates;
    end;

    Delete;
  end;
end;

//������������������������������������������������������������������������������
procedure TPerm.CancelUpdate;
begin
  with GetPermBuff do begin
    Cancel;

    if RecordCount > 0 then
      Delete;
  end;
end;

//������������������������������������������������������������������������������
procedure TPerm.DeletePerm(PermId: Integer);
begin
  QryPerms.Delete;
end;

//������������������������������������������������������������������������������
procedure TPerm.AddAffApp(AppId: Integer);
begin
  with QryAffApps do begin
    Append;
    FieldByName('Id').AsInteger := QryUtils.GenerateId(DatasetName);
    FieldByName('OwnerId').AsInteger := QryPerms.FieldByName('Id').AsInteger;
    FieldByName('EntityId').AsInteger := AppId;
    Post;

    Database.ApplyUpdates([QryAffApps]);
    CommitUpdates;
  end;
end;

//������������������������������������������������������������������������������
procedure TPerm.RevokeAff(AppId: Integer);
begin
  with QryAffApps do begin
    Locate('OwnerId;EntityId', VarArrayOf([
      QryPerms.FieldByName('Id').AsInteger,
      QryPerms.FieldByName('Id').AsInteger]), []
    );
    Delete;

    Database.ApplyUpdates([QryAffApps]);
    CommitUpdates;
  end;
end;

//������������������������������������������������������������������������������
procedure TPerm.GrantPerm(UserId, AppId: Integer);
begin
  with QryGrantUsrs do begin
    Append;
    FieldByName('Id').AsInteger := QryUtils.GenerateId(DatasetName);
    FieldByName('OwnerId').AsInteger := QryPerms.FieldByName('Id').AsInteger;
    FieldByName('EntityId').AsInteger := AppId;
    Post;

    Database.ApplyUpdates([QryGrantUsrs]);
    CommitUpdates;
  end;
end;

//������������������������������������������������������������������������������
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
