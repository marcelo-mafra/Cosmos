unit cosmos.servers.secretarias.atividades.methods;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.StrUtils, System.Classes,
  System.Json, Datasnap.DSServer, DataSnap.DSProviderDataModuleAdapter,
  Datasnap.DSAuth, DBClient, DB, SqlExpr, FMTBcd, cosmos.classes.application,
  System.Variants, Datasnap.Provider, cosmos.system.exceptions, Data.dbxCommon,
  cosmos.system.messages, cosmos.servers.sqlcommands, cosmos.classes.ServerInterface,
  System.WideStrings, DataSnap.DsSession, cosmos.classes.logs, cosmos.classes.cosmoscript;

type
  TDMSecAtividadesServerMethods = class(TDSServerModule)
    SQLAgenda: TSQLDataSet;
    DspAgenda: TDataSetProvider;
    SQLTiposAtividades: TSQLDataSet;
    DspTiposAtividades: TDataSetProvider;
    SQLLivrosEI: TSQLDataSet;
    DspLivrosEI: TDataSetProvider;
    SQLLivrosEICODLIV: TIntegerField;
    SQLLivrosEINOMLIV: TStringField;
    SQLLivrosEICODDIS: TIntegerField;
    SQLLivrosEIORDLIV: TSmallintField;
    SQLLivrosEINOTLIV: TMemoField;
    SQLLicoesEI: TSQLDataSet;
    DspLicoesEI: TDataSetProvider;
    SQLLicoesEICODLIC: TIntegerField;
    SQLLicoesEINOMLIC: TStringField;
    SQLLicoesEICODLIV: TIntegerField;
    SQLLicoesEIORDLIC: TSmallintField;
    SQLLicoesEINOTLIC: TMemoField;
    SQLLicoesEITITLIC: TStringField;
    SQLAlocucoes: TSQLDataSet;
    DspAlocucoes: TDataSetProvider;
    SQLAlocucoesCODALO: TIntegerField;
    SQLAlocucoesTITALO: TStringField;
    SQLAlocucoesNOMAUT: TStringField;
    SQLAlocucao: TSQLDataSet;
    SQLAlocucaoCODALO: TIntegerField;
    SQLAlocucaoTITALO: TStringField;
    SQLAlocucaoFRAALO: TStringField;
    SQLAlocucaoNOMAUT: TStringField;
    SQLAlocucaoNOTALO: TMemoField;
    DspAlocucao: TDataSetProvider;
    SQLAlocucaoINDLEC: TStringField;
    SQLAlocucaoINDTMO: TStringField;
    SQLAlocucaoINDTMB: TStringField;
    SQLAlocucaoINDTPU: TStringField;
    SQLAlocucoesDATATI: TDateField;
    SQLAtividadesTurmasTP: TSQLDataSet;
    DspAtividadesTurmasTP: TDataSetProvider;
    SQLAtividadesTurmasTPCODATI: TIntegerField;
    SQLAtividadesTurmasTPCODTIPATI: TIntegerField;
    SQLAtividadesTurmasTPDESTIPATI: TStringField;
    SQLAtividadesTurmasTPDATATI: TDateField;
    SQLAtividadesTurmasTPHORATI: TTimeField;
    SQLAtividadesTurmasTPNUMTEM: TSmallintField;
    SQLCirculosEI: TSQLDataSet;
    DspCirculosEI: TDataSetProvider;
    SQLCirculosEICODGRU: TIntegerField;
    SQLCirculosEINOMGRU: TStringField;
    SQLCirculosEISIGDIS: TStringField;
    SQLCirculosEINOMLIV: TStringField;
    SQLCirculosEINOMLIC: TStringField;
    DspMembrosCirculo: TDataSetProvider;
    SQLMembrosCirculo: TSQLDataSet;
    SQLMembrosCirculoCODMEM: TIntegerField;
    SQLMembrosCirculoCODGRU: TIntegerField;
    SQLMembrosCirculoCODCAD: TIntegerField;
    SQLMembrosCirculoMATCAD: TStringField;
    SQLMembrosCirculoNOMCAD: TStringField;
    SQLMembrosCirculoINDCON: TStringField;
    SQLDadosCirculo: TSQLDataSet;
    DspDadosCirculo: TDataSetProvider;
    SQLDadosCirculoCODGRU: TIntegerField;
    SQLDadosCirculoNOMGRU: TStringField;
    SQLDadosCirculoCODLIC: TIntegerField;
    SQLDadosCirculoNOMLIC: TStringField;
    SQLDadosCirculoSENCON: TStringField;
    SQLDadosCirculoCODSAC: TIntegerField;
    SQLDadosCirculoNOMSAC: TStringField;
    SQLDadosCirculoCODSAZ: TIntegerField;
    SQLDadosCirculoNOMSAZ: TStringField;
    SQLDadosCirculoDATCAD: TSQLTimeStampField;
    SQLDadosCirculoUSURES: TStringField;
    DspAluno: TDataSetProvider;
    SQLAluno: TSQLDataSet;
    SQLAlunoCODCAD: TIntegerField;
    SQLAlunoMATCAD: TStringField;
    SQLAlunoNOMCAD: TStringField;
    SQLAlunoAPECAD: TStringField;
    SQLAlunoSEXCAD: TStringField;
    SQLAlunoDATNAS: TDateField;
    SQLAlunoNACCAD: TStringField;
    SQLAlunoDOCIDE: TStringField;
    SQLAlunoORGEXP: TStringField;
    SQLAlunoESTCIV: TStringField;
    SQLAlunoFOTCAD: TGraphicField;
    SQLAlunoCODPRO: TIntegerField;
    SQLAlunoDESPRO: TStringField;
    SQLAlunoCODFOC: TIntegerField;
    SQLAlunoCODDIS: TIntegerField;
    SQLAlunoSIGDIS: TStringField;
    SQLAlunoCADTIT: TIntegerField;
    SQLAlunoINDEXTNUC: TStringField;
    SQLAlunoINDGRUJOV: TStringField;
    SQLAlunoINDLIGROZ: TStringField;
    SQLAlunoINDATI: TStringField;
    SQLAlunoINDFRE: TStringField;
    SQLAlunoINDMEN: TStringField;
    SQLAlunoVALMEN: TFMTBCDField;
    SQLAlunoVALTAX: TFMTBCDField;
    SQLAlunoDATOBI: TDateField;
    SQLAlunoOBSCAD: TMemoField;
    SQLAlunoUSURES: TStringField;
    SQLAlunoDATCAD: TSQLTimeStampField;
    SQLAlunoNOMTIT: TStringField;
    SQLAlunoINDLIC: TStringField;
    SQLFuncoesCadastrado: TSQLDataSet;
    DspFuncoesCadastrado: TDataSetProvider;
    SQLFuncoesCadastradoCODFUNCAD: TIntegerField;
    SQLFuncoesCadastradoCODCAD: TIntegerField;
    SQLFuncoesCadastradoUSURES: TStringField;
    SQLFuncoesCadastradoDATCAD: TSQLTimeStampField;
    DspDispensas: TDataSetProvider;
    SQLDispensas: TSQLDataSet;
    SQLDispensasCODDIS: TIntegerField;
    SQLDispensasCODCAD: TIntegerField;
    SQLDispensasINIDIS: TDateField;
    SQLDispensasTERDIS: TDateField;
    SQLDispensasDATCAD: TSQLTimeStampField;
    SQLDispensasUSURES: TStringField;
    SQLTarefas: TSQLDataSet;
    DspTarefas: TDataSetProvider;
    SQLAgendaCODATI: TIntegerField;
    SQLAgendaCODTIPATI: TIntegerField;
    SQLAgendaDESTIPATI: TStringField;
    SQLAgendaDATATI: TDateField;
    SQLAgendaHORATI: TTimeField;
    SQLAgendaINDFRE: TStringField;
    SQLAgendaCODFOC: TIntegerField;
    SQLAtividadeLEC: TSQLDataSet;
    DspAtividadeLEC: TDataSetProvider;
    SQLAtividadeLECCODATI: TIntegerField;
    SQLAtividadeLECCODTIPATI: TIntegerField;
    SQLAtividadeLECDESTIPATI: TStringField;
    SQLAtividadeLECCODFOC: TIntegerField;
    SQLAtividadeLECDATATI: TDateField;
    SQLAtividadeLECHORATI: TTimeField;
    SQLAtividadeLECLOCATI: TStringField;
    SQLAtividadeLECINDFRE: TStringField;
    SQLAtividadeLECCODALO: TIntegerField;
    SQLAtividadeLECTITALO: TStringField;
    SQLAtividadeLECINDJAL: TStringField;
    SQLAtividadeLECINDLIS: TStringField;
    SQLAtividadeLECOBSATI: TMemoField;
    SQLAtividadeLECUSURES: TStringField;
    SQLAtividadeLECDATCAD: TSQLTimeStampField;
    SQLAtividadeLECCAMPRO: TStringField;
    SQLAgendaCAMPRO: TStringField;
    SQLAgendaSIGFOC: TStringField;
    SQLParticipantes: TSQLDataSet;
    SQLParticipantesCODATIDIS: TIntegerField;
    SQLParticipantesCODATI: TIntegerField;
    SQLParticipantesCODDIS: TIntegerField;
    SQLParticipantesNOMDIS: TStringField;
    DspParticipantes: TDataSetProvider;
    SQLEscalas: TSQLDataSet;
    SQLEscalasCODESC: TIntegerField;
    SQLEscalasCODATI: TIntegerField;
    SQLEscalasCODCAD: TIntegerField;
    SQLEscalasNOMCAD: TStringField;
    SQLEscalasCODTIPATU: TIntegerField;
    SQLEscalasDESTIPATU: TStringField;
    DspEscalas: TDataSetProvider;
    SQLTiposAtividadesCODTIPATI: TIntegerField;
    SQLTiposAtividadesDESTIPATI: TStringField;
    SQLTiposAtividadesHORATI: TTimeField;
    SQLTiposAtividadesCAMPRO: TStringField;
    SQLTiposAtividadesINDFRE: TStringField;
    SQLTiposAtividadesINDESCINT: TStringField;
    SQLFrequencias: TSQLDataSet;
    DspFrequencias: TDataSetProvider;
    SQLFrequenciasCODATI: TIntegerField;
    SQLFrequenciasCODCAD: TIntegerField;
    SQLFrequenciasMATCAD: TStringField;
    SQLFrequenciasNOMCAD: TStringField;
    SQLFrequenciasINDPRE: TStringField;
    SQLFrequenciasINDJUSACE: TStringField;
    SQLAtividadeEI: TSQLDataSet;
    SQLAtividadeEICODATI: TIntegerField;
    SQLAtividadeEICODTIPATI: TIntegerField;
    SQLAtividadeEIDESTIPATI: TStringField;
    SQLAtividadeEICAMPRO: TStringField;
    SQLAtividadeEICODFOC: TIntegerField;
    SQLAtividadeEIDATATI: TDateField;
    SQLAtividadeEIHORATI: TTimeField;
    SQLAtividadeEILOCATI: TStringField;
    SQLAtividadeEIINDFRE: TStringField;
    SQLAtividadeEIINDJAL: TStringField;
    SQLAtividadeEIINDLIS: TStringField;
    SQLAtividadeEIOBSATI: TMemoField;
    SQLAtividadeEIUSURES: TStringField;
    SQLAtividadeEIDATCAD: TSQLTimeStampField;
    SQLAtividadeEICODGRU: TIntegerField;
    SQLAtividadeEINOMGRU: TStringField;
    DspAtividadeEI: TDataSetProvider;
    SQLAgendaINDESCINT: TStringField;
    SQLAgendaCODGRU: TIntegerField;
    SQLAtividadeTP: TSQLDataSet;
    SQLAtividadeTPCODATI: TIntegerField;
    SQLAtividadeTPCODTIPATI: TIntegerField;
    SQLAtividadeTPDESTIPATI: TStringField;
    SQLAtividadeTPCAMPRO: TStringField;
    SQLAtividadeTPCODFOC: TIntegerField;
    SQLAtividadeTPDATATI: TDateField;
    SQLAtividadeTPHORATI: TTimeField;
    SQLAtividadeTPLOCATI: TStringField;
    SQLAtividadeTPINDFRE: TStringField;
    SQLAtividadeTPINDJAL: TStringField;
    SQLAtividadeTPINDLIS: TStringField;
    SQLAtividadeTPOBSATI: TMemoField;
    SQLAtividadeTPUSURES: TStringField;
    SQLAtividadeTPDATCAD: TSQLTimeStampField;
    DspAtividadeTP: TDataSetProvider;
    SQLAtividadeTPCODALO: TIntegerField;
    SQLAtividadeTPTITALO: TStringField;
    SQLAtividadeTPCODTUR: TIntegerField;
    SQLAtividadeTPNUMTUR: TIntegerField;
    SQLAtividadeTPNUMTEM: TSmallintField;
    SQLMembrosEISearch: TSQLDataSet;
    DspMembrosEISearch: TDataSetProvider;
    SQLMembros: TSQLDataSet;
    SQLMembrosCODCAD: TIntegerField;
    SQLMembrosMATCAD: TStringField;
    SQLMembrosNOMCAD: TStringField;
    SQLMembrosAPECAD: TStringField;
    SQLMembrosSIGDIS: TStringField;
    SQLMembrosSIGFOC: TStringField;
    SQLMembrosINDATI: TStringField;
    DspMembros: TDataSetProvider;
    SQLReports: TSQLDataSet;
    DspReports: TDataSetProvider;
    DspMembro: TDataSetProvider;
    SQLMembro: TSQLDataSet;
    SQLMembroCODCAD: TIntegerField;
    SQLMembroMATCAD: TStringField;
    SQLMembroNOMCAD: TStringField;
    SQLMembroAPECAD: TStringField;
    SQLMembroSEXCAD: TStringField;
    SQLMembroDATNAS: TDateField;
    SQLMembroNACCAD: TStringField;
    SQLMembroDOCIDE: TStringField;
    SQLMembroORGEXP: TStringField;
    SQLMembroESTCIV: TStringField;
    SQLMembroFOTCAD: TGraphicField;
    SQLMembroCODPRO: TIntegerField;
    SQLMembroDESPRO: TStringField;
    SQLMembroCODFOC: TIntegerField;
    SQLMembroCODDIS: TIntegerField;
    SQLMembroSIGDIS: TStringField;
    SQLMembroCADTIT: TIntegerField;
    SQLMembroNOMTIT: TStringField;
    SQLMembroINDEXTNUC: TStringField;
    SQLMembroINDGRUJOV: TStringField;
    SQLMembroINDLIGROZ: TStringField;
    SQLMembroINDATI: TStringField;
    SQLMembroINDFRE: TStringField;
    SQLMembroINDLIC: TStringField;
    SQLMembroINDMEN: TStringField;
    SQLMembroVALMEN: TFMTBCDField;
    SQLMembroVALTAX: TFMTBCDField;
    SQLMembroDATOBI: TDateField;
    SQLMembroOBSCAD: TMemoField;
    SQLMembroUSURES: TStringField;
    SQLMembroDATCAD: TSQLTimeStampField;
    DspJovemTM: TDataSetProvider;
    SQLJovemTM: TSQLDataSet;
    SQLJovemTMCODCAD: TIntegerField;
    SQLJovemTMMATCAD: TStringField;
    SQLJovemTMNOMCAD: TStringField;
    SQLJovemTMAPECAD: TStringField;
    SQLJovemTMSEXCAD: TStringField;
    SQLJovemTMDATNAS: TDateField;
    SQLJovemTMNACCAD: TStringField;
    SQLJovemTMDOCIDE: TStringField;
    SQLJovemTMORGEXP: TStringField;
    SQLJovemTMESTCIV: TStringField;
    SQLJovemTMFOTCAD: TGraphicField;
    SQLJovemTMCODPRO: TIntegerField;
    SQLJovemTMDESPRO: TStringField;
    SQLJovemTMCODFOC: TIntegerField;
    SQLJovemTMCODDIS: TIntegerField;
    SQLJovemTMSIGDIS: TStringField;
    SQLJovemTMCADTIT: TIntegerField;
    SQLJovemTMNOMTIT: TStringField;
    SQLJovemTMINDEXTNUC: TStringField;
    SQLJovemTMINDLIGROZ: TStringField;
    SQLJovemTMINDATI: TStringField;
    SQLJovemTMINDFRE: TStringField;
    SQLJovemTMVALMEN: TFMTBCDField;
    SQLJovemTMVALTAX: TFMTBCDField;
    SQLJovemTMDATOBI: TDateField;
    SQLJovemTMOBSCAD: TMemoField;
    SQLJovemTMUSURES: TStringField;
    SQLJovemTMDATCAD: TSQLTimeStampField;
    SQLFrequenciasMATCADINT: TIntegerField;
    SQLMembrosMATCADINT: TIntegerField;
    SQLFrequenciasSIGFOC: TStringField;
    SQLFrequenciasSIGDIS: TStringField;
    SQLAtividadeEICODLIC: TIntegerField;
    SQLAtividadeEINOMLIC: TStringField;
    SQLAtividadeFrequencia: TSQLDataSet;
    DspAtividadeFrequencia: TDataSetProvider;
    SQLAtividadeFrequenciaCODATI: TIntegerField;
    SQLAtividadeFrequenciaDESTIPATI: TStringField;
    SQLAtividadeFrequenciaDATATI: TDateField;
    SQLAtividadeFrequenciaHORATI: TTimeField;
    SQLAtividadeFrequenciaCODFOC: TIntegerField;
    SQLAtividadeFrequenciaSIGFOC: TStringField;
    SQLAtividadeFrequenciaCAMPRO: TStringField;
    SQLAtividadeFrequenciaINDFRE: TStringField;
    SQLFocosParticipantes: TSQLDataSet;
    DspFocosParticipantes: TDataSetProvider;
    SQLFocosParticipantesCODATIFOC: TIntegerField;
    SQLFocosParticipantesCODATI: TIntegerField;
    SQLFocosParticipantesCODFOC: TIntegerField;
    SQLFocosParticipantesNOMFOC: TStringField;
    SQLFocosParticipantesSIGFOC: TStringField;
    SQLConferencia: TSQLDataSet;
    DspConferencia: TDataSetProvider;
    SQLConferenciaCODCON: TIntegerField;
    SQLConferenciaNOMCON: TStringField;
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
    SQLConferenciaOBSCON: TMemoField;
    SQLConferenciaDATCAD: TSQLTimeStampField;
    SQLConferenciaUSURES: TStringField;
    SQLConferenciaNOMFOC: TStringField;
    SQLProgramacao: TSQLDataSet;
    DspProgramacao: TDataSetProvider;
    SQLProgramacaoCODATI: TIntegerField;
    SQLProgramacaoDESTIPATI: TStringField;
    SQLProgramacaoDATATI: TDateField;
    SQLProgramacaoHORATI: TTimeField;
    SQLProgramacaoCODCON: TIntegerField;
    SQLAgendaCODCON: TIntegerField;
    SQLAgendaNOMCON: TStringField;
    SQLFuncoesCadastradoCODFUN: TIntegerField;
    SQLFuncoesCadastradoDESFUN: TStringField;
    SQLParticipantesTipoAtividade: TSQLDataSet;
    SQLParticipantesTipoAtividadeCODDIS: TIntegerField;
    SQLParticipantesTipoAtividadeNOMDIS: TStringField;
    DspParticipantesTipoAtividade: TDataSetProvider;
    SQLParticipantesTipoAtividadeCODPAR: TIntegerField;
    SQLParticipantesTipoAtividadeCODTIPATI: TIntegerField;
    SQLTipoAtividade: TSQLDataSet;
    DspTipoAtividade: TDataSetProvider;
    SQLConferenciaTIPLEV: TStringField;
    SQLCatExternalReports: TSQLDataSet;
    DspCatExternalReports: TDataSetProvider;
    SQLExternalReports: TSQLDataSet;
    DspExternalReports: TDataSetProvider;
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
    SQLAtividadeLECCODCON: TIntegerField;
    SQLAtividadeLECNOMCON: TStringField;
    SQLTiposAtividadesINDEST: TStringField;
    SQLConferenciasDiscipulados: TSQLDataSet;
    SQLConferenciasDiscipuladosCODCONDIS: TFMTBCDField;
    SQLConferenciasDiscipuladosCODCON: TIntegerField;
    SQLConferenciasDiscipuladosCODDIS: TIntegerField;
    SQLConferenciasDiscipuladosNOMDIS: TStringField;
    DspConferenciasDiscipulados: TDataSetProvider;
    SQLConferenciasFocos: TSQLDataSet;
    DspConferenciasFocos: TDataSetProvider;
    SQLConferenciasFocosCODCONFOC: TFMTBCDField;
    SQLConferenciasFocosCODCON: TIntegerField;
    SQLConferenciasFocosCODFOC: TIntegerField;
    SQLConferenciasFocosNOMFOC: TStringField;
    SQLFrequenciasConferencia: TSQLDataSet;
    DspFrequenciasConferencia: TDataSetProvider;
    SQLFrequenciasConferenciaCODATI: TIntegerField;
    SQLFrequenciasConferenciaCODCAD: TIntegerField;
    SQLFrequenciasConferenciaMATCAD: TStringField;
    SQLFrequenciasConferenciaNOMCAD: TStringField;
    SQLFrequenciasConferenciaSIGFOC: TStringField;
    SQLFrequenciasConferenciaINDPRE: TStringField;
    SQLFrequenciasConferenciaINDJUSACE: TStringField;
    SQLFrequenciasConferenciaMATCADINT: TIntegerField;
    SQLFrequenciasConferenciaSIGDIS: TStringField;
    SQLFrequenciasConferenciaCODCON: TIntegerField;
    SQLAgendaTIPLEV: TStringField;
    SQLFrequenciasConByAtividade: TSQLDataSet;
    SQLFrequenciasConByAtividadeCODFRE: TFMTBCDField;
    SQLFrequenciasConByAtividadeCODATI: TIntegerField;
    SQLFrequenciasConByAtividadeCODCON: TIntegerField;
    SQLFrequenciasConByAtividadeCODCAD: TIntegerField;
    SQLFrequenciasConByAtividadeMATCAD: TStringField;
    SQLFrequenciasConByAtividadeNOMCAD: TStringField;
    SQLFrequenciasConByAtividadeSIGDIS: TStringField;
    SQLFrequenciasConByAtividadeSIGFOC: TStringField;
    SQLFrequenciasConByAtividadeINDPRE: TStringField;
    SQLFrequenciasConByAtividadeINDJUSACE: TStringField;
    SQLFrequenciasConByAtividadeMATCADINT: TIntegerField;
    DspFrequenciasConferenciaByAtividade: TDataSetProvider;
    SQLProgramacaoINDFRE: TStringField;
    SQLDadosCirculoCODDIS: TIntegerField;
    SQLDadosCirculoNOMDIS: TStringField;
    SQLMembroINDIMP: TStringField;
    SQLPerfis: TSQLDataSet;
    DspPerfis: TDataSetProvider;
    SQLPerfisCODPER: TIntegerField;
    SQLPerfisNOMPER: TStringField;
    SQLPerfisINDLEC: TStringField;
    SQLPerfisINDTMO: TStringField;
    SQLPerfisINDTMB: TStringField;
    SQLPerfisINDTPU: TStringField;
    SQLPerfisINDEIN: TStringField;
    SQLPerfil: TSQLDataSet;
    DspPerfil: TDataSetProvider;
    SQLPerfilCODPER: TIntegerField;
    SQLPerfilNOMPER: TStringField;
    SQLPerfilINDLEC: TStringField;
    SQLPerfilINDTMO: TStringField;
    SQLPerfilINDTMB: TStringField;
    SQLPerfilINDTPU: TStringField;
    SQLPerfilINDEIN: TStringField;
    SQLPerfilABRPER: TStringField;
    SQLPerfilDESPER: TStringField;
    SQLPerfilINDADM: TStringField;
    SQLFrequenciasCODFRE: TLargeintField;
    SQLMembrosDATNAS: TDateField;
    SQLMembrosSEXCAD: TStringField;
    SQLMembrosINDESCINT: TStringField;
    SQLFrequenciasConferenciaCODFRE: TLargeintField;
    DspKeywords: TDataSetProvider;
    SQLKeywords: TSQLDataSet;
    SQLKeywordsCODKEY: TIntegerField;
    SQLKeywordsKEYWOR: TStringField;
    SQLKeywordsCODALO: TIntegerField;
    SQLDadosAtividade: TSQLDataSet;
    IntegerField1: TIntegerField;
    StringField1: TStringField;
    DateField1: TDateField;
    TimeField1: TTimeField;
    StringField4: TStringField;
    DspDadosAtividade: TDataSetProvider;
    SQLConferenciaMESREF: TSmallintField;
    SQLTiposAtividadesINDATI: TStringField;
    SQLFolhaPresenca: TSQLDataSet;
    DspFolhaPresenca: TDataSetProvider;
    procedure DspPerfilGetDataSetProperties(Sender: TObject; DataSet: TDataSet;
      out Properties: OleVariant);
    procedure DspConferenciasFocosGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspConferenciasDiscipuladosGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspExternalReportsGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspParticipantesTipoAtividadeGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspFocosParticipantesGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspFrequenciasGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspMembrosCirculoGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspTiposAtividadesGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspEscalasGetDataSetProperties(Sender: TObject; DataSet: TDataSet;
      out Properties: OleVariant);
    procedure DspParticipantesGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspAtividadeLECGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: WideString);
    procedure DspAtividadeLECGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspDispensasGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspFuncoesCadastradoGetDataSetProperties(Sender: TObject; DataSet: TDataSet;
      out Properties: OleVariant);
    procedure DspAlunoGetDataSetProperties(Sender: TObject; DataSet: TDataSet;
      out Properties: OleVariant);
    procedure DspDadosCirculoGetData(Sender: TObject;
      DataSet: TCustomClientDataSet);
    procedure DspAlocucoesGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspLicoesEIGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspLivrosEIGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspKeywordsGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure SQLAgendaBeforeOpen(DataSet: TDataSet);
    procedure DspAlunoGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: string);
    procedure DspTiposAtividadesGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: string);
    procedure DspAtividadeTPGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: string);
    procedure DspAgendaGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: string);
    procedure DspFuncoesCadastradoGetTableName(Sender: TObject;
      DataSet: TDataSet; var TableName: string);
    procedure DspCirculosEIGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: string);
    procedure DspMembrosCirculoGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: string);
    procedure DspDadosCirculoGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: string);
    procedure DspEscalasGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: string);
    procedure DspFrequenciasGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: string);
    procedure DspParticipantesTipoAtividadeGetTableName(Sender: TObject;
      DataSet: TDataSet; var TableName: string);
    procedure DspConferenciasDiscipuladosGetTableName(Sender: TObject;
      DataSet: TDataSet; var TableName: string);
    procedure DspConferenciasFocosGetTableName(Sender: TObject;
      DataSet: TDataSet; var TableName: string);
    procedure DspParticipantesGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: string);
    procedure DspFocosParticipantesGetTableName(Sender: TObject;
      DataSet: TDataSet; var TableName: string);
    procedure DspCirculosEIGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspEscalasUpdateData(Sender: TObject;
      DataSet: TCustomClientDataSet);
    procedure DspAgendaUpdateError(Sender: TObject;
      DataSet: TCustomClientDataSet; E: EUpdateError; UpdateKind: TUpdateKind;
      var Response: TResolverResponse);
  private
    { Private declarations }


  public
    { Public declarations }

    procedure DeleteActivity(codati: Integer);
    procedure DeleteTipoAtividade(IDTipoAtividade: Integer);
    function GerarFrequencia(Atividade: Integer): integer;
    function GerarFrequenciaConferencia(codcon: Integer): integer;
    procedure LimparFrequencias(codati: Integer);

    procedure NovaAlocucao(Alocucao, Assuntos: OleVariant);
  end;

