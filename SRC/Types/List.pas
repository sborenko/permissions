unit List;

interface

uses
  Item;

type
  TList = class(TItem)
  private
    Owner, Entity: TItem;
  public
    constructor Create(Owner, Entity: TItem);
    function DatasetName: ShortString; override;
    function DatasetFields: String; override;
  end;

implementation

uses
  TextLib;

//------------------------------------------------------------------------------
constructor TList.Create(Owner, Entity: TItem);
begin
  Self.Owner := Owner;
  Self.Entity := Entity;
end;

//------------------------------------------------------------------------------
function TList.DatasetName: ShortString;
begin
  Result := Owner.DatasetName + Entity.DatasetName;
end;

//------------------------------------------------------------------------------
function TList.DatasetFields: String;
begin
  Result := inherited DatasetFields;
  // ������������� ���������, ��������, ������������.
  Result := TextUtils.ConcatStr(Result, 'OwnerId Int', ', ');
  // ������������� ���������, ������� �������� ������, �������� ����������
  Result := TextUtils.ConcatStr(Result, 'EntityId Int', ', ');
end;

end.
