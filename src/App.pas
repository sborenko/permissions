unit App;

interface

uses
  NamedItem;

type

  TApp = class(TNamedItem)
  protected
    class function DataSetName: ShortString;
  end;

implementation

//------------------------------------------------------------------------------
class function TApp.DataSetName: ShortString;
begin
  Result := 'Applications';
end;

end.
