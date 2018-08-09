unit RDMConferencias;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Windows, Messages, SysUtils, Classes, ComServ, ComObj, VCLCom, DataBkr,
  DBClient, confser_TLB, StdVcl, FMTBcd, SqlExpr, SQLScript, Provider,
  DB, cosmos.logs.winservice, cosmos.core.classes, cosmos.persistence.registry,
  cosmos.core.ConstantesMsg, variants, shlobj, cosmos.core.server.utils,
  cosmos.core.winshell, fbservices_TLB, ActiveX, SQLConsts, ServerConnections,
  cosmos.framework.interfaces.utils, cosmos.core.SQLServerInterface,
  WideStrings, DBXFirebird, dbxCommon, cosmos.core.server.dataobjects,
  cosmos.core.server.cosmosobj, cosmos.core.server.security, cosmos.core.classes.FieldsInfo,
  cosmos.persistence.ini;

type
  TConferencias = class(TRemoteDataModule, IConferencias)
    SQLCon: TSQLConnection;
    SQLSearch: TSQLDataSet;
    DspSearch: TDataSetProvider;
    SQLCommand: TSQLDataSet;
    SQLMonitor: TSQLMonitor;
    SQLConferencia: TSQLDataSet;
    SQLConferenciaCODCON: TIntegerField;
    SQLConferenciaNOMCON: TStringField;
    SQLConferenciaNOMFOC: TStringField;
    SQLConferenciaCAMCON: TStringField;
    SQLConferenciaCODMOD: TIntegerField;
    SQLConferenciaNOMMOD: TStringField;
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
    DspRecados: TDataSetProvider;
    SQLRecados: TSQLDataSet;
    SQLRecadosCODNOT: TIntegerField;
    SQLRecadosCODINS: TIntegerField;
    SQLRecadosASSNOT: TStringField;
    SQLRecadosINDCRA: TStringField;
    SQLRecadosNOTINS: TStringField;
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
    procedure DspConferenciasFocosGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspConferenciasDiscipuladosGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspProgramacaoGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: WideString);
    procedure SQLSearchAfterOpen(DataSet: TDataSet);
    procedure RemoteDataModuleDestroy(Sender: TObject);
    procedure RemoteDataModuleCreate(Sender: TObject);
    procedure SQLConAfterConnect(Sender: TObject);
    procedure DspAtividadeLECGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: WideString);
    procedure DspAtividadeLECGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspEscalasGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: WideString);
    procedure DspEscalasGetDataSetProperties(Sender: TObject; DataSet: TDataSet;
      out Properties: OleVariant);
    procedure DspTiposAtividadesGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspAlojamentoGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: WideString);
    procedure DspAlojamentoGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspClassificadorGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspClassificadorUpdateError(Sender: TObject;
      DataSet: TCustomClientDataSet; E: EUpdateError; UpdateKind: TUpdateKind;
      var Response: TResolverResponse);
    procedure DspTipoAtividadeUpdateError(Sender: TObject;
      DataSet: TCustomClientDataSet; E: EUpdateError; UpdateKind: TUpdateKind;
      var Response: TResolverResponse);
    procedure DspClassificadoresLeitoGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspClassificadoresLeitoGetTableName(Sender: TObject;
      DataSet: TDataSet; var TableName: WideString);
    procedure DspAgendaGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: WideString);
    procedure DspLeitoGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: WideString);
    procedure DspInscritoGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: WideString);
    procedure DspInscritoGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspDetalhesInscricaoGetTableName(Sender: TObject;
      DataSet: TDataSet; var TableName: WideString);
    procedure DspClassificadoresCadastradosGetTableName(Sender: TObject;
      DataSet: TDataSet; var TableName: WideString);
    procedure DspClassificadoresCadastradosGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspTarefasAreaGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspTiposRecebimentosGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspTiposRecebimentosGetTableName(Sender: TObject;
      DataSet: TDataSet; var TableName: WideString);
    procedure DspRecebimentoGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspRecebimentoGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: WideString);
    procedure DspParticipantesTipoAtividadeGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspParticipantesTipoAtividadeGetTableName(Sender: TObject;
      DataSet: TDataSet; var TableName: WideString);
    procedure DspQuartosAlojamentoGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspQuartosAlojamentoGetTableName(Sender: TObject;
      DataSet: TDataSet; var TableName: WideString);
    procedure DspLeitoQuartoGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspLeitoQuartoGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: WideString);
    procedure DspFlagsInscricoesGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspDetalhesInscricoesGetTableName(Sender: TObject;
      DataSet: TDataSet; var TableName: WideString);
    procedure DspDetalhesInscricoesGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspParticipantesGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspParticipantesGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: WideString);
    procedure DspFocosParticipantesGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspFocosParticipantesGetTableName(Sender: TObject;
      DataSet: TDataSet; var TableName: WideString);
    procedure DspStaffTarefaGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspStaffTarefaGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: WideString);
    procedure DspSearchUpdateError(Sender: TObject;
      DataSet: TCustomClientDataSet; E: EUpdateError; UpdateKind: TUpdateKind;
      var Response: TResolverResponse);
    procedure SQLMonitorLogTrace(Sender: TObject; TraceInfo: TDBXTraceInfo);
  private
    { Private declarations }
    FConnectedUser: TCosmosUser;
    FConnectionID: TGUID; //Mapeia um identificador exclusivo para uma conexão.
    FCosmosFolder, FCosmosMonitorFolder, FConnectionRole, FConnectionPath: string;
    FLog: TWinServiceLog; //Classe registradora de logs.
    AFieldsInfoReader: TFieldsInfoReader;
    FMaxLineTrace: integer;
    FActiveRange: Int64; //Faixa d formação de chaves primárias.
    FLastUpdateError: Olevariant;

    function GetCurrentCosmosModule: TCosmosModules;
    procedure CloseDataset(const Dataset: TDataset); inline;
    procedure ReadChipherKey(var Key: string); inline;
    procedure CreateLog(const Message: string; MsgType: Cardinal); inline;
    procedure SetConnectionParams; inline;//Carrega informações sobre a conexão com o banco de dados.
    procedure DoExecuteDQL(const DQL: WideString);
    function DoExecuteCommand(const Command: string): integer;

    function NewSQLMonitorFile: string;
    procedure ConfigureLogSystem;
    function GetUserStatus(const UserName: string): TUserStatus;
    function CreateMessageData: TServerReturn; inline;
    function GetDatasetCommand(Dataset: TCustomSQLDataSet): string; inline;
    procedure DoCreateUpdateDataError(E: Exception);
    function CanDeleteAreaStaff(AreaID: integer): boolean;
    procedure ConfigureDatabaseMonitor;

  protected
    function GetSequenceValue(const SequenceName: WideString): OleVariant; safecall;
    function GetAcessedFocus(const UserName: WideString): OleVariant; safecall;
    function ExecuteDQL(SearchID: Integer; Params: OleVariant): OleVariant; safecall;
    function IsAdministrator(const UserName: WideString): OleVariant; safecall;
    function GetPerfilData: OleVariant; safecall;
    function Get_DatabaseVersion: OleVariant; safecall;
    function Get_ServerDateTime: OleVariant; safecall;
    function Get_ServerComputer: OleVariant; safecall;
    function Get_CodeKey: OleVariant; safecall;
    function Get_ActiveUser: OleVariant; safecall;
    function Get_BetaVersion: OleVariant; safecall;
    procedure BufferData(const SchemmaName: WideString;
      out DataPackage: OleVariant); safecall;
    function ConnectDatabase(const UserName, Password, RoleName,
      HostName: WideString): OleVariant; safecall;
    class procedure UpdateRegistry(Register: Boolean; const ClassID, ProgID: string); override;
    function GetLastUpdateError: OleVariant; safecall;
    function DeleteAttribute(codatr: Integer): OleVariant; safecall;
    function GetTableProviderName(Table: Integer): OleVariant; safecall;
    function Get_ActiveRange: OleVariant; safecall;
    function ManterAreaStaff(Params: OleVariant; Operation: Integer): OleVariant; safecall;
    function ExecuteCommand(CommandID: Integer; Params: OleVariant): OleVariant; safecall;
    function DeleteInfoInscricao(codfla, codite: Integer): OleVariant; safecall;
    function CancelarInscricao(codins: Integer): OleVariant; safecall;
    function ExecuteRegisteredSearch(SearchId: Integer; Params: OleVariant): OleVariant;
          safecall;
    function GetCosmosSearchsInfo: OleVariant; safecall;
    function DesalojarInscrito(Inscrito: Integer): OleVariant; safecall;


  public
    { Public declarations }
     property ActiveRange: Int64 read FActiveRange;
     property ConnectedUser: TCosmosUser read FConnectedUser;
     property CurrentCosmosModule: TCosmosModules read GetCurrentCosmosModule;
     property Log: TWinServiceLog read FLog;
  end;

