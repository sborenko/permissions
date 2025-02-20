unit FormPermList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, DBCtrls, CheckLst, ExtCtrls, DB,
  ComCtrls, Menus, FormList, Permission, DBTables;

type
  TIdObject = class
    Id: Integer;
  public
    constructor Create(Id: Integer); reintroduce;
    destructor Destroy; override;
  end;

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
    DbCmbBoxAppFilter: TDBComboBox;
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
    ChLstBxUsrPermApps: TCheckListBox;
    PopupGrantPerm: TPopupMenu;
    NGrantPerm: TMenuItem;
    NRevokePerm: TMenuItem;
    QryApps: TQuery;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PanelPermsResize(Sender: TObject);
    procedure PanelAffAppsResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TabGrantUsrsResize(Sender: TObject);
    procedure NAddPermissionClick(Sender: TObject);
    procedure NEditPermissionClick(Sender: TObject);
    procedure ChLstBxAffAppsClickCheck(Sender: TObject);
  private
    Perm: TPerm;

    procedure LoadApps;
    procedure CheckPermApps;
    function IndexOf(AppId: Integer): Integer;
  public
  end;

var
  FrmPermList: TFrmPermList;

implementation

uses
  App, DModMain, FormEditPerm, PermApp, QryLib;

{$R *.dfm}

//------------------------------------------------------------------------------
constructor TIdObject.Create(Id: Integer);
begin
  Self.Id := Id;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
destructor TIdObject.Destroy;
begin
  inherited Destroy;
end;

//------------------------------------------------------------------------------
procedure TFrmPermList.FormCreate(Sender: TObject);
begin
  Perm := TPerm.Open;
  DsrcPerms.DataSet := Perm.GetPerms;

  LoadApps;
  CheckPermApps;
end;

//------------------------------------------------------------------------------
procedure TFrmPermList.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;

  TPerm.Release(Perm);
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
      'from ' + App.DatasetName;
    Open;

    while not Eof do begin
      ChLstBxAffApps.AddItem(
        FieldByName(App.FieldName('Name')).AsString,
        TIdObject.Create(FieldByName(App.FieldName('Id')).AsInteger)
      );
      Next;
    end;
  end;

  App.Free;
end;

//------------------------------------------------------------------------------
procedure TFrmPermList.CheckPermApps;
var
  Indx: Integer;
begin
  with Perm.GetAffApps do begin
    First;

    while not Eof do begin
      Indx := IndexOf(FieldByName('EntityId').AsInteger);
      ChLstBxAffApps.Checked[Indx] := true;

      Next;
    end;
  end;
end;

//------------------------------------------------------------------------------
function TFrmPermList.IndexOf(AppId: Integer): Integer;
var
  I: Integer;
begin
  Result := -1;

  for I := 0 to ChLstBxAffApps.Count - 1 do
    if (ChLstBxAffApps.Items.Objects[I] as TIdObject).Id = AppId then begin
      Result := I;
      break;
    end;
end;

//------------------------------------------------------------------------------
procedure TFrmPermList.ChLstBxAffAppsClickCheck(Sender: TObject);
var
  I: Integer;
begin
  with ChLstBxAffApps do
    for I := 0 to Count - 1 do
      if Selected[I] then begin
        if Checked[I] then
          Perm.AddAffApp((Items.Objects[I] as TIdObject).Id)
        else
          Perm.RevokeAff((Items.Objects[I] as TIdObject).Id);

        break;
      end;
end;

//------------------------------------------------------------------------------
procedure TFrmPermList.PanelPermsResize(Sender: TObject);
begin
  DbCmbBoxAppFilter.Width := PanelPerms.Width - DbCmbBoxAppFilter.Left - 3;

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
  ChLstBxUsrPermApps.Width := TabGrantUsrs.ClientWidth;
  ChLstBxUsrPermApps.Height := TabGrantUsrs.ClientHeight;
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

end.
