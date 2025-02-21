unit FormPermList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, DBCtrls, ExtCtrls, DB,
  ComCtrls, Menus, FormList, DBTables, CheckLst, CustCheckListBox,
  Permission, Buttons;

type
  TFrmPermList = class(TFrmList)
    PanelRight: TPanel;
    PanelBottom: TPanel;
    PanelAffApps: TPanel;
    PanelGrantUsrs: TPanel;
    SplitterMain: TSplitter;
    SplitterRight: TSplitter;
    ChLstBxAffApps: TCheckListBox;
    LblAffectedApps: TLabel;
    DsrcPerms: TDataSource;
    PanelPerms: TPanel;
    DbgrPerms: TDBGrid;
    LblFilter: TLabel;
    PopupPerms: TPopupMenu;
    PageCtrlGrantPerms: TPageControl;
    TabGrantRoles: TTabSheet;
    TabGrantUsrs: TTabSheet;
    TabGrantUsrGrps: TTabSheet;
    NAddPermission: TMenuItem;
    NEditPermission: TMenuItem;
    NDelPerm: TMenuItem;
    PopupAffApps: TPopupMenu;
    NSetApp: TMenuItem;
    NResetApp: TMenuItem;
    ChLstBxUsrApps: TCheckListBox;
    PopupGrantPerm: TPopupMenu;
    NGrantPerm: TMenuItem;
    NRevokePerm: TMenuItem;
    QryApps: TQuery;
    QryAppFilter: TQuery;
    ComboAppFilter: TDBLookupComboBox;
    DsrcAppFilter: TDataSource;
    BtnClearAppFilter: TSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PanelPermsResize(Sender: TObject);
    procedure PanelAffAppsResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TabGrantUsrsResize(Sender: TObject);
    procedure NAddPermissionClick(Sender: TObject);
    procedure NEditPermissionClick(Sender: TObject);
    procedure ChLstBxAffAppsClickCheck(Sender: TObject);
    procedure ChLstBxUsrAppsClickCheck(Sender: TObject);
    procedure ComboAppFilterClick(Sender: TObject);
    procedure BtnClearAppFilterClick(Sender: TObject);
  private
    Perm: TPerm;

    procedure OpenAppFilterQry;
    procedure LoadApps;
    procedure CheckAffApps;

    procedure LoadUsrs;
    procedure CheckGrantUsrs(AppId: Integer);

    procedure OnPermScrollHnd;
    procedure OnAffAppScrollHnd(Sender: TObject);

    procedure OnAffAppAddHnd(AppId: Integer);
    procedure OnAffAppRevokeHnd(AppId: Integer);

    function GetSelectedAppId: Integer;
  end;

var
  FrmPermList: TFrmPermList;

implementation

uses
  App, DModMain, FormEditPerm, Item, List, QryLib, TextLib, User;

{$R *.dfm}

//------------------------------------------------------------------------------
procedure TFrmPermList.FormCreate(Sender: TObject);
begin
  ChLstBxAffApps.OnChange := OnAffAppScrollHnd;
  ChLstBxUsrApps.Enabled := false;

  Perm := TPerm.Open;
  Perm.OnPermScroll := OnPermScrollHnd;
  Perm.OnAffAppAdd := OnAffAppAddHnd;
  Perm.OnAffAppRevoke := OnAffAppRevokeHnd;

  DsrcPerms.DataSet := Perm.GetPerms;

  OpenAppFilterQry;

  LoadApps;
  CheckAffApps;

  LoadUsrs;
end;

//------------------------------------------------------------------------------
procedure TFrmPermList.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;

  TPerm.Release(Perm);
end;

//------------------------------------------------------------------------------
procedure TFrmPermList.OpenAppFilterQry;
var
  App: TApp;
begin
  App := TApp.Create;

  QryUtils.InitQuery(QryAppFilter);
  with QryAppFilter do begin
    SQL.Text :=
      'select * ' +
      'from ' + App.DecorDsName + ' ' +
      'order by ' + App.FieldName('Notes');
    Open;
  end;

  App.Free;
end;

//------------------------------------------------------------------------------
procedure TFrmPermList.LoadApps;
var
  App: TApp;
begin
  App := TApp.Create;

  QryUtils.InitQuery(QryApps);

  with QryApps do begin
    SQL.Text :=
      'select * ' +
      'from ' + App.DecorDsName;
    Open;

    while not Eof do begin
      ChLstBxAffApps.AddItem(
        TextUtils.PadRight(
          FieldByName(App.FieldName('Code')).AsString, ' ', 25) +
          FieldByName(App.FieldName('Name')).AsString,
        TIdObject.Create(FieldByName(App.FieldName('Id')).AsInteger)
      );

      Next;
    end;
  end;

  App.Free;
end;

//------------------------------------------------------------------------------
procedure TFrmPermList.OnPermScrollHnd;
begin
  CheckAffApps;
  CheckGrantUsrs(GetSelectedAppId);
end;

//------------------------------------------------------------------------------
procedure TFrmPermList.CheckAffApps;
var
  App: TItem;
  AppId, I: Integer;
  AffApps: TDataSet;
begin
  App := TApp.Create;
  AffApps := Perm.GetAffApps;

  for I := 0 to ChLstBxAffApps.Count - 1 do begin
    AppId := (ChLstBxAffApps.Items.Objects[I] as TIdObject).Id;

    ChLstBxAffApps.Checked[I] := AffApps.Locate(App.RefFldName, AppId, []);
  end;
  
  App.Free;
end;

