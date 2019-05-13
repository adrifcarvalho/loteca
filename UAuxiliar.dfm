object FAuxiliar: TFAuxiliar
  Left = 192
  Top = 124
  Caption = 'Carga Auxiliar de Banco de Dados'
  ClientHeight = 355
  ClientWidth = 864
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 172
    Top = 33
    Width = 539
    Height = 16
    Caption = 
      'Verifica se existem novos times no diret'#243'rio padr'#227'o e inclui na ' +
      'base de dados'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object btnArcMaior: TButton
    Left = 397
    Top = 378
    Width = 156
    Height = 27
    Caption = 'Carregar ARCANOS_MAIORES'
    TabOrder = 0
    OnClick = btnArcMaiorClick
  end
  object btnCargaPlanilha: TButton
    Left = 559
    Top = 378
    Width = 135
    Height = 27
    Caption = 'Carregar planilha'
    TabOrder = 1
    OnClick = btnCargaPlanilhaClick
  end
  object Memo1: TMemo
    Left = 15
    Top = 81
    Width = 837
    Height = 262
    Lines.Strings = (
      '')
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object Button6: TButton
    Left = 713
    Top = 377
    Width = 135
    Height = 27
    Caption = 'Verificar duplicados'
    TabOrder = 3
    OnClick = Button6Click
  end
  object btnArcMenor: TButton
    Left = 397
    Top = 411
    Width = 156
    Height = 27
    Caption = 'Carregar ARCANOS_MENORES'
    TabOrder = 4
    OnClick = btnArcMenorClick
  end
  object Button1: TButton
    Left = 713
    Top = 406
    Width = 117
    Height = 26
    Caption = 'btnTrocarData'
    TabOrder = 5
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 559
    Top = 411
    Width = 135
    Height = 27
    Caption = 'Inserir Times'
    TabOrder = 6
    OnClick = Button2Click
  end
  object FileListBox1: TFileListBox
    Left = 11
    Top = 368
    Width = 380
    Height = 201
    ItemHeight = 13
    TabOrder = 7
  end
  object btnCarga: TButton
    Left = 15
    Top = 15
    Width = 144
    Height = 44
    Caption = 'Inserir Times'
    TabOrder = 8
    OnClick = btnCargaPlanilhaClick
  end
  object FDQuery1: TFDQuery
    Connection = DM.FDConnection1
    Left = 589
    Top = 482
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'FMX'
    Left = 683
    Top = 470
  end
  object FDQuery2: TFDQuery
    Connection = DM.FDConnection1
    Left = 684
    Top = 36
  end
end
