object FrmUsrGrpList: TFrmUsrGrpList
  Left = 551
  Top = 391
  Width = 769
  Height = 583
  Caption = #1043#1088#1091#1087#1087#1099' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1077#1081
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDefaultPosOnly
  OnClose = FormClose
  DesignSize = (
    761
    549)
  PixelsPerInch = 96
  TextHeight = 13
  object SplitUsrGrps: TSplitter
    Left = 321
    Top = 0
    Height = 508
  end
  object BitBtn4: TBitBtn
    Left = 616
    Top = 518
    Width = 140
    Height = 25
    Action = ActDeleteItem
    Anchors = [akRight, akBottom]
    Caption = '&'#1059#1076#1072#1083#1080#1090#1100
    TabOrder = 0
  end
  object PanelBottom: TPanel
    Left = 0
    Top = 508
    Width = 761
    Height = 41
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      761
      41)
    object BtnSelect: TBitBtn
      Left = 160
      Top = 8
      Width = 140
      Height = 25
      Action = ActSelect
      Anchors = [akTop, akRight]
      Caption = '&'#1042#1099#1073#1088#1072#1090#1100
      ModalResult = 1
      TabOrder = 0
    end
    object BitBtn1: TBitBtn
      Left = 309
      Top = 8
      Width = 140
      Height = 25
      Action = ActNewGroup
      Anchors = [akTop, akRight]
      Caption = '&'#1053#1086#1074#1072#1103' '#1075#1088#1091#1087#1087#1072
      TabOrder = 1
    end
    object BitBtn2: TBitBtn
      Left = 464
      Top = 8
      Width = 140
      Height = 25
      Action = ActAddGroup
      Anchors = [akTop, akRight]
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' &'#1075#1088#1091#1087#1087#1091
      TabOrder = 2
    end
    object BitBtn3: TBitBtn
      Left = 616
      Top = 8
      Width = 140
      Height = 25
      Action = ActAddUser
      Anchors = [akTop, akRight]
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' &'#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
      TabOrder = 3
    end
  end
  object PanelClient: TPanel
    Left = 324
    Top = 0
    Width = 437
    Height = 508
    Align = alClient
    TabOrder = 2
    object Splitter1: TSplitter
      Left = 1
      Top = 153
      Width = 435
      Height = 3
      Cursor = crVSplit
      Align = alTop
    end
    object Splitter2: TSplitter
      Left = 1
      Top = 338
      Width = 435
      Height = 3
      Cursor = crVSplit
      Align = alBottom
    end
    object PanelUsrs: TPanel
      Left = 1
      Top = 1
      Width = 435
      Height = 152
      Align = alTop
      TabOrder = 0
      DesignSize = (
        435
        152)
      object Label1: TLabel
        Left = 8
        Top = 8
        Width = 32
        Height = 13
        Caption = 'Label1'
      end
      object CheckListBox1: TCheckListBox
        Left = 0
        Top = 24
        Width = 432
        Height = 129
        Anchors = [akLeft, akTop, akRight, akBottom]
        ItemHeight = 13
        TabOrder = 0
      end
    end
    object PanelPerms: TPanel
      Left = 1
      Top = 156
      Width = 435
      Height = 182
      Align = alClient
      TabOrder = 1
      DesignSize = (
        435
        182)
      object Label2: TLabel
        Left = 8
        Top = 8
        Width = 32
        Height = 13
        Caption = 'Label2'
      end
      object CheckListBox2: TCheckListBox
        Left = 0
        Top = 24
        Width = 432
        Height = 158
        Anchors = [akLeft, akTop, akRight, akBottom]
        ItemHeight = 13
        TabOrder = 0
      end
    end
    object PanelRoles: TPanel
      Left = 1
      Top = 341
      Width = 435
      Height = 166
      Align = alBottom
      TabOrder = 2
      DesignSize = (
        435
        166)
      object Label3: TLabel
        Left = 8
        Top = 8
        Width = 32
        Height = 13
        Caption = 'Label3'
      end
      object CheckListBox3: TCheckListBox
        Left = 0
        Top = 24
        Width = 432
        Height = 137
        Anchors = [akLeft, akTop, akRight, akBottom]
        ItemHeight = 13
        TabOrder = 0
      end
    end
  end
  object PanelUsrGrps: TPanel
    Left = 0
    Top = 0
    Width = 321
    Height = 508
    Align = alLeft
    TabOrder = 3
    DesignSize = (
      321
      508)
    object LblUsrGrps: TLabel
      Left = 8
      Top = 8
      Width = 59
      Height = 13
      Caption = 'User Groups'
    end
    object TreeUsrGrps: TTreeView
      Left = 0
      Top = 24
      Width = 321
      Height = 479
      Anchors = [akLeft, akTop, akRight, akBottom]
      Indent = 19
      PopupMenu = PopupMenu
      TabOrder = 0
      OnKeyDown = TreeUsrGrpsKeyDown
      Items.Data = {
        01000000190000000000000000000000FFFFFFFFFFFFFFFF0000000000000000
        00}
    end
  end
  object PopupMenu: TPopupMenu
    Left = 64
    Top = 40
    object PopNewGroup: TMenuItem
      Action = ActNewGroup
    end
    object Sep1: TMenuItem
      Caption = '-'
    end
    object PopAddGroup: TMenuItem
      Action = ActAddGroup
    end
    object PopAddUser: TMenuItem
      Action = ActAddUser
    end
    object PopSelect: TMenuItem
      Action = ActSelect
    end
    object Sep2: TMenuItem
      Caption = '-'
    end
    object PopDeleteItem: TMenuItem
      Action = ActDeleteItem
    end
  end
  object ActionList: TActionList
    Left = 24
    Top = 40
    object ActNewGroup: TAction
      Caption = '&'#1053#1086#1074#1072#1103' '#1075#1088#1091#1087#1087#1072
      OnExecute = ActNewGroupExecute
      OnUpdate = ActNonSelectUpdate
    end
    object ActAddGroup: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' &'#1075#1088#1091#1087#1087#1091
      OnExecute = ActAddGroupExecute
      OnUpdate = ActNonSelectUpdate
    end
    object ActAddUser: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' &'#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
      OnExecute = ActAddUserExecute
      OnUpdate = ActNonSelectUpdate
    end
    object ActDeleteItem: TAction
      Caption = '&'#1059#1076#1072#1083#1080#1090#1100
      OnExecute = ActDeleteItemExecute
      OnUpdate = ActNonSelectUpdate
    end
    object ActSelect: TAction
      Caption = '&'#1042#1099#1073#1088#1072#1090#1100
      OnUpdate = ActSelectUpdate
    end
  end
end
