unit Item;

interface

type

  TItem = class
  private
//    Id: Integer;
    procedure CreateTable;
    procedure Drop; virtual;

    procedure CreateGenerator;
    procedure Execute(Stmt: ShortString);

  protected
    function TblCreateStmt: String;
    function DatasetName: ShortString; virtual; abstract;
    function DatasetFields: String; virtual;
  public
    procedure Init;
  end;

implementation

uses
  DbTables, QryLib, TextLib;

//------------------------------------------------------------------------------
procedure TItem.Init;
begin
  Drop;
  CreateTable;
end;

//------------------------------------------------------------------------------
function TItem.TblCreateStmt: String;
begin
  Result :=
    'create table ' + DatasetName + '(' +
      DatasetFields +
    ')';
end;

//------------------------------------------------------------------------------
function TItem.DataSetFields: String;
begin
  Result := 'Id Int';
end;

//------------------------------------------------------------------------------
procedure TItem.CreateTable;
begin
  Execute(TblCreateStmt);
  CreateGenerator;
end;

//------------------------------------------------------------------------------
procedure TItem.Drop;
begin
  Execute(
    'drop table ' + DatasetName
  );
  Execute(
    'drop generator ' + DatasetName
  );
end;

//------------------------------------------------------------------------------
procedure TItem.CreateGenerator;
begin
  Execute(
    'create sequence ' + DatasetName
  );
  Execute(
    'alter sequence ' + DatasetName + ' restart with 0'
  );
end;

//------------------------------------------------------------------------------
procedure TItem.Execute(Stmt: ShortString);
var
  Query: TQuery;
begin
  Query := TQuery.Create(nil);
  QryUtils.InitQuery(Query);

  with Query do begin
    SQL.Text := Stmt;
    ExecSQL;
    Free;
  end;
end;

end.
