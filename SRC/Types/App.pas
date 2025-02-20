unit App;

interface

uses
  NamedItem;

type

  TApp = class(TNamedItem)
  public
    function DatasetName: ShortString; override;
    function DecorDsName: ShortString; override;
    function FieldName(Name: ShortString): ShortString; override;
  end;

implementation

//------------------------------------------------------------------------------
function TApp.DatasetName: ShortString;
begin
  Result := 'zz_PCmp';
end;

//------------------------------------------------------------------------------
function TApp.DecorDsName: ShortString;
begin
  Result := DatasetName;
end;

//------------------------------------------------------------------------------
function TApp.FieldName(Name: ShortString): ShortString; 
begin
  // ��� ���
  if Name = 'Id' then
    Result := 'Nr'
  else if Name = 'Code' then
    Result := 'ShCmp'
  else if Name = 'Name' then
    Result := 'NmCmp'
  else
    Result := Name;
end;

end.
