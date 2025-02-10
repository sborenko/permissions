unit UsrGrpHier;

interface

uses
  UsrGrpChild;

type

  TUsrGrpHier = class(TUsrGrpChild)
  private
//    SubgroupId: Integer;
  protected
    function DataSetName: ShortString; override;
    function DataSetFields: String; override;
  end;

implementation

uses
  TextLib;

//------------------------------------------------------------------------------
function TUsrGrpHier.DataSetName: ShortString;
begin
  Result := 'UsrGrpHier';
end;

//------------------------------------------------------------------------------
function TUsrGrpHier.DataSetFields: String;
begin
  Result := TextUtils.ConcatStr(inherited DataSetFields, 'SubgroupId Int', ', ');
end;

end.