var
  DMSecAtividadesServerMethods: TDMSecAtividadesServerMethods;


implementation

uses cosmos.servers.common.dataacess, cosmos.servers.common.methods,
 cosmos.servers.common.services;

{$R *.DFM}

procedure TDMSecAtividadesServerMethods.DspAgendaGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: string);
begin
 TableName := TTablesNames.TAB_ATIVIDADES;
end;

procedure TDMSecAtividadesServerMethods.DspAgendaUpdateError(Sender: TObject;
  DataSet: TCustomClientDataSet; E: EUpdateError; UpdateKind: TUpdateKind;
  var Response: TResolverResponse);
begin
 DMServerDataAcess.OnUpdateError(E, UpdateKind, Response);
end;

procedure TDMSecAtividadesServerMethods.DspAlocucoesGetDataSetProperties(Sender: TObject;
  DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_ALOCUCOES, False]);
end;

procedure TDMSecAtividadesServerMethods.DspAlunoGetDataSetProperties(Sender: TObject;
  DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_CADASTRADOS, False]);
end;

procedure TDMSecAtividadesServerMethods.DspAlunoGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: string);
begin
 TableName := TTablesNames.TAB_CADASTRADOS;
end;

procedure TDMSecAtividadesServerMethods.DspAtividadeLECGetDataSetProperties(Sender: TObject;
  DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_ATIVIDADES, False]);
