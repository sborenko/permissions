unit RoleOwner;

interface

uses
  NamedItem;

type

  TRoleOwner = class(TNamedItem)
  private
//    RootRoleId: Integer;
  protected
    function DataSetFields: String; override;
  end;

implementation

uses
  TextLib;

//------------------------------------------------------------------------------
function TRoleOwner.DataSetFields: String;
begin
  Result :=
    TextUtils.ConcatStr(inherited DatasetFields, 'RootRoleId Int', ', ');
end;

end.
