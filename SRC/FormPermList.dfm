object FrmPermList: TFrmPermList
  Left = 138
  Top = 71
  Width = 964
  Height = 640
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
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object SplitterMain: TSplitter
    Left = 449
    Top = 0
    Height = 560
  end
  object PanelRight: TPanel
    Left = 452
    Top = 0
    Width = 496
    Height = 560
    Align = alClient
    TabOrder = 0
    object SplitterRight: TSplitter
      Left = 1
      Top = 153
      Width = 494
      Height = 5
      Cursor = crVSplit
      Align = alTop
      Beveled = True
    end
    object PanelAffApps: TPanel
      Left = 1
      Top = 1
      Width = 494
      Height = 152
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      OnResize = PanelAffAppsResize
      DesignSize = (
        494
        152)
      object LblAffectedApps: TLabel
        Left = 8
        Top = 8
        Width = 100
        Height = 13
        Caption = 'Affected Applications'
      end
      object ChLstBxAffApps: TCheckListBox
        Left = 0
        Top = 24
        Width = 495
        Height = 125
        OnClickCheck = ChLstBxAffAppsClickCheck
        Anchors = [akLeft, akTop, akRight, akBottom]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Consolas'
        Font.Style = []
        ItemHeight = 13
        ParentFont = False
        PopupMenu = PopupAffApps
        Sorted = True
        TabOrder = 0
      end
    end
    object PanelGrantUsrs: TPanel
      Left = 1
      Top = 158
      Width = 494
      Height = 401
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object PageCtrlGrantPerms: TPageControl
        Left = 0
        Top = 0
        Width = 494
        Height = 401
        ActivePage = TabGrantUsrs
        Align = alClient
        PopupMenu = PopupGrantPerm
        Style = tsFlatButtons
        TabOrder = 0
        object TabGrantRoles: TTabSheet
          Caption = 'Granted Roles'
        end
        object TabGrantUsrs: TTabSheet
          Caption = 'Granted Users'
          ImageIndex = 1
          OnResize = TabGrantUsrsResize
          DesignSize = (
            486
            370)
          object ChLstBxUsrApps: TCheckListBox
            Left = 0
            Top = 0
            Width = 486
            Height = 370
            OnClickCheck = ChLstBxUsrAppsClickCheck
            Anchors = [akLeft, akTop, akRight, akBottom]
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Consolas'
            Font.Style = []
            ItemHeight = 13
            ParentFont = False
            Sorted = True
            TabOrder = 0
          end
        end
        object TabGrantUsrGrps: TTabSheet
          Caption = 'Granted User Groups'
          ImageIndex = 2
        end
      end
    end
  end
  object PanelBottom: TPanel
    Left = 0
    Top = 560
    Width = 948
    Height = 41
    Align = alBottom
    TabOrder = 1
  end
  object PanelPerms: TPanel
    Left = 0
    Top = 0
    Width = 449
    Height = 560
    Align = alLeft
    TabOrder = 2
    OnResize = PanelPermsResize
    DesignSize = (
      449
      560)
    object LblFilter: TLabel
      Left = 8
      Top = 8
      Width = 44
      Height = 13
      Caption = 'App Filter'
    end
    object BtnClearAppFilter: TSpeedButton
      Left = 424
      Top = 7
      Width = 23
      Height = 22
      Hint = 'Clear App Filter'
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      OnClick = BtnClearAppFilterClick
    end
    object DbgrPerms: TDBGrid
      Left = 1
      Top = 32
      Width = 447
      Height = 525
      Anchors = [akLeft, akTop, akRight, akBottom]
      DataSource = DsrcPerms
      PopupMenu = PopupPerms
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
    end
    object ComboAppFilter: TDBLookupComboBox
      Left = 64
      Top = 8
      Width = 353
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      KeyField = 'NR'
      ListField = 'NMCMP'
      ListSource = DsrcAppFilter
      TabOrder = 1
      OnClick = ComboAppFilterClick
    end
  end
  object DsrcPerms: TDataSource
    Left = 24
    Top = 80
  end
  object PopupPerms: TPopupMenu
    Left = 88
    Top = 80
    object NAddPermission: TMenuItem
      Caption = 'Add Permission'
      OnClick = NAddPermissionClick
    end
    object NEditPermission: TMenuItem
      Caption = 'Edit Permission'
      OnClick = NEditPermissionClick
    end
    object NDelPerm: TMenuItem
      Caption = 'Delete Permission'
    end
  end
  object PopupAffApps: TPopupMenu
    Left = 786
    Top = 65
    object NSetApp: TMenuItem
      Caption = 'Set Application'
    end
    object NResetApp: TMenuItem
      Caption = 'Reset Application'
    end
  end
  object PopupGrantPerm: TPopupMenu
    Left = 718
    Top = 289
    object NGrantPerm: TMenuItem
      Caption = 'Grant Permission'
    end
    object NRevokePerm: TMenuItem
      Caption = 'Revoke Permission'
    end
  end
  object QryApps: TQuery
    SQL.Strings = (
      '')
    Left = 581
    Top = 41
  end
  object QryAppFilter: TQuery
    Left = 288
    Top = 48
  end
  object DsrcAppFilter: TDataSource
    DataSet = QryAppFilter
    Left = 328
    Top = 48
  end
end
