unit Item;

interface

uses
  DbTables;

type
  TItem = class
  private
    procedure RunTblDDLStmt(Stmt: ShortString; IfExists: Boolean);
    procedure RunGenDDLStmt(Stmt: ShortString; IfExists: Boolean);

  protected
    function FieldDefs: String; virtual;
    function FieldNames: String; virtual;
    procedure Execute(Stmt: String);

    procedure PopulateUpdSQL(Item: TItem; UpdSQL: TUpdateSQL);
  public
    function DatasetName: ShortString; virtual; abstract;
    function DecorDsName: ShortString; virtual;

    procedure CreateTable; virtual;
    procedure DropTable; virtual;

    function FieldName(Name: ShortString): ShortString; virtual;
  end;

implementation

uses
  Classes, QryLib, SysUtils, TextLib;

//------------------------------------------------------------------------------
procedure TItem.CreateTable;
begin
  RunTblDDLStmt(
    'create table ' + DecorDsName + '(' + FieldDefs + ')',
    false
  );
  Execute(
    'alter table ' + DecorDsName + ' ' +
      'add primary key (' + FieldName('Id') + ')'
  );
  RunGenDDLStmt(
    'create sequence ' + DecorDsName, false
  );
  Execute(
    'alter sequence ' + DecorDsName + ' restart with 0'
  );
end;

//------------------------------------------------------------------------------
procedure TItem.DropTable;
begin
  RunTblDDLStmt(
    'drop table ' + DecorDsName, true
  );
  RunGenDDLStmt(
    'drop generator ' + DecorDsName, true
  );
end;

//------------------------------------------------------------------------------
function TItem.DecorDsName: ShortString;
begin
  Result := 'P$' + DatasetName;
end;

//------------------------------------------------------------------------------
function TItem.FieldDefs: String;
begin
  Result := FieldName('Id') + ' Integer not null';
end;

//------------------------------------------------------------------------------
function TItem.FieldNames: String;
begin
  Result := 'Id';
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
        'where rdb$relation_name = "' + UpperCase(DecorDsName) + '"' +
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
          'and rdb$generator_name = "' + UpperCase(DecorDsName) + '"' +
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
function TItem.FieldName(Name: ShortString): ShortString;
begin
  Result := Name;
end;

//------------------------------------------------------------------------------
procedure TItem.PopulateUpdSQL(Item: TItem; UpdSQL: TUpdateSQL);
var
  FldList: TStringList;
  I: Integer;
  FldName: ShortString;

  InsFldsClause,
  InsParamsClause,
  UpdValsClause,
  IdClause,
  OldIdClause: String;

  function ParamName: ShortString;
  begin
    Result := ':' + FldName;
  end;
begin
  InsFldsClause := '';
  InsParamsClause := '';

  FldList := TextUtils.SplitStr(Item.FieldDefs, ',');

  UpdValsClause := '';

  for I := 0 to FldList.Count - 1 do begin
    FldName := Copy(FldList[I], 1, Pos(' ', FldList[I]) - 1);

    InsFldsClause := TextUtils.ConcatStr(InsFldsClause, FldName, ', ');
    InsParamsClause := TextUtils.ConcatStr(InsParamsClause, ParamName, ', ');

    if I = 0 then begin
      IdClause := FldName;
      OldIdClause := ':OLD_' + FldName;
    end;

    if I > 0 then
      UpdValsClause := TextUtils.ConcatStr(
        UpdValsClause, FldName + ' = ' + ParamName, ', '
      );
  end;

  with UpdSQL do begin
    InsertSQL.Text :=
      'insert into ' + Item.DecorDsName + ' ' +
      '(' + InsFldsClause + ') ' +
      'values ' +
      '(' + InsParamsClause + ')';

    ModifySQL.Text :=
      'update ' + Item.DecorDsName + ' ' +
      'set ' + UpdValsClause + ' ' +
      'where ' + IdClause + ' = ' + OldIdClause;

    DeleteSQL.Text :=
      'delete from ' + Item.DecorDsName + ' ' +
      'where ' + IdClause + ' = ' + OldIdClause;
  end;
end;

end.
