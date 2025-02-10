unit FormList;

interface

uses
  Forms;

type

  TFormList = class(TForm)
  public
    function SelectionMode: Boolean;
    function SelectionResult: Integer;
  end;

implementation

uses
  Controls;

//------------------------------------------------------------------------------
function TFormList.SelectionMode: Boolean;
begin
  Result := FormStyle <> fsMDIChild;
end;

//------------------------------------------------------------------------------
function TFormList.SelectionResult: Integer;
begin
  if ModalResult = mrOk then
    Result := 100
  else
    Result := 0
end;

end.
