unit cosmos.servers.conferencias.methods;

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes, Datasnap.DSServer, Datasnap.DSAuth,
  cosmos.classes.application, cosmos.system.messages, cosmos.system.exceptions,
  cosmos.servers.sqlcommands, System.Variants, cosmos.classes.dataobjects,
  cosmos.classes.ServerInterface, Data.DB, Data.DBXCommon, DBClient, Data.FMTBcd,
  Data.SqlExpr, Datasnap.Provider, DataSnap.DsSession, DataSnap.DSProviderDataModuleAdapter,
  cosmos.business.focos, cosmos.classes.logs, Data.DBXDBReaders, cosmos.classes.cmdFactories;

type
  {$METHODINFO OFF}


  {$METHODINFO ON}    
  TDMCosmosConferenciasMethods = class(TDSServerModule)
    SQLConferencia: TSQLDataSet;
    SQLConferenciaCODCON: TIntegerField;
    SQLConferenciaNOMCON: TStringField;
    SQLConferenciaNOMFOC: TStringField;
    SQLConferenciaCAMCON: TStringField;
    SQLConferenciaVALTAX: TFMTBCDField;
    SQLConferenciaLIMINS: TSmallintField;
    SQLConferenciaDATINI: TDateField;
    SQLConferenciaDATTER: TDateField;
    SQLConferenciaHORINI: TTimeField;
    SQLConferenciaHORTER: TTimeField;
    SQLConferenciaDATLIM: TDateField;
    SQLConferenciaINDESP: TStringField;
    SQLConferenciaSTACON: TStringField;
    SQLConferenciaINDMOD: TStringField;
    SQLConferenciaTIPLEV: TStringField;
    SQLConferenciaOBSCON: TMemoField;
    SQLConferenciaDATCAD: TSQLTimeStampField;
    SQLConferenciaUSURES: TStringField;
    DspConferencia: TDataSetProvider;
    SQLProgramacao: TSQLDataSet;
    SQLProgramacaoCODATI: TIntegerField;
    SQLProgramacaoDESTIPATI: TStringField;
    SQLProgramacaoDATATI: TDateField;
    SQLProgramacaoHORATI: TTimeField;
    SQLProgramacaoCODCON: TIntegerField;
    SQLProgramacaoINDFRE: TStringField;
    DspProgramacao: TDataSetProvider;
    DspPesquisaConferencias: TDataSetProvider;
    SQLPesquisaConferencias: TSQLDataSet;
    SQLPesquisaConferenciasCODCON: TIntegerField;
    SQLPesquisaConferenciasNOMCON: TStringField;
    SQLPesquisaConferenciasDATINI: TDateField;
    SQLPesquisaConferenciasDATTER: TDateField;
    SQLPesquisaConferenciasSIGFOC: TStringField;
    SQLPesquisaConferenciasCAMCON: TStringField;
    SQLPesquisaConferenciasSTACON: TStringField;
    SQLConferenciasDiscipulados: TSQLDataSet;
    SQLConferenciasDiscipuladosCODCON: TIntegerField;
    SQLConferenciasDiscipuladosCODDIS: TIntegerField;
    SQLConferenciasDiscipuladosNOMDIS: TStringField;
    DspConferenciasDiscipulados: TDataSetProvider;
    DspConferenciasFocos: TDataSetProvider;
    SQLConferenciasFocos: TSQLDataSet;
    SQLConferenciasFocosCODCON: TIntegerField;
    SQLConferenciasFocosCODFOC: TIntegerField;
    SQLConferenciasFocosNOMFOC: TStringField;
    SQLConferenciasDiscipuladosCODCONDIS: TLargeintField;
    SQLConferenciasFocosCODCONFOC: TLargeintField;
    DspAtividadeLEC: TDataSetProvider;
    SQLAtividadeLEC: TSQLDataSet;
    SQLAtividadeLECCODATI: TIntegerField;
    SQLAtividadeLECCODTIPATI: TIntegerField;
    SQLAtividadeLECDESTIPATI: TStringField;
    SQLAtividadeLECCAMPRO: TStringField;
    SQLAtividadeLECCODFOC: TIntegerField;
    SQLAtividadeLECDATATI: TDateField;
    SQLAtividadeLECHORATI: TTimeField;
    SQLAtividadeLECLOCATI: TStringField;
    SQLAtividadeLECCODCON: TIntegerField;
    SQLAtividadeLECNOMCON: TStringField;
    SQLAtividadeLECINDFRE: TStringField;
    SQLAtividadeLECCODALO: TIntegerField;
    SQLAtividadeLECTITALO: TStringField;
    SQLAtividadeLECINDJAL: TStringField;
    SQLAtividadeLECINDLIS: TStringField;
    SQLAtividadeLECOBSATI: TMemoField;
    SQLAtividadeLECUSURES: TStringField;
    SQLAtividadeLECDATCAD: TSQLTimeStampField;
    DspEscalas: TDataSetProvider;
    SQLEscalas: TSQLDataSet;
    SQLEscalasCODESC: TIntegerField;
    SQLEscalasCODATI: TIntegerField;
    SQLEscalasCODCAD: TIntegerField;
    SQLEscalasNOMCAD: TStringField;
    SQLEscalasCODTIPATU: TIntegerField;
    SQLEscalasDESTIPATU: TStringField;
    DspTiposAtividades: TDataSetProvider;
    SQLTiposAtividades: TSQLDataSet;
    SQLTiposAtividadesCODTIPATI: TIntegerField;
    SQLTiposAtividadesDESTIPATI: TStringField;
    SQLTiposAtividadesHORATI: TTimeField;
    SQLTiposAtividadesCAMPRO: TStringField;
    SQLTiposAtividadesINDFRE: TStringField;
    SQLTiposAtividadesINDESCINT: TStringField;
    SQLTiposAtividadesINDEST: TStringField;
    SQLTipoAtividade: TSQLDataSet;
    DspTipoAtividade: TDataSetProvider;
    SQLAlojamento: TSQLDataSet;
    DspAlojamento: TDataSetProvider;
    SQLAlojamentoCODALO: TIntegerField;
    SQLAlojamentoCODFOC: TIntegerField;
    SQLAlojamentoNOMFOC: TStringField;
    SQLAlojamentoNOMALO: TStringField;
    SQLAlojamentoINDEXT: TStringField;
    SQLAlojamentoLOTALO: TSmallintField;
    SQLAlojamentoENDALO: TStringField;
    SQLAlojamentoTELALO: TStringField;
    SQLClassificadores: TSQLDataSet;
    SQLClassificadoresCODATR: TIntegerField;
    SQLClassificadoresSIGATR: TStringField;
    SQLClassificadoresDESATRLEI: TStringField;
    SQLClassificadoresDESATRCAD: TStringField;
    DspClassificadores: TDataSetProvider;
    DspClassificador: TDataSetProvider;
    SQLClassificador: TSQLDataSet;
    IntegerField1: TIntegerField;
    StringField1: TStringField;
    StringField2: TStringField;
    StringField3: TStringField;
    SQLClassificadoresLeito: TSQLDataSet;
    SQLClassificadoresLeitoCODATRLEI: TIntegerField;
    SQLClassificadoresLeitoCODATR: TIntegerField;
    SQLClassificadoresLeitoSIGATR: TStringField;
    SQLClassificadoresLeitoDESATRLEI: TStringField;
    SQLClassificadoresLeitoCODLEI: TIntegerField;
    DspClassificadoresLeito: TDataSetProvider;
    DspAgenda: TDataSetProvider;
    SQLAgenda: TSQLDataSet;
    SQLAgendaCODATI: TIntegerField;
    SQLAgendaCODTIPATI: TIntegerField;
    SQLAgendaDESTIPATI: TStringField;
    SQLAgendaDATATI: TDateField;
    SQLAgendaHORATI: TTimeField;
    SQLAgendaCODCON: TIntegerField;
    SQLAgendaNOMCON: TStringField;
    SQLAgendaTIPLEV: TStringField;
    SQLAgendaINDFRE: TStringField;
    SQLAgendaCODFOC: TIntegerField;
    SQLAgendaSIGFOC: TStringField;
    SQLAgendaCAMPRO: TStringField;
    SQLAgendaCODGRU: TIntegerField;
    SQLAgendaINDESCINT: TStringField;
    SQLLeito: TSQLDataSet;
    DspLeito: TDataSetProvider;
    SQLLeitoCODLEI: TIntegerField;
    SQLLeitoCODQUA: TIntegerField;
    SQLLeitoNUMQUA: TSmallintField;
    SQLLeitoNUMLEI: TSmallintField;
    SQLLeitoCODCAD: TIntegerField;
    SQLLeitoNOMCAD: TStringField;
    SQLLeitoINDBLO: TStringField;
    SQLInscrto: TSQLDataSet;
    DspInscrito: TDataSetProvider;
    SQLInscrtoAPECAD: TStringField;
    SQLInscrtoCODCAD: TIntegerField;
    SQLInscrtoCODCON: TIntegerField;
    SQLInscrtoCODFOC: TIntegerField;
    SQLInscrtoCODINS: TIntegerField;
    SQLInscrtoCODLEI: TIntegerField;
    SQLInscrtoDATCHE: TDateField;
    SQLInscrtoDATINS: TSQLTimeStampField;
    SQLInscrtoDATSAI: TDateField;
    SQLInscrtoHORCHE: TTimeField;
    SQLInscrtoHORSAI: TTimeField;
    SQLInscrtoINDMON: TStringField;
    SQLInscrtoINDSUB: TStringField;
    SQLInscrtoMATCAD: TStringField;
    SQLInscrtoMODTRA: TSmallintField;
    SQLInscrtoNOMALO: TStringField;
    SQLInscrtoNOMCAD: TStringField;
    SQLInscrtoNUMINS: TIntegerField;
    SQLInscrtoNUMLEI: TSmallintField;
    SQLInscrtoNUMQUA: TSmallintField;
    SQLInscrtoSEXCAD: TStringField;
    SQLInscrtoSIGDIS: TStringField;
    SQLInscrtoSIGFOC: TStringField;
    SQLInscrtoUSURES: TStringField;
    SQLInscrtoFORINS: TSmallintField;
    SQLDetalhesInscricao: TSQLDataSet;
    DspDetalhesInscricao: TDataSetProvider;
    SQLDetalhesInscricaoCODDET: TIntegerField;
    SQLDetalhesInscricaoCODINS: TIntegerField;
    SQLDetalhesInscricaoCODITE: TIntegerField;
    SQLDetalhesInscricaoVALINF: TStringField;
    SQLDetalhesInscricaoCODFLA: TIntegerField;
    SQLDetalhesInscricaoDESFLA: TStringField;
    SQLClassificadoresCadastrados: TSQLDataSet;
    DspClassificadoresCadastrados: TDataSetProvider;
    SQLClassificadoresCadastradosCODATRCAD: TIntegerField;
    SQLClassificadoresCadastradosCODATR: TIntegerField;
    SQLClassificadoresCadastradosCODCAD: TIntegerField;
    SQLClassificadoresCadastradosSIGATR: TStringField;
    SQLClassificadoresCadastradosDESATRCAD: TStringField;
    SQLClassificadoresCadastradosCODFOC: TIntegerField;
    SQLTarefasArea: TSQLDataSet;
    SQLTarefasAreaCODTAR: TIntegerField;
    SQLTarefasAreaDESTAR: TStringField;
    SQLTarefasAreaCODARE: TIntegerField;
    DspTarefasArea: TDataSetProvider;
    SQLCadastrado: TSQLDataSet;
    SQLCadastradoCODCAD: TIntegerField;
    SQLCadastradoNOMCAD: TStringField;
    SQLCadastradoMATCAD: TStringField;
    SQLCadastradoSIGDIS: TStringField;
    SQLCadastradoSIGFOC: TStringField;
    SQLCadastradoVALMEN: TFMTBCDField;
    SQLCadastradoVALTAX: TFMTBCDField;
    SQLCadastradoFOTCAD: TGraphicField;
    DspCadastrado: TDataSetProvider;
    SQLRecebimentos: TSQLDataSet;
    SQLRecebimentosCODREC: TIntegerField;
    SQLRecebimentosMESREF: TSmallintField;
    SQLRecebimentosMES: TStringField;
    SQLRecebimentosANOREF: TSmallintField;
    SQLRecebimentosVALPRE: TFMTBCDField;
    SQLRecebimentosVALREC: TFMTBCDField;
    SQLRecebimentosCODTIPREC: TIntegerField;
    SQLRecebimentosDESTIPREC: TStringField;
    SQLRecebimentosCODCAD: TIntegerField;
    SQLRecebimentosDATREC: TSQLTimeStampField;
    SQLRecebimentosDATCAD: TSQLTimeStampField;
    SQLRecebimentosUSURES: TStringField;
    DspRecebimentos: TDataSetProvider;
    SQLTiposRecebimentos: TSQLDataSet;
    SQLTiposRecebimentosCODTIPREC: TIntegerField;
    SQLTiposRecebimentosDESTIPREC: TStringField;
    SQLTiposRecebimentosVERSION: TIntegerField;
    SQLTiposRecebimentosSYNC: TSmallintField;
    DspTiposRecebimentos: TDataSetProvider;
    SQLRecebimento: TSQLDataSet;
    IntegerField2: TIntegerField;
    SmallintField1: TSmallintField;
    SmallintField2: TSmallintField;
    FMTBCDField1: TFMTBCDField;
    FMTBCDField2: TFMTBCDField;
    IntegerField3: TIntegerField;
    StringField4: TStringField;
    IntegerField4: TIntegerField;
    StringField5: TStringField;
    SQLTimeStampField1: TSQLTimeStampField;
    SQLTimeStampField2: TSQLTimeStampField;
    StringField6: TStringField;
    DspRecebimento: TDataSetProvider;
    SQLCrachas: TSQLDataSet;
    DspCrachas: TDataSetProvider;
    SQLCrachasNOMCON: TStringField;
    SQLCrachasMATCAD: TStringField;
    SQLCrachasNOMCAD: TStringField;
    SQLCrachasSIGDIS: TStringField;
    SQLCrachasSIGFOC: TStringField;
    SQLCrachasNOMALO: TStringField;
    SQLCrachasNUMQUA: TSmallintField;
    SQLCrachasNUMLEI: TSmallintField;
    SQLCrachasindmon: TStringField;
    SQLCrachasindsub: TStringField;
    DspParticipantesTipoAtividade: TDataSetProvider;
    SQLParticipantesTipoAtividade: TSQLDataSet;
    SQLParticipantesTipoAtividadeCODPAR: TIntegerField;
    SQLParticipantesTipoAtividadeCODTIPATI: TIntegerField;
    SQLParticipantesTipoAtividadeCODDIS: TIntegerField;
    SQLParticipantesTipoAtividadeNOMDIS: TStringField;
    DspProgramacaoReport: TDataSetProvider;
    SQLProgramacaoReport: TSQLDataSet;
    SQLQuartosAlojamento: TSQLDataSet;
    DspQuartosAlojamento: TDataSetProvider;
    SQLQuartosAlojamentoCODQUA: TIntegerField;
    SQLQuartosAlojamentoALAQUA: TStringField;
    SQLQuartosAlojamentoNUMQUA: TSmallintField;
    SQLQuartosAlojamentoCODALO: TIntegerField;
    SQLQuartosAlojamentoNOMALO: TStringField;
    SQLQuartosAlojamentoINDTRA: TStringField;
    SQLLeitoQuarto: TSQLDataSet;
    DspLeitoQuarto: TDataSetProvider;
    SQLLeitoQuartoCODLEI: TIntegerField;
    SQLLeitoQuartoCODQUA: TIntegerField;
    SQLLeitoQuartoNUMQUA: TSmallintField;
    SQLLeitoQuartoALAQUA: TStringField;
    SQLLeitoQuartoNUMLEI: TSmallintField;
    SQLLeitoQuartoCODCAD: TIntegerField;
    SQLLeitoQuartoNOMCAD: TStringField;
    SQLLeitoQuartoCODALO: TIntegerField;
    SQLLeitoQuartoNOMALO: TStringField;
    SQLLeitoQuartoINDBLO: TStringField;
    SQLFlagsInscricoes: TSQLDataSet;
    DspFlagsInscricoes: TDataSetProvider;
    SQLFlagsInscricoesCODFLA: TIntegerField;
    SQLFlagsInscricoesDESFLA: TStringField;
    SQLDetalhesInscricoes: TSQLDataSet;
    DspDetalhesInscricoes: TDataSetProvider;
    SQLDetalhesInscricoesCODITE: TIntegerField;
    SQLDetalhesInscricoesCODFLA: TIntegerField;
    SQLDetalhesInscricoesDESFLA: TStringField;
    SQLDetalhesInscricoesCODFOC: TIntegerField;
    SQLDetalhesInscricoesORDITE: TSmallintField;
    SQLExternalReports: TSQLDataSet;
    SQLExternalReportsCODREL: TIntegerField;
    SQLExternalReportsNOMREL: TStringField;
    SQLExternalReportsDESREL: TStringField;
    SQLExternalReportsNOMARQ: TStringField;
    SQLExternalReportsTAGREL: TStringField;
    SQLExternalReportsINDLEC: TStringField;
    SQLExternalReportsINDTMO: TStringField;
    SQLExternalReportsINDTMB: TStringField;
    SQLExternalReportsINDTPU: TStringField;
    SQLExternalReportsINDEIN: TStringField;
    SQLExternalReportsINDFOC: TStringField;
    SQLExternalReportsINDSEC: TStringField;
    SQLExternalReportsINDFIN: TStringField;
    SQLExternalReportsINDCON: TStringField;
    SQLExternalReportsINDATI: TStringField;
    DspExternalReports: TDataSetProvider;
    SQLParticipantes: TSQLDataSet;
    SQLParticipantesCODATIDIS: TIntegerField;
    SQLParticipantesCODATI: TIntegerField;
    SQLParticipantesCODDIS: TIntegerField;
    SQLParticipantesNOMDIS: TStringField;
    DspParticipantes: TDataSetProvider;
    SQLFocosParticipantes: TSQLDataSet;
    SQLFocosParticipantesCODATIFOC: TIntegerField;
    SQLFocosParticipantesCODATI: TIntegerField;
    SQLFocosParticipantesCODFOC: TIntegerField;
    SQLFocosParticipantesNOMFOC: TStringField;
    SQLFocosParticipantesSIGFOC: TStringField;
    DspFocosParticipantes: TDataSetProvider;
    SQLInscrtoINDPRE: TStringField;
    SQLDetalheInscricoes: TSQLDataSet;
    SQLDetalheInscricoesCODITE: TIntegerField;
    SQLDetalheInscricoesCODFLA: TIntegerField;
    SQLDetalheInscricoesDESFLA: TStringField;
    SQLDetalheInscricoesCODFOC: TIntegerField;
    SQLDetalheInscricoesORDITE: TSmallintField;
    DspDetalheInscricoes: TDataSetProvider;
    SQLStaffTarefa: TSQLDataSet;
    DspStaffTarefa: TDataSetProvider;
    SQLStaffTarefaCODSTA: TIntegerField;
    SQLStaffTarefaCODINS: TIntegerField;
    SQLStaffTarefaINDFIX: TStringField;
    SQLStaffTarefaDATSTA: TDateField;
    SQLStaffTarefaHORINI: TTimeField;
    SQLStaffTarefaHORTER: TTimeField;
    SQLStaffTarefaMENSTA: TMemoField;
    SQLStaffTarefaNOMCAD: TStringField;
    SQLStaffTarefaMATCAD: TStringField;
    SQLStaffTarefaSEXCAD: TStringField;
    SQLStaffTarefaSIGDIS: TStringField;
    SQLStaffTarefaSIGFOC: TStringField;
    SQLStaffTarefaCODTAR: TIntegerField;
    SQLCrachasCODINS: TIntegerField;
    SQLPesquisaConferenciasCODFOC: TIntegerField;
    SQLPesquisaConferenciasNOMFOC: TStringField;
    DspRecadosResumido: TDataSetProvider;
    SQLRecadosResumido: TSQLDataSet;
    SQLRecadosResumidoCODNOT: TIntegerField;
    SQLRecadosResumidoCODINS: TIntegerField;
    SQLRecadosResumidoASSNOT: TStringField;
    SQLRecadosResumidoINDCRA: TStringField;
    SQLRecadosResumidoNOTINS: TStringField;
    SQLAlojadosQuarto: TSQLDataSet;
    SQLAlojadosQuartoCODLEI: TIntegerField;
    SQLAlojadosQuartoNUMQUA: TSmallintField;
    SQLAlojadosQuartoNUMLEI: TSmallintField;
    SQLAlojadosQuartoNOMCAD: TStringField;
    SQLAlojadosQuartoSEXCAD: TStringField;
    SQLAlojadosQuartoSIGDIS: TStringField;
    SQLAlojadosQuartoSIGFOC: TStringField;
    SQLAlojadosQuartoidade: TLargeintField;
    SQLAlojadosQuartoindmon: TStringField;
    SQLAlojadosQuartoindsub: TStringField;
    DspAlojadosQuarto: TDataSetProvider;
    SQLFlagsInscricoesDESIMP: TStringField;
    SQLReports: TSQLDataSet;
    DspReports: TDataSetProvider;
    SQLConferenciaMESREF: TSmallintField;
    DspRecados: TDataSetProvider;
    SQLRecados: TSQLDataSet;
    SQLRecadosCODNOT: TIntegerField;
    SQLRecadosCODINS: TIntegerField;
    SQLRecadosASSNOT: TStringField;
    SQLRecadosNOTINS: TMemoField;
    SQLRecadosINDCRA: TStringField;
    SQLRecadosRESNOT: TStringField;
    SQLRecadosDATCAD: TSQLTimeStampField;
    procedure DspConferenciasFocosGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspConferenciasDiscipuladosGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspProgramacaoGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: string);
    procedure DspAtividadeLECGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: string);
    procedure DspAtividadeLECGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspEscalasGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: string);
    procedure DspEscalasGetDataSetProperties(Sender: TObject; DataSet: TDataSet;
      out Properties: OleVariant);
    procedure DspTiposAtividadesGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspAlojamentoGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: string);
    procedure DspAlojamentoGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspClassificadorGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspClassificadorUpdateError(Sender: TObject;
      DataSet: TCustomClientDataSet; E: EUpdateError; UpdateKind: TUpdateKind;
      var Response: TResolverResponse);
    procedure DspClassificadoresLeitoGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspClassificadoresLeitoGetTableName(Sender: TObject;
      DataSet: TDataSet; var TableName: string);
    procedure DspAgendaGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: string);
    procedure DspLeitoGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: string);
    procedure DspInscritoGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: string);
    procedure DspInscritoGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspDetalhesInscricaoGetTableName(Sender: TObject;
      DataSet: TDataSet; var TableName: string);
    procedure DspClassificadoresCadastradosGetTableName(Sender: TObject;
      DataSet: TDataSet; var TableName: string);
    procedure DspClassificadoresCadastradosGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspTarefasAreaGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspTiposRecebimentosGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspTiposRecebimentosGetTableName(Sender: TObject;
      DataSet: TDataSet; var TableName: string);
    procedure DspRecebimentoGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspRecebimentoGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: string);
    procedure DspParticipantesTipoAtividadeGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspParticipantesTipoAtividadeGetTableName(Sender: TObject;
      DataSet: TDataSet; var TableName: string);
    procedure DspQuartosAlojamentoGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspQuartosAlojamentoGetTableName(Sender: TObject;
      DataSet: TDataSet; var TableName: string);
    procedure DspLeitoQuartoGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspLeitoQuartoGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: string);
    procedure DspFlagsInscricoesGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspDetalhesInscricoesGetTableName(Sender: TObject;
      DataSet: TDataSet; var TableName: string);
    procedure DspDetalhesInscricoesGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspParticipantesGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspParticipantesGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: string);
    procedure DspFocosParticipantesGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspFocosParticipantesGetTableName(Sender: TObject;
      DataSet: TDataSet; var TableName: string);
    procedure DspStaffTarefaGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspStaffTarefaGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: string);
    procedure SQLConferenciaBeforeOpen(DataSet: TDataSet);
    procedure DspRecadosGetDataSetProperties(Sender: TObject; DataSet: TDataSet;
      out Properties: OleVariant);
    procedure DspProgramacaoUpdateError(Sender: TObject;
      DataSet: TCustomClientDataSet; E: EUpdateError; UpdateKind: TUpdateKind;
      var Response: TResolverResponse);
    procedure DspConferenciaUpdateError(Sender: TObject;
      DataSet: TCustomClientDataSet; E: EUpdateError; UpdateKind: TUpdateKind;
      var Response: TResolverResponse);
  private
    { Private declarations }
    function CanDeleteAreaStaff(AreaID: integer): boolean;

  public
    { Public declarations }
    procedure AtualizarAtributosInscricao(const codcon: integer);
    function DeleteAttribute(codatr: Integer): integer;
    function ManterAreaStaff(Params: OleVariant; Operation: Integer): integer;
    procedure MudarAreaTarefaStaff(TarefaId, NewParentId: integer);
    function DeleteInfoInscricao(codfla, codite: Integer): integer;
    function CancelarInscricao(codins: Integer): integer;
    function ClonarAlojamento(Inscritos: TDBXDataSetReader; codcon: integer): TDBXDataSetReader;
    procedure DesalojarInscrito(Inscrito: Integer);
  end;