implementation

uses Main;

{$R *.DFM}

function TConferencias.CanDeleteAreaStaff(AreaID: integer): boolean;
var
sSQL: string;
AConnection: TSQLConnection;
ACommand: TSQLServerCommand;
ADataset: TSQLDataset;
begin
{Verifica se é permitido a exclusão de um área de staff. A exclusão somente será
permitida caso não existam quaisquer membros de staff exercendo uma tarefa na
área de staff que está por ser excluída.}
 ACommand := TSQLServerCommand.Create;
 AConnection := ACommand.CreateConnection;
 ADataset := TSQLDataset.Create(nil);

 try
  ADataset.SQLConnection := AConnection;
  sSQL := Format(sCountTarefasStaffUsadas, [AreaID]);
  ACommand.ExecuteDQL(sSQL, ADataset);

 finally
  Result := (ADataset.Active) and (ADataset.Fields.Fields[0].AsInteger = 0);
  if Assigned(ADataset) then FreeAndNil(ADataset);
  if Assigned(ACommand) then FreeAndNil(ACommand);
  if Assigned(AConnection) then FreeAndNil(AConnection);
 end;
end;

procedure TConferencias.CloseDataset(const Dataset: TDataset);
begin
//Fecha um dataset ativo.
 if Assigned(Dataset) then
  if Dataset.Active then
   Dataset.Close;
end;

procedure TConferencias.ConfigureDatabaseMonitor;
begin
  //Verifica se a conexão com o servidor SQL estará em monitoramento.
  FMaxLineTrace := TCosmosInfoFiles.GetMaxLineTracesMonitor;
  SQLMonitor.FileName := self.NewSQLMonitorFile;
  SQLMonitor.Active := TCosmosInfoFiles.IsMonitoringDatabase;

  if SQLMonitor.Active then
    SQLMonitor.SQLConnection := SQLCon;
end;

procedure TConferencias.ConfigureLogSystem;
var
 AList: TStringList;
begin
//Configura o objeto interno da classe TWinService que usa o serviço de escrita
//de logs do MSWindows.
 if Assigned(FLog) then
  begin
   AList := TStringList.Create;

   try
     TCosmosApplication.ReadLogInformation(cmConferenciasServer, AList);

     TWinServiceLog(FLog).ConfigureService(AList.Values['CategoryMessageFile'],
      AList.Values['DisplayEventFile'], AList.Values['DisplayNameFile'],
      AList.Values['DisplayEventID'], AList.Values['EventFile'],
      AList.Values['PrimaryModule'], AList.Values['Source'], AList.Values['LogName'],
      StrToInt(AList.Values['CategoryCount']), StrToInt(AList.Values['DisplayNameID']),
      StrToInt(AList.Values['TypesSupported']));  //do not localize!

   finally
     if Assigned(AList) then
      FreeAndNil(AList);
   end;
  end;
end;

procedure TConferencias.CreateLog(const Message: string; MsgType: Cardinal);
begin
//Escreve um log no sistema de logs do Windows usando o component TEventWriter.
 case MsgType of
  EVENTLOG_SUCCESS : Log.RegisterSucess(Message);
  EVENTLOG_ERROR_TYPE: Log.RegisterError(Message);
  EVENTLOG_WARNING_TYPE: Log.RegisterWarning(Message);
  EVENTLOG_INFORMATION_TYPE: Log.RegisterInfo(Message);
  EVENTLOG_AUDIT_SUCCESS: Log.RegisterAuditSucess(Message);
  EVENTLOG_AUDIT_FAILURE: Log.RegisterAuditFailure(Message);
 end;
end;

function TConferencias.CreateMessageData: TServerReturn;
begin
 //Cria um objeto TServerReturn e configura suas propriedades com valores-padrão.
 Result := TServerReturn.Create;
 Result.Code := 0;
 Result.HelpContext := 0;
 Result.MessageText := '';
 Result.MessageTitle := '';
 Result.MessageType := mtpSucess;
 Result.CosmosModule := cmConferenciasServer;
 Result.SetMessageInfo(miInstallationID, self.ActiveRange);
end;

procedure TConferencias.DoCreateUpdateDataError(E: Exception);
var
AReturn: TServerReturn;
begin
{Trata a resposta, para as aplicações clientes, de exceções de violação de chaves
 primárias ou chaves estrangeiras.}
 AReturn := self.CreateMessageData;

 try
  AReturn.MessageTitle := sTitleUpdateData;
  AReturn.MessageText := sErrorUpdateData;
  AReturn.MessageType := mtpError;
  AReturn.CosmosModule := cmConferenciasServer;
  AReturn.SetMessageInfo(miInnerMessage, E.Message);
  self.FLastUpdateError := AReturn.ServerReturn;
  //A aplicação cliente deve chamar o método GetLastUpdateError para recuperar
  //este erro.

  self.CreateLog(E.Message, EVENTLOG_ERROR_TYPE);

 finally
  if Assigned(AReturn) then
   FreeAndNil(AReturn);
 end;
end;

function TConferencias.DoExecuteCommand(const Command: string): integer;
var
 ACommand: TSQLServerCommand;
begin
 //Executa um comando e retorna o número de linhas afetadas.
 ACommand := TSQLServerCommand.Create;

 try
  Result := ACommand.ExecuteCommand(Command);

 except
  if Assigned(ACommand) then
   FreeAndNil(ACommand);
  raise;
 end;
end;

procedure TConferencias.DoExecuteDQL(const DQL: WideString);
var
 ACommand: TSQLServerCommand;
begin
//Executa um comando DQL
 CloseDataset(SQLSearch);
 ACommand := TSQLServerCommand.Create;

 try
  ACommand.ExecuteDQL(DQL, SQLSearch);
  if Assigned(ACommand) then
   FreeAndNil(ACommand);

 except
  on E: Exception do
   begin
    CreateLog(E.Message +  Format(sErrorSQLCommand, [DQL]), EVENTLOG_ERROR_TYPE);
    if Assigned(ACommand) then FreeAndNil(ACommand);
    raise;
   end;
 end;
end;

procedure TConferencias.DspAgendaGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: WideString);
begin
 TableName := 'ATIVIDADES';
end;

procedure TConferencias.DspAlojamentoGetDataSetProperties(Sender: TObject;
  DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', sGEN_ATIVIDADES, False]);
end;

procedure TConferencias.DspAlojamentoGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: WideString);
begin
 TableName := 'ALOJAMENTOS';
end;

procedure TConferencias.DspAtividadeLECGetDataSetProperties(Sender: TObject;
  DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', sGEN_ATIVIDADES, False]);
end;

procedure TConferencias.DspAtividadeLECGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: WideString);
begin
 TableName := 'ATIVIDADES';
end;