//------------------------------------------------------------------------------
procedure TFrmPermList.ChLstBxAffAppsClickCheck(Sender: TObject);
var
  AppId, Indx: Integer;
begin
  with ChLstBxAffApps do begin
    Indx := GetSelectedIndx;
    AppId := (Items.Objects[Indx] as TIdObject).Id;

    if Checked[Indx] then
      Perm.AddAffApp(AppId)
    else
      Perm.RevokeApp(AppId);
  end;
  
  CheckGrantUsrs(AppId);
end;

//------------------------------------------------------------------------------
function TFrmPermList.GetSelectedAppId: Integer;
var
  Indx: Integer;
begin
  with ChLstBxAffApps do begin
    Indx := GetSelectedIndx;

    if Indx = -1 then
      Result := 0
    else
      Result := (Items.Objects[Indx] as TIdObject).Id;
  end;
end;

//------------------------------------------------------------------------------
procedure TFrmPermList.LoadUsrs;
var
  User: TUser;
begin
  User := TUser.Open;

  with User, GetUsrs do begin
    First;

    while not Eof do begin
      ChLstBxUsrApps.AddItem(
        TextUtils.PadRight(
          FieldByName(FieldName('Name')).AsString, ' ', 25) +
          FieldByName(FieldName('Notes')).AsString,
        TIdObject.Create(FieldByName(FieldName('Id')).AsInteger)
      );

      Next;
    end;
  end;

  TUser.Release(User);
end;

//------------------------------------------------------------------------------
procedure TFrmPermList.OnAffAppScrollHnd(Sender: TObject);
var
  AppId: Integer;
begin
  AppId := GetSelectedAppId;
  CheckGrantUsrs(AppId);
  ChLstBxUsrApps.Enabled := AppId <> 0;
end;

//------------------------------------------------------------------------------
// Проставляем check'и для пользователей, которым разрешён доступ к приложению
// AppId
//------------------------------------------------------------------------------
procedure TFrmPermList.CheckGrantUsrs(AppId: Integer);
var
  User: TItem;
  UserId, I: Integer;
  UserPermApps: TDataSet;
begin
  User := TUser.Create;
  UserPermApps := Perm.GetGrantUsrs(AppId);

  for I := 0 to ChLstBxUsrApps.Count - 1 do begin
    UserId := (ChLstBxUsrApps.Items.Objects[I] as TIdObject).Id;

    ChLstBxUsrApps.Checked[I] :=
      UserPermApps.Locate(User.RefFldName, UserId, []);
  end;

  User.Free;
end;

//------------------------------------------------------------------------------
procedure TFrmPermList.ChLstBxUsrAppsClickCheck(Sender: TObject);
var
  AppId, UserId, Indx: Integer;
begin
  Indx := ChLstBxAffApps.GetSelectedIndx;
  AppId := (ChLstBxAffApps.Items.Objects[Indx] as TIdObject).Id;

  Indx := ChLstBxUsrApps.GetSelectedIndx;
  UserId := (ChLstBxUsrApps.Items.Objects[Indx] as TIdObject).Id;

  if ChLstBxUsrApps.Checked[Indx] then
    Perm.GrantPerm(UserId, AppId)
  else
    Perm.RevokePerm(UserId, AppId);
end;

//------------------------------------------------------------------------------
procedure TFrmPermList.PanelPermsResize(Sender: TObject);
begin
  ComboAppFilter.Width := PanelPerms.Width - ComboAppFilter.Left - 3;

  DbgrPerms.Width := PanelPerms.Width - DbgrPerms.Left - 3;
  DbgrPerms.Height := PanelPerms.Height - DbgrPerms.Top - 3;
end;

//------------------------------------------------------------------------------
procedure TFrmPermList.PanelAffAppsResize(Sender: TObject);
begin
  ChLstBxAffApps.Width := PanelAffApps.Width - ChLstBxAffApps.Left - 3;
  ChLstBxAffApps.Height := PanelAffApps.Height - ChLstBxAffApps.Top - 3;
end;

//------------------------------------------------------------------------------
procedure TFrmPermList.TabGrantUsrsResize(Sender: TObject);
begin
  ChLstBxUsrApps.Width := TabGrantUsrs.ClientWidth;
  ChLstBxUsrApps.Height := TabGrantUsrs.ClientHeight;
end;

//------------------------------------------------------------------------------
procedure TFrmPermList.NAddPermissionClick(Sender: TObject);
begin
  if TFrmEditPerm.Run(Perm.AddPerm) = mrOk then
    Perm.ApplyUpdate
  else
    Perm.CancelUpdate;
end;

//------------------------------------------------------------------------------
procedure TFrmPermList.NEditPermissionClick(Sender: TObject);
begin
  if TFrmEditPerm.Run(Perm.UpdatePerm) = mrOk then
    Perm.ApplyUpdate
  else
    Perm.CancelUpdate;
end;

//------------------------------------------------------------------------------
procedure TFrmPermList.OnAffAppAddHnd;
begin
end;

//------------------------------------------------------------------------------
procedure TFrmPermList.OnAffAppRevokeHnd;
begin
end;

procedure TFrmPermList.ComboAppFilterClick(Sender: TObject);
var
  App: TApp;
begin
  App := TApp.Create;
  Perm.SetFilter(QryAppFilter.FieldByName(App.FieldName('Id')).AsInteger);
  App.Free;
end;

procedure TFrmPermList.BtnClearAppFilterClick(Sender: TObject);
begin
  ComboAppFilter.KeyValue := 0;
  Perm.SetFilter(0);
end;

end.