var
  DMCosmosConferenciasMethods: TDMCosmosConferenciasMethods;

implementation

{$R *.DFM}

uses cosmos.servers.common.dataacess, cosmos.servers.common.services;

function TDMCosmosConferenciasMethods.CanDeleteAreaStaff(AreaID: integer): boolean;
var
ADataset: TSQLDataset;
begin
{Verifica se é permitido a exclusão de um área de staff. A exclusão somente será
permitida caso não existam quaisquer membros de staff exercendo uma tarefa na
área de staff que está por ser excluída.}
 ADataset := DMServerDataAcess.CreateDataset;

 try
  ADataset.CommandText := Format(TGConfInscricoes.CountTarefasStaffUsadas, [AreaID]);
  ADataset.Open;

 finally
  Result := (ADataset.Active) and (ADataset.Fields.Fields[0].AsInteger = 0);
  if Assigned(ADataset) then FreeAndNil(ADataset);
 end;
end;

function TDMCosmosConferenciasMethods.ClonarAlojamento(Inscritos: TDBXDataSetReader;
  codcon: integer): TDBXDataSetReader;
var
 AProc: TSQLStoredProc;
 codcad: integer;
 AReturnData: TClientDataset;
begin
 {"Clona" as informações de alojamento de um inscrito em uma conferência para a
  mesma pessoa, inscrita em outra conferência. O parâmetro codins indica a inscriçao
  "original", de onde serão copiados os dados. O parâmetro codcon é a nova inscrição.}

  //Primeiro, encontra as informações que serão copiadas.
  AProc := DMServerDataAcess.CreateStoreProcedure;

  AReturnData := TClientDataset.Create(self);
  AReturnData.FieldDefs.Add('codret', ftInteger);
  AReturnData.FieldDefs.Add('message', ftString, 70);
  AReturnData.FieldDefs.Add('nomcad', ftString, 70);
  AReturnData.CreateDataSet;

  try
   AProc.StoredProcName := TProceduresNames.PROC_CLONAR_ALOJAMENTO_INSCRITO;
   AProc.Prepared := True;

   while Inscritos.Next do
    begin
     DMServerDataAcess.CloseDataset(AProc);

     codcad := Inscritos.GetValueByName('codcad').AsInt32;

     AProc.Params.ParamByName('ICODCAD').Value := codcad;
     AProc.Params.ParamByName('ICODCON').Value := codcon;
     AProc.Params.ParamByName('ICODINS').Value := Inscritos.GetValueByName('codins').AsInt32;

     AProc.Open;

     AReturnData.Append;
     AReturnData.FieldValues['codret'] := AProc.FieldValues['ocodret'];
     AReturnData.FieldValues['message'] := AProc.FieldValues['omessage'];
     AReturnData.FieldValues['nomcad'] := AProc.FieldValues['onomcad'];
     AReturnData.Post;
    end;

  Result := DMServerDataAcess.CreateReader(AReturnData);

  if Assigned(AReturnData) then FreeAndNil(AReturnData);
  if Assigned(AProc) then FreeAndNil(AProc);


 except
  on E: Exception do
   begin
    DMCosmosServerServices.RegisterLog(E.Message, Format(TCosmosLogs.SQLStoredProc, [AProc.StoredProcName]), leOnError);
    if Assigned(AReturnData) then FreeAndNil(AReturnData);
    if Assigned(AProc) then FreeAndNil(AProc);
    raise TDBXError.Create(TCosmosErrorCodes.ClonarAlojamento, TCosmosErrorMsg.ClonarAlojamento);
   end;
 end;
