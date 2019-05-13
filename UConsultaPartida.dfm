object FConsultaPartida: TFConsultaPartida
  Left = 56
  Top = 166
  Caption = 'CONSULTA JOGOS POR PARTIDA'
  ClientHeight = 480
  ClientWidth = 1019
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
  PixelsPerInch = 96
  TextHeight = 13
  object Label45: TLabel
    Left = 108
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
  object Label44: TLabel
    Left = 18
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
  object Label43: TLabel
    Left = 14
    Top = 5
    Width = 205
    Height = 13
    Caption = 'Selecione a partida a ser analisada:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Panel52: TPanel
    Left = 674
    Top = 14
    Width = 329
    Height = 57
    BorderStyle = bsSingle
    TabOrder = 2
    object btnLimpar: TBitBtn
      Left = 166
      Top = 8
      Width = 149
      Height = 38
      Cancel = True
      Caption = 'Limpar sele'#231#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00500005000555
        555557777F777555F55500000000555055557777777755F75555005500055055
        555577F5777F57555555005550055555555577FF577F5FF55555500550050055
        5555577FF77577FF555555005050110555555577F757777FF555555505099910
        555555FF75777777FF555005550999910555577F5F77777775F5500505509990
        3055577F75F77777575F55005055090B030555775755777575755555555550B0
        B03055555F555757575755550555550B0B335555755555757555555555555550
        BBB35555F55555575F555550555555550BBB55575555555575F5555555555555
        50BB555555555555575F555555555555550B5555555555555575}
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 1
      OnClick = btnLimparClick
    end
    object btnExcluir: TBitBtn
      Left = 321
      Top = 8
      Width = 176
      Height = 38
      Cancel = True
      Caption = 'Excluir selecionado'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333000033338833333333333333333F333333333333
        0000333911833333983333333388F333333F3333000033391118333911833333
        38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
        911118111118333338F3338F833338F3000033333911111111833333338F3338
        3333F8330000333333911111183333333338F333333F83330000333333311111
        8333333333338F3333383333000033333339111183333333333338F333833333
        00003333339111118333333333333833338F3333000033333911181118333333
        33338333338F333300003333911183911183333333383338F338F33300003333
        9118333911183333338F33838F338F33000033333913333391113333338FF833
        38F338F300003333333333333919333333388333338FFF830000333333333333
        3333333333333333333888330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 0
      Visible = False
    end
    object btnExibir: TBitBtn
      Left = 10
      Top = 8
      Width = 149
      Height = 38
      Caption = 'Exibir'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333300000000
        0000333377777777777733330FFFFFFFFFF033337F3FFF3F3FF733330F000F0F
        00F033337F777373773733330FFFFFFFFFF033337F3FF3FF3FF733330F00F00F
        00F033337F773773773733330FFFFFFFFFF033337FF3333FF3F7333300FFFF00
        F0F03333773FF377F7373330FB00F0F0FFF0333733773737F3F7330FB0BF0FB0
        F0F0337337337337373730FBFBF0FB0FFFF037F333373373333730BFBF0FB0FF
        FFF037F3337337333FF700FBFBFB0FFF000077F333337FF37777E0BFBFB000FF
        0FF077FF3337773F7F37EE0BFB0BFB0F0F03777FF3733F737F73EEE0BFBF00FF
        00337777FFFF77FF7733EEEE0000000003337777777777777333}
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 2
      OnClick = btnExibirClick
    end
  end
  object ComboBoxPartidas: TComboBox
    Left = 108
    Top = 44
    Width = 553
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
  object MaskEditData: TMaskEdit
    Left = 18
    Top = 44
    Width = 69
    Height = 21
    EditMask = '!99/99/9999;1;_'
    MaxLength = 10
    TabOrder = 0
    Text = '  /  /    '
    OnChange = MaskEditDataChange
  end
  object StringGrid1: TStringGrid
    Left = 12
    Top = 130
    Width = 995
    Height = 309
    ColCount = 9
    DefaultRowHeight = 18
    DefaultDrawing = False
    FixedCols = 0
    RowCount = 25
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
    ScrollBars = ssVertical
    TabOrder = 3
    OnDrawCell = StringGrid1DrawCell
    ColWidths = (
      51
      144
      143
      144
      141
      144
      143
      84
      64)
  end
  object Panel5: TPanel
    Left = 12
    Top = 86
    Width = 54
    Height = 45
    BevelKind = bkSoft
    Caption = 'VIT'#211'RIA'
    Color = 12189695
    ParentBackground = False
    TabOrder = 4
  end
  object Panel6: TPanel
    Left = 64
    Top = 107
    Width = 146
    Height = 24
    BevelKind = bkSoft
    Caption = 'CASA 1'
    Color = 12189695
    ParentBackground = False
    TabOrder = 5
  end
  object Panel7: TPanel
    Left = 64
    Top = 86
    Width = 436
    Height = 24
    BevelKind = bkSoft
    Caption = 'TIME A'
    Color = 12189695
    ParentBackground = False
    TabOrder = 6
  end
  object Panel8: TPanel
    Left = 209
    Top = 107
    Width = 146
    Height = 24
    BevelKind = bkSoft
    Caption = 'CAS A2'
    Color = 12189695
    ParentBackground = False
    TabOrder = 7
  end
  object Panel9: TPanel
    Left = 354
    Top = 107
    Width = 146
    Height = 24
    BevelKind = bkSoft
    Caption = 'CAS A3'
    Color = 12189695
    ParentBackground = False
    TabOrder = 8
  end
  object Panel12: TPanel
    Left = 498
    Top = 107
    Width = 146
    Height = 24
    BevelKind = bkSoft
    Caption = 'CASA 1'
    Color = 12189695
    ParentBackground = False
    TabOrder = 9
  end
  object Panel10: TPanel
    Left = 498
    Top = 86
    Width = 434
    Height = 24
    BevelKind = bkSoft
    Caption = 'TIME A'
    Color = 12189695
    ParentBackground = False
    TabOrder = 10
  end
  object Panel13: TPanel
    Left = 642
    Top = 107
    Width = 146
    Height = 24
    BevelKind = bkSoft
    Caption = 'CAS A2'
    Color = 12189695
    ParentBackground = False
    TabOrder = 11
  end
  object Panel14: TPanel
    Left = 786
    Top = 107
    Width = 146
    Height = 24
    BevelKind = bkSoft
    Caption = 'CAS A3'
    Color = 12189695
    ParentBackground = False
    TabOrder = 12
  end
  object Panel1: TPanel
    Left = 932
    Top = 86
    Width = 54
    Height = 45
    BevelKind = bkSoft
    Caption = 'Id'
    Color = 12189695
    ParentBackground = False
    TabOrder = 13
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'FMX'
    Left = 586
    Top = 10
  end
  object FDQuery1: TFDQuery
    Connection = DM.FDConnection1
    SQL.Strings = (
      'select Id, Vitoria,'
      
        '       a1ME.Descricao as A1MENOR, a2ME.Descricao as A2MENOR, a3M' +
        'E.Descricao as A3MENOR,'
      
        '       b1ME.Descricao as B1MENOR, b2ME.Descricao as B2MENOR, b3M' +
        'E.Descricao as B3MENOR'
      'from LOTECA'
      
        '            join ARCANOS_MENORES a1ME on(a1ME.Numero = A_CASA1_M' +
        'ENOR and a1ME.Naipe = A_CASA1_NAIPE)'
      
        '            join ARCANOS_MENORES a2ME on(a2ME.Numero = A_CASA2_M' +
        'ENOR and a2ME.Naipe = A_CASA2_NAIPE)'
      
        '            join ARCANOS_MENORES a3ME on(a3ME.Numero = A_CASA3_M' +
        'ENOR and a3ME.Naipe = A_CASA3_NAIPE)'
      
        '            join ARCANOS_MENORES b1ME on(b1ME.Numero = B_CASA1_M' +
        'ENOR and b1ME.Naipe = B_CASA1_NAIPE)'
      
        '            join ARCANOS_MENORES b2ME on(b2ME.Numero = B_CASA2_M' +
        'ENOR and b2ME.Naipe = B_CASA2_NAIPE)'
      
        '            join ARCANOS_MENORES b3ME on(b3ME.Numero = B_CASA3_M' +
        'ENOR and b3ME.Naipe = B_CASA3_NAIPE)'
      
        'where Id in (select idJogo from JOGOS_PARTIDAS where idPartida =' +
        ' :lsPartida)'
      'Order by Id')
    Left = 300
    Top = 300
    ParamData = <
      item
        Name = 'LSPARTIDA'
        ParamType = ptInput
      end>
  end
end
