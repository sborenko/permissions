unit FormUserList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  FormList, Dialogs, StdCtrls, Buttons, ActnList, Grids, DBGrids;

type
  TFrmUsrList = class(TFormList)
    BtnSelect: TBitBtn;
    BtnNewUser: TBitBtn;
    BitBtn4: TBitBtn;
    DbgrUsers: TDBGrid;
    ActionList: TActionList;
    ActNewUser: TAction;
    ActDelete: TAction;
    ActSelect: TAction;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ActNonSelectUpdate(Sender: TObject);
    procedure ActSelectUpdate(Sender: TObject);
    procedure DbgrUsersKeyDown(Sender: TObject; var Key: Word;
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
procedure TFrmUsrList.DbgrUsersKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    ModalResult := mrOk
  else if Key = VK_ESCAPE then
    ModalResult := mrCancel;
end;

end.
