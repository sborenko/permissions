unit FormList;

interface

uses
  Forms;

type

  TFrmList = class(TForm)
  public
    function SelectionMode: Boolean;
    function SelectionResult: Integer;
  end;

implementation

uses
  Controls;

//------------------------------------------------------------------------------
function TFrmList.SelectionMode: Boolean;
begin
  Result := FormStyle <> fsMDIChild;
end;

//------------------------------------------------------------------------------
function TFrmList.SelectionResult: Integer;
begin
  if ModalResult = mrOk then
    Result := 100
  else
    Result := 0
end;

end.
