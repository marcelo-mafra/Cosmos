object FrmFTPOptions: TFrmFTPOptions
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Op'#231#245'es FTP'
  ClientHeight = 468
  ClientWidth = 413
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object MSGroupHeader1: TMSGroupHeader
    Left = 8
    Top = 8
    Width = 399
    Height = 110
    Transparent = True
    Caption = 'Servidor FTP'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    object Label1: TLabel
      Left = 0
      Top = 22
      Width = 68
      Height = 13
      Caption = '&IP do Servidor'
      FocusControl = EdtIPServer
    end
    object Label2: TLabel
      Left = 202
      Top = 22
      Width = 26
      Height = 13
      Caption = '&Porta'
      FocusControl = EdtServerPort
    end
    object Label3: TLabel
      Left = 295
      Top = 22
      Width = 61
      Height = 13
      Caption = '&Vers'#227'o do IP'
      FocusControl = CbxIpVersion
    end
    object Label14: TLabel
      Left = 0
      Top = 66
      Width = 109
      Height = 13
      Caption = 'IP do Servidor (bound)'
      FocusControl = EdtBoundIp
    end
    object Label15: TLabel
      Left = 202
      Top = 66
      Width = 67
      Height = 13
      Caption = 'Porta (bound)'
      FocusControl = EdtBoundPort
    end
    object EdtIPServer: TEdit
      Left = 0
      Top = 37
      Width = 187
      Height = 21
      TabOrder = 0
      OnKeyPress = EdtServerPortKeyPress
    end
    object EdtServerPort: TEdit
      Left = 202
      Top = 37
      Width = 81
      Height = 21
      TabOrder = 1
      OnKeyPress = EdtServerPortKeyPress
    end
    object CbxIpVersion: TComboBox
      Left = 295
      Top = 37
      Width = 97
      Height = 22
      Style = csOwnerDrawFixed
      ItemIndex = 0
      TabOrder = 2
      Text = 'IPv4'
      Items.Strings = (
        'IPv4'
        'IPv6')
    end
    object EdtBoundIp: TEdit
      Left = 0
      Top = 81
      Width = 187
      Height = 21
      TabOrder = 3
    end
    object EdtBoundPort: TEdit
      Left = 202
      Top = 81
      Width = 81
      Height = 21
      TabOrder = 4
      OnKeyPress = EdtServerPortKeyPress
    end
  end
  object MSGroupHeader2: TMSGroupHeader
    Left = 8
    Top = 320
    Width = 399
    Height = 105
    Transparent = True
    Caption = 'Seguran'#231'a'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    object Label4: TLabel
      Left = 0
      Top = 22
      Width = 36
      Height = 13
      Caption = '&Usu'#225'rio'
      FocusControl = EdtUserName
    end
    object Label5: TLabel
      Left = 248
      Top = 22
      Width = 30
      Height = 13
      Caption = '&Senha'
      FocusControl = EdtPassword
    end
    object Label9: TLabel
      Left = 0
      Top = 64
      Width = 75
      Height = 13
      Caption = 'Usu'#225'rio (proxy)'
      FocusControl = EdtProxyUserName
    end
    object Label10: TLabel
      Left = 248
      Top = 64
      Width = 69
      Height = 13
      Caption = 'Senha (proxy)'
      FocusControl = EdtProxyPassword
    end
    object EdtUserName: TEdit
      Left = 0
      Top = 37
      Width = 209
      Height = 21
      TabOrder = 0
    end
    object EdtPassword: TEdit
      Left = 248
      Top = 37
      Width = 137
      Height = 21
      PasswordChar = '*'
      TabOrder = 1
    end
    object EdtProxyUserName: TEdit
      Left = 0
      Top = 79
      Width = 209
      Height = 21
      TabOrder = 2
    end
    object EdtProxyPassword: TEdit
      Left = 248
      Top = 79
      Width = 137
      Height = 21
      PasswordChar = '*'
      TabOrder = 3
    end
  end
  object Button1: TButton
    Left = 151
    Top = 439
    Width = 75
    Height = 25
    Caption = '&OK'
    ModalResult = 1
    TabOrder = 2
  end
  object Button2: TButton
    Left = 241
    Top = 439
    Width = 75
    Height = 25
    Caption = '&Cancelar'
    ModalResult = 2
    TabOrder = 5
  end
  object MSGroupHeader3: TMSGroupHeader
    Left = 6
    Top = 124
    Width = 399
    Height = 98
    Transparent = True
    Caption = 'Proxy'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    object Label11: TLabel
      Left = 0
      Top = 20
      Width = 68
      Height = 13
      Caption = '&IP do Servidor'
      FocusControl = EdtProxyHost
    end
    object Label12: TLabel
      Left = 208
      Top = 20
      Width = 26
      Height = 13
      Caption = '&Porta'
      FocusControl = EdtProxyPort
    end
    object Label8: TLabel
      Left = 0
      Top = 62
      Width = 109
      Height = 13
      Caption = '&IP do Servidor externo'
      FocusControl = EdtExternalHost
    end
    object EdtProxyHost: TEdit
      Left = 0
      Top = 35
      Width = 187
      Height = 21
      TabOrder = 0
    end
    object EdtProxyPort: TEdit
      Left = 208
      Top = 35
      Width = 81
      Height = 21
      TabOrder = 1
      OnKeyPress = EdtServerPortKeyPress
    end
    object EdtExternalHost: TEdit
      Left = 0
      Top = 77
      Width = 187
      Height = 21
      TabOrder = 2
    end
  end
  object MSGroupHeader4: TMSGroupHeader
    Left = 8
    Top = 239
    Width = 399
    Height = 61
    Transparent = True
    Caption = 'Timeout'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    object Label6: TLabel
      Left = 0
      Top = 22
      Width = 43
      Height = 13
      Caption = '&Conex'#227'o'
      FocusControl = EdtConnectTimeout
    end
    object Label7: TLabel
      Left = 148
      Top = 22
      Width = 33
      Height = 13
      Caption = '&Leitura'
      FocusControl = EdtReadTimeout
    end
    object Label13: TLabel
      Left = 273
      Top = 22
      Width = 66
      Height = 13
      Caption = '&Transfer'#234'ncia'
      FocusControl = EdtTransferTimeout
    end
    object EdtConnectTimeout: TEdit
      Left = 0
      Top = 37
      Width = 113
      Height = 21
      TabOrder = 0
      OnKeyPress = EdtServerPortKeyPress
    end
    object EdtReadTimeout: TEdit
      Left = 148
      Top = 37
      Width = 97
      Height = 21
      TabOrder = 1
      OnKeyPress = EdtServerPortKeyPress
    end
    object EdtTransferTimeout: TEdit
      Left = 273
      Top = 37
      Width = 97
      Height = 21
      TabOrder = 2
      OnKeyPress = EdtServerPortKeyPress
    end
  end
  object Button3: TButton
    Left = 330
    Top = 439
    Width = 75
    Height = 25
    Caption = '&Ajuda'
    TabOrder = 6
  end
end
