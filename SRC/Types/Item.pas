unit Item;

interface

uses
  Classes;

type

  TItem = class(TInterfacedObject)
  private
    procedure RunTblDDLStmt(Stmt: ShortString; IfExists: Boolean);
    procedure RunGenDDLStmt(Stmt: ShortString; IfExists: Boolean);

  protected
    function DatasetFields: String; virtual;
    procedure Execute(Stmt: String);

  public
    function DatasetName: ShortString; virtual; abstract;

    procedure CreateTable; virtual;
    procedure DropTable; virtual;

    function MapFieldName(Name: ShortString): ShortString; virtual;
  end;

implementation

uses
  DbTables, QryLib, SysUtils, TextLib;

//------------------------------------------------------------------------------
procedure TItem.CreateTable;
begin
  RunTblDDLStmt(
    'create table ' + DatasetName + '(' + DatasetFields + ')',
    false
  );
  Execute(
    'alter table ' + DatasetName + ' ' +
      'add primary key (' + MapFieldName('Id') + ')'
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
  Result := MapFieldName('Id') + ' Integer not null';
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
procedure TItem.Execute(Stmt: String);
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

//------------------------------------------------------------------------------
function TItem.MapFieldName(Name: ShortString): ShortString;
begin
  Result := Name;
end;

end.