end;

procedure TDMCosmosConferenciasMethods.DspAgendaGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: string);
begin
 TableName := TTablesNames.TAB_ATIVIDADES;
end;

procedure TDMCosmosConferenciasMethods.DspAlojamentoGetDataSetProperties(Sender: TObject;
  DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_ATIVIDADES, False]);
end;

procedure TDMCosmosConferenciasMethods.DspAlojamentoGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: string);
begin
 TableName := TTablesNames.TAB_ALOJAMENTOS;
end;

procedure TDMCosmosConferenciasMethods.DspAtividadeLECGetDataSetProperties(Sender: TObject;
  DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_ATIVIDADES, False]);
end;

procedure TDMCosmosConferenciasMethods.DspAtividadeLECGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: string);
begin
 TableName := TTablesNames.TAB_ATIVIDADES;
end;

procedure TDMCosmosConferenciasMethods.DspClassificadoresCadastradosGetDataSetProperties(
  Sender: TObject; DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_ATRIBUTOS_CADASTRADOS, False]);
end;

procedure TDMCosmosConferenciasMethods.DspClassificadoresCadastradosGetTableName(
  Sender: TObject; DataSet: TDataSet; var TableName: string);
begin
 TableName := TTablesNames.TAB_ATRIBUTOS_CADASTRADOS;
