unit Hier;

interface

uses
  Item;

type

  THier = class(TItem)
  private
    Entity: TItem;
  protected
    function DatasetFields: String; override;
  public
    constructor Create(Entity: TItem);
    function DatasetName: ShortString; override;
  end;

implementation

uses
  TextLib;

//------------------------------------------------------------------------------
constructor THier.Create(Entity: TItem);
begin
  Self.Entity := Entity;
end;

//------------------------------------------------------------------------------
function THier.DatasetName: ShortString;
begin
  Result := Entity.DatasetName + 'Hier';
end;

//------------------------------------------------------------------------------
function THier.DatasetFields: String;
begin
  Result := inherited DatasetFields;
  // ������������� ������������� ��������
  Result := TextUtils.ConcatStr('ParentId Int' , ', ');
  // ������������� ��������, ��������, ���� ��� ������ �������������,
  // ������� ����� ��������� ��������
  Result := TextUtils.ConcatStr('EntityId Int' , ', ');
end;

end.
