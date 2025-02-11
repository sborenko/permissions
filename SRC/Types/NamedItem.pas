unit NamedItem;

interface

uses
  Item;

type

  TNamedItem = class(TItem)
  private
//    Name: ShortString;
  protected
    function DataSetFields: String; override;
  end;

implementation

uses
  TextLib;

//------------------------------------------------------------------------------
function TNamedItem.DataSetFields: String;
begin
  Result :=
    TextUtils.ConcatStr(inherited DataSetFields, 'Name VarChar(30)', ', ');
end;

end.