end;

procedure TDMCosmosConferenciasMethods.DspClassificadoresLeitoGetDataSetProperties(
  Sender: TObject; DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_ATRIBUTOS_LEITOS, False]);
end;

procedure TDMCosmosConferenciasMethods.DspClassificadoresLeitoGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: string);
begin
 TableName := TTablesNames.TAB_ATRIBUTOS_LEITOS;
end;

procedure TDMCosmosConferenciasMethods.DspClassificadorGetDataSetProperties(Sender: TObject;
  DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_ATRIBUTOS, False]);
end;

procedure TDMCosmosConferenciasMethods.DspClassificadorUpdateError(Sender: TObject;
  DataSet: TCustomClientDataSet; E: EUpdateError; UpdateKind: TUpdateKind;
  var Response: TResolverResponse);
begin
  if Pos('UNQ_', E.Message) > 0 then
   raise TDBXError.Create(TCosmosErrorCodes.DuplicatedAttributes, TCosmosErrorMsg.DuplicatedAttributes)
  else
    DMServerDataAcess.OnUpdateError(E, UpdateKind, Response);
end;

procedure TDMCosmosConferenciasMethods.DspConferenciasDiscipuladosGetDataSetProperties(
  Sender: TObject; DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_CONFERENCIAS_DISC, False]);
