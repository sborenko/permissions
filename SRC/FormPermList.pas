unit FormPermList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, DBCtrls, CheckLst, ExtCtrls, DB,
  ComCtrls, Menus, FormList;

type
  TFrmPermList = class(TFrmList)
    PanelRight: TPanel;
    PanelBottom: TPanel;
    PanelAffApps: TPanel;
    PanelGrantUsrs: TPanel;
    SplitterMain: TSplitter;
    SplitterRight: TSplitter;
    ChLstBoxAffApps: TCheckListBox;
    LblAffectedApps: TLabel;
    DataSource1: TDataSource;
    PanelPerms: TPanel;
    DbgrPerms: TDBGrid;
    LblFilter: TLabel;
    DbCmbBoxAppFilter: TDBComboBox;
    PopupMenu1: TPopupMenu;
    PageCtrlGrants: TPageControl;
    TabGrantRoles: TTabSheet;
    TabGrantUsrs: TTabSheet;
    TabGrantUsrGrps: TTabSheet;
    DbgrGrantUsrs: TDBGrid;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PanelPermsResize(Sender: TObject);
    procedure TabGrantUsrGrpsResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPermList: TFrmPermList;

implementation

{$R *.dfm}

procedure TFrmPermList.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFrmPermList.PanelPermsResize(Sender: TObject);
begin
  DbCmbBoxAppFilter.Width := PanelPerms.Width - DbCmbBoxAppFilter.Left - 3;

  DbgrPerms.Width := PanelPerms.Width - 3;
  DbgrPerms.Height := PanelPerms.Height - DbgrPerms.Top - 3;
end;

procedure TFrmPermList.TabGrantUsrGrpsResize(Sender: TObject);
var
  Tab: TTabSheet;
begin
end;

end.
