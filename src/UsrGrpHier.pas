unit UsrGrpHier;

interface

uses
  UsrGrpChild;

type

  TUsrGrpHier = class(TUsrGrpChild)
  protected
    function DataSetFields: String; override;
  public
    function DataSetName: ShortString; override;
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