end;

procedure TDMCosmosConferenciasMethods.DspConferenciasFocosGetDataSetProperties(
  Sender: TObject; DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_CONFERENCIAS_FOCOS, False]);
end;

procedure TDMCosmosConferenciasMethods.DspConferenciaUpdateError(
  Sender: TObject; DataSet: TCustomClientDataSet; E: EUpdateError;
  UpdateKind: TUpdateKind; var Response: TResolverResponse);
begin
 DMServerDataAcess.OnUpdateError(E, UpdateKind, Response);
end;

procedure TDMCosmosConferenciasMethods.DspDetalhesInscricaoGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: string);
begin
 TableName := TTablesNames.TAB_DETALHE_INSCRICAO;
end;

procedure TDMCosmosConferenciasMethods.DspDetalhesInscricoesGetDataSetProperties(
  Sender: TObject; DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_ITENS_INSCRICAO, False]);
end;

procedure TDMCosmosConferenciasMethods.DspDetalhesInscricoesGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: string);
begin
 TableName := TTablesNames.TAB_ITENS_INSCRICAO;
end;

procedure TDMCosmosConferenciasMethods.DspEscalasGetDataSetProperties(Sender: TObject;
  DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_ESCALAS_ATIVIDADES, False]);
end;

procedure TDMCosmosConferenciasMethods.DspEscalasGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: string);
begin
 TableName := TTablesNames.TAB_ESCALAS_ATIVIDADES;
