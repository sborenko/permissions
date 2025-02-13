unit NamedItem;

interface

uses
  Item;

type

  TNamedItem = class(TItem)
  protected
    function DataSetFields: String; override;
  end;

implementation

uses
  TextLib;

//------------------------------------------------------------------------------
function TNamedItem.DataSetFields: String;
begin
  Result := inherited DataSetFields;
  Result := TextUtils.ConcatStr(Result,
    FieldName('Name') + ' VarChar(30)', ', ');
  Result := TextUtils.ConcatStr(Result,
    'Notes blob sub_type 1 segment size 4096', ',');
end;

end.