end;

procedure TDMSecAtividadesServerMethods.DspAtividadeLECGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: WideString);
begin
 TableName := TTablesNames.TAB_ATIVIDADES;
end;

procedure TDMSecAtividadesServerMethods.DspAtividadeTPGetTableName(
  Sender: TObject; DataSet: TDataSet; var TableName: string);
begin
 TableName := TTablesNames.TAB_ATIVIDADES;
end;

procedure TDMSecAtividadesServerMethods.DspCirculosEIGetDataSetProperties(
  Sender: TObject; DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_GRUPOS_EI, False]);
end;

procedure TDMSecAtividadesServerMethods.DspCirculosEIGetTableName(
  Sender: TObject; DataSet: TDataSet; var TableName: string);
begin
 TableName := TTablesNames.TAB_CIRCULOS_EI;
end;

procedure TDMSecAtividadesServerMethods.DspConferenciasDiscipuladosGetDataSetProperties(
  Sender: TObject; DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_CONFERENCIAS_DISC, False]);
end;

procedure TDMSecAtividadesServerMethods.DspConferenciasDiscipuladosGetTableName(
  Sender: TObject; DataSet: TDataSet; var TableName: string);
begin
 TableName := TTablesNames.TAB_CONFERENCIAS_DISCIPULADOS;
