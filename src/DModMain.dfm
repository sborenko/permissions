object DmMain: TDmMain
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 331
  Top = 229
  Height = 158
  Width = 332
  object Database: TDatabase
    LoginPrompt = False
    Params.Strings = (
      'USER NAME=SYSDBA'
      'PASSWORD=paraheda')
    SessionName = 'Default'
    Left = 16
    Top = 8
  end
end
