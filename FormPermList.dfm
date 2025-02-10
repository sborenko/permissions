object FormPermissions: TFormPermissions
  Left = 666
  Top = 356
  Width = 790
  Height = 583
  Caption = 'Permissions'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object PanelRight: TPanel
    Left = 597
    Top = 0
    Width = 185
    Height = 508
    Align = alRight
    TabOrder = 0
    object LblAffectedApps: TLabel
      Left = 8
      Top = 8
      Width = 100
      Height = 13
      Caption = 'Affected Applications'
    end
    object LblFilter: TLabel
      Left = 8
      Top = 272
      Width = 22
      Height = 13
      Caption = 'Filter'
    end
    object LblGrantedUsers: TLabel
      Left = 8
      Top = 368
      Width = 68
      Height = 13
      Caption = 'Granted Users'
    end
    object CheckListBox1: TCheckListBox
      Left = 8
      Top = 24
      Width = 169
      Height = 241
      ItemHeight = 13
      TabOrder = 0
    end
    object DBComboBox1: TDBComboBox
      Left = 8
      Top = 288
      Width = 169
      Height = 21
      ItemHeight = 13
      TabOrder = 1
    end
    object DbgrGrantedUsers: TDBGrid
      Left = 8
      Top = 384
      Width = 168
      Height = 120
      TabOrder = 2
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
    end
  end
  object PanelBottom: TPanel
    Left = 0
    Top = 508
    Width = 782
    Height = 41
    Align = alBottom
    TabOrder = 1
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 597
    Height = 508
    Align = alClient
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
end
