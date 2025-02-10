unit GroupUser;

interface

uses
  UsrGrpChild;

type

  TGroupUser = class(TUsrGrpChild)
  private
//    UserId: Integer;
  protected
    function DataSetName: ShortString; override;
    function DataSetFields: String; override;
  end;

implementation

uses
  TextLib;

//------------------------------------------------------------------------------
function TGroupUser.DataSetName: ShortString;
begin
  Result := 'GroupUsers';
end;

//------------------------------------------------------------------------------
function TGroupUser.DataSetFields: String;
begin
  Result := TextUtils.ConcatStr(inherited DataSetFields, 'UserId Int', ', ');
end;

end.
