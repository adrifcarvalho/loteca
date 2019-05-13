object FAlteracao: TFAlteracao
  Left = 91
  Top = 183
  Caption = 'ALTERAR JOGO EXISTENTE'
  ClientHeight = 378
  ClientWidth = 982
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    000000008000008000000080800080000000800080008080000080808000C0C0
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    0000000000000000000000000000000000000000000000000000000000000000
    000B3B3B3B33330000BB3B3000000000B3B3B3B3333333030BB3303300000003
    3330000000000030BB0B3B3330000003333B8B8383333033BBBB333330000000
    3333333333330B3B3BB33B3B3B0000000B3B3B3333330B3B33B3BBB3330000B3
    B3B3B3B333330B3B333BBB333B0003333000000000000B3B33BBBBB3B3000300
    000B3B3B33330B3B333BB0B33B000030B3B3B3B3B3330B3B333BBBB3B3000303
    3333333333330B33333BBB3B3B000003000B888383830BB33333333BB0000000
    33330000000000B33B3333BB300000033000B3B3B3B3B0BB33330BBB00000000
    0B3B3B3B3B3B3B0BB33B3BB00000000033333333333333300B33330000000000
    3000BBB838383830003000000000000003333380000000000000000000000000
    3338000B3B3B3B3B3B000000000000000330B3B3B3B3B3B3B3B3300000000000
    0003333FFFFFF33333333300000000000003088BBBB3B3B3B300030000000000
    000033333BBBBB3B3B33300000000000000333B3B3BBBBB3B3B3330000000000
    0000333B3BBBBBBB333330000000000000000003B3B3BFFFFB00000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000FFFF
    FFFFFE003C1FF000000FE0000007C0000003C0000003C0000001C00000018000
    00010000000100000001000000010000000180000003C0000003C0000007E000
    000FE000001FE00000FFE00000FFE000007FF000003FF800001FFC00001FFC00
    001FFC00001FFE00003FFF00007FFFE003FFFFFFFFFFFFFFFFFFFFFFFFFF}
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel52: TPanel
    Left = 684
    Top = 80
    Width = 289
    Height = 132
    BorderStyle = bsSingle
    TabOrder = 3
    object Label34: TLabel
      Left = 4
      Top = 2
      Width = 239
      Height = 20
      Caption = 'Selecione o resultado do jogo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object RadioGroupResultado: TRadioGroup
      Left = 10
      Top = 29
      Width = 121
      Height = 92
      Caption = 'Time'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ItemIndex = 3
      Items.Strings = (
        'A'
        'B'
        'Empate'
        'Sem resultado')
      ParentFont = False
      TabOrder = 0
    end
    object BitBtn1: TBitBtn
      Left = 147
      Top = 50
      Width = 124
      Height = 45
      Caption = 'ALTERAR'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000000
        000033333377777777773333330FFFFFFFF03FF3FF7FF33F3FF700300000FF0F
        00F077F777773F737737E00BFBFB0FFFFFF07773333F7F3333F7E0BFBF000FFF
        F0F077F3337773F3F737E0FBFBFBF0F00FF077F3333FF7F77F37E0BFBF00000B
        0FF077F3337777737337E0FBFBFBFBF0FFF077F33FFFFFF73337E0BF0000000F
        FFF077FF777777733FF7000BFB00B0FF00F07773FF77373377373330000B0FFF
        FFF03337777373333FF7333330B0FFFF00003333373733FF777733330B0FF00F
        0FF03333737F37737F373330B00FFFFF0F033337F77F33337F733309030FFFFF
        00333377737FFFFF773333303300000003333337337777777333}
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 1
      OnClick = BitBtnInserirClick
    end
  end
  object btnFiltrar: TBitBtn
    Left = 755
    Top = 22
    Width = 124
    Height = 45
    Caption = 'Filtrar jogo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333333333333333FF33333333333330003FF3FFFFF3333777003000003333
      300077F777773F333777E00BFBFB033333337773333F7F33333FE0BFBF000333
      330077F3337773F33377E0FBFBFBF033330077F3333FF7FFF377E0BFBF000000
      333377F3337777773F3FE0FBFBFBFBFB039977F33FFFFFFF7377E0BF00000000
      339977FF777777773377000BFB03333333337773FF733333333F333000333333
      3300333777333333337733333333333333003333333333333377333333333333
      333333333333333333FF33333333333330003333333333333777333333333333
      3000333333333333377733333333333333333333333333333333}
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 2
    OnClick = btnFiltrarClick
  end
  object GroupBoxTimeA: TGroupBox
    Left = 4
    Top = 0
    Width = 333
    Height = 211
    Caption = 'Time A'
    Color = 12582847
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 0
    object GroupBox1: TGroupBox
      Left = 6
      Top = 20
      Width = 319
      Height = 61
      Caption = 'CASA 1'
      Color = 12582847
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      TabOrder = 0
      object Label2: TLabel
        Left = 8
        Top = 18
        Width = 80
        Height = 13
        Caption = 'Arcano Menor'
      end
      object ComboBoxArcMenorA1: TComboBox
        Left = 8
        Top = 34
        Width = 305
        Height = 21
        Style = csDropDownList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
    end
    object GroupBox2: TGroupBox
      Left = 6
      Top = 82
      Width = 319
      Height = 61
      Caption = 'CASA 2'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object Label4: TLabel
        Left = 8
        Top = 18
        Width = 80
        Height = 13
        Caption = 'Arcano Menor'
      end
      object ComboBoxArcMenorA2: TComboBox
        Left = 8
        Top = 34
        Width = 305
        Height = 21
        Style = csDropDownList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
    end
    object GroupBox3: TGroupBox
      Left = 6
      Top = 144
      Width = 319
      Height = 61
      Caption = 'CASA 3'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      object Label6: TLabel
        Left = 8
        Top = 20
        Width = 80
        Height = 13
        Caption = 'Arcano Menor'
      end
      object ComboBoxArcMenorA3: TComboBox
        Left = 8
        Top = 37
        Width = 305
        Height = 21
        Style = csDropDownList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
    end
  end
  object GroupBoxTimeB: TGroupBox
    Left = 346
    Top = 0
    Width = 333
    Height = 211
    Caption = 'Time B'
    Color = 11184895
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 1
    object GroupBox5: TGroupBox
      Left = 6
      Top = 20
      Width = 319
      Height = 61
      Caption = 'CASA 1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object Label8: TLabel
        Left = 8
        Top = 18
        Width = 80
        Height = 13
        Caption = 'Arcano Menor'
      end
      object ComboBoxArcMenorB1: TComboBox
        Left = 8
        Top = 34
        Width = 305
        Height = 21
        Style = csDropDownList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
    end
    object GroupBox6: TGroupBox
      Left = 6
      Top = 82
      Width = 319
      Height = 61
      Caption = 'CASA 2'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object Label10: TLabel
        Left = 8
        Top = 18
        Width = 80
        Height = 13
        Caption = 'Arcano Menor'
      end
      object ComboBoxArcMenorB2: TComboBox
        Left = 8
        Top = 34
        Width = 305
        Height = 21
        Style = csDropDownList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
    end
    object GroupBox7: TGroupBox
      Left = 6
      Top = 144
      Width = 319
      Height = 61
      Caption = 'CASA 3'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      object Label12: TLabel
        Left = 8
        Top = 18
        Width = 80
        Height = 13
        Caption = 'Arcano Menor'
      end
      object ComboBoxArcMenorB3: TComboBox
        Left = 8
        Top = 34
        Width = 305
        Height = 21
        Style = csDropDownList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
    end
  end
  object Panel5: TPanel
    Left = 4
    Top = 226
    Width = 54
    Height = 45
    BevelKind = bkSoft
    Caption = 'VIT'#211'RIA'
    Color = 12189695
    ParentBackground = False
    TabOrder = 4
  end
  object StringGrid1: TStringGrid
    Left = 4
    Top = 270
    Width = 937
    Height = 99
    ColCount = 7
    DefaultRowHeight = 18
    DefaultDrawing = False
    FixedCols = 0
    RowCount = 13
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
    ScrollBars = ssVertical
    TabOrder = 5
    ColWidths = (
      51
      144
      143
      144
      141
      144
      176)
  end
  object Panel6: TPanel
    Left = 56
    Top = 247
    Width = 146
    Height = 24
    BevelKind = bkSoft
    Caption = 'CASA 1'
    Color = 12189695
    ParentBackground = False
    TabOrder = 6
  end
  object Panel7: TPanel
    Left = 56
    Top = 226
    Width = 436
    Height = 24
    BevelKind = bkSoft
    Caption = 'TIME A'
    Color = 12189695
    ParentBackground = False
    TabOrder = 7
  end
  object Panel8: TPanel
    Left = 201
    Top = 247
    Width = 146
    Height = 24
    BevelKind = bkSoft
    Caption = 'CAS A2'
    Color = 12189695
    ParentBackground = False
    TabOrder = 8
  end
  object Panel9: TPanel
    Left = 346
    Top = 247
    Width = 146
    Height = 24
    BevelKind = bkSoft
    Caption = 'CAS A3'
    Color = 12189695
    ParentBackground = False
    TabOrder = 9
  end
  object Panel12: TPanel
    Left = 490
    Top = 247
    Width = 146
    Height = 24
    BevelKind = bkSoft
    Caption = 'CASA 1'
    Color = 12189695
    ParentBackground = False
    TabOrder = 10
  end
  object Panel10: TPanel
    Left = 490
    Top = 226
    Width = 434
    Height = 24
    BevelKind = bkSoft
    Caption = 'TIME A'
    Color = 12189695
    ParentBackground = False
    TabOrder = 11
  end
  object Panel13: TPanel
    Left = 634
    Top = 247
    Width = 146
    Height = 24
    BevelKind = bkSoft
    Caption = 'CAS A2'
    Color = 12189695
    ParentBackground = False
    TabOrder = 12
  end
  object Panel14: TPanel
    Left = 778
    Top = 247
    Width = 146
    Height = 24
    BevelKind = bkSoft
    Caption = 'CAS A3'
    Color = 12189695
    ParentBackground = False
    TabOrder = 13
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 900
    Top = 20
  end
end
