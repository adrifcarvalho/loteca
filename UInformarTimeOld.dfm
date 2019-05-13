object FInformarTime: TFInformarTime
  Left = 0
  Top = 0
  Caption = 'Informe os times da partida'
  ClientHeight = 310
  ClientWidth = 544
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Tahoma'
  Font.Style = [fsBold]
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 19
  object Label1: TLabel
    Left = 38
    Top = 20
    Width = 254
    Height = 19
    Caption = 'Informe os times do novo jogo:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 38
    Top = 54
    Width = 59
    Height = 19
    Caption = 'TIME A'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 38
    Top = 114
    Width = 58
    Height = 19
    Caption = 'TIME B'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 39
    Top = 176
    Width = 125
    Height = 19
    Caption = 'DATA DO JOGO'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object edTimeA: TEdit
    Left = 38
    Top = 75
    Width = 461
    Height = 27
    CharCase = ecUpperCase
    TabOrder = 0
  end
  object edTimeB: TEdit
    Left = 38
    Top = 134
    Width = 461
    Height = 27
    CharCase = ecUpperCase
    TabOrder = 1
  end
  object btnOk: TBitBtn
    Left = 112
    Top = 242
    Width = 139
    Height = 55
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 2
    OnClick = btnOkClick
  end
  object btnCancelar: TBitBtn
    Left = 292
    Top = 242
    Width = 139
    Height = 55
    Caption = 'Cancelar'
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 3
  end
  object DateTimePicker1: TDateTimePicker
    Left = 38
    Top = 198
    Width = 186
    Height = 27
    Date = 42660.699200543980000000
    Time = 42660.699200543980000000
    TabOrder = 4
  end
end
