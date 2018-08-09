object DMSecReports: TDMSecReports
  OldCreateOrder = False
  Height = 719
  Width = 822
  object FrFolhaPresenca: TfrxDBDataset
    UserName = 'FrFolhaPresenca'
    CloseDataSource = False
    OpenDataSource = False
    DataSet = DMSecData.CdsFolhasPresenca
    BCDToCurrency = False
    Left = 608
    Top = 256
  end
  object frxCarteirinhas: TfrxDBDataset
    UserName = 'Carteirinhas'
    CloseDataSource = False
    FieldAliases.Strings = (
      'CODCAD=CODCAD'
      'MATCAD=MATCAD'
      'NOMCAD=NOMCAD'
      'FOTCAD=FOTCAD'
      'DOCIDE=DOCIDE'
      'ORGEXP=ORGEXP'
      'NOMFAM=NOMFAM'
      'PARFAR=PARFAR'
      'TELFAM=TELFAM'
      'DESCON=DESCON'
      'NOMLOG=NOMLOG'
      'NUMEND=NUMEND'
      'COMEND=COMEND'
      'NOMBAI=NOMBAI'
      'NOMCID=NOMCID'
      'NOMEST=NOMEST')
    OpenDataSource = False
    DataSet = DMSecData.CdsReportData
    BCDToCurrency = False
    Left = 104
    Top = 112
  end
  object frxFichaCadastral: TfrxDBDataset
    UserName = 'FichaCadastral'
    CloseDataSource = False
    OpenDataSource = False
    DataSet = DMSecData.CdsFichaCadastral
    BCDToCurrency = True
    Left = 600
    Top = 24
  end
  object FrFolhaPresencaMensal: TfrxDBDataset
    UserName = 'FrFolhaPresencaMensal'
    CloseDataSource = False
    OpenDataSource = False
    DataSet = DMSecData.CdsFolhaPresencaMensal
    BCDToCurrency = False
    Left = 680
    Top = 256
  end
  object frxEnderecoAluno: TfrxDBDataset
    UserName = 'EnderecoAluno'
    CloseDataSource = False
    FieldAliases.Strings = (
      'CODEND=CODEND'
      'CODCAD=CODCAD'
      'CODLOG=CODLOG'
      'NOMLOG=NOMLOG'
      'NUMEND=NUMEND'
      'COMEND=COMEND'
      'CEPLOG=CEPLOG'
      'CODBAI=CODBAI'
      'NOMBAI=NOMBAI'
      'CODCID=CODCID'
      'NOMCID=NOMCID'
      'NOMEST=NOMEST'
      'SIGEST=SIGEST'
      'CODPAI=CODPAI'
      'NOMPAI=NOMPAI'
      'INDCOR=INDCOR'
      'TIPEND=TIPEND'
      'DATCAD=DATCAD'
      'USURES=USURES')
    OpenDataSource = False
    DataSet = DMSecData.CdsEnderecosAlunos
    BCDToCurrency = False
    Left = 600
    Top = 80
  end
  object frxMeiosContatosAluno: TfrxDBDataset
    UserName = 'MeiosContatosAlunos'
    CloseDataSource = False
    OpenDataSource = False
    DataSet = DMSecData.CdsMeiosContatos
    BCDToCurrency = False
    Left = 688
    Top = 24
  end
  object frxHistoricoDiscipular: TfrxDBDataset
    UserName = 'HistoricoDiscipular'
    CloseDataSource = False
    OpenDataSource = False
    DataSet = DMSecData.CdsHistoricoDiscipular
    BCDToCurrency = False
    Left = 688
    Top = 80
  end
  object frxFuncoes: TfrxDBDataset
    UserName = 'Funcoes'
    CloseDataSource = False
    OpenDataSource = False
    DataSet = DMSecData.CdsFuncoes
    BCDToCurrency = False
    Left = 464
    Top = 16
  end
  object frxFamiliares: TfrxDBDataset
    UserName = 'Familiares'
    CloseDataSource = False
    FieldAliases.Strings = (
      'CODCAD=CODCAD'
      'NOMFAM=NOMFAM'
      'PARFAM=PARFAM'
      'TELFAM=TELFAM'
      'INDFAM=INDFAM')
    OpenDataSource = False
    DataSet = DMSecData.CdsFamiliares
    BCDToCurrency = False
    Left = 688
    Top = 136
  end
  object frxDBListaAlunos: TfrxDBDataset
    UserName = 'frxDBListaAlunos'
    CloseDataSource = False
    DataSet = DMSecData.CdsListaAlunos
    BCDToCurrency = False
    Left = 104
    Top = 16
  end
  object frxDBEnderecosAlunos: TfrxDBDataset
    UserName = 'frxDBEnderecosAlunos'
    CloseDataSource = False
    DataSet = DMSecData.CdsEnderecosAlunos
    BCDToCurrency = False
    Left = 104
    Top = 64
  end
  object frxDBContarCadastrados: TfrxDBDataset
    UserName = 'frxDBContarCadastrados'
    CloseDataSource = False
    FieldAliases.Strings = (
      'CODCAD=CODCAD'
      'MATCAD=MATCAD'
      'NOMCAD=NOMCAD'
      'FOTCAD=FOTCAD'
      'DOCIDE=DOCIDE'
      'ORGEXP=ORGEXP'
      'NOMFAM=NOMFAM'
      'PARFAR=PARFAR'
      'TELFAM=TELFAM'
      'DESCON=DESCON'
      'NOMLOG=NOMLOG'
      'NUMEND=NUMEND'
      'COMEND=COMEND'
      'NOMBAI=NOMBAI'
      'NOMCID=NOMCID'
      'NOMEST=NOMEST')
    OpenDataSource = False
    DataSet = DMSecData.CdsContarCadastrados
    BCDToCurrency = False
    Left = 104
    Top = 160
  end
  object frxDBAtividades: TfrxDBDataset
    UserName = 'frxDBAtividades'
    CloseDataSource = False
    FieldAliases.Strings = (
      'CODCAD=CODCAD'
      'MATCAD=MATCAD'
      'NOMCAD=NOMCAD'
      'FOTCAD=FOTCAD'
      'DOCIDE=DOCIDE'
      'ORGEXP=ORGEXP'
      'NOMFAM=NOMFAM'
      'PARFAR=PARFAR'
      'TELFAM=TELFAM'
      'DESCON=DESCON'
      'NOMLOG=NOMLOG'
      'NUMEND=NUMEND'
      'COMEND=COMEND'
      'NOMBAI=NOMBAI'
      'NOMCID=NOMCID'
      'NOMEST=NOMEST')
    OpenDataSource = False
    DataSet = DMSecData.CdsAtividades
    BCDToCurrency = False
    Left = 104
    Top = 224
  end
  object frxDBTempoDiscipulado: TfrxDBDataset
    UserName = 'frxDBTempoDiscipulado'
    CloseDataSource = False
    FieldAliases.Strings = (
      'CODCAD=CODCAD'
      'MATCADINT=MATCADINT'
      'MATCAD=MATCAD'
      'NOMCAD=NOMCAD'
      'SIGDIS=SIGDIS'
      'SIGFOC=SIGFOC'
      'DATHIS=DATHIS'
      'ANOS=ANOS'
      'MESES=MESES'
      'INDINS=INDINS')
    OpenDataSource = False
    DataSet = DMSecData.CdsTempoDiscipulado
    BCDToCurrency = False
    Left = 104
    Top = 280
  end
  object frxDBRegioesAdmin: TfrxDBDataset
    UserName = 'frxDBRegioesAdmin'
    CloseDataSource = False
    FieldAliases.Strings = (
      'CODCAD=CODCAD'
      'MATCAD=MATCAD'
      'NOMCAD=NOMCAD'
      'FOTCAD=FOTCAD'
      'DOCIDE=DOCIDE'
      'ORGEXP=ORGEXP'
      'NOMFAM=NOMFAM'
      'PARFAR=PARFAR'
      'TELFAM=TELFAM'
      'DESCON=DESCON'
      'NOMLOG=NOMLOG'
      'NUMEND=NUMEND'
      'COMEND=COMEND'
      'NOMBAI=NOMBAI'
      'NOMCID=NOMCID'
      'NOMEST=NOMEST')
    OpenDataSource = False
    DataSet = DMSecData.CdsRegioesAdmin
    BCDToCurrency = False
    Left = 104
    Top = 336
  end
  object frxDBResumoEstatisticoRas: TfrxDBDataset
    UserName = 'frxDBResumoEstatisticoRas'
    CloseDataSource = False
    FieldAliases.Strings = (
      'CODREG=CODREG'
      'NOMREG=NOMREG'
      'CODPAI=CODPAI'
      'NUM1AS=NUM1AS'
      'NUM1AS_EN=NUM1AS_EN'
      'TOTAL1AS=TOTAL1AS'
      'NUM2AS=NUM2AS'
      'NUM2AS_EN=NUM2AS_EN'
      'TOTAL2AS=TOTAL2AS'
      'TOTAL_EE=TOTAL_EE'
      'TOTAL_EE_EN=TOTAL_EE_EN'
      'TOTALGERAL_EE=TOTALGERAL_EE'
      'NUMECS=NUMECS'
      'NUMECS_EN=NUMECS_EN'
      'TOTALECS=TOTALECS'
      'NUMEKK=NUMEKK'
      'NUMEKK_EN=NUMEKK_EN'
      'TOTALEKK=TOTALEKK'
      'NUMGRA=NUMGRA'
      'NUMGRA_EN=NUMGRA_EN'
      'TOTALGRA=TOTALGRA'
      'NUM5AS=NUM5AS'
      'NUM5AS_EN=NUM5AS_EN'
      'TOTAL5AS=TOTAL5AS'
      'NUM6AS=NUM6AS'
      'NUM6AS_EN=NUM6AS_EN'
      'TOTAL6AS=TOTAL6AS'
      'NUMJOV=NUMJOV'
      'NUMJOV_EN=NUMJOV_EN'
      'TOTALJOV=TOTALJOV'
      'NUMSIM=NUMSIM'
      'NUMSIM_EN=NUMSIM_EN'
      'TOTALSIM=TOTALSIM'
      'TOTAL_EI=TOTAL_EI'
      'TOTAL_EI_EN=TOTAL_EI_EN'
      'TOTALGERAL_EI=TOTALGERAL_EI'
      'TOTAL=TOTAL'
      'TOTAL_EN=TOTAL_EN'
      'TOTALGERAL=TOTALGERAL')
    OpenDataSource = False
    DataSet = DMSecData.CdsResumoEstatisticoRas
    BCDToCurrency = False
    Left = 104
    Top = 384
  end
  object frxDBQuadroTotalizacaoRaTM: TfrxDBDataset
    UserName = 'frxDBQuadroTotalizacaoRaTM'
    CloseDataSource = False
    FieldAliases.Strings = (
      'CODCAD=CODCAD'
      'MATCAD=MATCAD'
      'NOMCAD=NOMCAD'
      'FOTCAD=FOTCAD'
      'DOCIDE=DOCIDE'
      'ORGEXP=ORGEXP'
      'NOMFAM=NOMFAM'
      'PARFAR=PARFAR'
      'TELFAM=TELFAM'
      'DESCON=DESCON'
      'NOMLOG=NOMLOG'
      'NUMEND=NUMEND'
      'COMEND=COMEND'
      'NOMBAI=NOMBAI'
      'NOMCID=NOMCID'
      'NOMEST=NOMEST')
    OpenDataSource = False
    DataSet = DMSecData.CdsQuadroTotalizacaoTM
    BCDToCurrency = False
    Left = 104
    Top = 440
  end
  object frxDBResumoEstatisticoLEC: TfrxDBDataset
    UserName = 'frxDBResumoEstatisticoLEC'
    CloseDataSource = False
    FieldAliases.Strings = (
      'CODFOC=CODFOC'
      'CODREG=CODREG'
      'NOMFOC=NOMFOC'
      'SIGFOC=SIGFOC'
      'INDNAC=INDNAC'
      'NUM1AS=NUM1AS'
      'NUM1AS_EN=NUM1AS_EN'
      'TOTAL1AS=TOTAL1AS'
      'NUM2AS=NUM2AS'
      'NUM2AS_EN=NUM2AS_EN'
      'TOTAL2AS=TOTAL2AS'
      'TOTAL_EE=TOTAL_EE'
      'TOTAL_EE_EN=TOTAL_EE_EN'
      'TOTALGERAL_EE=TOTALGERAL_EE'
      'NUMECS=NUMECS'
      'NUMECS_EN=NUMECS_EN'
      'TOTALECS=TOTALECS'
      'NUMEKK=NUMEKK'
      'NUMEKK_EN=NUMEKK_EN'
      'TOTALEKK=TOTALEKK'
      'NUMGRA=NUMGRA'
      'NUMGRA_EN=NUMGRA_EN'
      'TOTALGRA=TOTALGRA'
      'NUM5AS=NUM5AS'
      'NUM5AS_EN=NUM5AS_EN'
      'TOTAL5AS=TOTAL5AS'
      'NUM6AS=NUM6AS'
      'NUM6AS_EN=NUM6AS_EN'
      'TOTAL6AS=TOTAL6AS'
      'NUMJOV=NUMJOV'
      'NUMJOV_EN=NUMJOV_EN'
      'TOTALJOV=TOTALJOV'
      'NUMSIM=NUMSIM'
      'NUMSIM_EN=NUMSIM_EN'
      'TOTALSIM=TOTALSIM'
      'TOTAL_EI=TOTAL_EI'
      'TOTAL_EI_EN=TOTAL_EI_EN'
      'TOTALGERAL_EI=TOTALGERAL_EI'
      'TOTAL=TOTAL'
      'TOTAL_EN=TOTAL_EN'
      'TOTALGERAL=TOTALGERAL')
    OpenDataSource = False
    DataSet = DMSecData.CdsResumoEstatisticoLEC
    BCDToCurrency = False
    Left = 104
    Top = 496
  end
  object frxDBDatasInstalacoes: TfrxDBDataset
    UserName = 'frxDBDatasInstalacoes'
    CloseDataSource = False
    DataSet = DMSecData.CdsDatasInstalacoes
    BCDToCurrency = False
    Left = 296
    Top = 64
  end
  object frxDBAlunosHistorico: TfrxDBDataset
    UserName = 'frxDBAlunosHistorico'
    CloseDataSource = False
    DataSet = DMSecData.CdsAlunosHistorico
    BCDToCurrency = False
    Left = 296
    Top = 112
  end
  object frxDBHistoricoDiscipular: TfrxDBDataset
    UserName = 'frxDBHistoricoDiscipular'
    CloseDataSource = False
    DataSet = DMSecData.CdsHistoricoDiscipular
    BCDToCurrency = False
    Left = 296
    Top = 160
  end
  object frxDBAtividadesCampo: TfrxDBDataset
    UserName = 'frxDBAtividadesCampo'
    CloseDataSource = False
    FieldAliases.Strings = (
      'CODATI=CODATI'
      'CODTIPATI=CODTIPATI'
      'DESTIPATI=DESTIPATI'
      'DATATI=DATATI'
      'HORATI=HORATI'
      'CODCON=CODCON'
      'NOMCON=NOMCON'
      'TIPLEV=TIPLEV'
      'INDFRE=INDFRE'
      'CODFOC=CODFOC'
      'SIGFOC=SIGFOC'
      'CAMPRO=CAMPRO'
      'CODGRU=CODGRU'
      'CODTUR=CODTUR'
      'NUMTEM=NUMTEM'
      'INDESCINT=INDESCINT')
    DataSet = DMSecData.CdsAtividadesCampo
    BCDToCurrency = False
    Left = 296
    Top = 208
  end
  object frxDBSumarizaAtividades: TfrxDBDataset
    UserName = 'frxDBSumarizaAtividades'
    CloseDataSource = False
    DataSet = DMSecData.CdsSumarizaAtividades
    BCDToCurrency = False
    Left = 104
    Top = 608
  end
  object frxDBMembrosCirculo: TfrxDBDataset
    UserName = 'MembrosCirculo'
    CloseDataSource = False
    DataSet = DMSecData.CdsMembrosCirculo
    BCDToCurrency = False
    Left = 296
    Top = 304
  end
  object frxDBCirculos: TfrxDBDataset
    UserName = 'frxDBCirculos'
    CloseDataSource = False
    DataSet = DMSecData.CdsCirculos
    BCDToCurrency = False
    Left = 296
    Top = 344
  end
  object frxDBContabilizarFrequencia: TfrxDBDataset
    UserName = 'frxDBContabilizarFrequencia'
    CloseDataSource = False
    DataSet = DMSecData.CdsContabilizarFrequencia
    BCDToCurrency = False
    Left = 296
    Top = 392
  end
  object frxDBContabilizarFrequenciaDisc: TfrxDBDataset
    UserName = 'frxDBContabilizarFrequenciaDisc'
    CloseDataSource = False
    DataSet = DMSecData.CdsContabilizarFrequencia
    BCDToCurrency = False
    Left = 296
    Top = 456
  end
  object frxDBMalaDireta: TfrxDBDataset
    UserName = 'frxDBMalaDireta'
    CloseDataSource = False
    FieldAliases.Strings = (
      'LINE1=LINE1'
      'LINE2=LINE2'
      'LINE3=LINE3'
      'LINE4=LINE4'
      'CODCAD=CODCAD'
      'CODFOC=CODFOC'
      'MATCAD=MATCAD'
      'MATCADINT=MATCADINT'
      'CODDIS=CODDIS'
      'CAMTRA=CAMTRA'
      'INDATI=INDATI')
    DataSet = DMSecData.CdsMalaDireta
    BCDToCurrency = False
    Left = 296
    Top = 512
  end
  object frxDBCadastradosDisc: TfrxDBDataset
    UserName = 'CadastradosDisc'
    CloseDataSource = False
    DataSet = DMSecData.CdsCadastradosDisc
    BCDToCurrency = False
    Left = 296
    Top = 16
  end
  object frxDBListaFuncoes: TfrxDBDataset
    UserName = 'frxDBListaFuncoes'
    CloseDataSource = False
    OpenDataSource = False
    DataSet = DMSecData.CdsListaFuncoes
    BCDToCurrency = False
    Left = 464
    Top = 80
  end
  object frxDBCadastradosFuncoes: TfrxDBDataset
    UserName = 'frxDBCadastradosFuncoes'
    CloseDataSource = False
    OpenDataSource = False
    DataSet = DMSecData.CdsCadastradosFuncoes
    BCDToCurrency = False
    Left = 464
    Top = 136
  end
  object frxDBCadastradosProfissoes: TfrxDBDataset
    UserName = 'frxDBCadastradosProfissoes'
    CloseDataSource = False
    OpenDataSource = False
    DataSet = DMSecData.CdsCadastradosProfissoes
    BCDToCurrency = False
    Left = 464
    Top = 256
  end
  object frxDBListaProfissoes: TfrxDBDataset
    UserName = 'frxDBListaProfissoes'
    CloseDataSource = False
    OpenDataSource = False
    DataSet = DMSecData.CdsListaProfissoes
    BCDToCurrency = False
    Left = 464
    Top = 200
  end
  object frxDBJovensTM: TfrxDBDataset
    UserName = 'frxDBJovensTM'
    CloseDataSource = False
    OpenDataSource = False
    DataSet = DMSecData.CdsJovensTM
    BCDToCurrency = False
    Left = 456
    Top = 320
  end
  object frxDBAniversariantes: TfrxDBDataset
    UserName = 'frxDBAniversariantes'
    CloseDataSource = False
    OpenDataSource = False
    DataSet = DMSecData.CdsAniversariantes
    BCDToCurrency = False
    Left = 456
    Top = 384
  end
  object frxDBConferencia: TfrxDBDataset
    UserName = 'frxDBConferencia'
    CloseDataSource = False
    OpenDataSource = False
    DataSet = DMSecData.CdsConferencia
    BCDToCurrency = False
    Left = 456
    Top = 448
  end
  object frxDBConferenciaAtividades: TfrxDBDataset
    UserName = 'frxDBConferenciaAtividades'
    CloseDataSource = False
    OpenDataSource = False
    DataSet = DMSecData.CdsAtividadesConferencia
    BCDToCurrency = False
    Left = 456
    Top = 504
  end
  object frxDBContarAlunosEE: TfrxDBDataset
    UserName = 'frxDBContarAlunosEE'
    CloseDataSource = False
    OpenDataSource = False
    DataSet = DMSecData.CdsContarAlunosEE
    BCDToCurrency = False
    Left = 608
    Top = 336
  end
  object frxDBContarAlunosEI: TfrxDBDataset
    UserName = 'frxDBContarAlunosEI'
    CloseDataSource = False
    OpenDataSource = False
    DataSet = DMSecData.CdsContarAlunosEI
    BCDToCurrency = False
    Left = 608
    Top = 384
  end
  object frxDBTotalAlunos: TfrxDBDataset
    UserName = 'frxDBTotalAlunos'
    CloseDataSource = False
    OpenDataSource = False
    DataSet = DMSecData.CdsReportData
    BCDToCurrency = False
    Left = 608
    Top = 440
  end
  object frxDBTarefas: TfrxDBDataset
    UserName = 'frxDBTarefas'
    CloseDataSource = False
    OpenDataSource = False
    DataSet = DMSecData.CdsTarefas
    BCDToCurrency = False
    Left = 464
    Top = 560
  end
  object frxDBEscalasAtividades: TfrxDBDataset
    UserName = 'frxDBEscalasAtividades'
    CloseDataSource = False
    FieldAliases.Strings = (
      'CODATI=CODATI'
      'CODCAD=CODCAD'
      'NOMCAD=NOMCAD'
      'CODTIPATU=CODTIPATU'
      'DESTIPATU=DESTIPATU')
    OpenDataSource = False
    DataSet = DMSecData.CdsEscalasAtividades
    BCDToCurrency = False
    Left = 296
    Top = 256
  end
  object frxDBListaGeralAlunos: TfrxDBDataset
    UserName = 'frxDBListaGeralAlunos'
    CloseDataSource = False
    DataSet = DMSecData.CdsListaGeralAlunos
    BCDToCurrency = False
    Left = 296
    Top = 576
  end
end
