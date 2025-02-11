unit GroupUser;

interface

uses
  UsrGrpChild;

type

  TGroupUser = class(TUsrGrpChild)
  private
//    UserId: Integer;
  protected
    function DataSetFields: String; override;
  public
    function DataSetName: ShortString; override;
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
