unit DModMain;

interface

uses
  DB, DBTables, SysUtils, Classes;

type
  TDmMain = class(TDataModule)
    Database: TDatabase;
    procedure DataModuleCreate(Sender: TObject);
  end;

var
  DmMain: TDmMain;

implementation

{$R *.dfm}

//------------------------------------------------------------------------------
procedure TDmMain.DataModuleCreate(Sender: TObject);
begin
  with Database do begin
    AliasName := 'PERMISSIONS';
    Connected := true;
  end;
end;

end.
