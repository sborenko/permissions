unit PermApp;

interface

uses
  Item;

type
  TPermApp = class(TItem)
  public
    function DatasetName: ShortString; override;
    function FieldDefs: String; override;
  end;

implementation

uses
  TextLib;

//------------------------------------------------------------------------------
function TPermApp.DatasetName;
begin
  Result := DATASET_PREFIX + 'PermApp';
end;

//------------------------------------------------------------------------------
function TPermApp.FieldDefs: String;
begin
  Result := inherited FieldDefs;
  Result := TextUtils.ConcatStr(Result, 'PermId Integer not null', ', ');
  Result := TextUtils.ConcatStr(Result, 'AppId Integer not null', ', ');
end;

end.