end;

procedure TDMCosmosConferenciasMethods.DspFlagsInscricoesGetDataSetProperties(Sender: TObject;
  DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_FLAGS_INSCRICOES, False]);
end;

procedure TDMCosmosConferenciasMethods.DspFocosParticipantesGetDataSetProperties(
  Sender: TObject; DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_ATIVIDADES_FOCOS, False]);
end;

procedure TDMCosmosConferenciasMethods.DspFocosParticipantesGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: string);
begin
 TableName := TTablesNames.TAB_ATIVIDADES_FOCOS;
end;

procedure TDMCosmosConferenciasMethods.DspInscritoGetDataSetProperties(Sender: TObject;
  DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_INSCRICOES, False]);
end;

procedure TDMCosmosConferenciasMethods.DspInscritoGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: string);
begin
 TableName := TTablesNames.TAB_INSCRICOES;
end;

procedure TDMCosmosConferenciasMethods.DspLeitoGetTableName(Sender: TObject; DataSet: TDataSet;
  var TableName: string);
begin
 TableName := TTablesNames.TAB_LEITOS;
end;

procedure TDMCosmosConferenciasMethods.DspLeitoQuartoGetDataSetProperties(Sender: TObject;
  DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_LEITOS, False]);
end;

procedure TDMCosmosConferenciasMethods.DspLeitoQuartoGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: string);
begin
 TableName := TTablesNames.TAB_LEITOS;
