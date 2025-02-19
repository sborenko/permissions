object FrmEditPerm: TFrmEditPerm
  Left = 827
  Top = 673
  BorderStyle = bsSingle
  Caption = 'Permission'
  ClientHeight = 191
  ClientWidth = 429
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    429
    191)
  PixelsPerInch = 96
  TextHeight = 13
  object LblName: TLabel
    Left = 8
    Top = 8
    Width = 28
    Height = 13
    Caption = 'Name'
  end
  object LblNotes: TLabel
    Left = 8
    Top = 72
    Width = 28
    Height = 13
    Caption = 'Notes'
  end
  object DbeName: TDBEdit
    Left = 96
    Top = 8
    Width = 326
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    DataField = 'Name'
    DataSource = DsrcPerm
    TabOrder = 0
  end
  object DbmNotes: TDBMemo
    Left = 96
    Top = 72
    Width = 326
    Height = 84
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataField = 'Notes'
    DataSource = DsrcPerm
    TabOrder = 1
  end
  object DBChBxAllApps: TDBCheckBox
    Left = 8
    Top = 40
    Width = 101
    Height = 17
    Alignment = taLeftJustify
    Caption = 'All Applications'
    DataField = 'AllApps'
    DataSource = DsrcPerm
    TabOrder = 2
    ValueChecked = 'Y'
    ValueUnchecked = ' '
  end
  object PanelBottom: TPanel
    Left = 0
    Top = 161
    Width = 429
    Height = 30
    Align = alBottom
    TabOrder = 3
    object BtnOk: TBitBtn
      Left = 288
      Top = 3
      Width = 75
      Height = 25
      TabOrder = 0
      Kind = bkOK
    end
    object BtnCancel: TBitBtn
      Left = 368
      Top = 3
      Width = 75
      Height = 25
      TabOrder = 1
      Kind = bkCancel
    end
  end
  object DsrcPerm: TDataSource
    Left = 232
    Top = 40
  end
end
