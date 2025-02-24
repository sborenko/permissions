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
    ListBxAffApps: TCheckListBox;
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
    ListBxGrantUsrs: TCheckListBox;
    PopupGrantPerm: TPopupMenu;
    NGrantPerm: TMenuItem;
    NRevokePerm: TMenuItem;
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
    procedure ListBxAffAppsClickCheck(Sender: TObject);
    procedure ListBxGrantUsrsClickCheck(Sender: TObject);
    procedure ComboAppFilterClick(Sender: TObject);
    procedure BtnClearAppFilterClick(Sender: TObject);
  private
    Perm: TPerm;

    procedure OpenAppFilterQry;
    procedure LoadApps;
    procedure RefreshAffApps;

    procedure LoadUsrs;
    procedure RefreshGrantUsrs(PermAppId: Integer);

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
  ListBxAffApps.OnChange := OnAffAppScrollHnd;
  ListBxGrantUsrs.Enabled := false;

  Perm := TPerm.Open;
  Perm.OnPermScroll := OnPermScrollHnd;
  Perm.OnAffAppAdd := OnAffAppAddHnd;
  Perm.OnAffAppRevoke := OnAffAppRevokeHnd;

  DsrcPerms.DataSet := Perm.GetPerms;

  OpenAppFilterQry;

  LoadApps;
  RefreshAffApps;

  LoadUsrs;
  // "дёрнуть" ChangeItem;
  ListBxAffApps.ForceSelection;

  // "дёрнуть" Resize;
  PanelPerms.OnResize(nil);
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
  App := TApp.Open;

  with App.GetApps do begin
    while not Eof do begin
      ListBxAffApps.AddItem(
        TextUtils.PadRight(
          '     ' + FieldByName(App.FieldName('Code')).AsString, ' ', 30) +
          FieldByName(App.FieldName('Name')).AsString,
        TIdObject.Create(NOID, FieldByName(App.FieldName('Id')).AsInteger)
      );

      Next;
    end;
  end;

  TApp.Release(App);
end;

//------------------------------------------------------------------------------
procedure TFrmPermList.OnPermScrollHnd;
begin
  RefreshAffApps;
  RefreshGrantUsrs(GetSelectedAppId);
end;

//------------------------------------------------------------------------------
procedure TFrmPermList.RefreshAffApps;
var
  App: TItem;
  AppId, PermAppId, I: Integer;
  AffApps: TDataSet;
begin
  App := TApp.Create;

  AffApps := Perm.GetAffApps;

  with ListBxAffApps do
    for I := 0 to Count - 1 do begin
      AppId := (Items.Objects[I] as TIdObject).EntityId;
      PermAppId := NOID;

      with AffApps do
        if Locate(App.RefFldName, AppId, []) then
          PermAppId := FieldByName('Id').AsInteger;

      if PermAppId <> NOID then begin
        (Items.Objects[I] as TIdObject).ItemId := PermAppId;
        Checked[I] := true;
      end else
        Checked[I] := false;
    end;

  App.Free;
end;

//------------------------------------------------------------------------------
procedure TFrmPermList.ListBxAffAppsClickCheck(Sender: TObject);
var
  PermAppId, Indx: Integer;
begin
  with ListBxAffApps do begin
    Indx := GetSelectedIndx;
    PermAppId := (Items.Objects[Indx] as TIdObject).ItemId;

    if PermAppId = NOID then begin
      PermAppId := Perm.AddAffApp((Items.Objects[Indx] as TIdObject).EntityId);
      (Items.Objects[Indx] as TIdObject).ItemId := PermAppId;
      ListBxGrantUsrs.Enabled := true;
    end else begin
      Perm.RevokeApp(PermAppId);
      (Items.Objects[Indx] as TIdObject).ItemId := NOID;
      ListBxGrantUsrs.Enabled := false;
    end;
  end;

  RefreshGrantUsrs(PermAppId);
end;

//------------------------------------------------------------------------------
function TFrmPermList.GetSelectedAppId: Integer;
var
  Indx: Integer;
