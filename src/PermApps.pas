unit PermApps;

interface

uses Item;

type
  TPermApps = class(TItem)
  protected
    function DataSetFields: String; override;
  public
    function DataSetName: ShortString; override;
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
  Result := TextUtils.ConcatStr(inherited DataSetFields, 'PermId Int', ', ');
  // Идентификатор приложения, к которому данное разрешение применимо 
  Result := TextUtils.ConcatStr(Result, 'AppId Int', ', ');
end;

end.
