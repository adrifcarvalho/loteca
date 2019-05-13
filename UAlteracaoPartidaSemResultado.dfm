object FAlteracaoPartidaSemResultado: TFAlteracaoPartidaSemResultado
  Left = 56
  Top = 166
  Caption = 'ALTERAR PARTIDA COM JOGOS SEM RESULTADO'
  ClientHeight = 513
  ClientWidth = 960
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
  object Label43: TLabel
    Left = 12
    Top = 8
    Width = 115
    Height = 13
    Caption = 'Selecione a partida:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label44: TLabel
    Left = 12
    Top = 30
    Width = 28
    Height = 13
    Caption = 'Data'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label45: TLabel
    Left = 97
    Top = 30
    Width = 28
    Height = 13
    Caption = 'Jogo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Panel52: TPanel
    Left = 674
    Top = 8
    Width = 267
    Height = 101
    BorderStyle = bsSingle
    TabOrder = 2
    object Label34: TLabel
      Left = 6
      Top = 4
      Width = 210
      Height = 16
      Caption = 'Selecione o resultado do jogo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object RadioGroupResultado: TRadioGroup
      Left = 4
      Top = 21
      Width = 115
      Height = 74
      Caption = 'Time'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ItemIndex = 2
      Items.Strings = (
        'A'
        'B'
        'Empate'
        'Sem resultado')
      ParentFont = False
      TabOrder = 0
    end
    object BitBtnAlterar: TBitBtn
      Left = 137
      Top = 38
      Width = 120
      Height = 38
      Caption = 'Alterar'
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
      OnClick = BitBtnAlterarClick
    end
  end
  object MaskEditData: TMaskEdit
    Left = 12
    Top = 44
    Width = 69
    Height = 21
    EditMask = '!99/99/9999;1;_'
    MaxLength = 10
    TabOrder = 0
    Text = '  /  /    '
    OnChange = MaskEditDataChange
  end
  object ComboBoxPartidas: TComboBox
    Left = 97
    Top = 44
    Width = 547
    Height = 21
    Style = csDropDownList
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnChange = ComboBoxPartidasChange
  end
  object Panel5: TPanel
    Left = 12
    Top = 134
    Width = 54
    Height = 45
    BevelKind = bkSoft
    Caption = 'VIT'#211'RIA'
    Color = 12189695
    ParentBackground = False
    TabOrder = 3
  end
  object Panel7: TPanel
    Left = 64
    Top = 134
    Width = 436
    Height = 24
    BevelKind = bkSoft
    Caption = 'TIME A'
    Color = 12189695
    ParentBackground = False
    TabOrder = 4
  end
  object Panel6: TPanel
    Left = 64
    Top = 155
    Width = 146
    Height = 24
    BevelKind = bkSoft
    Caption = 'CASA 1'
    Color = 12189695
    ParentBackground = False
    TabOrder = 5
  end
  object Panel8: TPanel
    Left = 209
    Top = 155
    Width = 146
    Height = 24
    BevelKind = bkSoft
    Caption = 'CAS A2'
    Color = 12189695
    ParentBackground = False
    TabOrder = 6
  end
  object Panel9: TPanel
    Left = 354
    Top = 155
    Width = 146
    Height = 24
    BevelKind = bkSoft
    Caption = 'CAS A3'
    Color = 12189695
    ParentBackground = False
    TabOrder = 7
  end
  object Panel10: TPanel
    Left = 498
    Top = 134
    Width = 434
    Height = 24
    BevelKind = bkSoft
    Caption = 'TIME A'
    Color = 12189695
    ParentBackground = False
    TabOrder = 8
  end
  object Panel12: TPanel
    Left = 498
    Top = 155
    Width = 146
    Height = 24
    BevelKind = bkSoft
    Caption = 'CASA 1'
    Color = 12189695
    ParentBackground = False
    TabOrder = 9
  end
  object Panel13: TPanel
    Left = 642
    Top = 155
    Width = 146
    Height = 24
    BevelKind = bkSoft
    Caption = 'CAS A2'
    Color = 12189695
    ParentBackground = False
    TabOrder = 10
  end
  object Panel14: TPanel
    Left = 786
    Top = 155
    Width = 146
    Height = 24
    BevelKind = bkSoft
    Caption = 'CAS A3'
    Color = 12189695
    ParentBackground = False
    TabOrder = 11
  end
  object StringGrid1: TStringGrid
    Left = 12
    Top = 178
    Width = 937
    Height = 251
    ColCount = 8
    DefaultRowHeight = 18
    DefaultDrawing = False
    FixedCols = 0
    RowCount = 13
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
    ScrollBars = ssVertical
    TabOrder = 12
    ColWidths = (
      51
      144
      143
      144
      141
      144
      176
      84)
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'FMX'
    Left = 588
    Top = 96
  end
end
