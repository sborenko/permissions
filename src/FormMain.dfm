object FrmMain: TFrmMain
  Left = 162
  Top = 9
  Width = 994
  Height = 701
  Caption = 'FrmMain'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = MainMenu
  OldCreateOrder = False
  WindowState = wsMaximized
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object MainMenu: TMainMenu
    Left = 56
    Top = 56
    object MnuRefs: TMenuItem
      Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      object MnuPermissions: TMenuItem
        Action = ActPermissions
      end
      object MnuRoles: TMenuItem
        Action = ActRoles
      end
      object Sep2: TMenuItem
        Caption = '-'
      end
      object MnuApplications: TMenuItem
        Action = ActApplications
      end
      object Sep1: TMenuItem
        Caption = '-'
      end
      object MnuUsers: TMenuItem
        Action = ActUsers
      end
      object MnuUserGroups: TMenuItem
        Action = ActUserGroups
      end
    end
  end
  object ActionList: TActionList
    Left = 16
    Top = 56
    object ActApplications: TAction
      Caption = '&'#1055#1088#1080#1083#1086#1078#1077#1085#1080#1103
    end
    object ActPermissions: TAction
      Caption = '&'#1056#1072#1079#1088#1077#1096#1077#1085#1080#1103
      OnExecute = ActViewPermiss
    end
    object ActRoles: TAction
      Caption = '&'#1056#1086#1083#1080
      OnExecute = ActRolesExecute
    end
    object ActUsers: TAction
      Caption = '&'#1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1080
      OnExecute = ActViewUsers
    end
    object ActUserGroups: TAction
      Caption = '&'#1043#1088#1091#1087#1087#1099' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1077#1081
      OnExecute = ActViewUsrGroups
    end
  end
end
