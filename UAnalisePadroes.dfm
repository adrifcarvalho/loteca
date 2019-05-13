object FAnalisePadroes: TFAnalisePadroes
  Left = 74
  Top = 111
  Caption = 'AN'#193'LISE DE PADR'#213'ES'
  ClientHeight = 611
  ClientWidth = 1201
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
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel5: TPanel
    Left = 0
    Top = 0
    Width = 1201
    Height = 219
    Align = alTop
    TabOrder = 0
    object Label43: TLabel
      Left = 22
      Top = 15
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
    object Label44: TLabel
      Left = 22
      Top = 34
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
      Left = 112
      Top = 34
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
    object GroupBoxTimeA: TGroupBox
      Left = 4
      Top = 88
      Width = 514
      Height = 110
      Caption = 'Time A'
      Color = 12058551
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentColor = False
      ParentFont = False
      TabOrder = 2
      object Label1: TLabel
        Left = 56
        Top = 18
        Width = 44
        Height = 13
        Caption = 'CASA 1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label2: TLabel
        Left = 230
        Top = 18
        Width = 44
        Height = 13
        Caption = 'CASA 2'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label3: TLabel
        Left = 396
        Top = 18
        Width = 44
        Height = 13
        Caption = 'CASA 3'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object cklbCasaA1: TCheckListBox
        Left = 8
        Top = 37
        Width = 158
        Height = 66
        BevelInner = bvNone
        BevelOuter = bvSpace
        BevelKind = bkSoft
        Columns = 1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ItemHeight = 13
        Items.Strings = (
          'Arcano maior'
          'Arcano menor'
          'Naipe arcano menor'
          'N'#250'mero arcano menor')
        ParentColor = True
        ParentFont = False
        TabOrder = 0
      end
      object cklbCasaA2: TCheckListBox
        Left = 176
        Top = 37
        Width = 158
        Height = 66
        BevelInner = bvNone
        BevelOuter = bvSpace
        BevelKind = bkSoft
        Columns = 1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ItemHeight = 13
        Items.Strings = (
          'Arcano maior'
          'Arcano menor'
          'Naipe arcano menor'
          'N'#250'mero arcano menor')
        ParentColor = True
        ParentFont = False
        TabOrder = 1
      end
      object cklbCasaA3: TCheckListBox
        Left = 344
        Top = 37
        Width = 158
        Height = 66
        BevelInner = bvNone
        BevelOuter = bvSpace
        BevelKind = bkSoft
        Columns = 1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ItemHeight = 13
        Items.Strings = (
          'Arcano maior'
          'Arcano menor'
          'Naipe arcano menor'
          'N'#250'mero arcano menor')
        ParentColor = True
        ParentFont = False
        TabOrder = 2
      end
    end
    object GroupBoxTimeB: TGroupBox
      Left = 528
      Top = 88
      Width = 514
      Height = 110
      Caption = 'Time B'
      Color = 10461183
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentColor = False
      ParentFont = False
      TabOrder = 3
      object Label4: TLabel
        Left = 56
        Top = 18
        Width = 44
        Height = 13
        Caption = 'CASA 1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label5: TLabel
        Left = 230
        Top = 18
        Width = 44
        Height = 13
        Caption = 'CASA 2'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label6: TLabel
        Left = 396
        Top = 18
        Width = 44
        Height = 13
        Caption = 'CASA 3'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object cklbCasaB1: TCheckListBox
        Left = 8
        Top = 37
        Width = 158
        Height = 66
        BevelInner = bvNone
        BevelOuter = bvSpace
        BevelKind = bkSoft
        Columns = 1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ItemHeight = 13
        Items.Strings = (
          'Arcano maior'
          'Arcano menor'
          'Naipe arcano menor'
          'N'#250'mero arcano menor')
        ParentColor = True
        ParentFont = False
        TabOrder = 0
      end
      object cklbCasaB2: TCheckListBox
        Left = 176
        Top = 37
        Width = 158
        Height = 66
        BevelInner = bvNone
        BevelOuter = bvSpace
        BevelKind = bkSoft
        Columns = 1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ItemHeight = 13
        Items.Strings = (
          'Arcano maior'
          'Arcano menor'
          'Naipe arcano menor'
          'N'#250'mero arcano menor')
        ParentColor = True
        ParentFont = False
        TabOrder = 1
      end
      object cklbCasaB3: TCheckListBox
        Left = 344
        Top = 37
        Width = 158
        Height = 66
        BevelInner = bvNone
        BevelOuter = bvSpace
        BevelKind = bkSoft
        Columns = 1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ItemHeight = 13
        Items.Strings = (
          'Arcano maior'
          'Arcano menor'
          'Naipe arcano menor'
          'N'#250'mero arcano menor')
        ParentColor = True
        ParentFont = False
        TabOrder = 2
      end
    end
    object MaskEditData: TMaskEdit
      Left = 22
      Top = 48
      Width = 69
      Height = 21
      EditMask = '!99/99/9999;1;_'
      MaxLength = 10
      TabOrder = 0
      Text = '  /  /    '
      OnChange = MaskEditDataChange
    end
    object ComboBoxPartidas: TComboBox
      Left = 112
      Top = 48
      Width = 578
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
    end
  end
  object Panel1: TPanel
    Left = 847
    Top = 3
    Width = 275
    Height = 75
    BorderStyle = bsSingle
    TabOrder = 1
    object Label13: TLabel
      Left = 10
      Top = 4
      Width = 255
      Height = 13
      Caption = 'PREVIS'#195'O: escolha o time para compara'#231#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object RadioGroupTime: TRadioGroup
      Left = 4
      Top = 19
      Width = 49
      Height = 47
      Caption = 'Time'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Items.Strings = (
        'A'
        'B')
      ParentFont = False
      TabOrder = 0
    end
    object BitBtnPrever: TBitBtn
      Left = 55
      Top = 28
      Width = 104
      Height = 38
      Caption = 'Prever Vit'#243'ria'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333303333
        333333333337FF3333333333330003333333333333777F333333333333080333
        3333333F33777FF33F3333B33B000B33B3333373F777773F7333333BBB0B0BBB
        33333337737F7F77F333333BBB0F0BBB33333337337373F73F3333BBB0F7F0BB
        B333337F3737F73F7F3333BB0FB7BF0BB3333F737F37F37F73FFBBBB0BF7FB0B
        BBB3773F7F37337F377333BB0FBFBF0BB333337F73F333737F3333BBB0FBF0BB
        B3333373F73FF7337333333BBB000BBB33333337FF777337F333333BBBBBBBBB
        3333333773FF3F773F3333B33BBBBB33B33333733773773373333333333B3333
        333333333337F33333333333333B333333333333333733333333}
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 1
      OnClick = BitBtnPreverClick
    end
    object BitBtnLimpar: TBitBtn
      Left = 161
      Top = 28
      Width = 104
      Height = 38
      Caption = 'Limpar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333444444
        33333333333F8888883F33330000324334222222443333388F3833333388F333
        000032244222222222433338F8833FFFFF338F3300003222222AAAAA22243338
        F333F88888F338F30000322222A33333A2224338F33F8333338F338F00003222
        223333333A224338F33833333338F38F00003222222333333A444338FFFF8F33
        3338888300003AAAAAAA33333333333888888833333333330000333333333333
        333333333333333333FFFFFF000033333333333344444433FFFF333333888888
        00003A444333333A22222438888F333338F3333800003A2243333333A2222438
        F38F333333833338000033A224333334422224338338FFFFF8833338000033A2
        22444442222224338F3388888333FF380000333A2222222222AA243338FF3333
        33FF88F800003333AA222222AA33A3333388FFFFFF8833830000333333AAAAAA
        3333333333338888883333330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 2
      OnClick = BitBtnLimparClick
    end
  end
  object StringGrid1: TStringGrid
    Left = 476
    Top = 69
    Width = 435
    Height = 20
    ColCount = 13
    DefaultRowHeight = 18
    FixedCols = 0
    RowCount = 13
    ScrollBars = ssVertical
    TabOrder = 2
    Visible = False
    ColWidths = (
      37
      38
      30
      31
      32
      31
      27
      26
      34
      29
      26
      28
      27)
  end
  object Panel2: TPanel
    Left = 0
    Top = 219
    Width = 1201
    Height = 392
    Align = alClient
    Caption = 'Panel2'
    TabOrder = 3
    DesignSize = (
      1201
      392)
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'FMX'
    Left = 752
    Top = 16
  end
  object FDQuery1: TFDQuery
    Connection = DM.FDConnection1
    SQL.Strings = (
      'select Vitoria, '#39'A'#39' as Equipe,'
      
        '            a1MA.Descricao as A1MAIOR, a1ME.Descricao as A1MENOR' +
        ','
      
        '            a2MA.Descricao as A2MAIOR, a2ME.Descricao as A2MENOR' +
        ','
      
        '            a3MA.Descricao as A3MAIOR, a3ME.Descricao as A3MENOR' +
        ','
      
        '            b1MA.Descricao as B1MAIOR, b1ME.Descricao as B1MENOR' +
        ', '
      
        '            b2MA.Descricao as B2MAIOR, b2ME.Descricao as B2MENOR' +
        ', '
      
        '            b3MA.Descricao as B3MAIOR, b3ME.Descricao as B3MENOR' +
        ' '
      'from LOTECA'
      
        '            join ARCANOS_MAIORES a1MA on(a1MA.Codigo = A_CASA1_M' +
        'AIOR) '
      
        '            join ARCANOS_MENORES a1ME on(a1ME.Numero = A_CASA1_M' +
        'ENOR and a1ME.Naipe = A_CASA1_NAIPE) '
      
        '            join ARCANOS_MAIORES a2MA on(a2MA.Codigo = A_CASA2_M' +
        'AIOR) '
      
        '            join ARCANOS_MENORES a2ME on(a2ME.Numero = A_CASA2_M' +
        'ENOR and a2ME.Naipe = A_CASA2_NAIPE) '
      
        '            join ARCANOS_MAIORES a3MA on(a3MA.Codigo = A_CASA3_M' +
        'AIOR) '
      
        '            join ARCANOS_MENORES a3ME on(a3ME.Numero = A_CASA3_M' +
        'ENOR and a3ME.Naipe = A_CASA3_NAIPE) '
      
        '            join ARCANOS_MAIORES b1MA on(b1MA.Codigo = B_CASA1_M' +
        'AIOR) '
      
        '            join ARCANOS_MAIORES b2MA on(b2MA.Codigo = B_CASA2_M' +
        'AIOR) '
      
        '            join ARCANOS_MAIORES b3MA on(b3MA.Codigo = B_CASA3_M' +
        'AIOR) '
      
        '            join ARCANOS_MENORES b1ME on(b1ME.Numero = B_CASA1_M' +
        'ENOR and b1ME.Naipe = B_CASA1_NAIPE) '
      
        '            join ARCANOS_MENORES b2ME on(b2ME.Numero = B_CASA2_M' +
        'ENOR and b2ME.Naipe = B_CASA2_NAIPE) '
      
        '            join ARCANOS_MENORES b3ME on(b3ME.Numero = B_CASA3_M' +
        'ENOR and b3ME.Naipe = B_CASA3_NAIPE)'
      'WHERE Vitoria is not null'
      'and'
      
        '  ( ( (A_CASA1_MENOR = :ArcMen1Filtro and A_CASA1_NAIPE = :Naipe' +
        '1Filtro) and'
      
        '      (A_CASA2_MENOR = :ArcMen2Filtro and A_CASA2_NAIPE = :Naipe' +
        '2Filtro) and'
      
        '      (A_CASA3_MENOR = :ArcMen3Filtro and A_CASA3_NAIPE = :Naipe' +
        '3Filtro)'
      '    )'
      '    and'
      
        '    ( ( (B_CASA1_MAIOR = :ArcMai1Oposto and B_CASA1_MENOR = :Arc' +
        'Men1Oposto) or'
      
        '        (B_CASA2_MAIOR = :ArcMai2Oposto and B_CASA2_MENOR = :Arc' +
        'Men2Oposto) or'
      
        '        (B_CASA3_MAIOR = :ArcMai3Oposto and B_CASA3_MENOR = :Arc' +
        'Men3Oposto)'
      '      )'
      '      or'
      
        '      ( (B_CASA2_MENOR = :ArcMen2Oposto and B_CASA2_NAIPE = :Nai' +
        'pe2Oposto) or'
      '        (B_CASA2_MAIOR = :ArcMai2Oposto) or'
      
        '        (B_CASA2_MAIOR = :ArcMai2Oposto and B_CASA2_MENOR = :Arc' +
        'Men2Oposto) or'
      
        '        (B_CASA2_MAIOR = :ArcMai2Oposto and B_CASA2_MENOR = :Arc' +
        'Men2Oposto and B_CASA2_NAIPE = :Naipe2Oposto) or'
      
        '        (B_CASA2_MAIOR = :ArcMai2Oposto and B_CASA2_NAIPE = :Nai' +
        'pe2Oposto)'
      '      )'
      '      or'
      
        '      ( ( (B_CASA2_MENOR = :ArcMen2Oposto and B_CASA2_NAIPE = :N' +
        'aipe2Oposto) or'
      '          (B_CASA2_MAIOR = :ArcMai2Oposto) or'
      
        '          (B_CASA2_MAIOR = :ArcMai2Oposto and B_CASA2_MENOR = :A' +
        'rcMen2Oposto) or'
      
        '          (B_CASA2_MAIOR = :ArcMai2Oposto and B_CASA2_MENOR = :A' +
        'rcMen2Oposto and B_CASA2_NAIPE = :Naipe2Oposto) or'
      
        '          (B_CASA2_MAIOR = :ArcMai2Oposto and B_CASA2_NAIPE = :N' +
        'aipe2Oposto)'
      '         )'
      '        and'
      
        '        ( (B_CASA1_MENOR = :ArcMen1Oposto) or (B_CASA1_MAIOR = :' +
        'ArcMai1Oposto) or'
      
        '          (B_CASA1_MAIOR = :ArcMai1Oposto and B_CASA1_MENOR = :A' +
        'rcMen1Oposto)  or'
      
        '          (B_CASA1_MAIOR = :ArcMai1Oposto and B_CASA1_MENOR = :A' +
        'rcMen1Oposto and B_CASA1_NAIPE = :Naipe1Oposto) or'
      
        '          (B_CASA1_MAIOR = :ArcMai1Oposto and B_CASA1_NAIPE = :N' +
        'aipe1Oposto)   or'
      
        '          (B_CASA3_MENOR = :ArcMen3Oposto) or (B_CASA3_MAIOR = :' +
        'ArcMai3Oposto) or'
      
        '          (B_CASA3_MAIOR = :ArcMai3Oposto and B_CASA3_MENOR = :A' +
        'rcMen3Oposto)  or'
      
        '          (B_CASA3_MAIOR = :ArcMai3Oposto and B_CASA3_MENOR = :A' +
        'rcMen3Oposto and B_CASA3_NAIPE = :Naipe3Oposto) or'
      
        '          (B_CASA3_MAIOR = :ArcMai3Oposto and B_CASA3_NAIPE = :N' +
        'aipe3Oposto)'
      '        )'
      '      )'
      '      or'
      
        '      ( (B_CASA1_MENOR = :ArcMen1Oposto and B_CASA2_MENOR = :Arc' +
        'Men2Oposto) or'
      
        '        (B_CASA1_MENOR = :ArcMen1Oposto and B_CASA3_MENOR = :Arc' +
        'Men3Oposto) or'
      
        '        (B_CASA2_MENOR = :ArcMen2Oposto and B_CASA3_MENOR = :Arc' +
        'Men3Oposto)'
      '      )'
      '      or'
      
        '      ( (B_CASA1_MAIOR = :ArcMai1Oposto and B_CASA1_MENOR = :Arc' +
        'Men1Oposto) or'
      
        '        (B_CASA1_MAIOR = :ArcMai1Oposto and B_CASA1_NAIPE = :Nai' +
        'pe1Oposto)  or'
      
        '        (B_CASA1_MAIOR = :ArcMai1Oposto and B_CASA1_MENOR = :Arc' +
        'Men1Oposto and B_CASA1_NAIPE = :Naipe1Oposto)  or'
      
        '        (B_CASA3_MAIOR = :ArcMai3Oposto and B_CASA3_MENOR = :Arc' +
        'Men3Oposto) or'
      
        '        (B_CASA3_MAIOR = :ArcMai3Oposto and B_CASA3_NAIPE = :Nai' +
        'pe3Oposto)  or'
      
        '        (B_CASA3_MAIOR = :ArcMai3Oposto and B_CASA3_MENOR = :Arc' +
        'Men3Oposto and B_CASA3_NAIPE = :Naipe3Oposto)  or'
      
        '        (B_CASA1_MENOR = :ArcMen1Oposto and B_CASA3_MENOR = :Arc' +
        'Men3Oposto) or'
      
        '        (B_CASA1_MENOR = :ArcMen1Oposto and B_CASA3_MAIOR = :Arc' +
        'Mai3Oposto) or'
      
        '        (B_CASA1_MAIOR = :ArcMai1Oposto and B_CASA3_MENOR = :Arc' +
        'Men3Oposto) or'
      
        '        (B_CASA1_MAIOR = :ArcMai1Oposto and B_CASA3_MAIOR = :Arc' +
        'Mai3Oposto)'
      '      )'
      '    )'
      '  )'
      'UNION'
      'select Vitoria, '#39'B'#39' as Equipe,'
      
        '            a1MA.Descricao as A1MAIOR, a1ME.Descricao as A1MENOR' +
        ','
      
        '            a2MA.Descricao as A2MAIOR, a2ME.Descricao as A2MENOR' +
        ','
      
        '            a3MA.Descricao as A3MAIOR, a3ME.Descricao as A3MENOR' +
        ','
      
        '            b1MA.Descricao as B1MAIOR, b1ME.Descricao as B1MENOR' +
        ','
      
        '            b2MA.Descricao as B2MAIOR, b2ME.Descricao as B2MENOR' +
        ','
      '            b3MA.Descricao as B3MAIOR, b3ME.Descricao as B3MENOR'
      'from LOTECA'
      
        '            join ARCANOS_MAIORES a1MA on(a1MA.Codigo = A_CASA1_M' +
        'AIOR)'
      
        '            join ARCANOS_MENORES a1ME on(a1ME.Numero = A_CASA1_M' +
        'ENOR and a1ME.Naipe = A_CASA1_NAIPE)'
      
        '            join ARCANOS_MAIORES a2MA on(a2MA.Codigo = A_CASA2_M' +
        'AIOR)'
      
        '            join ARCANOS_MENORES a2ME on(a2ME.Numero = A_CASA2_M' +
        'ENOR and a2ME.Naipe = A_CASA2_NAIPE)'
      
        '            join ARCANOS_MAIORES a3MA on(a3MA.Codigo = A_CASA3_M' +
        'AIOR)'
      
        '            join ARCANOS_MENORES a3ME on(a3ME.Numero = A_CASA3_M' +
        'ENOR and a3ME.Naipe = A_CASA3_NAIPE)'
      
        '            join ARCANOS_MAIORES b1MA on(b1MA.Codigo = B_CASA1_M' +
        'AIOR)'
      
        '            join ARCANOS_MAIORES b2MA on(b2MA.Codigo = B_CASA2_M' +
        'AIOR)'
      
        '            join ARCANOS_MAIORES b3MA on(b3MA.Codigo = B_CASA3_M' +
        'AIOR)'
      
        '            join ARCANOS_MENORES b1ME on(b1ME.Numero = B_CASA1_M' +
        'ENOR and b1ME.Naipe = B_CASA1_NAIPE)'
      
        '            join ARCANOS_MENORES b2ME on(b2ME.Numero = B_CASA2_M' +
        'ENOR and b2ME.Naipe = B_CASA2_NAIPE)'
      
        '            join ARCANOS_MENORES b3ME on(b3ME.Numero = B_CASA3_M' +
        'ENOR and b3ME.Naipe = B_CASA3_NAIPE)'
      'WHERE Vitoria is not null'
      'and'
      
        '  ( ( (B_CASA1_MENOR = :ArcMen1Filtro and B_CASA1_NAIPE = :Naipe' +
        '1Filtro) and'
      
        '      (B_CASA2_MENOR = :ArcMen2Filtro and B_CASA2_NAIPE = :Naipe' +
        '2Filtro) and'
      
        '      (B_CASA3_MENOR = :ArcMen3Filtro and B_CASA3_NAIPE = :Naipe' +
        '3Filtro)'
      '    )'
      '    and'
      
        '    ( ( (A_CASA1_MAIOR = :ArcMai1Oposto and A_CASA1_MENOR = :Arc' +
        'Men1Oposto) or'
      
        '        (A_CASA2_MAIOR = :ArcMai2Oposto and A_CASA2_MENOR = :Arc' +
        'Men2Oposto) or'
      
        '        (A_CASA3_MAIOR = :ArcMai3Oposto and A_CASA3_MENOR = :Arc' +
        'Men3Oposto)'
      '      )'
      '      or'
      
        '      ( (A_CASA2_MENOR = :ArcMen2Oposto and A_CASA2_NAIPE = :Nai' +
        'pe2Oposto) or'
      '        (A_CASA2_MAIOR = :ArcMai2Oposto) or'
      
        '        (A_CASA2_MAIOR = :ArcMai2Oposto and A_CASA2_MENOR = :Arc' +
        'Men2Oposto) or'
      
        '        (A_CASA2_MAIOR = :ArcMai2Oposto and A_CASA2_MENOR = :Arc' +
        'Men2Oposto and A_CASA2_NAIPE = :Naipe2Oposto) or'
      
        '        (A_CASA2_MAIOR = :ArcMai2Oposto and A_CASA2_NAIPE = :Nai' +
        'pe2Oposto)'
      '      )'
      '      or'
      
        '      ( ( (A_CASA2_MENOR = :ArcMen2Oposto and A_CASA2_NAIPE = :N' +
        'aipe2Oposto) or'
      '          (A_CASA2_MAIOR = :ArcMai2Oposto) or'
      
        '          (A_CASA2_MAIOR = :ArcMai2Oposto and A_CASA2_MENOR = :A' +
        'rcMen2Oposto) or'
      
        '          (A_CASA2_MAIOR = :ArcMai2Oposto and A_CASA2_MENOR = :A' +
        'rcMen2Oposto and A_CASA2_NAIPE = :Naipe2Oposto) or'
      
        '          (A_CASA2_MAIOR = :ArcMai2Oposto and A_CASA2_NAIPE = :N' +
        'aipe2Oposto)'
      '        )'
      '        and'
      
        '        ( A_CASA1_MENOR = :ArcMen1Oposto or  A_CASA1_MAIOR = :Ar' +
        'cMai1Oposto or'
      
        '         (A_CASA1_MAIOR = :ArcMai1Oposto and A_CASA1_MENOR = :Ar' +
        'cMen1Oposto) or'
      
        '         (A_CASA1_MAIOR = :ArcMai1Oposto and A_CASA1_MENOR = :Ar' +
        'cMen1Oposto and A_CASA1_NAIPE = :Naipe1Oposto) or'
      
        '         (A_CASA1_MAIOR = :ArcMai1Oposto and A_CASA1_NAIPE = :Na' +
        'ipe1Oposto) or'
      
        '          A_CASA3_MENOR = :ArcMen3Oposto or  A_CASA3_MAIOR = :Ar' +
        'cMai3Oposto or'
      
        '         (A_CASA3_MAIOR = :ArcMai3Oposto and A_CASA3_MENOR = :Ar' +
        'cMen3Oposto) or'
      
        '         (A_CASA3_MAIOR = :ArcMai3Oposto and A_CASA3_MENOR = :Ar' +
        'cMen3Oposto and A_CASA3_NAIPE = :Naipe3Oposto) or'
      
        '         (A_CASA3_MAIOR = :ArcMai3Oposto and A_CASA3_NAIPE = :Na' +
        'ipe3Oposto) )'
      '      )'
      '      or'
      
        '      ( (A_CASA1_MENOR = :ArcMen1Oposto and A_CASA2_MENOR = :Arc' +
        'Men2Oposto) or'
      
        '        (A_CASA1_MENOR = :ArcMen1Oposto and A_CASA3_MENOR = :Arc' +
        'Men3Oposto) or'
      
        '        (A_CASA2_MENOR = :ArcMen2Oposto and A_CASA3_MENOR = :Arc' +
        'Men3Oposto)'
      '      )'
      '      or'
      
        '      ( (A_CASA1_MAIOR = :ArcMai1Oposto and A_CASA1_MENOR = :Arc' +
        'Men1Oposto) or'
      
        '        (A_CASA1_MAIOR = :ArcMai1Oposto and A_CASA1_NAIPE = :Nai' +
        'pe1Oposto)  or'
      
        '        (A_CASA1_MAIOR = :ArcMai1Oposto and A_CASA1_MENOR = :Arc' +
        'Men1Oposto and A_CASA1_NAIPE = :Naipe1Oposto)  or'
      
        '        (A_CASA3_MAIOR = :ArcMai3Oposto and A_CASA3_MENOR = :Arc' +
        'Men3Oposto) or'
      
        '        (A_CASA3_MAIOR = :ArcMai3Oposto and A_CASA3_NAIPE = :Nai' +
        'pe3Oposto)  or'
      
        '        (A_CASA3_MAIOR = :ArcMai3Oposto and A_CASA3_MENOR = :Arc' +
        'Men3Oposto and A_CASA3_NAIPE = :Naipe3Oposto)  or'
      
        '        (A_CASA1_MENOR = :ArcMen1Oposto and A_CASA3_MENOR = :Arc' +
        'Men3Oposto) or'
      
        '        (A_CASA1_MENOR = :ArcMen1Oposto and A_CASA3_MAIOR = :Arc' +
        'Mai3Oposto) or'
      
        '        (A_CASA1_MAIOR = :ArcMai1Oposto and A_CASA3_MENOR = :Arc' +
        'Men3Oposto) or'
      
        '        (A_CASA1_MAIOR = :ArcMai1Oposto and A_CASA3_MAIOR = :Arc' +
        'Mai3Oposto)'
      '      )'
      '    )'
      '  )'
      'Order by VITORIA, Equipe')
    Left = 300
    Top = 300
    ParamData = <
      item
        Name = 'ARCMEN1FILTRO'
        ArrayType = atArray
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'NAIPE1FILTRO'
        ArrayType = atArray
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'ARCMEN2FILTRO'
        ArrayType = atArray
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'NAIPE2FILTRO'
        ArrayType = atArray
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'ARCMEN3FILTRO'
        ArrayType = atArray
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'NAIPE3FILTRO'
        ArrayType = atArray
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'ARCMAI1OPOSTO'
        ArrayType = atArray
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'ARCMEN1OPOSTO'
        ArrayType = atArray
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'ARCMAI2OPOSTO'
        ArrayType = atArray
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'ARCMEN2OPOSTO'
        ArrayType = atArray
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'ARCMAI3OPOSTO'
        ArrayType = atArray
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'ARCMEN3OPOSTO'
        ArrayType = atArray
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'NAIPE2OPOSTO'
        ArrayType = atArray
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'NAIPE1OPOSTO'
        ArrayType = atArray
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'NAIPE3OPOSTO'
        ArrayType = atArray
        DataType = ftString
        ParamType = ptInput
      end>
  end
  object FDQuery1Count: TFDQuery
    Connection = DM.FDConnection1
    SQL.Strings = (
      'select COUNT(Vitoria) as QTD, Vitoria, '#39'A'#39' as Equipe '
      'from LOTECA '
      'WHERE Vitoria is not null'
      'and'
      
        '  ( ( (A_CASA1_MENOR = :ArcMen1Filtro and A_CASA1_NAIPE = :Naipe' +
        '1Filtro) and'
      
        '      (A_CASA2_MENOR = :ArcMen2Filtro and A_CASA2_NAIPE = :Naipe' +
        '2Filtro) and'
      
        '      (A_CASA3_MENOR = :ArcMen3Filtro and A_CASA3_NAIPE = :Naipe' +
        '3Filtro)'
      '    )'
      '    and'
      
        '    ( ( (B_CASA1_MAIOR = :ArcMai1Oposto and B_CASA1_MENOR = :Arc' +
        'Men1Oposto) or'
      
        '        (B_CASA2_MAIOR = :ArcMai2Oposto and B_CASA2_MENOR = :Arc' +
        'Men2Oposto) or'
      
        '        (B_CASA3_MAIOR = :ArcMai3Oposto and B_CASA3_MENOR = :Arc' +
        'Men3Oposto)'
      '      )'
      '      or'
      
        '      ( (B_CASA2_MENOR = :ArcMen2Oposto and B_CASA2_NAIPE = :Nai' +
        'pe2Oposto) or'
      '        (B_CASA2_MAIOR = :ArcMai2Oposto) or'
      
        '        (B_CASA2_MAIOR = :ArcMai2Oposto and B_CASA2_MENOR = :Arc' +
        'Men2Oposto) or'
      
        '        (B_CASA2_MAIOR = :ArcMai2Oposto and B_CASA2_MENOR = :Arc' +
        'Men2Oposto and B_CASA2_NAIPE = :Naipe2Oposto) or'
      
        '        (B_CASA2_MAIOR = :ArcMai2Oposto and B_CASA2_NAIPE = :Nai' +
        'pe2Oposto)'
      '      )'
      '      or'
      
        '      ( ( (B_CASA2_MENOR = :ArcMen2Oposto and B_CASA2_NAIPE = :N' +
        'aipe2Oposto) or'
      '          (B_CASA2_MAIOR = :ArcMai2Oposto) or'
      
        '          (B_CASA2_MAIOR = :ArcMai2Oposto and B_CASA2_MENOR = :A' +
        'rcMen2Oposto) or'
      
        '          (B_CASA2_MAIOR = :ArcMai2Oposto and B_CASA2_MENOR = :A' +
        'rcMen2Oposto and B_CASA2_NAIPE = :Naipe2Oposto) or'
      
        '          (B_CASA2_MAIOR = :ArcMai2Oposto and B_CASA2_NAIPE = :N' +
        'aipe2Oposto)'
      '         )'
      '        and'
      
        '        ( (B_CASA1_MENOR = :ArcMen1Oposto) or (B_CASA1_MAIOR = :' +
        'ArcMai1Oposto) or'
      
        '          (B_CASA1_MAIOR = :ArcMai1Oposto and B_CASA1_MENOR = :A' +
        'rcMen1Oposto)  or'
      
        '          (B_CASA1_MAIOR = :ArcMai1Oposto and B_CASA1_MENOR = :A' +
        'rcMen1Oposto and B_CASA1_NAIPE = :Naipe1Oposto) or'
      
        '          (B_CASA1_MAIOR = :ArcMai1Oposto and B_CASA1_NAIPE = :N' +
        'aipe1Oposto)   or'
      
        '          (B_CASA3_MENOR = :ArcMen3Oposto) or (B_CASA3_MAIOR = :' +
        'ArcMai3Oposto) or'
      
        '          (B_CASA3_MAIOR = :ArcMai3Oposto and B_CASA3_MENOR = :A' +
        'rcMen3Oposto)  or'
      
        '          (B_CASA3_MAIOR = :ArcMai3Oposto and B_CASA3_MENOR = :A' +
        'rcMen3Oposto and B_CASA3_NAIPE = :Naipe3Oposto) or'
      
        '          (B_CASA3_MAIOR = :ArcMai3Oposto and B_CASA3_NAIPE = :N' +
        'aipe3Oposto)'
      '        )'
      '      )'
      '      or'
      
        '      ( (B_CASA1_MENOR = :ArcMen1Oposto and B_CASA2_MENOR = :Arc' +
        'Men2Oposto) or'
      
        '        (B_CASA1_MENOR = :ArcMen1Oposto and B_CASA3_MENOR = :Arc' +
        'Men3Oposto) or'
      
        '        (B_CASA2_MENOR = :ArcMen2Oposto and B_CASA3_MENOR = :Arc' +
        'Men3Oposto)'
      '      )'
      '      or'
      
        '      ( (B_CASA1_MAIOR = :ArcMai1Oposto and B_CASA1_MENOR = :Arc' +
        'Men1Oposto) or'
      
        '        (B_CASA1_MAIOR = :ArcMai1Oposto and B_CASA1_NAIPE = :Nai' +
        'pe1Oposto)  or'
      
        '        (B_CASA1_MAIOR = :ArcMai1Oposto and B_CASA1_MENOR = :Arc' +
        'Men1Oposto and B_CASA1_NAIPE = :Naipe1Oposto)  or'
      
        '        (B_CASA3_MAIOR = :ArcMai3Oposto and B_CASA3_MENOR = :Arc' +
        'Men3Oposto) or'
      
        '        (B_CASA3_MAIOR = :ArcMai3Oposto and B_CASA3_NAIPE = :Nai' +
        'pe3Oposto)  or'
      
        '        (B_CASA3_MAIOR = :ArcMai3Oposto and B_CASA3_MENOR = :Arc' +
        'Men3Oposto and B_CASA3_NAIPE = :Naipe3Oposto)  or'
      
        '        (B_CASA1_MENOR = :ArcMen1Oposto and B_CASA3_MENOR = :Arc' +
        'Men3Oposto) or'
      
        '        (B_CASA1_MENOR = :ArcMen1Oposto and B_CASA3_MAIOR = :Arc' +
        'Mai3Oposto) or'
      
        '        (B_CASA1_MAIOR = :ArcMai1Oposto and B_CASA3_MENOR = :Arc' +
        'Men3Oposto) or'
      
        '        (B_CASA1_MAIOR = :ArcMai1Oposto and B_CASA3_MAIOR = :Arc' +
        'Mai3Oposto)'
      '      )'
      '    )'
      '  )'
      'UNION'
      'select COUNT(Vitoria) as QTD, Vitoria, '#39'B'#39' as Equipe'
      'from LOTECA'
      'WHERE Vitoria is not null'
      'and'
      
        '  ( ( (B_CASA1_MENOR = :ArcMen1Filtro and B_CASA1_NAIPE = :Naipe' +
        '1Filtro) and'
      
        '      (B_CASA2_MENOR = :ArcMen2Filtro and B_CASA2_NAIPE = :Naipe' +
        '2Filtro) and'
      
        '      (B_CASA3_MENOR = :ArcMen3Filtro and B_CASA3_NAIPE = :Naipe' +
        '3Filtro)'
      '    )'
      '    and'
      
        '    ( ( (A_CASA1_MAIOR = :ArcMai1Oposto and A_CASA1_MENOR = :Arc' +
        'Men1Oposto) or'
      
        '        (A_CASA2_MAIOR = :ArcMai2Oposto and A_CASA2_MENOR = :Arc' +
        'Men2Oposto) or'
      
        '        (A_CASA3_MAIOR = :ArcMai3Oposto and A_CASA3_MENOR = :Arc' +
        'Men3Oposto)'
      '      )'
      '      or'
      
        '      ( (A_CASA2_MENOR = :ArcMen2Oposto and A_CASA2_NAIPE = :Nai' +
        'pe2Oposto) or'
      '        (A_CASA2_MAIOR = :ArcMai2Oposto) or'
      
        '        (A_CASA2_MAIOR = :ArcMai2Oposto and A_CASA2_MENOR = :Arc' +
        'Men2Oposto) or'
      
        '        (A_CASA2_MAIOR = :ArcMai2Oposto and A_CASA2_MENOR = :Arc' +
        'Men2Oposto and A_CASA2_NAIPE = :Naipe2Oposto) or'
      
        '        (A_CASA2_MAIOR = :ArcMai2Oposto and A_CASA2_NAIPE = :Nai' +
        'pe2Oposto)'
      '      )'
      '      or'
      
        '      ( ( (A_CASA2_MENOR = :ArcMen2Oposto and A_CASA2_NAIPE = :N' +
        'aipe2Oposto) or'
      '          (A_CASA2_MAIOR = :ArcMai2Oposto) or'
      
        '          (A_CASA2_MAIOR = :ArcMai2Oposto and A_CASA2_MENOR = :A' +
        'rcMen2Oposto) or'
      
        '          (A_CASA2_MAIOR = :ArcMai2Oposto and A_CASA2_MENOR = :A' +
        'rcMen2Oposto and A_CASA2_NAIPE = :Naipe2Oposto) or'
      
        '          (A_CASA2_MAIOR = :ArcMai2Oposto and A_CASA2_NAIPE = :N' +
        'aipe2Oposto)'
      '        )'
      '        and'
      
        '        ( A_CASA1_MENOR = :ArcMen1Oposto or  A_CASA1_MAIOR = :Ar' +
        'cMai1Oposto or'
      
        '         (A_CASA1_MAIOR = :ArcMai1Oposto and A_CASA1_MENOR = :Ar' +
        'cMen1Oposto) or'
      
        '         (A_CASA1_MAIOR = :ArcMai1Oposto and A_CASA1_MENOR = :Ar' +
        'cMen1Oposto and A_CASA1_NAIPE = :Naipe1Oposto) or'
      
        '         (A_CASA1_MAIOR = :ArcMai1Oposto and A_CASA1_NAIPE = :Na' +
        'ipe1Oposto) or'
      
        '          A_CASA3_MENOR = :ArcMen3Oposto or  A_CASA3_MAIOR = :Ar' +
        'cMai3Oposto or'
      
        '         (A_CASA3_MAIOR = :ArcMai3Oposto and A_CASA3_MENOR = :Ar' +
        'cMen3Oposto) or'
      
        '         (A_CASA3_MAIOR = :ArcMai3Oposto and A_CASA3_MENOR = :Ar' +
        'cMen3Oposto and A_CASA3_NAIPE = :Naipe3Oposto) or'
      
        '         (A_CASA3_MAIOR = :ArcMai3Oposto and A_CASA3_NAIPE = :Na' +
        'ipe3Oposto) )'
      '      )'
      '      or'
      
        '      ( (A_CASA1_MENOR = :ArcMen1Oposto and A_CASA2_MENOR = :Arc' +
        'Men2Oposto) or'
      
        '        (A_CASA1_MENOR = :ArcMen1Oposto and A_CASA3_MENOR = :Arc' +
        'Men3Oposto) or'
      
        '        (A_CASA2_MENOR = :ArcMen2Oposto and A_CASA3_MENOR = :Arc' +
        'Men3Oposto)'
      '      )'
      '      or'
      
        '      ( (A_CASA1_MAIOR = :ArcMai1Oposto and A_CASA1_MENOR = :Arc' +
        'Men1Oposto) or'
      
        '        (A_CASA1_MAIOR = :ArcMai1Oposto and A_CASA1_NAIPE = :Nai' +
        'pe1Oposto)  or'
      
        '        (A_CASA1_MAIOR = :ArcMai1Oposto and A_CASA1_MENOR = :Arc' +
        'Men1Oposto and A_CASA1_NAIPE = :Naipe1Oposto)  or'
      
        '        (A_CASA3_MAIOR = :ArcMai3Oposto and A_CASA3_MENOR = :Arc' +
        'Men3Oposto) or'
      
        '        (A_CASA3_MAIOR = :ArcMai3Oposto and A_CASA3_NAIPE = :Nai' +
        'pe3Oposto)  or'
      
        '        (A_CASA3_MAIOR = :ArcMai3Oposto and A_CASA3_MENOR = :Arc' +
        'Men3Oposto and A_CASA3_NAIPE = :Naipe3Oposto)  or'
      
        '        (A_CASA1_MENOR = :ArcMen1Oposto and A_CASA3_MENOR = :Arc' +
        'Men3Oposto) or'
      
        '        (A_CASA1_MENOR = :ArcMen1Oposto and A_CASA3_MAIOR = :Arc' +
        'Mai3Oposto) or'
      
        '        (A_CASA1_MAIOR = :ArcMai1Oposto and A_CASA3_MENOR = :Arc' +
        'Men3Oposto) or'
      
        '        (A_CASA1_MAIOR = :ArcMai1Oposto and A_CASA3_MAIOR = :Arc' +
        'Mai3Oposto)'
      '      )'
      '    )'
      '  )'
      'Order by VITORIA, Equipe')
    Left = 302
    Top = 358
    ParamData = <
      item
        Name = 'ARCMEN1FILTRO'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'NAIPE1FILTRO'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'ARCMEN2FILTRO'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'NAIPE2FILTRO'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'ARCMEN3FILTRO'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'NAIPE3FILTRO'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'ARCMAI1OPOSTO'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'ARCMEN1OPOSTO'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'ARCMAI2OPOSTO'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'ARCMEN2OPOSTO'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'ARCMAI3OPOSTO'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'ARCMEN3OPOSTO'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'NAIPE2OPOSTO'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'NAIPE1OPOSTO'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'NAIPE3OPOSTO'
        DataType = ftString
        ParamType = ptInput
      end>
  end
  object FDQHeader: TFDQuery
    Connection = DM.FDConnection1
    SQL.Strings = (
      'select Vitoria, '#39' '#39' as Equipe,'
      '       a1MA.Descricao as A1MAIOR, a1ME.Descricao as A1MENOR,'
      '       a2MA.Descricao as A2MAIOR, a2ME.Descricao as A2MENOR,'
      '       a3MA.Descricao as A3MAIOR, a3ME.Descricao as A3MENOR,'
      '       b1MA.Descricao as B1MAIOR, b1ME.Descricao as B1MENOR,'
      '       b2MA.Descricao as B2MAIOR, b2ME.Descricao as B2MENOR,'
      '       b3MA.Descricao as B3MAIOR, b3ME.Descricao as B3MENOR'
      'from LOTECA'
      
        '            join ARCANOS_MAIORES a1MA on(a1MA.Codigo = A_CASA1_M' +
        'AIOR)'
      
        '            join ARCANOS_MENORES a1ME on(a1ME.Numero = A_CASA1_M' +
        'ENOR and a1ME.Naipe = A_CASA1_NAIPE)'
      
        '            join ARCANOS_MAIORES a2MA on(a2MA.Codigo = A_CASA2_M' +
        'AIOR)'
      
        '            join ARCANOS_MENORES a2ME on(a2ME.Numero = A_CASA2_M' +
        'ENOR and a2ME.Naipe = A_CASA2_NAIPE)'
      
        '            join ARCANOS_MAIORES a3MA on(a3MA.Codigo = A_CASA3_M' +
        'AIOR)'
      
        '            join ARCANOS_MENORES a3ME on(a3ME.Numero = A_CASA3_M' +
        'ENOR and a3ME.Naipe = A_CASA3_NAIPE)'
      
        '            join ARCANOS_MAIORES b1MA on(b1MA.Codigo = B_CASA1_M' +
        'AIOR)'
      
        '            join ARCANOS_MAIORES b2MA on(b2MA.Codigo = B_CASA2_M' +
        'AIOR)'
      
        '            join ARCANOS_MAIORES b3MA on(b3MA.Codigo = B_CASA3_M' +
        'AIOR)'
      
        '            join ARCANOS_MENORES b1ME on(b1ME.Numero = B_CASA1_M' +
        'ENOR and b1ME.Naipe = B_CASA1_NAIPE)'
      
        '            join ARCANOS_MENORES b2ME on(b2ME.Numero = B_CASA2_M' +
        'ENOR and b2ME.Naipe = B_CASA2_NAIPE)'
      
        '            join ARCANOS_MENORES b3ME on(b3ME.Numero = B_CASA3_M' +
        'ENOR and b3ME.Naipe = B_CASA3_NAIPE)'
      'WHERE Id = :liId'
      '')
    Left = 304
    Top = 228
    ParamData = <
      item
        Name = 'LIID'
        DataType = ftLargeint
        ParamType = ptInput
      end>
  end
end
