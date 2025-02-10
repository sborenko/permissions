unit FormPermList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, DBCtrls, CheckLst, ExtCtrls;

type
  TFormPermissions = class(TForm)
    PanelRight: TPanel;
    PanelBottom: TPanel;
    CheckListBox1: TCheckListBox;
    DBComboBox1: TDBComboBox;
    LblAffectedApps: TLabel;
    LblFilter: TLabel;
    DBGrid1: TDBGrid;
    DbgrGrantedUsers: TDBGrid;
    LblGrantedUsers: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPermissions: TFormPermissions;

implementation

{$R *.dfm}

end.