end;

procedure TDMSecAtividadesServerMethods.DspConferenciasFocosGetDataSetProperties(Sender: TObject;
  DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_CONFERENCIAS_FOCOS, False]);
end;

procedure TDMSecAtividadesServerMethods.DspConferenciasFocosGetTableName(
  Sender: TObject; DataSet: TDataSet; var TableName: string);
begin
 TableName := TTablesNames.TAB_CONFERENCIAS_FOCOS;
end;

procedure TDMSecAtividadesServerMethods.DspDadosCirculoGetData(Sender: TObject;
  DataSet: TCustomClientDataSet);
begin
 if not Dataset.Fields.FieldByName('sencon').IsNull then
  begin
   Dataset.Edit;

   try
    Dataset.Fields.FieldByName('sencon').AsString := TCripterFactory.Descriptografar(Dataset.Fields.FieldByName('sencon').AsString);

   finally
    DMServerDataAcess.CloseDataset(DMServerDataAcess.SQLSearch);
   end;

   Dataset.Post;
  end;
end;

procedure TDMSecAtividadesServerMethods.DspDadosCirculoGetTableName(
  Sender: TObject; DataSet: TDataSet; var TableName: string);
begin
TableName := TTablesNames.TAB_GRUPOS_EI;
end;

procedure TDMSecAtividadesServerMethods.DspDispensasGetDataSetProperties(Sender: TObject;
  DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_DISPENSAS, False]);
