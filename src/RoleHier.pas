unit RoleHier;

interface

uses
  RoleChild;

type

  TRoleHier = class(TRoleChild)
  private
//    SubroleId: Integer;
  public
    function DataSetName: ShortString; override;
    function DataSetFields: String; override;
  end;

implementation

uses
  TextLib;

//------------------------------------------------------------------------------
function TRoleHier.DataSetName: ShortString;
begin
  Result := 'RoleHier';
end;

//------------------------------------------------------------------------------
function TRoleHier.DataSetFields: String;
begin
  Result :=
    TextUtils.ConcatStr(inherited DataSetFields, 'SubroleId Int', ', ');
end;

end.
