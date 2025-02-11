unit Permission;

interface

uses
  NamedItem;

type

  TPermission = class(TNamedItem)
  public
    function DatasetName: ShortString; override;
    function DatasetFields: String; override;
  end;

implementation

uses
  TextLib;

//------------------------------------------------------------------------------
function TPermission.DatasetName: ShortString;
begin
  Result := 'Permissions';
end;

//------------------------------------------------------------------------------
function TPermission.DatasetFields: String;
begin
  Result :=
    TextUtils.ConcatStr(inherited DatasetFields, 'AllApps Char(1)', ',');
end;

end.
