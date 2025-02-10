object FrmUsrList: TFrmUsrList
  Left = 469
  Top = 431
  Width = 703
  Height = 354
  Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1080
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
    695
    320)
  PixelsPerInch = 96
  TextHeight = 13
  object BtnSelect: TBitBtn
    Left = 546
    Top = 8
    Width = 140
    Height = 25
    Action = ActSelect
    Anchors = [akTop, akRight]
    Caption = '&'#1042#1099#1073#1088#1072#1090#1100
    ModalResult = 1
    TabOrder = 0
  end
  object BtnNewUser: TBitBtn
    Left = 546
    Top = 259
    Width = 140
    Height = 25
    Action = ActNewUser
    Anchors = [akRight, akBottom]
    Caption = '&'#1053#1086#1074#1099#1081' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
    TabOrder = 1
  end
  object BitBtn4: TBitBtn
    Left = 546
    Top = 291
    Width = 140
    Height = 25
    Action = ActDelete
    Anchors = [akRight, akBottom]
    Caption = '&'#1059#1076#1072#1083#1080#1090#1100
    TabOrder = 2
  end
  object DbgrUsers: TDBGrid
    Left = 8
    Top = 8
    Width = 529
    Height = 305
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnKeyDown = DbgrUsersKeyDown
  end
  object ActionList: TActionList
    Left = 56
    Top = 64
    object ActNewUser: TAction
      Caption = '&'#1053#1086#1074#1099#1081' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
      OnUpdate = ActNonSelectUpdate
    end
    object ActDelete: TAction
      Caption = '&'#1059#1076#1072#1083#1080#1090#1100
      OnUpdate = ActNonSelectUpdate
    end
    object ActSelect: TAction
      Caption = '&'#1042#1099#1073#1088#1072#1090#1100
      OnUpdate = ActSelectUpdate
    end
  end
end
