object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 375
  Width = 442
  object FDConnection1: TFDConnection
    Params.Strings = (
      'DriverID=SQLite'
      'Database=C:\SQLite3\LOTECA.sqlite')
    Connected = True
    LoginPrompt = False
    Left = 38
    Top = 48
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    Left = 132
    Top = 48
  end
end
