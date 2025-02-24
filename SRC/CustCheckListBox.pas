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
    constructor Create(AOwner: TComponent); override;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;

    function GetSelectedIndx: Integer;
    procedure ForceSelection;
  end;

implementation

//------------------------------------------------------------------------------
constructor TCheckListBox.Create(AOwner: TComponent);
begin
  inherited;
  FItemIndex := -1;
end;

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
procedure TCheckListBox.ForceSelection;
begin
  if Items.Count > 0 then
    SetItemIndex(0);
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
