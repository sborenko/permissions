unit Item;

interface

type

  TItem = class
  private
//    Id: Integer;

    procedure CreateTable;
    procedure Execute(Stmt: ShortString);

  protected
    function DatasetName: ShortString; virtual; abstract;
    function DatasetFields: String; virtual;
  public
    function GetCreateTblStmt: String;
  end;

implementation

uses
  QryLib, TextLib;

//------------------------------------------------------------------------------
function TItem.GetCreateTblStmt: String;
begin
  Result :=
    'create table ' + DatasetName +
    '(' + DatasetFields + ')';
end;

//------------------------------------------------------------------------------
function TItem.DataSetFields: String;
begin
  Result := 'Id Int';
end;

//------------------------------------------------------------------------------
procedure TItem.CreateTable;
begin
  Execute(GetCreateTblStmt);
  QryUtils.g
end;

//------------------------------------------------------------------------------
procedure TItem.Execute(Stmt: ShortString);
begin
end;

end.
