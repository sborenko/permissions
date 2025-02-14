unit FormUserList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  FormList, Dialogs, StdCtrls, Buttons, ActnList, Grids, DBGrids, CheckLst,
  ExtCtrls;

type
  TFrmUsrList = class(TFrmList)
    ActionList: TActionList;
    ActNewUser: TAction;
    ActDelete: TAction;
    ActSelect: TAction;
    PanelClient: TPanel;
    PanelPemrs: TPanel;
    PanelRoles: TPanel;
    Splitter1: TSplitter;
    PanelUsrs: TPanel;
    DbgrUsrs: TDBGrid;
    LblPerms: TLabel;
    LblRoles: TLabel;
    LblUsers: TLabel;
    DbgrPerms: TDBGrid;
    DbgrRoles: TDBGrid;
    PanelBottom: TPanel;
    PanelUsrGrps: TPanel;
    SplitUsrGrpsPems: TSplitter;
    SplitPermRoles: TSplitter;
    ChLstBxUsrGrps: TCheckListBox;
    LblUsrGrps: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ActNonSelectUpdate(Sender: TObject);
    procedure ActSelectUpdate(Sender: TObject);
    procedure DbgrUsrsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  end;

var
  FrmUsrList: TFrmUsrList;

implementation

{$R *.dfm}

//------------------------------------------------------------------------------
procedure TFrmUsrList.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if not SelectionMode then begin
    FrmUsrList := nil;
    Action := caFree;
  end;
end;

//------------------------------------------------------------------------------
procedure TFrmUsrList.ActNonSelectUpdate(Sender: TObject);
begin
  (Sender as TAction).Visible := not SelectionMode;
end;
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
procedure TFrmUsrList.ActSelectUpdate(Sender: TObject);
begin
  (Sender as TAction).Visible := SelectionMode;
end;

//------------------------------------------------------------------------------
procedure TFrmUsrList.DbgrUsrsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    ModalResult := mrOk
  else if Key = VK_ESCAPE then
    ModalResult := mrCancel;
end;

end.
