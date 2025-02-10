unit App;

interface

uses
  NamedItem;

type

  TApp = class(TNamedItem)
  protected
    function DataSetName: ShortString; override;
  end;

implementation

//------------------------------------------------------------------------------
function TApp.DataSetName: ShortString;
begin
  Result := 'Applications';
end;

end.
