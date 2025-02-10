object FrmUsrGrpList: TFrmUsrGrpList
  Left = 111
  Top = 194
  Width = 677
  Height = 417
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
    669
    383)
  PixelsPerInch = 96
  TextHeight = 13
  object TreeUsrGroups: TTreeView
    Left = 8
    Top = 8
    Width = 509
    Height = 369
    Anchors = [akLeft, akTop, akRight, akBottom]
    Indent = 19
    PopupMenu = PopupMenu
    TabOrder = 0
    OnKeyDown = TreeUsrGroupsKeyDown
    Items.Data = {
      01000000190000000000000000000000FFFFFFFFFFFFFFFF0000000000000000
      00}
  end
  object BitBtn1: TBitBtn
    Left = 524
    Top = 256
    Width = 140
    Height = 25
    Action = ActNewGroup
    Anchors = [akRight, akBottom]
    Caption = '&'#1053#1086#1074#1072#1103' '#1075#1088#1091#1087#1087#1072
    TabOrder = 1
  end
  object BitBtn2: TBitBtn
    Left = 524
    Top = 288
    Width = 140
    Height = 25
    Action = ActAddGroup
    Anchors = [akRight, akBottom]
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100' &'#1075#1088#1091#1087#1087#1091
    TabOrder = 2
  end
  object BitBtn3: TBitBtn
    Left = 524
    Top = 320
    Width = 140
    Height = 25
    Action = ActAddUser
    Anchors = [akRight, akBottom]
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100' &'#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
    TabOrder = 3
  end
  object BitBtn4: TBitBtn
    Left = 524
    Top = 352
    Width = 140
    Height = 25
    Action = ActDeleteItem
    Anchors = [akRight, akBottom]
    Caption = '&'#1059#1076#1072#1083#1080#1090#1100
    TabOrder = 4
  end
  object BtnSelect: TBitBtn
    Left = 524
    Top = 8
    Width = 140
    Height = 25
    Action = ActSelect
    Anchors = [akTop, akRight]
    Caption = '&'#1042#1099#1073#1088#1072#1090#1100
    ModalResult = 1
    TabOrder = 5
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
