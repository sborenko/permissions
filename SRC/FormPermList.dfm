object FrmPermList: TFrmPermList
  Left = 419
  Top = 282
  Width = 1107
  Height = 709
  Caption = 'Permission List'
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
    Left = 1096
    Top = 0
    Height = 634
    Align = alRight
  end
  object PanelRight: TPanel
    Left = 553
    Top = 0
    Width = 543
    Height = 634
    Align = alClient
    TabOrder = 0
    object SplitterRight: TSplitter
      Left = 1
      Top = 153
      Width = 541
      Height = 5
      Cursor = crVSplit
      Align = alTop
      Beveled = True
    end
    object PanelAffApps: TPanel
      Left = 1
      Top = 1
      Width = 541
      Height = 152
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        541
        152)
      object LblAffectedApps: TLabel
        Left = 8
        Top = 8
        Width = 100
        Height = 13
        Caption = 'Affected Applications'
      end
      object ChLstBoxAffApps: TCheckListBox
        Left = 0
        Top = 24
        Width = 541
        Height = 125
        Anchors = [akLeft, akTop, akRight, akBottom]
        ItemHeight = 13
        TabOrder = 0
      end
    end
    object PanelGrantUsrs: TPanel
      Left = 1
      Top = 158
      Width = 541
      Height = 475
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object PageCtrlGrants: TPageControl
        Left = 0
        Top = 0
        Width = 541
        Height = 475
        ActivePage = TabGrantUsrs
        Align = alClient
        Style = tsFlatButtons
        TabOrder = 0
        object TabGrantRoles: TTabSheet
          Caption = 'Granted Roles'
        end
        object TabGrantUsrs: TTabSheet
          Caption = 'Grant Users'
          ImageIndex = 1
          object DbgrGrantUsrs: TDBGrid
            Left = 0
            Top = 0
            Width = 533
            Height = 444
            Align = alClient
            Color = clMoneyGreen
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
          end
        end
        object TabGrantUsrGrps: TTabSheet
          Caption = 'Granted User Groups'
          ImageIndex = 2
          OnResize = TabGrantUsrGrpsResize
        end
      end
    end
  end
  object PanelBottom: TPanel
    Left = 0
    Top = 634
    Width = 1099
    Height = 41
    Align = alBottom
    TabOrder = 1
  end
  object PanelPerms: TPanel
    Left = 0
    Top = 0
    Width = 553
    Height = 634
    Align = alLeft
    TabOrder = 2
    OnResize = PanelPermsResize
    DesignSize = (
      553
      634)
    object LblFilter: TLabel
      Left = 8
      Top = 8
      Width = 22
      Height = 13
      Caption = 'Filter'
    end
    object DbgrPerms: TDBGrid
      Left = 2
      Top = 32
      Width = 542
      Height = 594
      Anchors = [akLeft, akTop, akRight, akBottom]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
    end
    object DbCmbBoxAppFilter: TDBComboBox
      Left = 42
      Top = 8
      Width = 502
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      ItemHeight = 13
      TabOrder = 1
    end
  end
  object DataSource1: TDataSource
    Left = 24
    Top = 80
  end
  object PopupMenu1: TPopupMenu
    Left = 88
    Top = 80
  end
end
