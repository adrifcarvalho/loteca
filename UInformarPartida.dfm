object FInformarPartida: TFInformarPartida
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Informe os times da partida'
  ClientHeight = 454
  ClientWidth = 839
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = [fsBold]
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object LabelA1: TLabel
    Left = 371
    Top = 92
    Width = 94
    Height = 16
    Caption = 'DATA DO JOGO'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LabelB1: TLabel
    Left = 93
    Top = 630
    Width = 288
    Height = 20
    Caption = 'Selecione a partida a ser analisada:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LabelB2: TLabel
    Left = 93
    Top = 656
    Width = 40
    Height = 20
    Caption = 'Data'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LabelB3: TLabel
    Left = 194
    Top = 656
    Width = 40
    Height = 20
    Caption = 'Jogo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object btnOk: TBitBtn
    Left = 447
    Top = 25
    Width = 120
    Height = 43
    Caption = 'OK'
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    ModalResult = 1
    NumGlyphs = 2
    TabOrder = 4
    OnClick = btnOkClick
  end
  object btnCancelar: TBitBtn
    Left = 591
    Top = 25
    Width = 120
    Height = 43
    Caption = 'Cancelar'
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 5
  end
  object RadioGroupSelection: TRadioGroup
    Left = 129
    Top = 8
    Width = 299
    Height = 69
    Caption = 'Selecione o tipo de jogo:'
    Columns = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    Items.Strings = (
      'A. Novo jogo'
      'B. Jogo existente')
    ParentFont = False
    TabOrder = 0
    OnClick = RadioGroupSelectionClick
  end
  object mkDataJogo: TMaskEdit
    Left = 93
    Top = 676
    Width = 95
    Height = 24
    EditMask = '!99/99/9999;1;_'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    MaxLength = 10
    ParentFont = False
    TabOrder = 2
    Text = '  /  /    '
    OnChange = mkDataJogoChange
    OnEnter = ComponentEnter
    OnExit = ComponentExit
  end
  object ComboBoxPartidas: TComboBox
    Left = 194
    Top = 676
    Width = 551
    Height = 24
    Style = csDropDownList
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
  end
  object mkNovoJogo: TMaskEdit
    Left = 373
    Top = 114
    Width = 95
    Height = 24
    EditMask = '!99/99/9999;1;_'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    MaxLength = 10
    ParentFont = False
    TabOrder = 1
    Text = '  /  /    '
    OnEnter = mkNovoJogoEnter
    OnExit = ComponentExit
  end
  object GroupBoxTimeA: TGroupBox
    Left = 16
    Top = 148
    Width = 815
    Height = 143
    Caption = 'Time A'
    TabOrder = 6
    object Shape1: TShape
      Left = 672
      Top = 15
      Width = 129
      Height = 123
    end
    object ImageTimeA: TImage
      Left = 684
      Top = 24
      Width = 105
      Height = 108
      Stretch = True
      Transparent = True
    end
    object SpeedButtonTimeA: TSpeedButton
      Left = 588
      Top = 21
      Width = 34
      Height = 35
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333333333333333333FFF333333333333000333333333
        3333777FFF3FFFFF33330B000300000333337F777F777773F333000E00BFBFB0
        3333777F773333F7F333000E0BFBF0003333777F7F3337773F33000E0FBFBFBF
        0333777F7F3333FF7FFF000E0BFBF0000003777F7F3337777773000E0FBFBFBF
        BFB0777F7F33FFFFFFF7000E0BF000000003777F7FF777777773000000BFB033
        33337777773FF733333333333300033333333333337773333333333333333333
        3333333333333333333333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333}
      NumGlyphs = 2
      OnClick = SpeedButtonTimeAClick
    end
    object SpeedButtonImgA: TSpeedButton
      Left = 628
      Top = 21
      Width = 34
      Height = 35
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333FFFFFFFFFFFFF33000077777770033377777777777773F000007888888
        00037F3337F3FF37F37F00000780088800037F3337F77F37F37F000007800888
        00037F3337F77FF7F37F00000788888800037F3337777777337F000000000000
        00037F3FFFFFFFFFFF7F00000000000000037F77777777777F7F000FFFFFFFFF
        00037F7F333333337F7F000FFFFFFFFF00037F7F333333337F7F000FFFFFFFFF
        00037F7F333333337F7F000FFFFFFFFF00037F7F333333337F7F000FFFFFFFFF
        00037F7F333333337F7F000FFFFFFFFF07037F7F33333333777F000FFFFFFFFF
        0003737FFFFFFFFF7F7330099999999900333777777777777733}
      NumGlyphs = 2
      OnClick = SpeedButtonImgAClick
    end
    object edTimeA: TEdit
      Left = 13
      Top = 26
      Width = 569
      Height = 24
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnEnter = ComponentEnter
      OnExit = ComponentExit
    end
  end
  object GroupBoxTimeB: TGroupBox
    Left = 14
    Top = 297
    Width = 815
    Height = 142
    Caption = 'Time B'
    TabOrder = 7
    object Shape2: TShape
      Left = 668
      Top = 16
      Width = 129
      Height = 123
    end
    object ImageTimeB: TImage
      Left = 680
      Top = 26
      Width = 105
      Height = 106
      Stretch = True
      Transparent = True
    end
    object SpeedButtonTimeB: TSpeedButton
      Left = 588
      Top = 21
      Width = 34
      Height = 35
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333333333333333333FFF333333333333000333333333
        3333777FFF3FFFFF33330B000300000333337F777F777773F333000E00BFBFB0
        3333777F773333F7F333000E0BFBF0003333777F7F3337773F33000E0FBFBFBF
        0333777F7F3333FF7FFF000E0BFBF0000003777F7F3337777773000E0FBFBFBF
        BFB0777F7F33FFFFFFF7000E0BF000000003777F7FF777777773000000BFB033
        33337777773FF733333333333300033333333333337773333333333333333333
        3333333333333333333333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333}
      NumGlyphs = 2
      OnClick = SpeedButtonTimeBClick
    end
    object SpeedButtonImgB: TSpeedButton
      Left = 628
      Top = 21
      Width = 34
      Height = 35
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333FFFFFFFFFFFFF33000077777770033377777777777773F000007888888
        00037F3337F3FF37F37F00000780088800037F3337F77F37F37F000007800888
        00037F3337F77FF7F37F00000788888800037F3337777777337F000000000000
        00037F3FFFFFFFFFFF7F00000000000000037F77777777777F7F000FFFFFFFFF
        00037F7F333333337F7F000FFFFFFFFF00037F7F333333337F7F000FFFFFFFFF
        00037F7F333333337F7F000FFFFFFFFF00037F7F333333337F7F000FFFFFFFFF
        00037F7F333333337F7F000FFFFFFFFF07037F7F33333333777F000FFFFFFFFF
        0003737FFFFFFFFF7F7330099999999900333777777777777733}
      NumGlyphs = 2
      OnClick = SpeedButtonImgBClick
    end
    object edTimeB: TEdit
      Left = 12
      Top = 26
      Width = 570
      Height = 24
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnEnter = ComponentEnter
      OnExit = ComponentExit
    end
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Left = 40
    Top = 14
  end
end
