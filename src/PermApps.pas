unit PermApps;

interface

uses Item;

type
  TPermApp = class(TItem)
  protected
    class function DataSetName: ShortString;
    function DataSetFields: String; override;
  end;

implementation

//------------------------------------------------------------------------------
class function TPermApps.DataSetName: ShortString;
begin
  Result := 'PermApps';
end;

//------------------------------------------------------------------------------
function TPermApps.DataSetFields: String;
begin
  Result := TextUtils.ConcatStr(inherited DataSetFields, 'AppId Int', ', ');
end;

end.
