unit TreeMngr;

interface

uses
  ComCtrls;

type

  TTreeResp = (TREE_RESP_ACCEPT, TREE_RESP_DENY);

  TTreeManager = class
  private
    Tree: TTreeView;
  public
    constructor Create(Tree: TTreeView);

    function AddNode: TTreeResp;
    function CopyNode(Node, Target: TTreeNode): TTreeResp ;
    function DelNode(Node: TTreeNode): TTreeResp;
    function MoveNode(Node, Target: TTreeNode): TTreeResp ;
  end;

implementation

uses
  Classes;

//------------------------------------------------------------------------------
constructor TTreeManager.Create(Tree: TTreeView);
begin
  Self.Tree := Tree;
end;

//------------------------------------------------------------------------------
function TTreeManager.AddNode: TTreeResp;
begin
  Result := TREE_RESP_DENY;
end;

//------------------------------------------------------------------------------
function TTreeManager.CopyNode(Node, Target: TTreeNode): TTreeResp ;
begin
  Result := TREE_RESP_DENY;
end;

//------------------------------------------------------------------------------
function TTreeManager.DelNode(Node: TTreeNode): TTreeResp;
begin
  Result := TREE_RESP_DENY;
end;

//------------------------------------------------------------------------------
function TTreeManager.MoveNode(Node, Target: TTreeNode): TTreeResp ;
begin
  Result := TREE_RESP_DENY;
end;

end.
