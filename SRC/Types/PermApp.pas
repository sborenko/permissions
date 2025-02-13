unit PermApp;

interface

uses
  Item;

type
  TPermApp = class(TItem)
  public
    function DatasetName: ShortString; override;
    function DatasetFields: String; override;
  end;

implementation

uses
  TextLib;

//------------------------------------------------------------------------------
function TPermApp.DatasetName;
begin
  Result := 'PermApp';
end;

//------------------------------------------------------------------------------
function TPermApp.DatasetFields: String;
begin
  Result := inherited DatasetFields;
  Result := TextUtils.ConcatStr(Result, 'PermId Integer not null', ', ');
  Result := TextUtils.ConcatStr(Result, 'AppId Integer not null', ', ');
end;

end.
