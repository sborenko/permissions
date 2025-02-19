unit FormPermList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, DBCtrls, CheckLst, ExtCtrls, DB,
  ComCtrls, Menus, FormList, Permission;

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
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PanelPermsResize(Sender: TObject);
    procedure PanelAffAppsResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TabGrantUsrsResize(Sender: TObject);
    procedure NAddPermissionClick(Sender: TObject);
    procedure NEditPermissionClick(Sender: TObject);
  private
    Perm: TPerm;
  public
    { Public declarations }
  end;

var
  FrmPermList: TFrmPermList;

implementation

uses
  FormEditPerm;

{$R *.dfm}

//------------------------------------------------------------------------------
procedure TFrmPermList.FormCreate(Sender: TObject);
begin
  Perm := TPerm.Open;
  DsrcPerms.DataSet := Perm.GetPerms;
end;

//------------------------------------------------------------------------------
procedure TFrmPermList.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;

  TPerm.Release(Perm);
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