end;

procedure TDMSecAtividadesServerMethods.DspEscalasGetDataSetProperties(Sender: TObject;
  DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_ESCALAS_ATIVIDADES, False]);
end;

procedure TDMSecAtividadesServerMethods.DspEscalasGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: string);
begin
 TableName := TTablesNames.TAB_ESCALAS_ATIVIDADES;
end;

procedure TDMSecAtividadesServerMethods.DspEscalasUpdateData(Sender: TObject;
  DataSet: TCustomClientDataSet);
var
 ADataset: TSQLDataset;
 sCommand: string;
 codati, codcad, codcon: integer;
begin
 {Verifica se o cadastrado pode ser escalado para a atividade. Existem algumas
  situações que o impedem:
  1 - O cadastrado está falecido.
  2 - No caso de uma atividade de uma conferência, apenas cadastrados inscritos
      podem ser escalados em tarefas da ativdiade.}
 codcad := Dataset.Fields.FieldByName('codcad').AsInteger;

 //Primeiro, verifica se o cadastrado está falecido.
 if DMCosmosApplicationServer.CadastradoEstaFalecido(codcad) then
  raise TDBXError.Create(TCosmosErrorCodes.EscalarFalecido, TCosmosErrorMsg.EscalarFalecido);

 //Agora, checa se o escalado pode entrar na escala da atividade.
 if not Dataset.Fields.FieldByName('codati').IsNull then
  begin
   ADataset := DMServerDataAcess.CreateDataset;
   codati := Dataset.Fields.FieldByName('codati').AsInteger;

   try
     sCommand := TGConfCommands.ConferenciaAtividade;
     sCommand := sCommand.Format(sCommand, [codati]);
     ADataset.CommandText := sCommand;
     ADataset.Open;

     if not ADataset.Fields.FieldByName('codcon').IsNull then
       begin
        codcon := ADataset.Fields.FieldByName('codcon').AsInteger;

        ADataset.Close;
        sCommand := TGConfCommands.EstaInscritoConferencia;
        sCommand := sCommand.Format(sCommand, [codcon, codcad]);
        ADataset.CommandText := sCommand;
        ADataset.Open;

        //Caso o escalado não esteja inscrito na conferência, dispara o erro.
        if ADataset.IsEmpty then
          raise TDBXError.Create(TCosmosErrorCodes.InvalidEscaladoConferencia, TCosmosErrorMsg.EscalaConferenciaInvalida);
       end;

   finally
     if Assigned(ADataset) then FreeAndNil(ADataset);
   end;
  end;
