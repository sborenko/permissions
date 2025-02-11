object FrmPermList: TFrmPermList
  Left = 362
  Top = 115
  Width = 732
  Height = 583
  Caption = 'Permissions'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object SplitterMain: TSplitter
    Left = 458
    Top = 0
    Height = 503
    Align = alRight
  end
  object PanelRight: TPanel
    Left = 461
    Top = 0
    Width = 255
    Height = 503
    Align = alRight
    TabOrder = 0
    object SplitterRight: TSplitter
      Left = 1
      Top = 273
      Width = 253
      Height = 5
      Cursor = crVSplit
      Align = alTop
      Beveled = True
    end
    object PanelApps: TPanel
      Left = 1
      Top = 1
      Width = 253
      Height = 272
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        253
        272)
      object LblAffectedApps: TLabel
        Left = 8
        Top = 8
        Width = 100
        Height = 13
        Caption = 'Affected Applications'
      end
      object ChLstBox: TCheckListBox
        Left = 8
        Top = 24
        Width = 239
        Height = 241
        OnClickCheck = ChLstBoxClickCheck
        Anchors = [akLeft, akTop, akRight, akBottom]
        ItemHeight = 13
        TabOrder = 0
      end
    end
    object PanelFilter: TPanel
      Left = 1
      Top = 278
      Width = 253
      Height = 224
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      DesignSize = (
        253
        224)
      object LblFilter: TLabel
        Left = 8
        Top = 8
        Width = 22
        Height = 13
        Caption = 'Filter'
      end
      object LblGrantedUsers: TLabel
        Left = 8
        Top = 44
        Width = 68
        Height = 13
        Caption = 'Granted Users'
      end
      object DbgrGrantedUsers: TDBGrid
        Left = 8
        Top = 64
        Width = 241
        Height = 153
        Anchors = [akLeft, akTop, akRight, akBottom]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
      end
      object DBComboBox1: TDBComboBox
        Left = 8
        Top = 20
        Width = 241
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        ItemHeight = 13
        TabOrder = 1
      end
    end
  end
  object PanelBottom: TPanel
    Left = 0
    Top = 503
    Width = 716
    Height = 41
    Align = alBottom
    TabOrder = 1
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 458
    Height = 503
    Align = alClient
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
end
