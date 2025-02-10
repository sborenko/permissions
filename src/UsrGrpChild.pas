unit UsrGrpChild;

interface

uses
  Item;
  
type

  TUsrGrpChild = class(TItem)
  private
//    GroupId: Integer;
  protected
    function DataSetFields: String; override;
  end;

implementation

uses
  TextLib;

//------------------------------------------------------------------------------
function TUsrGrpChild.DataSetFields: String;
begin
  Result :=
    TextUtils.ConcatStr(inherited DataSetFields, 'GroupId Int', ', ');
end;

end.
