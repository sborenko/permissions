unit Permission;

interface

uses
  NamedItem;

type

  TPermis = class(TNamedItem)
  public
    procedure CreateTable; override;
    procedure DropTable; override;
    function DatasetName: ShortString; override;
    function DatasetFields: String; override;
  end;

implementation

uses
  App, Item, List, TextLib;

//------------------------------------------------------------------------------
procedure TPermis.CreateTable;
var
  Entity: TItem;
begin
  inherited CreateTable;

  // Список приложений, к которым применимо разрешение
  Entity := TApp.Create;
  with TList.Create(Self, Entity) do begin
    CreateTable;
    Free;
  end;;
  Entity.Free;
end;

//------------------------------------------------------------------------------
procedure TPermis.DropTable;
var
  Entity: TItem;
begin
  Entity := TApp.Create;
  with TList.Create(Self, Entity) do begin
    DropTable;
    Free;
  end;;
  Entity.Free;

  inherited DropTable;
end;

//------------------------------------------------------------------------------
function TPermis.DatasetName: ShortString;
begin
  Result := 'Permiss';
end;

//------------------------------------------------------------------------------
function TPermis.DatasetFields: String;
begin
  Result := inherited DatasetFields;
  // Признак применимости разрешения ко всем приложениям
  Result := TextUtils.ConcatStr(Result, 'AllApps Char(1)', ',');
end;

end.
