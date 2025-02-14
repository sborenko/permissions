object FrmPermList: TFrmPermList
  Left = 43
  Top = 159
  Width = 802
  Height = 375
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
    Left = 389
    Top = 0
    Height = 295
    Align = alRight
  end
  object PanelRight: TPanel
    Left = 392
    Top = 0
    Width = 394
    Height = 295
    Align = alRight
    TabOrder = 0
    object SplitterRight: TSplitter
      Left = 1
      Top = 153
      Width = 392
      Height = 5
      Cursor = crVSplit
      Align = alTop
      Beveled = True
    end
    object PanelAffApps: TPanel
      Left = 1
      Top = 1
      Width = 392
      Height = 152
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        392
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
        Width = 392
        Height = 125
        Anchors = [akLeft, akTop, akRight, akBottom]
        ItemHeight = 13
        TabOrder = 0
      end
    end
    object PanelGrantUsrs: TPanel
      Left = 1
      Top = 158
      Width = 392
      Height = 136
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object PageCtrlGrants: TPageControl
        Left = 0
        Top = 0
        Width = 392
        Height = 136
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
            Width = 384
            Height = 105
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
    Top = 295
    Width = 786
    Height = 41
    Align = alBottom
    TabOrder = 1
  end
  object PanelPerms: TPanel
    Left = 0
    Top = 0
    Width = 389
    Height = 295
    Align = alClient
    TabOrder = 2
    OnResize = PanelPermsResize
    DesignSize = (
      389
      295)
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
      Width = 386
      Height = 260
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
      Width = 346
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
