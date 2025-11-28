object DMDados: TDMDados
  OldCreateOrder = True
  OnCreate = DataModuleCreate
  Height = 311
  Width = 455
  object FDConnection: TFDConnection
    Params.Strings = (
      'LockingMode=Normal'
      'DriverID=SQLite')
    AfterConnect = FDConnectionAfterConnect
    Left = 168
    Top = 80
  end
  object QDados: TFDQuery
    Connection = FDConnection
    Left = 168
    Top = 168
  end
end