end;

procedure TDMSecAtividadesServerMethods.DspExternalReportsGetDataSetProperties(Sender: TObject;
  DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_RELATORIOS_EXTERNOS, False]);
end;

procedure TDMSecAtividadesServerMethods.DspFocosParticipantesGetDataSetProperties(
  Sender: TObject; DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_ATIVIDADES_FOCOS, False]);
end;

procedure TDMSecAtividadesServerMethods.DspFocosParticipantesGetTableName(
  Sender: TObject; DataSet: TDataSet; var TableName: string);
begin
 TableName := TTablesNames.TAB_ATIVIDADES_FOCOS;
end;

procedure TDMSecAtividadesServerMethods.DspFrequenciasGetDataSetProperties(Sender: TObject;
  DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_FREQUENCIAS, False]);
end;

procedure TDMSecAtividadesServerMethods.DspFrequenciasGetTableName(
  Sender: TObject; DataSet: TDataSet; var TableName: string);
begin
 TableName := TTablesNames.TAB_FREQUENCIAS;
end;

procedure TDMSecAtividadesServerMethods.DspFuncoesCadastradoGetDataSetProperties(Sender: TObject;
  DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_FUNCOES_CADASTRADO, False]);
end;

procedure TDMSecAtividadesServerMethods.DspFuncoesCadastradoGetTableName(
  Sender: TObject; DataSet: TDataSet; var TableName: string);