procedure TConferencias.DspClassificadoresCadastradosGetDataSetProperties(
  Sender: TObject; DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', sGEN_ATRIBUTOS_CADASTRADOS, False]);
end;

procedure TConferencias.DspClassificadoresCadastradosGetTableName(
  Sender: TObject; DataSet: TDataSet; var TableName: WideString);
begin
 TableName := 'ATRIBUTOS_CADASTRADOS';
end;

procedure TConferencias.DspClassificadoresLeitoGetDataSetProperties(
  Sender: TObject; DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', sGEN_ATRIBUTOS_LEITOS, False]);
end;

procedure TConferencias.DspClassificadoresLeitoGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: WideString);
begin
 TableName := 'ATRIBUTOS_LEITOS';
end;

procedure TConferencias.DspClassificadorGetDataSetProperties(Sender: TObject;
  DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', sGEN_ATRIBUTOS, False]);
end;

procedure TConferencias.DspClassificadorUpdateError(Sender: TObject;
  DataSet: TCustomClientDataSet; E: EUpdateError; UpdateKind: TUpdateKind;
  var Response: TResolverResponse);
var
AReturn: TServerReturn;
begin
 AReturn := self.CreateMessageData;

 try
  if Pos('UNQ_', E.Message) > 0 then
   begin
    AReturn.MessageTitle := sTitleUpdateData;
    AReturn.MessageText := sErrorDuplicatedAttributes;
    AReturn.MessageType := mtpError;
    AReturn.SetMessageInfo(miInnerMessage, E.Message);
    self.FLastUpdateError := AReturn.ServerReturn;
   end
  else
   DoCreateUpdateDataError(E);

 finally
  if Assigned(AReturn) then
   FreeAndNil(AReturn);
 end;
end;

procedure TConferencias.DspConferenciasDiscipuladosGetDataSetProperties(
  Sender: TObject; DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', sGEN_CONFERENCIAS_DISC, False]);
end;

procedure TConferencias.DspConferenciasFocosGetDataSetProperties(
  Sender: TObject; DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', sGEN_CONFERENCIAS_FOCOS, False]);
end;

procedure TConferencias.DspDetalhesInscricaoGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: WideString);
begin
 TableName := 'DETALHE_INSCRICAO';
end;

procedure TConferencias.DspDetalhesInscricoesGetDataSetProperties(
  Sender: TObject; DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', sGEN_ITENS_INSCRICAO, False]);
end;

procedure TConferencias.DspDetalhesInscricoesGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: WideString);
begin
 TableName := 'ITENS_INSCRICAO';
end;

procedure TConferencias.DspEscalasGetDataSetProperties(Sender: TObject;
  DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', sGEN_ESCALAS_ATIVIDADES, False]);
end;

procedure TConferencias.DspEscalasGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: WideString);
begin
 TableName := 'ESCALAS_ATIVIDADES';
end;

procedure TConferencias.DspFlagsInscricoesGetDataSetProperties(Sender: TObject;
  DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', sGEN_FLAGS_INSCRICOES, False]);
end;

procedure TConferencias.DspFocosParticipantesGetDataSetProperties(
  Sender: TObject; DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', sGEN_ATIVIDADES_FOCOS, False]);
end;

procedure TConferencias.DspFocosParticipantesGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: WideString);
begin
 TableName := 'ATIVIDADES_FOCOS';
end;

procedure TConferencias.DspInscritoGetDataSetProperties(Sender: TObject;
  DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', sGEN_INSCRICOES, False]);
end;

procedure TConferencias.DspInscritoGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: WideString);
begin
 TableName := 'INSCRICOES';
end;

procedure TConferencias.DspLeitoGetTableName(Sender: TObject; DataSet: TDataSet;
  var TableName: WideString);
begin
 TableName := 'LEITOS';
end;

procedure TConferencias.DspLeitoQuartoGetDataSetProperties(Sender: TObject;
  DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', sGEN_LEITOS, False]);
end;

procedure TConferencias.DspLeitoQuartoGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: WideString);
begin
 TableName := 'LEITOS';
end;

procedure TConferencias.DspParticipantesGetDataSetProperties(Sender: TObject;
  DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', sGEN_ATIVIDADES_DISCIPULADOS, False]);
end;

procedure TConferencias.DspParticipantesGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: WideString);
begin
 TableName := 'ATIVIDADES_DISCIPULADOS';
end;

procedure TConferencias.DspParticipantesTipoAtividadeGetDataSetProperties(
  Sender: TObject; DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', sGEN_PARTICIPANTES, False]);
end;

procedure TConferencias.DspParticipantesTipoAtividadeGetTableName(
  Sender: TObject; DataSet: TDataSet; var TableName: WideString);
begin
TableName := 'PARTICIPANTES';
end;

procedure TConferencias.DspProgramacaoGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: WideString);
begin
 TableName := 'ATIVIDADES';
end;

procedure TConferencias.DspQuartosAlojamentoGetDataSetProperties(
  Sender: TObject; DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', sGEN_QUARTOS, False]);
end;

procedure TConferencias.DspQuartosAlojamentoGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: WideString);
begin
 TableName := 'QUARTOS';
end;

procedure TConferencias.DspRecebimentoGetDataSetProperties(Sender: TObject;
  DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', sGEN_RECEBIMENTOS, False]);
end;

procedure TConferencias.DspRecebimentoGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: WideString);
begin
 TableName := 'RECEBIMENTOS';
end;

procedure TConferencias.DspSearchUpdateError(Sender: TObject;
  DataSet: TCustomClientDataSet; E: EUpdateError; UpdateKind: TUpdateKind;
  var Response: TResolverResponse);
begin
 self.DoCreateUpdateDataError(E);
end;

procedure TConferencias.DspStaffTarefaGetDataSetProperties(Sender: TObject;
  DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', sGEN_STAFF, False]);
end;

procedure TConferencias.DspStaffTarefaGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: WideString);
begin
 TableName := 'STAFF';
end;

procedure TConferencias.DspTarefasAreaGetDataSetProperties(Sender: TObject;
  DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', sGEN_TAREFAS_STAFF, False]);
end;

procedure TConferencias.DspTipoAtividadeUpdateError(Sender: TObject;
  DataSet: TCustomClientDataSet; E: EUpdateError; UpdateKind: TUpdateKind;
  var Response: TResolverResponse);
begin
 DoCreateUpdateDataError(E);
end;

procedure TConferencias.DspTiposAtividadesGetDataSetProperties(Sender: TObject;
  DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', sGEN_TIPOS_ATIVIDADES, False]);
end;

procedure TConferencias.DspTiposRecebimentosGetDataSetProperties(
  Sender: TObject; DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', sGEN_TIPOS_RECEBIMENTOS, False]);
end;

procedure TConferencias.DspTiposRecebimentosGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: WideString);
begin
 TableName := 'TIPOS_RECEBIMENTOS';
end;

function TConferencias.GetUserStatus(const UserName: string): TUserStatus;
var
 UserManager: TCosmosUsersManager;
begin
//Verifica o status do usuário...
 UserManager := TCosmosUsersManager.Create;

 try
  Result := UserManager.GetUserStatus(UserName);

  if Assigned(UserManager) then
   FreeAndNil(UserManager);

 except
  on E: Exception do
   begin
    Result := usUnknown;
    if Assigned(UserManager) then
     FreeAndNil(UserManager);

    self.CreateLog(E.Message, EVENTLOG_ERROR_TYPE);
   end;
 end;
end;

function TConferencias.NewSQLMonitorFile: string;
var
AFileName: string;
GUID: TGUID;
begin
//Gera um novo arquivo para ser usado pelo sqlmonitor
 Result := '';
{Obtém a pasta onde serão armazenados arquivos de monitoração das transações
 com o servidor SQL.}
 AFileName := TCosmosInfoFiles.GetDatabaseMonitorFolder;

 if not DirectoryExists(AFileName) then
  CreateDir(AFileName);

 CreateGUID(GUID);
 Result := AFileName + '\gconf_' + GUIDToString(GUID) + '.txt';
end;

procedure TConferencias.ReadChipherKey(var Key: string);
var
AFile: TIniFilePersistence;
begin
{Lê a chave criptográfica. Esta chave será usada para criptografar e descriptografar
dados, tanto na aplicação servidora como na cliente. A aplicação cliente lê a
chave gerada por esta rotina através da propriedade CodeKey,
exposta pela TypeLibrary.}
 AFile := TIniFilePersistence.Create('cosmos_adm.ini', True);

 try
  Key := AFile.ReadString('Criptografia', 'Key', '');

 finally
  if Assigned(AFile) then
   FreeAndNil(AFile);
 end;
end;

procedure TConferencias.RemoteDataModuleCreate(Sender: TObject);
var
AXMLFile: string;
begin
 FConnectedUser := TCosmosUser.Create;
 //Obtém a pasta onde o servidor está instalado.
 FCosmosFolder := TCosmosApplication.GetModulePath;

 //Cria e configura o objeto manipulador de logs.
 if not Assigned(FLog) then
  begin
   FLog := TWinServiceLog.Create;
   ConfigureLogSystem;
  end;

 ConfigureDatabaseMonitor;

 //Pega a interface com o arquivo de configuração de dados dos campos de dados.
 AXMLFile := self.FCosmosFolder + 'FieldsInfo.xml'; //do not localize!

 try
  AFieldsInfoReader := TFieldsInfoReader.Create(AXMLFile);

 except
  on E: Exception do
   begin
    self.Log.RegisterError(E.Message);
   end;
 end;
end;

procedure TConferencias.RemoteDataModuleDestroy(Sender: TObject);
begin
 if Assigned(FConnectedUser) then
  FreeAndNil(FConnectedUser);

 if Assigned(FrmMain) then
  FrmMain.UnregisterConnection(FConnectionID);
end;

procedure TConferencias.SetConnectionParams;
begin
 //Obtém as informações de configuração em memória sobre conexão do banco de dados.
 try
  if FConnectionPath = '' then
   EDatabaseConnectError.Create(sDatabaseNotFound);

  SQLCon.ConnectionName := 'COSMOS';
  SQLCon.LoadParamsFromIniFile(self.FCosmosFolder + 'dbxconnections.ini');

 except
  raise;
 end;
end;

procedure TConferencias.SQLConAfterConnect(Sender: TObject);
begin
 //Obtém o número de faixa de chaves primárias do banco de dados
 try
  DoExecuteDQL(Format(sSQLGenerators, [sGEN_ACTIVE_RANGE, 0]));
  FActiveRange := SQLSearch.Fields.Fields[0].Value;

 finally
  CloseDataset(SQLSearch);
 end;
end;

procedure TConferencias.SQLMonitorLogTrace(Sender: TObject;
  TraceInfo: TDBXTraceInfo);
begin
 if (SQLMonitor.Active) and (SQLMonitor.TraceCount > FMaxLineTrace) then
  begin
   SQLMonitor.SaveToFile(SQLMonitor.FileName);
   SQLMonitor.TraceList.Clear;
   SQLMonitor.FileName := self.NewSQLMonitorFile;
  end;
end;

procedure TConferencias.SQLSearchAfterOpen(DataSet: TDataSet);
begin
 TCosmosFields.LoadFieldsInfo(Dataset);
end;

class procedure TConferencias.UpdateRegistry(Register: Boolean; const ClassID, ProgID: string);
begin
  if Register then
  begin
    inherited UpdateRegistry(Register, ClassID, ProgID);
    EnableSocketTransport(ClassID);
    EnableWebTransport(ClassID);
  end else
  begin
    DisableSocketTransport(ClassID);
    DisableWebTransport(ClassID);
    inherited UpdateRegistry(Register, ClassID, ProgID);
  end;
end;

function TConferencias.ConnectDatabase(const UserName, Password, RoleName,
  HostName: WideString): OleVariant;
var
FAditionalInfo: TStringList;
AUserManager: TCosmosUsersManager;
AUserData : TCosmosData;
sUserName: string;
vUserStatus: TUserStatus;
AReturn: TServerReturn;
begin
{Este método remoto permite que uma aplicação cliente execute a validação de usuário no
 servidor Firebird. São registradas eventos de log para o sucesso ou erro gerados durante a
 execução deste método.}

 //Cria a classe que retornará dados do método para a aplicação cliente. A Classe
 //recebe valores padrão.
 AReturn := self.CreateMessageData;
 AReturn.SetMessageInfo(miInstallationID, self.ActiveRange);
 AReturn.ServerData := null;

 //Primeiro, checa se o servidor aceita novas conexões.
 try
  if Assigned(FrmMain) then
   begin
    if FrmMain.CManager.Locked then
     raise ELockedServerError.Create(sLogLockedServer);
    end;

  //Descriptografa o login do usuário. Esse dado será usado em seguida.
  sUserName := TDataTransformation.Descriptografar(UserName);
  AReturn.SetMessageInfo(miUserName, sUserName);
  AReturn.SetMessageInfo(miRoleName, RoleName);

  //Agora, verifica o status do usuário...
  vUserStatus :=  self.GetUserStatus(sUserName);

  case vUserStatus of
   usCosmosUser:
    begin
     AReturn.Code := 0;//Usuário registrado do Cosmos.
     AReturn.MessageType := mtpSucess;
     AReturn.MessageText := sSucessfullLogin;
     AReturn.MessageTitle := sTitleAutentication;
     Result := AReturn.ServerReturn;
    end;
   usBlockedUser://É um usuário registrado, porém está bloqueado.
    begin
     AReturn.Code := 3;
     AReturn.MessageType := mtpError;
     AReturn.MessageText := sBlockedUser;
     AReturn.MessageTitle := sTitleInvalidAutentication;
     Result := AReturn.ServerReturn;
     Exit;
    end;
   usSysdba://O usuário é o administrador do SGBD. No Gestor de Secretarias ele não pode trabalhar..
    begin
     AReturn.Code := 4;
     AReturn.MessageType := mtpError;
     AReturn.MessageText := sSysdbaLoginFailure;
     AReturn.MessageTitle := sTitleInvalidAutentication;
     Result := AReturn.ServerReturn;
     Exit;
    end;
   usUnknown://O sistema não pode determinar o status do usuário.
    begin
     AReturn.Code := 5;
     AReturn.MessageType := mtpError;
     AReturn.MessageText := Format(sUnknowUser, ['"'+ sUserName + '"']);
     AReturn.MessageTitle := sTitleInvalidAutentication;
     Result := AReturn.ServerReturn;
     Exit;
    end;
  end;

  if RoleName <> '' then
    FConnectionRole := RoleName;

 //Se chegou aqui, o processo de login vai começar...
  SetConnectionParams; //Configura o objeto de conexão.

  //Conecta com o usuário interno...
  SqlCon.Open;
  if SqlCon.Connected then
   AReturn.Code := 0;


   //Checa se uma conexão pode ser feita. Se o banco estiver esm estado de
   //sincronização, a conexão deverá ser desfeita.
  {*** if IsSyncronizing then
    raise ELockedDatabaseError.Create(sSyncProcessing); ***}

   //Se o login foi feito com sucesso, checa quem é o aluno usuário
   if AReturn.Code = 0 then
    begin
     AUserManager := TCosmosUsersManager.Create;
     AUserData := TCosmosData.Create(20);
     {Atribui os privilégios do perfil do aluno que efetuou o login. A senha é
     ´passada criptografada mesmo.}

     AUserManager.GetUserInfo(TDataTransformation.Descriptografar(UserName), Password, RoleName, AUserData);
    // SetUserInfo(Descriptografar(UserName), Password, RoleName, AUserData);
     AUserData.WriteValue('GROUP', RoleName, 14);

     //Agora, checa se o aluno está ligado ou é um ex-aluno
     if AUserData.FindValue('ATIVO') = False then
      begin
       CreateLog(Format(sInvalidUser, [AUserData.FindValue('USER_NAME')]),EVENTLOG_AUDIT_FAILURE);
       raise EValidateUser.Create(Format(sInvalidUser, [AUserData.FindValue('USER_NAME')]));
      end;

     if (AUserData.FindValue('USER_NAME') = '') then
      raise EUnknownUser.Create(sErroUnknownUser);

    //Agora, verifica se o usuário pode acessar o módulo corrente do Cosmos.
    if not TCosmosMethods.CanAccessModule(AUserData.FindValue('CODUSU'), CurrentCosmosModule) then
     raise ECantAcessCosmosModule.Create(sErroCantAcessCosmosModuel);

    //Finalmente, usuário está autenticado: registra-o e escreve um log do evento
     if AUserData.FindValue('USER_NAME') <> '' then
      begin
       FAditionalInfo := TStringList.Create;
       FAditionalInfo.Add('USER_NAME=' + AUserData.FindValue('USER_NAME'));
       FAditionalInfo.Add('MATRICULA=' + AUserData.FindValue('MATRICULA'));
       FAditionalInfo.Add('FOCO=' + AUserData.FindValue('FOCO'));
       FAditionalInfo.Add('DISCIPULADO=' + AUserData.FindValue('DISCIPULADO'));
       FConnectionID := FrmMain.RegisterConnection(AUserData.FindValue('USER_NAME'), RoleName, HostName,
        FAditionalInfo.CommaText);

       AUserData.WriteValue('CONNECTION_TIME', Now, 15);
       AUserData.WriteValue('CONNECTION_ID', GUIDToString(FConnectionID), 16);
       AUserData.WriteValue('CONNECTION_STATUS', 0, 17);

       AReturn.ServerData := AUserData.XMLData;
       Result := AReturn.ServerReturn;
       CreateLog(Format(sLogCorrectLogin, [AUserData.FindValue('USER_NAME'), RoleName]),EVENTLOG_AUDIT_SUCCESS);
      end;

     FConnectedUser.LoadInfo(AUserData);
    end;

  except
   on E: ELockedDatabaseError do //Banco de dados está bloqueado pela sincronização.
    begin
     SQLCon.Close;
     AReturn.Code := 6;
     AReturn.MessageType := mtpError;
     AReturn.MessageText := E.Message;
     AReturn.MessageTitle := sTitleCanceledAutentication;
     AReturn.SetMessageInfo(miInnerMessage, E.Message);
     Result := AReturn.ServerReturn;
     CreateLog(E.Message, EVENTLOG_AUDIT_FAILURE);
    end;
   on E: EDatabaseError do //Erro ocorrido durante tentativa de login
    begin
     AReturn.Code := 7;
     AReturn.MessageType := mtpError;
     AReturn.MessageText := Format(sLogIncorrectLogin, [sUserName, E.Message]);
     AReturn.MessageTitle := sTitleCanceledAutentication;
     AReturn.SetMessageInfo(miInnerMessage, E.Message);
     Result := AReturn.ServerReturn;
     CreateLog(Format(sLogIncorrectLogin, [sUserName, E.Message]),EVENTLOG_AUDIT_FAILURE);
    end;
   on E: EIncorrectRoleAcess do //Usuário não é da role passada
    begin
     AReturn.Code := 8;
     AReturn.MessageType := mtpError;
     AReturn.MessageText := Format(sLogIcorrectRole, [sUserName, RoleName]);
     AReturn.MessageTitle := sTitleInvalidAutentication;
     AReturn.SetMessageInfo(miInnerMessage, E.Message);
     Result := AReturn.ServerReturn;
     CreateLog(Format(sLogIcorrectRole, [sUserName, RoleName]),EVENTLOG_AUDIT_FAILURE);
    end;
   on E: ELockedServerError do //Servidor está indisponível para novas conexões
    begin
     AReturn.Code := 9;
     AReturn.MessageType := mtpError;
     AReturn.MessageText := sLogLockedServer;
     AReturn.MessageTitle := sTitleCanceledAutentication;
     AReturn.SetMessageInfo(miInnerMessage, E.Message);
     Result := AReturn.ServerReturn;
     CreateLog(sLogLockedServer,EVENTLOG_AUDIT_FAILURE);
    end;
   on E: ECosmosSystemFailure do //Falha de sistema genérica...
    begin
     AReturn.Code := 10;
     AReturn.MessageType := mtpError;
     AReturn.MessageText := E.Message;
     AReturn.MessageTitle := sTitleErrorAutentication;
     AReturn.SetMessageInfo(miInnerMessage, E.Message);
     Result := AReturn.ServerReturn;
     CreateLog(E.Message,EVENTLOG_ERROR_TYPE);
    end;
   on E: EValidateUser do //Dados fornecidos pelo usuário estão incorretos...
    begin
     AReturn.Code := 11;
     AReturn.MessageType := mtpError;
     AReturn.MessageText := sLoginFailure;
     AReturn.MessageTitle := sTitleInvalidAutentication;
     AReturn.SetMessageInfo(miInnerMessage, E.Message);
     Result := AReturn.ServerReturn;
     CreateLog(E.Message, EVENTLOG_AUDIT_FAILURE);
    end;
   on E: EUnknownUser do //Não encontrou o usuário na tabela de usuários...
    begin
     AReturn.Code := 12;
     AReturn.MessageType := mtpError;
     AReturn.MessageText := sLoginFailure;
     AReturn.MessageTitle := sTitleInvalidAutentication;
     AReturn.SetMessageInfo(miInnerMessage, E.Message);
     Result := AReturn.ServerReturn;
     CreateLog(E.Message, EVENTLOG_AUDIT_FAILURE);
    end;
   on E: ECantAcessCosmosModule do //Usuário não pdoe acessar o módulo do Cosmos.
    begin
     AReturn.Code := 13;
     AReturn.MessageType := mtpError;
     AReturn.MessageText := E.Message;
     AReturn.MessageTitle := sTitlePermissoes;
     AReturn.SetMessageInfo(miInnerMessage, E.Message + ' : ' + sUserName);
     Result := AReturn.ServerReturn;
     CreateLog(E.Message + ' : ' + sUserName, EVENTLOG_AUDIT_FAILURE);
    end;
   on E: TDBXError do //Falha de sistema relacionada a banco de dados...
    begin
      if Pos('password', E.Message) > 0 then //Login ou senha inválidos.
       begin
        AReturn.Code := 14;
        AReturn.MessageType := mtpError;
        AReturn.MessageText := sLoginFailure;
        AReturn.MessageTitle := sTitleInvalidAutentication;
        AReturn.SetMessageInfo(miInnerMessage, E.Message);
        Result := AReturn.ServerReturn;
        CreateLog(E.Message, EVENTLOG_AUDIT_FAILURE);
       end
      else
       begin
        AReturn.Code := 15; //Erro desconhecido...
        AReturn.MessageType := mtpError;
        AReturn.MessageText := sErrorCosmosSystem;
        AReturn.MessageTitle := sTitleErrorAutentication;
        AReturn.SetMessageInfo(miInnerMessage, E.Message);
        Result := AReturn.ServerReturn;
        CreateLog(E.Message,EVENTLOG_ERROR_TYPE);
       end;
    end;
  end;
end;

procedure TConferencias.BufferData(const SchemmaName: WideString;
  out DataPackage: OleVariant);
var
TD: TDBXTransaction;
AServer: TSQLServerTransactionsManager;
begin
//Bufferiza um pacote de dados no formato olevariant que é envidao para o cliente.
 AServer := TSQLServerTransactionsManager.Create;

 try
  TD := AServer.BeginTransaction(SQLCon);
  SQLSearch.CommandText := Format(sSQLBufferSchemma, [SchemmaName]);
  DataPackage := DspSearch.Data;

 finally
  AServer.CommitTransaction(SQLCon, TD);
  if Assigned(AServer) then
   FreeAndNil(AServer);
 end;
end;

function TConferencias.Get_BetaVersion: OleVariant;
begin
 Result := False;
end;

function TConferencias.Get_ActiveUser: OleVariant;
begin
//Retorna o nome do usuário ativo, caso exista um
 if SQLCon.Connected then
  Result := SqlCon.Params.values['user_name']
 else
  Result := Null; //Retorna um ponteiro nulo
end;

function TConferencias.Get_CodeKey: OleVariant;
var
AReturn: TServerReturn;
begin
//Lê a chave dinâmica para operação de criptografia e descriptografia.
 AReturn := self.CreateMessageData;

 try
  AReturn.Code := 0;
  AReturn.ServerData := FCodeKey;
  Result := AReturn.ServerReturn;

  if Assigned(AReturn) then
   FreeAndNil(AReturn);

 except
  on E: Exception do
   begin
    if Assigned(AReturn) then
     begin
      AReturn.Code := -1;
      AReturn.ServerData := '';
      AReturn.MessageType := mtpError;
      AReturn.MessageText := sErrorGetCodeKey;
      AReturn.MessageTitle := sTitleServerConection;
      AReturn.SetMessageInfo(miInnerMessage, E.Message);
      Result := AReturn.ServerReturn;
      AReturn.Free;
     end;

    self.CreateLog(E.Message, EVENTLOG_ERROR_TYPE);
   end;
 end;
end;

function TConferencias.Get_ServerComputer: OleVariant;
var
AReturn: TServerReturn;
begin
//Retorna o nome do computador no qual a aplicação servidora está rodando
 AReturn := self.CreateMessageData;

 try
  AReturn.Code := 0;
  AReturn.ServerData := TWinShell.GetComputerName;
  Result := AReturn.ServerReturn;

 except
  on E: Exception do
   begin
    if Assigned(AReturn) then
     begin
      AReturn.Code := -1;
      AReturn.ServerData := '';
      AReturn.MessageType := mtpError;
      AReturn.MessageText := sErrorGetServerName;
      AReturn.MessageTitle := sTitleSystemFailure;
      Result := AReturn.ServerReturn;
      AReturn.Free;
     end;

    self.CreateLog(E.Message, EVENTLOG_ERROR_TYPE);
   end;
 end;
end;

function TConferencias.Get_ServerDateTime: OleVariant;
var
AReturn: TServerReturn;
begin
 //Retorna a data e hora no servidor.
 AReturn := self.CreateMessageData;

 try
  AReturn.ServerData := TCosmosMethods.GetServerDateTime;
  Result := AReturn.ServerReturn;
  if Assigned(AReturn) then AReturn.Free;


 except
  on E: Exception do
   begin
    AReturn.Code := -1;
    AReturn.MessageType := mtpError;
    AReturn.MessageText := sErrorGetServerDateTime;
    AReturn.MessageTitle := sTitleServerDateTime;
    AReturn.ServerData := unassigned;
    Result := AReturn.ServerReturn;
    if Assigned(AReturn) then AReturn.Free;

    CreateLog(E.Message, EVENTLOG_ERROR_TYPE);
   end;
 end;
end;

function TConferencias.Get_DatabaseVersion: OleVariant;
var
AReturn: TServerReturn;
begin
//Obtém a versão do banco de dados
 AReturn := self.CreateMessageData;

 try
  CloseDataset(SQLSearch);
  self.DoExecuteDQL(Format(sSQLGenerators, [sGEN_DBVERSION,0]));
  AReturn.ServerData := SQLSearch.Fields.Fields[0].AsInteger;
  CloseDataset(SQLSearch);
  Result := AReturn.ServerReturn;

  if Assigned(AReturn) then
   FreeAndNil(AReturn);

 except
  on E: Exception do
   begin
    AReturn.Code := -1;
    AReturn.MessageType := mtpError;
    AReturn.MessageText := sErrorSelectData;
    AReturn.MessageTitle := sTitleErrorSelectData;
    AReturn.ServerData := unassigned;
    Result := AReturn.ServerReturn;
    if Assigned(AReturn) then AReturn.Free;

    CreateLog(E.Message, EVENTLOG_ERROR_TYPE);
   end;
 end;
end;

function TConferencias.GetPerfilData: OleVariant;
var
AReturn: TServerReturn;
begin
//Este método retorna o perfil do usuário logado
 AReturn := TServerReturn.Create;

 try
  if SQLCon.Connected then
   begin
    AReturn.ServerData := 'user_name=' + SQLCon.Params.Values['User_Name'];
    AReturn.ServerData := AReturn.ServerData + ';' + 'role_name=' + SQLCon.Params.Values['RoleName'];
    Result := AReturn.ServerReturn;
   end;

 finally
  if Assigned(AReturn) then
   AReturn.Free;
 end;
end;

function TConferencias.IsAdministrator(const UserName: WideString): OleVariant;
var
AReturn: TServerReturn;
begin
//Checa se um usuário é um administrador do sistema.
 AReturn := self.CreateMessageData;

 try
  AReturn.ServerData := TCosmosMethods.IsAdministrator(UserName);
  Result := AReturn.ServerReturn;

 finally
  if Assigned(AReturn) then
   AReturn.Free;
 end;
end;

function TConferencias.ExecuteDQL(SearchID: Integer; Params: OleVariant): OleVariant;
var
AReturn: TServerReturn;
ACosmosSearch: TCosmosSearch;
ACommand: string;
begin
//Executa uma pesquisa padrão do Cosmos.
 ACosmosSearch :=  TSQLServerInterface.GetCosmosSearch(SearchID);
 ACommand := TSQLCommandsFactory.GetSQLCommand(ACosmosSearch);
 TSQLCommandsFactory.CreateCommandText(ACommand, Params);

 AReturn := self.CreateMessageData;

 try
  //Executa o comando DQL...
  self.DoExecuteDQL(ACommand);
  AReturn.ServerData := DspSearch.Data;
  Result := AReturn.ServerReturn;
  CloseDataset(SQLSearch);

 except
  on E: Exception do
   begin
    AReturn.Code := -1;
    AReturn.MessageType := mtpError;
    AReturn.MessageText := sErrorSelectData;
    AReturn.MessageTitle := sTitleErrorSelectData;
    AReturn.ServerData := unassigned;
    Result := AReturn.ServerReturn;
    CloseDataset(SQLSearch);
    CreateLog(E.Message, EVENTLOG_ERROR_TYPE);
   end;
 end;
end;

function TConferencias.GetAcessedFocus(const UserName: WideString): OleVariant;
var
AReturn: TServerReturn;
ADataset: TClientDataset;
begin
//Retorna os focos que o usuário passado em parâmetro pode acessar
 AReturn := self.CreateMessageData;
 ADataset := TClientDataset.Create(nil);

 try
  ADataset.Data := TCosmosMethods.GetAcessedFocus(UserName, cmConferencias);

  case ADataset.RecordCount of
   0:  //Nenhum foco pode ser acessado pelo usuário
     begin
      AReturn.Code := 0;
      AReturn.MessageType := mtpInformation;
      AReturn.MessageTitle := sTitleOpenFocus;
      AReturn.MessageText := sInfoNoFocusAcess;
     end;
   1:   //Apenas um foco pode ser acessado pelo usuário
     begin
      AReturn.Code := 1;
      AReturn.ServerData := ADataset.Data;
     end
   else //Mais de um foco pode ser acessado pelo usuário
     begin
      AReturn.Code := 2;
      AReturn.ServerData := ADataset.Data;
     end;
  end;


  Result := AReturn.ServerReturn;
  if Assigned(ADataset) then FreeAndNil(ADataset);
  if Assigned(AReturn) then FreeAndNil(AReturn);

 except
  on E: Exception do
   begin
    CloseDataset(SQLSearch);
    AReturn.Code := -1;
    AReturn.MessageType := mtpError;
    AReturn.MessageText := sErrorOpenFocus;
    AReturn.MessageTitle := sTitleOpenFocus;
    AReturn.SetMessageInfo(miInnerMessage, E.Message);
    AReturn.ServerData := unassigned;
    Result := AReturn.ServerReturn;
    if Assigned(ADataset) then FreeAndNil(ADataset);
    if Assigned(AReturn) then FreeAndNil(AReturn);

    CreateLog(E.Message, EVENTLOG_ERROR_TYPE);
   end;
 end;
end;

function TConferencias.GetSequenceValue(
  const SequenceName: WideString): OleVariant;
var
TD: TDBXTransaction;
ASQLServer: TSQLServerTransactionsManager;
AReturn: TServerReturn;
begin
 //Obtém o valor atual de uma sequence a partir do nome da sequence e da faixa
 //de chaves primárias.
 CloseDataset(SQLSearch);
 AReturn := self.CreateMessageData;
 ASQLServer := TSQLServerTransactionsManager.Create;

 try
  TD := ASQLServer.BeginTransaction(SQLCon, TDBXIsolations.ReadCommitted);
  DoExecuteDQL(Format(sSQLGenerators, [SequenceName, 1]));

  AReturn.Code := 0;
  AReturn.ServerData := SQLSearch.Fields.Fields[0].Value + ActiveRange;
  Result := AReturn.ServerReturn;

  CloseDataset(SQLSearch);
  ASQLServer.CommitTransaction(SQLCon, TD);

  if Assigned(AReturn) then
   AReturn.Free;

  if Assigned(ASQLServer) then
   ASQLServer.Free;

 except
  on E: Exception do
   begin
    AReturn.Code := -1;
    AReturn.MessageType := mtpError;
    AReturn.MessageText := sErrorSelectSequenceData;
    AReturn.MessageTitle := sTitleErrorSelectData;
    AReturn.SetMessageInfo(miInnerMessage, E.Message);
    Result := AReturn.ServerReturn;

    CloseDataset(SQLSearch);
    ASQLServer.RollbackTransaction(SQLCon, TD);

    if Assigned(AReturn) then AReturn.Free;
    if Assigned(ASQLServer) then ASQLServer.Free;

    self.CreateLog(E.Message, EVENTLOG_ERROR_TYPE);
   end;
 end;
end;

function TConferencias.GetDatasetCommand(Dataset: TCustomSQLDataSet): string;
var
I: integer;
sParamValue: string;
begin
//Retorna uma string que representa o camando executado por um dataset.
 if Dataset <> nil then
  begin
   if Dataset is TSQLDataset then
    Result := TSQLDataset(Dataset).CommandText else
   if Dataset is TSQLQuery then
    Result := TSQLQUery(Dataset).CommandText else
   if Dataset is TSQLStoredProc then
    begin
     Result := Format('exec %s ', [TSQLStoredProc(Dataset).StoredProcName]);
     Result := Result + '(%s)';

     for I := 0 to TSQLStoredProc(Dataset).Params.Count - 1 do
       begin
        sParamValue := sParamValue +  TSQLStoredProc(Dataset).Params.Items[I].Text;
        if I <=  Pred(TSQLStoredProc(Dataset).Params.Count) then
         sParamValue := sParamValue + ', ';
       end;

     Result := Format(Result, [sParamValue]);
    end;
  end;
end;

function TConferencias.GetLastUpdateError: OleVariant;
begin
 {Retorna a última mensagem de erro de atualizaão de dados. Neste caso, não é
 necessário criar uma estrutura de retorno usando a classe TServerReturn.}
 Result := FLastUpdateError;
end;

function TConferencias.DeleteAttribute(codatr: Integer): OleVariant;
var
AReturn: TServerReturn;
ACommand: TSQLServerCommand;
begin
{Exclui um atributo, se possível.}
 AReturn := self.CreateMessageData;
 ACommand := TSQLServerCommand.Create;

 try
  self.DoExecuteDQL(Format(sSQLCountAttributes, [codatr, codatr]));
  if SQLSearch.IsEmpty then
   begin
    AReturn.Code := 0;
    ACommand.ExecuteCommand(Format(sSQLDelAttribute, [codatr]));
   end
  else
   begin
    AReturn.Code := 1;
    AReturn.MessageType := mtpInformation;
    AReturn.MessageTitle := sTitleClassificadores;
    AReturn.MessageText := sInfoCantDeleteClassificador;
   end;


  Result := AReturn.ServerReturn;
  CloseDataset(SQLSearch);
  if Assigned(ACommand) then FreeAndNil(ACommand);


 except
  on E: EXception do
   begin
    AReturn.Code := -1;
    AReturn.MessageType := mtpError;
    AReturn.MessageTitle := sTitleClassificadores;
    AReturn.MessageText := sErrorDelAttribute;
    AReturn.SetMessageInfo(miInnerMessage, E.Message);
    Result := AReturn.ServerReturn;
    CloseDataset(SQLSearch);
    if Assigned(ACommand) then FreeAndNil(ACommand);
   end;
 end;
end;

function TConferencias.GetTableProviderName(Table: Integer): OleVariant;
var
AReturn: TServerReturn;
begin
//Retorna o nome de um TDatasetProvider que retorna os dados de uma tabela acessória.
 AReturn := self.CreateMessageData;

 try
  case TCosmosTables(Table) of
   ctAptidoes: AReturn.ServerData := 'DspAptidoes';
   ctCargos: AReturn.ServerData := 'DspCargos';
   ctEnfermidades: AReturn.ServerData := 'DspEnfermidades';
   ctFuncoes: AReturn.ServerData := 'DspFuncoes';
   ctMeiosContatos: AReturn.ServerData := 'DspMeiosContato';
   ctProfissoes: AReturn.ServerData := 'DspProfissoes';
   ctTiposRecebimentos: AReturn.ServerData := 'DspTiposRecebimentos';
   ctFlagsInscricao: AReturn.ServerData := 'DspFlagsInscricoes';
  end;

 finally
  Result := AReturn.ServerReturn;
  if Assigned(AReturn) then
   AReturn.Free;
 end;
end;

function TConferencias.Get_ActiveRange: OleVariant;
var
AReturn: TServerReturn;
begin
 AReturn := self.CreateMessageData;

 try
  AReturn.Code := 0;
  AReturn.ServerData := self.FActiveRange;
  Result := AReturn.ServerReturn;

 except
  on E: Exception do
   begin
    AReturn.Code := -1;
    AReturn.MessageType := mtpError;
    AReturn.MessageText := sErrorSelectData;
    AReturn.MessageTitle := sTitleSincronizador;
    AReturn.SetMessageInfo(miInstallationID, self.FActiveRange);
    AReturn.SetMessageInfo(miInnerMessage, E.Message);
    Result := AReturn.ServerReturn;

    if Assigned(AReturn) then AReturn.Free;

    CreateLog(E.Message, EVENTLOG_ERROR_TYPE);
   end;
 end;
end;

function TConferencias.ManterAreaStaff(Params: OleVariant; Operation: Integer): OleVariant;
var
AReturn: TServerReturn;
sSQL: string;
ACommand: TSQLServerCommand;
CanExecute: boolean;
begin
 AReturn := self.CreateMessageData;
 ACommand := TSQLServerCommand.Create;

 try
  AReturn.Code := 0;
  AReturn.MessageType := mtpSucess;

  case TDatabaseOperation(Operation) of
   doInsert: sSQL := sSQLInsAreaStaff;
   doUpdate: sSQL := sSQLUpdAreaStaff;
   doDelete: sSQL := sSQLDelAreaStaff;
  end;

  TSQLCommandsFactory.CreateCommandText(sSQL, Params);

  if TDatabaseOperation(Operation) = doDelete then
   begin
    CanExecute := CanDeleteAreaStaff(Params[0]);
    if not CanExecute then
     begin
       AReturn.Code := 1;
       AReturn.MessageType := mtpInformation;
       AReturn.MessageText := sInfoDelAreaStaff;
     end;

   end;

  if CanExecute then
   ACommand.ExecuteCommand(sSQL);

  Result := AReturn.ServerReturn;
  if Assigned(ACommand) then FreeAndNil(ACommand);


 except
  on E: Exception do
   begin
    AReturn.Code := -1;
    AReturn.MessageType := mtpError;
    AReturn.MessageText := sErrorSelectData;
    AReturn.MessageTitle := sTitleAreasStaff;
    AReturn.SetMessageInfo(miInstallationID, self.FActiveRange);
    AReturn.SetMessageInfo(miInnerMessage, E.Message);
    Result := AReturn.ServerReturn;

    if Assigned(AReturn) then AReturn.Free;
    if Assigned(ACommand) then FreeAndNil(ACommand);

    CreateLog(E.Message, EVENTLOG_ERROR_TYPE);
   end;
 end;
end;

function TConferencias.ExecuteCommand(CommandID: Integer; Params: OleVariant): OleVariant;
var
AReturn: TServerReturn;
ACosmosCommand: TCosmosCommand;
ACommand: string;
begin
 //Executa um command DML simples (uma linha) no servidor SQL.
 ACosmosCommand :=  TSQLServerInterface.GetCosmosCommand(CommandID);
 ACommand := TSQLCommandsFactory.GetDMLCommand(ACosmosCommand);

 if ACommand = '' then
  raise EUnknownCommandError.Create(sErrorUnknownCommand);

 //Preenche os valores dos parâmetros recebidos.
 TSQLCommandsFactory.CreateCommandText(ACommand, Params);

 AReturn := self.CreateMessageData;

 try
  if DoExecuteCommand(ACommand) > 0 then
   begin
    AReturn.Code := 0;
    AReturn.ServerData := True;
   end;

  Result := AReturn.ServerReturn;

 except
  on E: Exception do
   begin
    AReturn.Code := -1;
    AReturn.MessageType := mtpError;
    AReturn.MessageText := sErrorExecuteDML;
    AReturn.MessageTitle := sTitleExecuteDML;
    AReturn.SetMessageInfo(miInnerMessage, E.Message);
    Result := AReturn.ServerReturn;

    if Assigned(AReturn) then AReturn.Free;

    CreateLog(E.Message, EVENTLOG_ERROR_TYPE);
   end;
 end;
end;

function TConferencias.DeleteInfoInscricao(codfla, codite: Integer): OleVariant;
var
AReturn: TServerReturn;
begin
{Exclui um item de detalhamento de inscrição, se possível.}
 AReturn := self.CreateMessageData;

 try
  self.DoExecuteDQL(Format(sSQLCountInfoInscricao, [codfla]));
  if SQLSearch.Fields.Fields[0].AsInteger = 0 then
   begin
    AReturn.Code := 0;
    self.DoExecuteCommand(Format(sSQLDelItensInscricao, [codite]));
   end
  else
   begin
    AReturn.Code := 1;
    AReturn.MessageType := mtpInformation;
    AReturn.MessageTitle := sTitleInscricoesConferencia;
    AReturn.MessageText := sInfoCantDeleteFlagInscricoes;
   end;

  Result := AReturn.ServerReturn;

 except
  on E: Exception do
   begin
    AReturn.Code := -1;
    AReturn.MessageType := mtpError;
    AReturn.MessageTitle := sTitleInscricoesConferencia;
    AReturn.MessageText := sErrorDelFlagInscricao;
    AReturn.SetMessageInfo(miInnerMessage, E.Message);
    Result := AReturn.ServerReturn;
   end;
 end;

end;

function TConferencias.CancelarInscricao(codins: Integer): OleVariant;
var
AReturn: TServerReturn;
codcad, codcon: integer;
begin
{Exclui um item de detalhamento de inscrição, se possível.}
 AReturn := self.CreateMessageData;

 try
  self.DoExecuteDQL(Format(sSQLInfoInscricao, [codins]));
  if not SQLSearch.IsEmpty then
   begin
    codcad := SQLSearch.FieldValues['codcad'];
    codcon := SQLSearch.FieldValues['codcon'];
    CloseDataset(SQLSearch);

    self.DoExecuteDQL(Format(sSQLCountFrequenciaInscrito, [codcon, codcad]));
    if SQLSearch.Fields.Fields[0].AsInteger = 0 then
     begin
      AReturn.Code := 0;
      self.DoExecuteCommand(Format(sSQLDelInscrito, [codins]));
     end
    else
     begin
      AReturn.Code := 1;
      AReturn.MessageType := mtpError;
      AReturn.MessageTitle := sTitleInscricoesConferencia;
      AReturn.MessageText := sInfoCannotDelInscrito;
     end;
   end;

  CloseDataset(SQLSearch);
  Result := AReturn.ServerReturn;

 except
  on E: Exception do
   begin
    AReturn.Code := -1;
    AReturn.MessageType := mtpError;
    AReturn.MessageTitle := sTitleInscricoesConferencia;
    AReturn.MessageText := sErrorCancelarInscricao;
    AReturn.SetMessageInfo(miInnerMessage, E.Message);
    Result := AReturn.ServerReturn;
   end;
 end;
end;


function TConferencias.ExecuteRegisteredSearch(SearchId: Integer; Params: OleVariant): OleVariant;
var
AReturn: TServerReturn;
ACommand: string;
begin
//Executa uma pesquisa existente na tabela da Central de Pesquisas.
 ACommand := TCosmosDataObjects.GetRegisteredCommand(SearchID);
 TSQLCommandsFactory.CreateCommandText(ACommand, Params);
 AReturn := self.CreateMessageData;

 try
  //Executa o comando DQL...
  self.DoExecuteDQL(ACommand);
  AReturn.ServerData := DspSearch.Data;
  Result := AReturn.ServerReturn;
  CloseDataset(SQLSearch);

 except
  on E: Exception do
   begin
    AReturn.Code := -1;
    AReturn.MessageType := mtpError;
    AReturn.MessageText := sErrorSelectData;
    AReturn.MessageTitle := sTitleErrorSelectData;
    AReturn.SetMessageInfo(miInnerMessage, E.Message);
    AReturn.ServerData := unassigned;
    Result := AReturn.ServerReturn;
    CloseDataset(SQLSearch);
    CreateLog(E.Message, EVENTLOG_ERROR_TYPE);
   end;
 end;
end;

function TConferencias.GetCosmosSearchsInfo: OleVariant;
var
AReturn: TServerReturn;
begin
{Retorna para o cliente o caminho de um arquivo XML com as configurações das
 pesquisas que podem ser executadas por meio da ferramenta "Central de Relatórios.}

 AReturn := self.CreateMessageData;

 try
  AReturn.ServerData := TCosmosMethods.GetCosmosSearchs;
  Result := AReturn.ServerReturn;

 except
  on E: Exception do
   begin
    AReturn.Code := -1;
    AReturn.MessageType := mtpError;
    AReturn.MessageText := sErrorGetCommand;
    AReturn.MessageTitle := sTitleGetCommands;
    AReturn.SetMessageInfo(miInnerMessage, E.Message);
    Result := AReturn.ServerReturn;

    if Assigned(AReturn) then AReturn.Free;

    CreateLog(E.Message, EVENTLOG_ERROR_TYPE);
   end;
 end;
end;

function TConferencias.GetCurrentCosmosModule: TCosmosModules;
begin
 Result := cmConferencias;
end;

function TConferencias.DesalojarInscrito(Inscrito: Integer): OleVariant;
var
ACommand: string;
AReturn: TServerReturn;
begin
{Desaloja um inscrito do seu leito atual.}
 ACommand := Format(sUpdDesalojaInscrito, [Inscrito]);
 AReturn := self.CreateMessageData;

 try
  DoExecuteCommand(ACommand);
  Result := AReturn.ServerReturn;

 except
  on E: Exception do
   begin
    AReturn.Code := -1;
    AReturn.MessageType := mtpError;
    AReturn.MessageText := sErrorExecuteDML;
    AReturn.MessageTitle := sTitleAlojamentos;
    AReturn.SetMessageInfo(miInnerMessage, E.Message);
    Result := AReturn.ServerReturn;

    if Assigned(AReturn) then AReturn.Free;

    CreateLog(E.Message, EVENTLOG_ERROR_TYPE);
   end;
 end;
end;



initialization
  TComponentFactory.Create(ComServer, TConferencias,
    Class_Conferencias, ciMultiInstance, tmApartment);
end.
