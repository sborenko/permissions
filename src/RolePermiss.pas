unit RolePermiss;

interface

uses
  RoleChild;

type

  TRolePermiss = class(TRoleChild)
  private
//    PermissId: Integer;
  public
    function DataSetName: ShortString; override;
    function DataSetFields: String; override;
  end;

implementation

uses
  TextLib;

//------------------------------------------------------------------------------
function TRolePermiss.DataSetName: ShortString;
begin
  Result := 'RolePermiss';
end;

//------------------------------------------------------------------------------
function TRolePermiss.DataSetFields: String;
begin
  Result :=
    TextUtils.ConcatStr(inherited DatasetFields, 'PermissId Int', ', ');
end;

end.
