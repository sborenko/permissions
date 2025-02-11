unit PermOwner;

interface

uses
  ChildDataset;

type
  TPermOwner = class(TChildDataSet)
  public
    function DatasetName: ShortString; override;
    function DatasetFields: String; override;
  end;

implementation

uses
  TextLib;

//------------------------------------------------------------------------------
function TPermOwner.DatasetName: ShortString;
begin
  Result := ParentDatasetName +'Perms';
end;

//------------------------------------------------------------------------------
function TPermOwner.DatasetFields: String;
begin
  Result := TextUtils.ConcatStr(inherited DatasetFields, 'PermId Int', ', ');
  // ������������� ����������, � �������� ���� ��������� ��������� ����������
  Result := TextUtils.ConcatStr(Result, 'AppId Int', ', ');
end;

end.
