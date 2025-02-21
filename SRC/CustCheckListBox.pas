unit CustCheckListBox;

interface

uses
  CheckLst, Classes, Controls, Messages;

type
  TCheckListBox = class(CheckLst.TCheckListBox)
  private
    FItemIndex: Integer;
    FOnChange: TNotifyEvent;
    procedure CNCommand(var AMessage: TWMCommand); message CN_COMMAND;
  protected
    procedure Change; virtual;
    procedure SetItemIndex(const Value: Integer); override;
  published
    property OnChange: TNotifyEvent read FOnChange write FOnChange;

    function GetSelectedIndx: Integer;
  end;

implementation

//------------------------------------------------------------------------------
procedure TCheckListBox.CNCommand(var AMessage: TWMCommand);
begin
  inherited;

  if (AMessage.NotifyCode = LBN_SELCHANGE)
    and (FItemIndex <> ItemIndex) then
  begin
    FItemIndex := ItemIndex;
    Change;
  end;
end;

//------------------------------------------------------------------------------
procedure TCheckListBox.SetItemIndex(const Value: Integer);
begin
  inherited;

  if FItemIndex <> ItemIndex then begin
    FItemIndex := ItemIndex;
    Change;
  end;
end;

//------------------------------------------------------------------------------
procedure TCheckListBox.Change;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

//------------------------------------------------------------------------------
function TCheckListBox.GetSelectedIndx: Integer;
var
  I: Integer;
begin
  Result := -1;

  for I := 0 to Count - 1 do
    if Selected[I] then begin
      Result := I;
      break;
    end;
end;

end.
