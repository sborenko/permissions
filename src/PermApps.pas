unit PermApps;

interface

uses Item;

type
  TPermApps = class(TItem)
  protected
    function DataSetName: ShortString; override;
    function DataSetFields: String; override;
  end;

implementation

uses
  TextLib;

//------------------------------------------------------------------------------
function TPermApps.DataSetName: ShortString;
begin
  Result := 'PermApps';
end;

//------------------------------------------------------------------------------
function TPermApps.DataSetFields: String;
begin
  Result := TextUtils.ConcatStr(inherited DataSetFields, 'AppId Int', ', ');
end;

end.
