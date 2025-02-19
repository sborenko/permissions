unit FormEditPerm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, DBCtrls, Mask, DB;

type
  TFrmEditPerm = class(TForm)
    LblName: TLabel;
    LblNotes: TLabel;
    DbeName: TDBEdit;
    DbmNotes: TDBMemo;
    DBChBxAllApps: TDBCheckBox;
    PanelBottom: TPanel;
    BtnOk: TBitBtn;
    BtnCancel: TBitBtn;
    DsrcPerm: TDataSource;
    procedure FormCreate(Sender: TObject);
  private
    PermRec: TDataSet;
    constructor Create(PermRec: TDataSet); reintroduce;
  public
    class function Run(PermRec: TDataSet): Integer;
  end;

implementation

{$R *.dfm}

//------------------------------------------------------------------------------
class function TFrmEditPerm.Run(PermRec: TDataSet): Integer;
begin
  with TFrmEditPerm.Create(PermRec) do begin
    Result := ShowModal;
    Free;
  end;
end;

//------------------------------------------------------------------------------
constructor TFrmEditPerm.Create(PermRec: TDataSet);
begin
  inherited Create(nil);
  
  Self.PermRec := PermRec;
end;

//------------------------------------------------------------------------------
procedure TFrmEditPerm.FormCreate(Sender: TObject);
begin
  DsrcPerm.DataSet := PermRec;
end;

end.
