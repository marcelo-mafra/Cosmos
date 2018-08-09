object FrmEditarTarefasStaff: TFrmEditarTarefasStaff
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Tarefas'
  ClientHeight = 157
  ClientWidth = 423
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
  object Bevel1: TBevel
    Left = 8
    Top = 109
    Width = 412
    Height = 10
    Shape = bsBottomLine
  end
  object Label1: TLabel
    Left = 8
    Top = 64
    Width = 32
    Height = 13
    Caption = 'Tarefa'
  end
  object EdtArea: TLabeledEdit
    Left = 8
    Top = 32
    Width = 407
    Height = 21
    CharCase = ecUpperCase
    Color = clBtnFace
    EditLabel.Width = 65
    EditLabel.Height = 13
    EditLabel.Caption = #193'rea de Staff'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
  end
  object Button1: TButton
    Left = 170
    Top = 128
    Width = 75
    Height = 25
    Action = ActNova
    TabOrder = 1
  end
  object Button2: TButton
    Left = 256
    Top = 128
    Width = 75
    Height = 25
    Action = ActPost
    TabOrder = 2
  end
  object Button3: TButton
    Left = 345
    Top = 128
    Width = 75
    Height = 25
    Action = ActClose
    TabOrder = 3
  end
  object DBEdit1: TDBEdit
    Left = 8
    Top = 80
    Width = 410
    Height = 21
    DataField = 'DESTAR'
    DataSource = DsrTarefasArea
    TabOrder = 4
  end
  object ActionList1: TActionList
    Left = 344
    Top = 16
    object ActNova: TAction
      Caption = 'Nova'
      Hint = 'Nova|Insere uma nova tarefa'
      OnExecute = ActNovaExecute
    end
    object ActPost: TAction
      Caption = 'Salvar'
      Hint = 'Salvar|Salva os dados da tarefa'
      OnExecute = ActPostExecute
      OnUpdate = ActPostUpdate
    end
    object ActClose: TAction
      Caption = 'Fechar'
      Hint = 'Fechar|Fecha a janela de edi'#231#227'o de tarefas'
      OnExecute = ActCloseExecute
    end
  end
  object CdsTarefasArea: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'codare'
        ParamType = ptInput
        Value = 0
      end>
    ProviderName = 'DspTarefasArea'
    AfterInsert = CdsTarefasAreaAfterInsert
    BeforePost = CdsTarefasAreaBeforePost
    AfterPost = CdsTarefasAreaAfterPost
    OnReconcileError = CdsTarefasAreaReconcileError
    Left = 152
    Top = 8
  end
  object DsrTarefasArea: TDataSource
    DataSet = CdsTarefasArea
    Left = 232
    Top = 8
  end
end