begin
  with ListBxAffApps do begin
    Indx := GetSelectedIndx;

    if Indx = -1 then
      Result := 0
    else
      Result := (Items.Objects[Indx] as TIdObject).ItemId;
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
      ListBxGrantUsrs.AddItem(
        TextUtils.PadRight(
          '     ' + FieldByName(FieldName('Name')).AsString, ' ', 30) +
          FieldByName(FieldName('Notes')).AsString,
        TIdObject.Create(NOID, FieldByName(FieldName('Id')).AsInteger)
      );

      Next;
    end;
  end;

  TUser.Release(User);
end;

//------------------------------------------------------------------------------
procedure TFrmPermList.OnAffAppScrollHnd(Sender: TObject);
var
  PermAppId: Integer;
begin
  PermAppId := GetSelectedAppId;
  RefreshGrantUsrs(PermAppId);
  ListBxGrantUsrs.Enabled := PermAppId <> NOID;
end;

//------------------------------------------------------------------------------
// Проставляем check'и для пользователей, которым разрешён доступ к приложению
// AppId
//------------------------------------------------------------------------------
procedure TFrmPermList.RefreshGrantUsrs(PermAppId: Integer);
var
  User: TUser;
  UserId, GrantId, I: Integer;
  GrantUsrs: TDataSet;
begin
  User := TUser.Create;

  GrantUsrs := Perm.GetGrantUsrs(PermAppId);

  with ListBxGrantUsrs do
    for I := 0 to Count - 1 do begin
      UserId := (Items.Objects[I] as TIdObject).EntityId;
      GrantId := NOID;

      with GrantUsrs do
        if Locate(User.RefFldName, UserId, []) then
          GrantId := GrantUsrs.FieldByName('Id').AsInteger;

      if GrantId <> NOID then begin
        (Items.Objects[I] as TIdObject).ItemId := GrantId;
        Checked[I] := true;
      end else
        Checked[I] := false;
    end;

  User.Free;
end;

//------------------------------------------------------------------------------
procedure TFrmPermList.ListBxGrantUsrsClickCheck(Sender: TObject);
var
  UserIndx, AppIndx, PermAppId, UserId, GrantId: Integer;
begin
  with ListBxGrantUsrs do begin
    UserIndx := GetSelectedIndx;

    if Checked[UserIndx] then begin
      AppIndx := ListBxAffApps.GetSelectedIndx;
      PermAppId := (ListBxAffApps.Items.Objects[AppIndx] as TIdObject).ItemId;

      UserId := (Items.Objects[UserIndx] as TIdObject).EntityId;
      GrantId := Perm.GrantPerm(UserId, PermAppId);
      (Items.Objects[UserIndx] as TIdObject).ItemId := GrantId;
    end else begin
      GrantId := (Items.Objects[UserIndx] as TIdObject).ItemId;
      Perm.RevokeGrant(GrantId);
      (Items.Objects[UserIndx] as TIdObject).ItemId := NOID;
    end;
  end;
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
  ListBxAffApps.Width := PanelAffApps.Width - ListBxAffApps.Left - 3;
  ListBxAffApps.Height := PanelAffApps.Height - ListBxAffApps.Top - 3;
end;

//------------------------------------------------------------------------------
procedure TFrmPermList.TabGrantUsrsResize(Sender: TObject);
begin
  ListBxGrantUsrs.Width := TabGrantUsrs.ClientWidth;
  ListBxGrantUsrs.Height := TabGrantUsrs.ClientHeight;
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

//------------------------------------------------------------------------------
procedure TFrmPermList.ComboAppFilterClick(Sender: TObject);
var
  App: TApp;
begin
  App := TApp.Create;
  Perm.SetFilter(QryAppFilter.FieldByName(App.FieldName('Id')).AsInteger);
  App.Free;
end;

//------------------------------------------------------------------------------
procedure TFrmPermList.BtnClearAppFilterClick(Sender: TObject);
begin
  ComboAppFilter.KeyValue := 0;
  Perm.SetFilter(0);
end;

end.
