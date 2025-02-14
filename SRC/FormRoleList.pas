unit FormRoleList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, FormList;

type
  TFrmRoleList = class(TFrmList)
    PanelBottom: TPanel;
    PanelLeft: TPanel;
    PanelRight: TPanel;
    SplitLeftRight: TSplitter;
    PanelPermApps: TPanel;
    Splitter2: TSplitter;
    PanelUsrs: TPanel;
    PanelUsrGrps: TPanel;
    SplitUsrUsrGrps: TSplitter;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRoleList: TFrmRoleList;

implementation

{$R *.dfm}

procedure TFrmRoleList.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
