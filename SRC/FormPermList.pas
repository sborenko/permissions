unit FormPermList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, DBCtrls, CheckLst, ExtCtrls;

type
  TFrmPermList = class(TForm)
    PanelRight: TPanel;
    PanelBottom: TPanel;
    DBGrid1: TDBGrid;
    PanelApps: TPanel;
    PanelFilter: TPanel;
    SplitterMain: TSplitter;
    SplitterRight: TSplitter;
    DbgrGrantedUsers: TDBGrid;
    DBComboBox1: TDBComboBox;
    ChLstBox: TCheckListBox;
    LblFilter: TLabel;
    LblAffectedApps: TLabel;
    LblGrantedUsers: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ChLstBoxClickCheck(Sender: TObject);
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

procedure TFrmPermList.ChLstBoxClickCheck(Sender: TObject);
begin
  ChLstBox.
  if ChLstBox.Selected[0] then
    ShowMessage('Hi');
end;

end.