end;

procedure TDMCosmosConferenciasMethods.DspParticipantesGetDataSetProperties(Sender: TObject;
  DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_ATIVIDADES_DISCIPULADOS, False]);
end;

procedure TDMCosmosConferenciasMethods.DspParticipantesGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: string);
begin
 TableName := TTablesNames.TAB_ATIVIDADES_DISCIPULADOS;
end;

procedure TDMCosmosConferenciasMethods.DspParticipantesTipoAtividadeGetDataSetProperties(
  Sender: TObject; DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_PARTICIPANTES, False]);
end;

procedure TDMCosmosConferenciasMethods.DspParticipantesTipoAtividadeGetTableName(
  Sender: TObject; DataSet: TDataSet; var TableName: string);
begin
TableName := TTablesNames.TAB_PARTICIPANTES;
end;

procedure TDMCosmosConferenciasMethods.DspProgramacaoGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: string);
begin
 TableName := TTablesNames.TAB_ATIVIDADES;
end;

procedure TDMCosmosConferenciasMethods.DspProgramacaoUpdateError(
  Sender: TObject; DataSet: TCustomClientDataSet; E: EUpdateError;
  UpdateKind: TUpdateKind; var Response: TResolverResponse);
begin
 DMServerDataAcess.OnUpdateError(E, UpdateKind, Response);
end;

procedure TDMCosmosConferenciasMethods.DspQuartosAlojamentoGetDataSetProperties(
  Sender: TObject; DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_QUARTOS, False]);
end;

procedure TDMCosmosConferenciasMethods.DspQuartosAlojamentoGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: string);
begin
 TableName := TTablesNames.TAB_QUARTOS;
end;

procedure TDMCosmosConferenciasMethods.DspRecadosGetDataSetProperties(
  Sender: TObject; DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_NOTAS_INSCRITO, False]);
end;

procedure TDMCosmosConferenciasMethods.DspRecebimentoGetDataSetProperties(Sender: TObject;
  DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_RECEBIMENTOS, False]);
end;

procedure TDMCosmosConferenciasMethods.DspRecebimentoGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: string);
begin
 TableName := TTablesNames.TAB_RECEBIMENTOS;
end;

procedure TDMCosmosConferenciasMethods.DspStaffTarefaGetDataSetProperties(Sender: TObject;
  DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_STAFF, False]);
end;

procedure TDMCosmosConferenciasMethods.DspStaffTarefaGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: string);
begin
 TableName := TTablesNames.TAB_STAFF;
end;

procedure TDMCosmosConferenciasMethods.DspTarefasAreaGetDataSetProperties(Sender: TObject;
  DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_TAREFAS_STAFF, False]);
end;

procedure TDMCosmosConferenciasMethods.DspTiposAtividadesGetDataSetProperties(Sender: TObject;
  DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_TIPOS_ATIVIDADES, False]);
end;

procedure TDMCosmosConferenciasMethods.DspTiposRecebimentosGetDataSetProperties(
  Sender: TObject; DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_TIPOS_RECEBIMENTOS, False]);
end;

procedure TDMCosmosConferenciasMethods.DspTiposRecebimentosGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: string);
begin
 TableName := TTablesNames.TAB_TIPOS_RECEBIMENTOS;
end;

procedure TDMCosmosConferenciasMethods.SQLConferenciaBeforeOpen(
  DataSet: TDataSet);
begin
 TSQLDataSet(Dataset).SQLConnection := DMServerDataAcess.ConnectionPool.GetConnection;
end;

function TDMCosmosConferenciasMethods.DeleteAttribute(codatr: Integer): integer;
var
ADataset: TSQLDataset;
begin
{Exclui um atributo, se possível.}
 ADataset := DMServerDataAcess.CreateDataset;

 try
  ADataset.CommandText := Format(TGConfCommands.AttributesCount, [codatr, codatr]);
  ADataset.Open;
  if ADataset.IsEmpty then
   begin
    Result := 0;
    DMServerDataAcess.DoExecuteCommand(Format(TGConfCommands.AttributeDelete, [codatr]));
   end
  else
   begin
    Result:= 1;
//    AReturn.MessageText := sInfoCantDeleteClassificador;
   end;

  if Assigned(ADataset) then FreeAndNil(ADataset);


 except
  on E: EXception do
   begin
    Result := 2;
    DMCosmosServerServices.RegisterLog(E.Message, ADataset.CommandText, leOnError);
    if Assigned(ADataset) then FreeAndNil(ADataset);
    raise TDBXError.Create(TCosmosErrorCodes.DelAttribute, TCosmosErrorMsg.DelAttribute);
   end;
 end;
end;

