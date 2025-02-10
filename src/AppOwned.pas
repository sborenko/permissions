unit AppOwned;

interface

uses
  NamedItem;

type

  TAppOwned = class(TNamedItem)
  private
//    AppId: Integer;
  protected
    function DataSetFields: String; override;
  end;

implementation

uses
  TextLib;

//------------------------------------------------------------------------------
function TAppOwned.DataSetFields: String;
begin
  Result := TextUtils.ConcatStr(inherited DataSetFields, 'AppId Int', ', ');
end;

end.
