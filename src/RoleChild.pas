unit RoleChild;

interface

uses
  Item;

type

  TRoleChild = class(TItem)
  private
//    RoleId: Integer;
//    GrantOrRevoke: Char;
  public
    function DataSetFields: String; override;
  end;

implementation

uses
  TextLib;

//------------------------------------------------------------------------------
function TRoleChild.DataSetFields: String;
begin
  Result :=
    TextUtils.ConcatStr(inherited DataSetFields,
      'RoleId Int, GrantOrRevoke Char(1)', ', ');
end;

end.
