unit App;

interface

uses
  NamedItem;

type

  TApp = class(TNamedItem)
  public
    function DataSetName: ShortString; override;
    function FieldName(Name: ShortString): ShortString; override;
  end;

implementation

//------------------------------------------------------------------------------
function TApp.DataSetName: ShortString;
begin
  Result := 'App';
end;

//------------------------------------------------------------------------------
function TApp.FieldName(Name: ShortString): ShortString; 
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
