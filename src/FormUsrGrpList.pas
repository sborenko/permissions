unit FormUsrGrpList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  FormList, Dialogs, ActnList, Menus, ComCtrls, StdCtrls, Buttons;

type
  TFrmUsrGrpList = class(TFormList)
    TreeUsrGroups: TTreeView;
    ActionList: TActionList;
    ActNewGroup: TAction;
    ActAddGroup: TAction;
    ActAddUser: TAction;
    ActDeleteItem: TAction;
    PopupMenu: TPopupMenu;
    PopNewGroup: TMenuItem;
    Sep1: TMenuItem;
    PopAddGroup: TMenuItem;
    PopAddUser: TMenuItem;
    Sep2: TMenuItem;
    PopDeleteItem: TMenuItem;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BtnSelect: TBitBtn;
    ActSelect: TAction;
    PopSelect: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ActAddGroupExecute(Sender: TObject);
    procedure ActNewGroupExecute(Sender: TObject);
    procedure ActAddUserExecute(Sender: TObject);
    procedure ActDeleteItemExecute(Sender: TObject);
    procedure ActSelectUpdate(Sender: TObject);
    procedure ActNonSelectUpdate(Sender: TObject);
    procedure TreeUsrGroupsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    procedure LoadTree;

  public
  end;

var
  FrmUsrGrpList: TFrmUsrGrpList;

implementation

uses
  FormUserList;

{$R *.dfm}

//------------------------------------------------------------------------------
procedure TFrmUsrGrpList.LoadTree;
begin
  if SelectionMode then
  else
end;

//------------------------------------------------------------------------------
procedure TFrmUsrGrpList.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if not SelectionMode then begin
    FrmUsrGrpList := nil;
    Action := caFree;
  end;
end;

//------------------------------------------------------------------------------
procedure TFrmUsrGrpList.ActNewGroupExecute(Sender: TObject);
begin
  ShowMessage('Hi');
end;
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
procedure TFrmUsrGrpList.ActAddGroupExecute(Sender: TObject);
begin
  with TFrmUsrGrpList.Create(nil) do begin
    ShowModal;

    if SelectionResult > 0 then
      ShowMessage('Group added');
  end;
end;
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
procedure TFrmUsrGrpList.ActAddUserExecute(Sender: TObject);
begin
  with TFrmUsrList.Create(nil) do begin
    ShowModal;

    if SelectionResult > 0 then
      ShowMessage('User added');
  end;
end;
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
procedure TFrmUsrGrpList.ActDeleteItemExecute(Sender: TObject);
begin
  ShowMessage('Hi');
end;

//------------------------------------------------------------------------------
procedure TFrmUsrGrpList.ActSelectUpdate(Sender: TObject);
begin
  (Sender as TAction).Visible := SelectionMode;
end;
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
procedure TFrmUsrGrpList.ActNonSelectUpdate(Sender: TObject);
begin
  (Sender as TAction).Visible := not SelectionMode;
end;

//------------------------------------------------------------------------------
procedure TFrmUsrGrpList.TreeUsrGroupsKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    ModalResult := mrOk
  else if Key = VK_ESCAPE then
    ModalResult := mrCancel;
end;

end.
