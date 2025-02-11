unit App;

interface

uses
  NamedItem;

type

  TApp = class(TNamedItem)
  public
    function DataSetName: ShortString; override;
    function MapFieldName(Name: ShortString): ShortString; override;
  end;

implementation

//------------------------------------------------------------------------------
function TApp.DataSetName: ShortString;
begin
  Result := 'Apps';
end;

//------------------------------------------------------------------------------
function TApp.MapFieldName(Name: ShortString): ShortString; 
begin
  // Äëÿ ÎÏÈ
  if Name = 'Id' then
    Result := 'Nr'
  else if Name = 'Name' then
    Result := 'NmCmp'
  else
    Result := Name;
end;

end.