function TDMCosmosConferenciasMethods.ManterAreaStaff(Params: OleVariant; Operation: Integer): integer;
var
sCommand: string;
CanExecute: boolean;
begin

 try
  Result := 0;
  //OPerações de inserção e alteração sempre podem ser executadas.
  CanExecute := TDatabaseOperation(Operation) <> doDelete;

  case TDatabaseOperation(Operation) of
   doInsert: sCommand := TGConfCommands.InsertAreaStaff;
   doUpdate: sCommand := TGConfCommands.UpdateAreaStaff;
   doDelete: sCommand := TGConfCommands.DeleteAreaStaff;
  end;

  TSQLCommandsFactory.CreateCommandText(sCommand, Params);

  if TDatabaseOperation(Operation) = doDelete then
   begin
    CanExecute := CanDeleteAreaStaff(Params[0]);
    if not CanExecute then
      Result := 1;
   end;

  if CanExecute then
   DMServerDataAcess.DoExecuteCommand(sCommand);

 except
  on E: Exception do
   begin
    Result := 2;
    DMCosmosServerServices.RegisterLog(E.Message, Format(TCosmosLogs.SQLCommand, [sCommand]), leOnError);
    raise TDBXError.Create(TCosmosErrorCodes.SaveAreaStaff, TCosmosErrorMsg.SaveAreaStaff);
   end;
 end;
end;

procedure TDMCosmosConferenciasMethods.MudarAreaTarefaStaff(TarefaId,
  NewParentId: integer);
var
 sCommand: string;
begin
{Muda uma tarefa de área de staff.}
 sCommand := Format(TGConfCommands.ChangeTarefaAreaStaff, [NewparentId, TarefaId]);

 try
   DMServerDataAcess.DoExecuteCommand(sCommand);

 except
  on E: Exception do
   begin
    DMCosmosServerServices.RegisterLog(E.Message, sCommand, leOnError);
    raise TDBXError.Create(TCosmosErrorCodes.ChangeTarefaAreaStaff, TCosmosErrorMsg.ChangeTarefaAreaStaff);
   end;
 end;
end;

function TDMCosmosConferenciasMethods.DeleteInfoInscricao(codfla, codite: Integer): integer;
var
 ADataset: TSQLDataset;
begin
{Exclui um item de detalhamento de inscrição, se possível.}
 ADataset := DMServerDataAcess.CreateDataset;

 try
  ADataset.CommandText := Format(TGConfCommands.CountInfoInscricao, [codfla]);
  ADataset.Open;
  if ADataset.Fields.Fields[0].AsInteger = 0 then
   begin
    Result := 0;
    DMServerDataAcess.DoExecuteCommand(Format(TGConfCommands.DeleteItensInscricao, [codite]));
   end
  else
    Result := 1;

  if Assigned(ADataset) then FreeAndNil(ADataset);


 except
  on E: Exception do
   begin
    Result := 2;
    DMCosmosServerServices.RegisterLog(E.Message, ADataset.CommandText, leOnError);
    if Assigned(ADataset) then FreeAndNil(ADataset);
    raise TDBXError.Create(TCosmosErrorCodes.DelFlagInscricao, TCosmosErrorMsg.DelFlagInscricao);
   end;
 end;

end;

procedure TDMCosmosConferenciasMethods.AtualizarAtributosInscricao(
  const codcon: integer);
var
 sCommand: string;
begin
{Atualiza os atributos de detalhamento de inscrição dos inscritos em uma conferência.}
 try
  sCommand := Format(TGConfCommands.AtualizarAtributosInscritos, [codcon]);
  DMServerDataAcess.DoExecuteCommand(sCommand);

 except
  on E: Exception do
   begin
    DMCosmosServerServices.RegisterLog(E.Message, sCommand, leOnError);
    raise TDBXError.Create(TCosmosErrorCodes.UpdateAtributosInscricoes, TCosmosErrorMsg.AtualizarAtributosInscricoes);
   end;
 end;
end;

function TDMCosmosConferenciasMethods.CancelarInscricao(codins: Integer): integer;
var
codcad, codcon: integer;
ADataset: TSQLDataset;
begin
{Exclui um item de detalhamento de inscrição, se possível.}
 ADataset := DMServerDataAcess.CreateDataset;

 try
  ADataset.CommandText := Format(TGConfCommands.InscricaoInfo, [codins]);
  ADataset.Open;

  if not ADataset.IsEmpty then
   begin
    codcad := ADataset.FieldValues['codcad'];
    codcon := ADataset.FieldValues['codcon'];

    DMServerDataAcess.CloseDataset(ADataset);
    ADataset.CommandText := Format(TGConfCommands.InscritoFrequenciaCount, [codcon, codcad]);
    ADataset.Open;
    if ADataset.Fields.Fields[0].AsInteger = 0 then
     begin
      Result := 0;
      DMServerDataAcess.DoExecuteCommand(Format(TGConfCommands.InscricaoDelete, [codins]));
     end
    else
     begin
      Result := 1;
     // AReturn.MessageTitle := sTitleInscricoesConferencia;
     // AReturn.MessageText := TCosmosInfoMsg.CantDelInscrito;
     end;
   end;

 if Assigned(ADataset) then FreeAndNil(ADataset);


 except
  on E: Exception do
   begin
    Result := 2;
    DMCosmosServerServices.RegisterLog(E.Message, ADataset.CommandText, leOnError);
    if Assigned(ADataset) then FreeAndNil(ADataset);
    raise TDBXError.Create(TCosmosErrorCodes.CancelarInscricao, TCosmosErrorMsg.CancelarInscricao);
   end;
 end;
end;


procedure TDMCosmosConferenciasMethods.DesalojarInscrito(Inscrito: Integer);
var
ACommand: string;
begin
{Desaloja um inscrito do seu leito atual.}
 ACommand := Format(TGConfCommands.DesalojaInscrito, [Inscrito]);

 try
  DMServerDataAcess.DoExecuteCommand(ACommand);

 except
  on E: Exception do
   begin
    DMCosmosServerServices.RegisterLog(E.Message, Format(TCosmosLogs.SQLCommand, [ACommand]), leOnError);
    raise TDBXError.Create(TCosmosErrorCodes.DesalojarInscrito, TCosmosErrorMsg.DesalojarInscrito);
   end;
 end;
end;

end.
