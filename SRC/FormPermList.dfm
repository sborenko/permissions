object FrmPermList: TFrmPermList
  Left = 75
  Top = 122
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
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object SplitterMain: TSplitter
    Left = 553
    Top = 0
    Height = 629
  end
  object PanelRight: TPanel
    Left = 556
    Top = 0
    Width = 535
    Height = 629
    Align = alClient
    TabOrder = 0
    object SplitterRight: TSplitter
      Left = 1
      Top = 153
      Width = 533
      Height = 5
      Cursor = crVSplit
      Align = alTop
      Beveled = True
    end
    object PanelAffApps: TPanel
      Left = 1
      Top = 1
      Width = 533
      Height = 152
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      OnResize = PanelAffAppsResize
      DesignSize = (
        533
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
        Width = 534
        Height = 125
        OnClickCheck = ChLstBxAffAppsClickCheck
        Anchors = [akLeft, akTop, akRight, akBottom]
        ItemHeight = 13
        PopupMenu = PopupAffApps
        TabOrder = 0
      end
    end
    object PanelGrantUsrs: TPanel
      Left = 1
      Top = 158
      Width = 533
      Height = 470
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object PageCtrlGrantPerms: TPageControl
        Left = 0
        Top = 0
        Width = 533
        Height = 470
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
            525
            439)
          object ChLstBxUsrPermApps: TCheckListBox
            Left = 0
            Top = 0
            Width = 534
            Height = 441
            Anchors = [akLeft, akTop, akRight, akBottom]
            ItemHeight = 13
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
    Top = 629
    Width = 1091
    Height = 41
    Align = alBottom
    TabOrder = 1
  end
  object PanelPerms: TPanel
    Left = 0
    Top = 0
    Width = 553
    Height = 629
    Align = alLeft
    TabOrder = 2
    OnResize = PanelPermsResize
    DesignSize = (
      553
      629)
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
      DataSource = DsrcPerms
      PopupMenu = PopupPerms
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
  object DsrcPerms: TDataSource
    OnDataChange = DsrcPermsDataChange
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
end
