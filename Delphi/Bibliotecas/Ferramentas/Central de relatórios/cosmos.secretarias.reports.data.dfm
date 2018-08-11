object DMSecData: TDMSecData
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 733
  Width = 682
  object CdsListaAlunos: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 56
    Top = 16
  end
  object CdsEnderecosAlunos: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'CODEND'
        DataType = ftInteger
      end
      item
        Name = 'CODCAD'
        DataType = ftInteger
      end
      item
        Name = 'CODLOG'
        DataType = ftInteger
      end
      item
        Name = 'NOMLOG'
        DataType = ftString
        Size = 70
      end
      item
        Name = 'NUMEND'
        DataType = ftInteger
      end
      item
        Name = 'COMEND'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'CEPLOG'
        Attributes = [faFixed]
        DataType = ftString
        Size = 9
      end
      item
        Name = 'CODBAI'
        DataType = ftInteger
      end
      item
        Name = 'NOMBAI'
        DataType = ftString
        Size = 70
      end
      item
        Name = 'CODCID'
        DataType = ftInteger
      end
      item
        Name = 'NOMCID'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'NOMEST'
        DataType = ftString
        Size = 35
      end
      item
        Name = 'SIGEST'
        Attributes = [faFixed]
        DataType = ftString
        Size = 2
      end
      item
        Name = 'CODPAI'
        DataType = ftInteger
      end
      item
        Name = 'NOMPAI'
        DataType = ftString
        Size = 35
      end
      item
        Name = 'INDCOR'
        Attributes = [faFixed]
        DataType = ftString
        Size = 1
      end
      item
        Name = 'TIPEND'
        Attributes = [faFixed]
        DataType = ftString
        Size = 1
      end
      item
        Name = 'DATCAD'
        DataType = ftTimeStamp
      end
      item
        Name = 'USURES'
        Attributes = [faFixed]
        DataType = ftString
        Size = 31
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 56
    Top = 64
  end
  object CdsContarCadastrados: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 56
    Top = 120
  end
  object CdsAtividades: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 56
    Top = 256
  end
  object CdsTempoDiscipulado: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 56
    Top = 304
  end
  object CdsAtividadesMes: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 56
    Top = 360
  end
  object CdsExternalReports: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 56
    Top = 416
  end
  object CdsResumoEstatisticoLEC: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 56
    Top = 480
  end
  object CdsMalaDireta: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 344
    Top = 464
  end
  object CdsCadastradosDisc: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 208
    Top = 16
  end
  object CdsDatasInstalacoes: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 208
    Top = 64
  end
  object CdsAlunosHistorico: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 208
    Top = 112
  end
  object CdsHistoricoDiscipular: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 208
    Top = 160
  end
  object CdsAtividadesCampo: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 208
    Top = 224
  end
  object CdsCatExternalReports: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'codmod'
        ParamType = ptInput
        Value = 0
      end>
    Left = 208
    Top = 344
  end
  object CdsSumarizaAtividades: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 208
    Top = 400
  end
  object CdsFichaCadastral: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 344
    Top = 16
  end
  object CdsMeiosContatos: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'CODTIPCON'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'DESTIPCON'
        Attributes = [faRequired]
        DataType = ftString
        Size = 70
      end
      item
        Name = 'DESCON'
        Attributes = [faRequired]
        DataType = ftString
        Size = 50
      end
      item
        Name = 'CODFOC'
        DataType = ftInteger
      end
      item
        Name = 'CODCON'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CODCAD'
        DataType = ftInteger
      end
      item
        Name = 'INDCAR'
        Attributes = [faRequired, faFixed]
        DataType = ftString
        Size = 1
      end
      item
        Name = 'DATCAD'
        Attributes = [faRequired]
        DataType = ftTimeStamp
      end
      item
        Name = 'USURES'
        Attributes = [faRequired, faFixed]
        DataType = ftString
        Size = 31
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 344
    Top = 64
  end
  object CdsMembrosCirculo: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 344
    Top = 240
  end
  object CdsCirculos: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 344
    Top = 192
  end
  object CdsMembrosCirculos: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 344
    Top = 304
  end
  object CdsContabilizarFrequencia: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 344
    Top = 352
  end
  object CdsConferencia: TClientDataSet
    Aggregates = <>
    CommandText = 
      'select codcon, nomcon, camcon, datini, datter from conferencias ' +
      'where codcon = :codcon'
    Params = <
      item
        DataType = ftInteger
        Name = 'codcon'
        ParamType = ptInput
        Value = 0
      end>
    Left = 344
    Top = 408
  end
  object CdsFuncoes: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 464
    Top = 16
  end
  object CdsListaFuncoes: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 464
    Top = 72
  end
  object CdsCadastradosFuncoes: TClientDataSet
    Aggregates = <
      item
        Visible = False
      end>
    Params = <>
    Left = 464
    Top = 128
  end
  object CdsCadastradosProfissoes: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 464
    Top = 248
  end
  object CdsDiscipulados: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 464
    Top = 360
  end
  object CdsJovensTM: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 464
    Top = 304
  end
  object CdsAniversariantes: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 464
    Top = 424
  end
  object CdsContarAlunosEI: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 344
    Top = 520
  end
  object CdsListaProfissoes: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 464
    Top = 192
  end
  object CdsTarefas: TClientDataSet
    PersistDataPacket.Data = {
      4D0100009619E0BD01000000180000000B0000000000030000004D0109546173
      6B496E64657801004900100001000557494454480200020026000B4465736372
      697074696F6E010049001000010005574944544802000200C800074372656174
      6F7201004900100001000557494454480200020064000A437265617465446174
      6501004900100001000557494454480200020013000A54617267657444617465
      080008001000000007456E644461746508000800100000000C436F736D6F7353
      797374656D010049001000010005574944544802000200460006537461747573
      0100490010000100055749445448020002000F000843617465676F7279010049
      0010000100055749445448020002009600085072696F72697479010049001000
      0100055749445448020002000F00054E6F74657304004B001000010007535542
      5459504502004900050054657874000000}
    Active = True
    Aggregates = <>
    Params = <>
    Left = 208
    Top = 592
  end
  object CdsContarAlunosEE: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 344
    Top = 576
  end
  object CdsResumoEstatisticoRas: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 56
    Top = 536
  end
  object CdsRegioesAdmin: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 56
    Top = 648
  end
  object CdsQuadroTotalizacaoTM: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 56
    Top = 592
  end
  object CdsAtividadesConferencia: TClientDataSet
    Aggregates = <>
    CommandText = 
      'select codati, destipati, datati, horati, codcon from viw_ativid' +
      'ades where codcon = :codcon and indfre = '#39'S'#39
    Params = <
      item
        DataType = ftInteger
        Name = 'codcon'
        ParamType = ptInput
        Value = 0
      end>
    Left = 208
    Top = 536
  end
  object CdsFolhasPresenca: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'icodati'
        ParamType = ptInput
        Value = 0
      end
      item
        DataType = ftString
        Name = 'iordem'
        ParamType = ptInput
        Size = 1
        Value = 'NOMCAD'
      end>
    ProviderName = 'DspFolhaPresenca'
    Left = 208
    Top = 472
  end
  object CdsFamiliares: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 344
    Top = 128
  end
  object CdsReportData: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 464
    Top = 480
  end
  object CdsFolhaPresencaMensal: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 464
    Top = 536
  end
  object DsrMasterSource: TDataSource
    Left = 608
    Top = 256
  end
  object CdsEscalasAtividades: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'CODATI'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CODCAD'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'NOMCAD'
        Attributes = [faRequired]
        DataType = ftString
        Size = 70
      end
      item
        Name = 'CODTIPATU'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'DESTIPATU'
        Attributes = [faRequired]
        DataType = ftString
        Size = 70
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 208
    Top = 272
  end
  object CdsListaGeralAlunos: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 56
    Top = 184
  end
end
