object FrmUsrList: TFrmUsrList
  Left = 523
  Top = 347
  Width = 920
  Height = 584
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
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 433
    Top = 0
    Height = 509
  end
  object PanelClient: TPanel
    Left = 436
    Top = 0
    Width = 476
    Height = 509
    Align = alClient
    TabOrder = 0
    object SplitUsrGrpsPems: TSplitter
      Left = 1
      Top = 137
      Width = 474
      Height = 3
      Cursor = crVSplit
      Align = alTop
    end
    object SplitPermRoles: TSplitter
      Left = 1
      Top = 333
      Width = 474
      Height = 3
      Cursor = crVSplit
      Align = alBottom
    end
    object PanelPemrs: TPanel
      Left = 1
      Top = 140
      Width = 474
      Height = 193
      Align = alClient
      TabOrder = 0
      DesignSize = (
        474
        193)
      object LblPerms: TLabel
        Left = 8
        Top = 8
        Width = 55
        Height = 13
        Caption = 'Permissions'
      end
      object DbgrPerms: TDBGrid
        Left = 0
        Top = 24
        Width = 469
        Height = 170
        Anchors = [akLeft, akTop, akRight, akBottom]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
      end
    end
    object PanelRoles: TPanel
      Left = 1
      Top = 336
      Width = 474
      Height = 172
      Align = alBottom
      TabOrder = 1
      DesignSize = (
        474
        172)
      object LblRoles: TLabel
        Left = 8
        Top = 8
        Width = 27
        Height = 13
        Caption = 'Roles'
      end
      object DbgrRoles: TDBGrid
        Left = 0
        Top = 24
        Width = 469
        Height = 148
        Anchors = [akLeft, akTop, akRight, akBottom]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
      end
    end
    object PanelUsrGrps: TPanel
      Left = 1
      Top = 1
      Width = 474
      Height = 136
      Align = alTop
      TabOrder = 2
      DesignSize = (
        474
        136)
      object LblUsrGrps: TLabel
        Left = 8
        Top = 8
        Width = 59
        Height = 13
        Caption = 'User Groups'
      end
      object ChLstBxUsrGrps: TCheckListBox
        Left = 0
        Top = 24
        Width = 469
        Height = 113
        Anchors = [akLeft, akTop, akRight, akBottom]
        ItemHeight = 13
        TabOrder = 0
      end
    end
  end
  object PanelUsrs: TPanel
    Left = 0
    Top = 0
    Width = 433
    Height = 509
    Align = alLeft
    TabOrder = 1
    DesignSize = (
      433
      509)
    object LblUsers: TLabel
      Left = 8
      Top = 8
      Width = 27
      Height = 13
      Caption = 'Users'
    end
    object DbgrUsrs: TDBGrid
      Left = 0
      Top = 24
      Width = 433
      Height = 480
      Anchors = [akLeft, akTop, akRight, akBottom]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnKeyDown = DbgrUsrsKeyDown
    end
  end
  object PanelBottom: TPanel
    Left = 0
    Top = 509
    Width = 912
    Height = 41
    Align = alBottom
    TabOrder = 2
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
