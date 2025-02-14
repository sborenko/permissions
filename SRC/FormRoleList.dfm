object FrmRoleList: TFrmRoleList
  Left = 610
  Top = 375
  Width = 971
  Height = 580
  Caption = 'Role List'
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
  object SplitLeftRight: TSplitter
    Left = 489
    Top = 0
    Height = 505
  end
  object PanelBottom: TPanel
    Left = 0
    Top = 505
    Width = 963
    Height = 41
    Align = alBottom
    TabOrder = 0
  end
  object PanelLeft: TPanel
    Left = 0
    Top = 0
    Width = 489
    Height = 505
    Align = alLeft
    TabOrder = 1
  end
  object PanelRight: TPanel
    Left = 492
    Top = 0
    Width = 471
    Height = 505
    Align = alClient
    TabOrder = 2
    object Splitter2: TSplitter
      Left = 1
      Top = 161
      Width = 469
      Height = 3
      Cursor = crVSplit
      Align = alTop
    end
    object SplitUsrUsrGrps: TSplitter
      Left = 1
      Top = 341
      Width = 469
      Height = 3
      Cursor = crVSplit
      Align = alBottom
    end
    object PanelPermApps: TPanel
      Left = 1
      Top = 1
      Width = 469
      Height = 160
      Align = alTop
      TabOrder = 0
    end
    object PanelUsrs: TPanel
      Left = 1
      Top = 164
      Width = 469
      Height = 177
      Align = alClient
      TabOrder = 1
    end
    object PanelUsrGrps: TPanel
      Left = 1
      Top = 344
      Width = 469
      Height = 160
      Align = alBottom
      TabOrder = 2
    end
  end
end