begin
 TableName := TTablesNames.TAB_FUNCOES_CADASTRADO;
end;

procedure TDMSecAtividadesServerMethods.DspKeywordsGetDataSetProperties(
  Sender: TObject; DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_KEYWORDS, False]);
end;

procedure TDMSecAtividadesServerMethods.DspLicoesEIGetDataSetProperties(Sender: TObject;
  DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_LICOES_EI, False]);
end;

procedure TDMSecAtividadesServerMethods.DspLivrosEIGetDataSetProperties(Sender: TObject;
  DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_LIVROS_EI, False]);
end;

procedure TDMSecAtividadesServerMethods.DspMembrosCirculoGetDataSetProperties(Sender: TObject;
  DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_MEMBROS_GRUPOS_EI, False]);
end;

procedure TDMSecAtividadesServerMethods.DspMembrosCirculoGetTableName(
  Sender: TObject; DataSet: TDataSet; var TableName: string);
begin
TableName := TTablesNames.TAB_MEMBROS_GRUPOS_EI;
end;

procedure TDMSecAtividadesServerMethods.DspParticipantesGetDataSetProperties(Sender: TObject;
  DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_ATIVIDADES_DISCIPULADOS, False]);
end;

procedure TDMSecAtividadesServerMethods.DspParticipantesGetTableName(
  Sender: TObject; DataSet: TDataSet; var TableName: string);
begin
 TableName := TTablesNames.TAB_ATIVIDADES_DISCIPULADOS;
end;

procedure TDMSecAtividadesServerMethods.DspParticipantesTipoAtividadeGetDataSetProperties(
  Sender: TObject; DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_PARTICIPANTES, False]);
end;

procedure TDMSecAtividadesServerMethods.DspParticipantesTipoAtividadeGetTableName(
  Sender: TObject; DataSet: TDataSet; var TableName: string);
begin
 TableName := TTablesNames.TAB_PARTICIPANTES;
end;

procedure TDMSecAtividadesServerMethods.DspPerfilGetDataSetProperties(Sender: TObject;
  DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_PERFIS, False]);
end;

procedure TDMSecAtividadesServerMethods.DspTiposAtividadesGetDataSetProperties(Sender: TObject;
  DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_TIPOS_ATIVIDADES, False]);
end;


procedure TDMSecAtividadesServerMethods.DspTiposAtividadesGetTableName(
  Sender: TObject; DataSet: TDataSet; var TableName: string);
begin
 TableName := TTablesNames.TAB_TIPOS_ATIVIDADES;
end;

procedure TDMSecAtividadesServerMethods.NovaAlocucao(Alocucao, Assuntos: OleVariant);
var
 ADataset: TClientDataset;
 NewID: integer;
 sCommand, sAutor, sNotes: string;
 AScript: TStringList;
begin
 //Insere uma nova alocução e suas palavras-chave.
 ADataset := TClientDataset.Create(self);
 AScript := TStringList.Create;

 try
  ADataset.Data := Alocucao;
  sCommand := TSecAtividadesCommands.AlocucaoInsert + ';';
  NewID := DMServerDataAcess.DoGetSequenceValue(TSequencesNames.GEN_ALOCUCOES);

  if ADataset.Fields.FieldByName('nomaut').IsNull then
   sAutor := 'null'
  else
   sAutor := QuotedStr(ADataset.Fields.FieldByName('nomaut').AsString);

  if ADataset.Fields.FieldByName('notalo').IsNull then
   sNotes := 'null'
  else
   sNotes := QuotedStr(ADataset.Fields.FieldByName('notalo').AsString);

  sCommand := Format(sCommand, [NewID, QuotedStr(ADataset.Fields.FieldByName('titalo').AsString),
   QuotedStr(ADataset.Fields.FieldByName('fraalo').AsString), sAutor,
   QuotedStr(ADataset.Fields.FieldByName('indlec').AsString),
   QuotedStr(ADataset.Fields.FieldByName('indtmo').AsString),
   QuotedStr(ADataset.Fields.FieldByName('indtmb').AsString),
   QuotedStr(ADataset.Fields.FieldByName('indtpu').AsString), sNotes]);

  AScript.Add(sCommand);
  ADataset.Data := Assuntos;
  sCommand := TSecAtividadesCommands.AlocucaoKeywordInsert + ';';

  while not ADataset.Eof do
   begin
    AScript.Add(Format(sCommand, [QuotedStr(ADataset.Fields.FieldByName('keywor').AsString), NewID]));
    ADataset.Next;
   end;


  DMServerDataAcess.DoExecuteScript(AScript);
  ADataset.Free;
  AScript.Free;


 except
  on E: Exception do
   begin
    DMCosmosServerServices.RegisterLog(E.Message, AScript.Text, leOnError);
    if Assigned(ADataset) then FreeAndNil(ADataset);
    if Assigned(AScript) then FreeAndNil(AScript);
   end;
 end;
end;

procedure TDMSecAtividadesServerMethods.SQLAgendaBeforeOpen(DataSet: TDataSet);
begin
 TSQLDataset(Dataset).SQLConnection := DMServerDataAcess.ConnectionPool.GetConnection;
end;

procedure TDMSecAtividadesServerMethods.DeleteActivity(codati: Integer);
var
 ADataset: TSQLDataset;
begin
{Exclui uma atividade, se possível. Uma atividade pode ser deletada se não
 existem dependências com outros dados, tais como levantamento de freqüências
 já processados.}
 ADataset := DMServerDataAcess.CreateDataset;

 try
  ADataset.CommandText := Format(TDQLCommands.CountFrequencias, [codati]);
  ADataset.Open;

  if ADataset.Fields.Fields[0].AsInteger = 0 then
   DMServerDataAcess.DoExecuteCommand(Format(TSecAtividadesCommands.AtividadeDelete, [codati]))
  else
   raise ECannotDeleteActivity.Create(TCosmosErrorSecMsg.DelAtividades);

  ADataset.Free;

 except
  on E: ECannotDeleteActivity do
   begin
    if Assigned(ADataset) then FreeAndNil(ADataset);
    DMCosmosServerServices.RegisterLog(E.Message, '', leOnError);
   end;
  on E: Exception do
   begin
    if Assigned(ADataset) then FreeAndNil(ADataset);
    E.Message := TCosmosErrorSecMsg.DelAtividades;
    DMCosmosServerServices.RegisterLog(E.Message, '', leOnError);
   end;
 end;
