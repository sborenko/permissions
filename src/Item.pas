unit Item;

interface

uses
  Classes;

type

  TItem = class(TInterfacedObject)
  private
//    Id: Integer;
    procedure CreateTable;
    procedure DropTable;

    procedure Execute(Stmt: ShortString);

    procedure RunTblDDLStmt(Stmt: ShortString; IfExists: Boolean);
    procedure RunGenDDLStmt(Stmt: ShortString; IfExists: Boolean);

  protected
    function DatasetFields: String; virtual;
  public
    function DatasetName: ShortString; virtual; abstract;
    procedure Init; virtual;
  end;

implementation

uses
  DbTables, QryLib, SysUtils, TextLib;

//------------------------------------------------------------------------------
procedure TItem.Init;
begin
  DropTable;
  CreateTable;
end;

//------------------------------------------------------------------------------
procedure TItem.CreateTable;
begin
  RunTblDDLStmt(
    'create table ' + DatasetName + '(' + DatasetFields + ')', false
  );
  RunGenDDLStmt(
    'create sequence ' + DatasetName, false
  );
  Execute(
    'alter sequence ' + DatasetName + ' restart with 0'
  );
end;

//------------------------------------------------------------------------------
procedure TItem.DropTable;
begin
  RunTblDDLStmt(
    'drop table ' + DatasetName, true
  );
  RunGenDDLStmt(
    'drop generator ' + DatasetName, true
  );
end;

//------------------------------------------------------------------------------
function TItem.DataSetFields: String;
begin
  Result := 'Id Int';
end;

//------------------------------------------------------------------------------
procedure TItem.RunTblDDLStmt(Stmt: ShortString; IfExists: Boolean);
var
  NotClause: ShortString;
begin
  if IfExists then
    NotClause := ''
  else
    NotClause := 'not ';

  Execute(
    'execute block as begin ' +
      'if (' + NotClause + 'exists(' +
        'select 1 ' +
        'from rdb$relations ' +
        'where rdb$relation_name = "' + UpperCase(DatasetName) + '"' +
      ')) ' +
      'then execute statement "' + Stmt + '"; ' +
    'end'
  );
end;

//------------------------------------------------------------------------------
procedure TItem.RunGenDDLStmt(Stmt: ShortString; IfExists: Boolean);
var
  NotClause: ShortString;
begin
  if IfExists then
    NotClause := ''
  else
    NotClause := 'not ';

  Execute(
    'execute block as begin ' +
      'if (' + NotClause + 'exists(' +
        'select 1 ' +
        'from rdb$generators ' +
        'where coalesce(RDB$SYSTEM_FLAG, 0) = 0 ' +
          'and rdb$generator_name = "' + UpperCase(DatasetName) + '"' +
      ')) ' +
      'then execute statement "' + Stmt + '"; ' +
    'end'
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