end;

function TDMSecAtividadesServerMethods.GerarFrequencia(Atividade: Integer): integer;
var
 CurrentConnectedUser: string;
 ADataset: TSQLDataset;
begin
{Insere presença ou falta para os participantes de uma determinada atividade.
A presença ou falta são atribuídos se o cadastrado é assíduo ou não às
atividades como um todo.}
 ADataset := DMServerDataAcess.CreateDataset;

 try
  //Primeiro, verifica se a freqüência para esta atividade já foi gerada.
  ADataset.CommandText := Format(TDQLCommands.CountFrequencias, [Atividade]);
  ADataset.Open;

  if ADataset.Fields.Fields[0].AsInteger = 0 then
   begin
    CurrentConnectedUser := DMCosmosServerServices.ConnectedUser.ToUpper;
    CurrentConnectedUser := CurrentConnectedUser.QuotedString;
    if DMServerDataAcess.DoExecuteCommand(Format(sExecGerarFrequencia, [Atividade, CurrentConnectedUser])) > 0 then
     Result := 0;
   end
  else
    raise EFrequenciaLevantada.Create(TCosmosInfoMsg.FrequenciaComputada);

 if Assigned(ADataset) then FreeAndNil(ADataset);

 except
  on E: EFrequenciaLevantada do
   begin
    Result := 1;
    if Assigned(ADataset) then FreeAndNil(ADataset);
    raise TDBXError.Create(TCosmosErrorCodes.FrequenciaComputada, TCosmosInfoMsg.FrequenciaComputada);
   end;
  on E: Exception do
   begin
    Result := -1;
    if Assigned(ADataset) then FreeAndNil(ADataset);
    DMCosmosServerServices.RegisterLog(E.Message, '', leOnError);
   end;
 end;
end;

procedure TDMSecAtividadesServerMethods.LimparFrequencias(codati: Integer);
begin
//Elimina todos os registro de freqüência de uma determinada atividade.
 try
  DMServerDataAcess.DoExecuteCommand(Format(TSecAtividadesCommands.FrequenciasClear, [codati]));

 except
 on E: Exception do
  begin
   E.Message := TCosmosErrorSecMsg.LimparFrequencia;
   DMCosmosServerServices.RegisterLog(E.Message, '', leOnError);
  end;
 end;
end;

function TDMSecAtividadesServerMethods.GerarFrequenciaConferencia(codcon: Integer): integer;
var
 CurrentConnectedUser: string;
 ADataset: TSQLDataset;
begin
{Insere presença ou falta para os participantes de uma determinada conferência.
A presença ou falta são atribuídos se o cadastrado é assíduo ou não às
conferências como um todo.}

 ADataset := DMServerDataAcess.CreateDataset;

 try
  ADataset.CommandText := Format(TGConfCommands.FrequenciasConfCount, [codcon]);
  ADataset.Open;

  if ADataset.Fields.Fields[0].AsInteger = 0 then
   begin
    CurrentConnectedUser := DMCosmosServerServices.ConnectedUser.ToUpper;
    CurrentConnectedUser := CurrentConnectedUser.QuotedString;
    if DMServerDataAcess.DoExecuteCommand(Format(TGConfCommands.GerarFrequenciaConf, [codcon, CurrentConnectedUser])) > 0 then
     Result := 0;
   end
   else
    raise EFrequenciaLevantada.Create(TCosmosInfoMsg.FrequenciaComputada);

   if Assigned(ADataset) then FreeAndNil(ADataset);

 except
  on E: EFrequenciaLevantada do
   begin
    Result := 1;
    if Assigned(ADataset) then FreeAndNil(ADataset);
    raise TDBXError.Create(TCosmosErrorCodes.FrequenciaComputada, TCosmosInfoMsg.FrequenciaComputada);
   end;
  on E: TDBXError do
   begin
    Result := -1;
    DMCosmosServerServices.RegisterLog(E.Message, '', leOnError);
    if Assigned(ADataset) then FreeAndNil(ADataset);
    raise TDBXError.Create(TCosmosErrorCodes.GerarFrequenciaConferencia, TCosmosErrorMsg.GerarFrequenciaConferencia);
   end;
  on E: Exception do
   begin
    Result := -1;
    DMCosmosServerServices.RegisterLog(E.Message, '', leOnError);
    raise TDBXError.Create(TCosmosErrorCodes.GerarFrequenciaConferencia, TCosmosErrorMsg.GerarFrequenciaConferencia);
    if Assigned(ADataset) then FreeAndNil(ADataset);
   end;
  end;
end;

procedure TDMSecAtividadesServerMethods.DeleteTipoAtividade(IDTipoAtividade: Integer);
var
 ADataset: TSQLDataset;
begin
 //Exclui um tipo de atividade e retorna o resultado ao cliente.
 ADataset := DMServerDataAcess.CreateDataset;

 try
  ADataset.CommandText := Format(TSecAtividadesCommands.TiposAtividadesCount,[IDTipoAtividade]);
  ADataset.Open;

  if ADataset.Fields.Fields[0].AsInteger = 0 then
    DMServerDataAcess.DoExecuteCommand(Format(TSecAtividadesCommands.TiposAtividadesDelete, [IDTipoAtividade]))
  else
   raise ECannotDeleteActivity.Create('');


 except
  on E: TDBXError do
   begin
    DMCosmosServerServices.RegisterLog(E.Message, '', leOnError);
    E.RaiseOuterException(EDataOperationError.Create(TCosmosErrorSecMsg.DelTiposAtividades));
   end;
  on E: ECannotDeleteActivity do
   begin
    E.Message := TCosmosErrorSecMsg.DelTiposAtividades;
   end;
 end;
end;



end.

