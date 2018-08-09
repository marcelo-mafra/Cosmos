unit cosmos.servers.financeiro.finmethods;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer, Windows, System.DateUtils,
  DBClient, FMTBcd, DB, SqlExpr, Provider, SQLScript, Variants,  cosmos.classes.application,
  Cosmos.classes.ServerInterface, cosmos.system.types, cosmos.system.exceptions,
  cosmos.system.winshell,  DBXCommon, DBXFirebird, DataSnap.DSProviderDataModuleAdapter,
  cosmos.framework.interfaces.utils, WideStrings, cosmos.classes.dataobjects,
  cosmos.classes.logs;

type
  TDMFinanceiroMethods = class(TDSServerModule)
    SQLConta: TSQLDataSet;
    SQLContaCODCON: TIntegerField;
    SQLContaDESCON: TStringField;
    SQLContaDESCONING: TStringField;
    SQLContaTIPCON: TStringField;
    SQLContaCODFOC: TIntegerField;
    SQLContaNOMFOC: TStringField;
    SQLContaCODCONPAR: TIntegerField;
    SQLContaINDNAC: TStringField;
    SQLContaDATCAD: TSQLTimeStampField;
    SQLContaUSURES: TStringField;
    DspConta: TDataSetProvider;
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
    DspTiposRecebimentos: TDataSetProvider;
    SQLRecebimento: TSQLDataSet;
    IntegerField1: TIntegerField;
    SmallintField1: TSmallintField;
    SmallintField2: TSmallintField;
    FMTBCDField1: TFMTBCDField;
    FMTBCDField2: TFMTBCDField;
    IntegerField2: TIntegerField;
    StringField1: TStringField;
    IntegerField3: TIntegerField;
    StringField2: TStringField;
    SQLTimeStampField1: TSQLTimeStampField;
    SQLTimeStampField2: TSQLTimeStampField;
    StringField3: TStringField;
    DspRecebimento: TDataSetProvider;
    SQLPesquisarPlanoContas: TSQLDataSet;
    DspPesquisarPlanoContas: TDataSetProvider;
    SQLCentrosCusto: TSQLDataSet;
    SQLCentrosCustoCODCEN: TIntegerField;
    SQLCentrosCustoNOMCEN: TStringField;
    SQLCentrosCustoNOMENG: TStringField;
    SQLCentrosCustoCODFOC: TIntegerField;
    SQLCentrosCustoNOMFOC: TStringField;
    SQLCentrosCustoINDATI: TStringField;
    DspCentrosCusto: TDataSetProvider;
    SQLCentroCusto: TSQLDataSet;
    SQLCentroCustoCODCEN: TIntegerField;
    SQLCentroCustoNOMCEN: TStringField;
    SQLCentroCustoNOMENG: TStringField;
    SQLCentroCustoCODFOC: TIntegerField;
    SQLCentroCustoNOMFOC: TStringField;
    SQLCentroCustoINDATI: TStringField;
    DspCentroCusto: TDataSetProvider;
    SQLTransacoes: TSQLDataSet;
    SQLTransacoesCODTRA: TIntegerField;
    SQLTransacoesCODCAI: TIntegerField;
    SQLTransacoesNUMCAI: TStringField;
    SQLTransacoesCODFOC: TIntegerField;
    SQLTransacoesNOMFOC: TStringField;
    SQLTransacoesSIGFOC: TStringField;
    SQLTransacoesDATTRA: TDateField;
    SQLTransacoesDESTRA: TStringField;
    SQLTransacoesVALTRA: TFMTBCDField;
    SQLTransacoesINDDEBCRE: TStringField;
    DspTransacoes: TDataSetProvider;
    SQLRecebimentoCODFAV: TIntegerField;
    SQLRecebimentoNOMFAV: TStringField;
    SQLRecebimentoCODLOC: TIntegerField;
    SQLRecebimentoNOMLOC: TStringField;
    SQLRecebimentosNOMFAV: TStringField;
    DspValoresContribuicao: TDataSetProvider;
    SQLValoresContribuicao: TSQLDataSet;
    IntegerField4: TIntegerField;
    StringField4: TStringField;
    StringField5: TStringField;
    FMTBCDField3: TFMTBCDField;
    FMTBCDField4: TFMTBCDField;
    SQLValoresContribuicaoCODFOC: TIntegerField;
    SQLTiposRecebimentosSIGTIPREC: TStringField;
    DspContribuicoesPendentes: TDataSetProvider;
    SQLContribuicoesPendentes: TSQLDataSet;
    SQLContribuicoesPendentesCODREC: TIntegerField;
    SQLContribuicoesPendentesMESREF: TSmallintField;
    SQLContribuicoesPendentesANOREF: TSmallintField;
    SQLContribuicoesPendentesDESTIPREC: TStringField;
    SQLContribuicoesPendentesVALREC: TFMTBCDField;
    SQLContribuicoesPendentesDATREC: TSQLTimeStampField;
    SQLContribuicoesPendentesINDPEN: TStringField;
    SQLRecebimentoCODCAI: TIntegerField;
    SQLRecebimentoNUMCAI: TStringField;
    SQLRecebimentoNOMCAD: TStringField;
    SQLPagamentos: TSQLDataSet;
    DspPagamentos: TDataSetProvider;
    SQLPagamento: TSQLDataSet;
    DspPagamento: TDataSetProvider;
    SQLRecimentosCaixa: TSQLDataSet;
    DspRecebimentosCaixa: TDataSetProvider;
    SQLRecimentosCaixaCODREC: TIntegerField;
    SQLRecimentosCaixaMESREF: TSmallintField;
    SQLRecimentosCaixaANOREF: TSmallintField;
    SQLRecimentosCaixaVALPRE: TFMTBCDField;
    SQLRecimentosCaixaVALREC: TFMTBCDField;
    SQLRecimentosCaixaCODTIPREC: TIntegerField;
    SQLRecimentosCaixaDESTIPREC: TStringField;
    SQLRecimentosCaixaCODFAV: TIntegerField;
    SQLRecimentosCaixaNOMFAV: TStringField;
    SQLRecimentosCaixaCODLOC: TIntegerField;
    SQLRecimentosCaixaNOMLOC: TStringField;
    SQLRecimentosCaixaCODCAD: TIntegerField;
    SQLRecimentosCaixaMATCAD: TStringField;
    SQLRecimentosCaixaCODFOCCAD: TIntegerField;
    SQLRecimentosCaixaDATREC: TSQLTimeStampField;
    SQLRecimentosCaixaCODCAI: TIntegerField;
    SQLRecimentosCaixaNUMCAI: TStringField;
    SQLRecimentosCaixaNOMCAD: TStringField;
    SQLRecimentosCaixaOBSREC: TStringField;
    SQLRecimentosCaixaDATCAD: TSQLTimeStampField;
    SQLRecimentosCaixaUSURES: TStringField;
    SQLPagamentosCaixa: TSQLDataSet;
    DspPagamentosCaixa: TDataSetProvider;
    SQLPagamentosCaixaCODPAG: TIntegerField;
    SQLPagamentosCaixaCODCAI: TIntegerField;
    SQLPagamentosCaixaNUMCAI: TStringField;
    SQLPagamentosCaixaVALPAG: TFMTBCDField;
    SQLPagamentosCaixaDATPAG: TDateField;
    SQLPagamentosCaixaDESPAG: TStringField;
    SQLPagamentosCaixaFORPAG: TStringField;
    SQLPagamentosCaixaDATCAD: TSQLTimeStampField;
    SQLPagamentosCaixaUSURES: TStringField;
    SQLRecebimentosINDCAN: TStringField;
    SQLRecebimentoINDCAN: TStringField;
    SQLRecebimentoUSUCAN: TStringField;
    SQLRecimentosCaixaINDCAN: TStringField;
    SQLRecimentosCaixaUSUCAN: TStringField;
    SQLRecebimentoMOTCAN: TSmallintField;
    SQLRecebimentoDATCAN: TSQLTimeStampField;
    SQLContasBancarias: TSQLDataSet;
    DspContasBancarias: TDataSetProvider;
    SQLContasBancariasCODCONBAN: TIntegerField;
    SQLContasBancariasNUMAGE: TIntegerField;
    SQLContasBancariasNUMCON: TStringField;
    SQLContasBancariasCAMTRA: TStringField;
    SQLContasBancariasCODFOC: TIntegerField;
    SQLContasBancariasNOMFOC: TStringField;
    SQLContasBancariasINDATI: TStringField;
    SQLContaBancaria: TSQLDataSet;
    IntegerField5: TIntegerField;
    IntegerField6: TIntegerField;
    StringField6: TStringField;
    StringField7: TStringField;
    IntegerField7: TIntegerField;
    StringField8: TStringField;
    StringField9: TStringField;
    DspContaBancaria: TDataSetProvider;
    SQLContaBancariaOBSCON: TStringField;
    SQLContasBancariasNUMBAN: TStringField;
    SQLContaBancariaNUMBAN: TStringField;
    SQLContasBancariasNOMBAN: TStringField;
    SQLContaBancariaNOMBAN: TStringField;
    SQLPagamentosCODPAG: TIntegerField;
    SQLPagamentosMESREF: TSmallintField;
    SQLPagamentosANOREF: TSmallintField;
    SQLPagamentosVALPAG: TFMTBCDField;
    SQLPagamentosDESPAG: TStringField;
    SQLPagamentosCODCAI: TIntegerField;
    SQLPagamentosNUMCAI: TStringField;
    SQLPagamentosNOMFOC: TStringField;
    SQLPagamentosFORPAG: TStringField;
    SQLPagamentosINDCAN: TStringField;
    SQLPagamentosDATCAN: TSQLTimeStampField;
    SQLPagamentoCODPAG: TIntegerField;
    SQLPagamentoMESREF: TSmallintField;
    SQLPagamentoANOREF: TSmallintField;
    SQLPagamentoVALPAG: TFMTBCDField;
    SQLPagamentoDESPAG: TStringField;
    SQLPagamentoDATPAG: TDateField;
    SQLPagamentoCODCAI: TIntegerField;
    SQLPagamentoNUMCAI: TStringField;
    SQLPagamentoCODFOC: TIntegerField;
    SQLPagamentoNOMFOC: TStringField;
    SQLPagamentoFORPAG: TStringField;
    SQLPagamentoOBSPAG: TMemoField;
    SQLPagamentoINDCAN: TStringField;
    SQLPagamentoDATCAN: TSQLTimeStampField;
    SQLPagamentoUSUCAN: TStringField;
    SQLPagamentoMOTCAN: TSmallintField;
    SQLPagamentoDATCAD: TSQLTimeStampField;
    SQLPagamentoUSURES: TStringField;
    SQLPagamentoNOMCAD: TStringField;
    procedure SQLContaBeforeOpen(DataSet: TDataSet);
    procedure DspContaGetDataSetProperties(Sender: TObject; DataSet: TDataSet;
      out Properties: OleVariant);
    procedure DspContaGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: string);
    procedure DspTiposRecebimentosGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspTiposRecebimentosGetTableName(Sender: TObject;
      DataSet: TDataSet; var TableName: string);
    procedure DspRecebimentoGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspRecebimentoGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: string);
    procedure DspCentroCustoGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspCentroCustoGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: string);
    procedure DspValoresContribuicaoGetTableName(Sender: TObject;
      DataSet: TDataSet; var TableName: string);
    procedure DspPagamentoGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: string);
    procedure DspPagamentoGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspContaBancariaGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: string);
    procedure DspContaBancariaGetDataSetProperties(Sender: TObject;
      DataSet: TDataSet; out Properties: OleVariant);
    procedure DspContaUpdateError(Sender: TObject;
      DataSet: TCustomClientDataSet; E: EUpdateError; UpdateKind: TUpdateKind;
      var Response: TResolverResponse);
  private
    { Private declarations }
    function GetCurrentCosmosModule: TCosmosModules;

  public
     //Caixas
    function AbrirCaixa(FocusId: integer; UserLogin: string): string;
    function FecharCaixa(CaixaID: integer; UserLogin: string; Close: Boolean): string;
    //Contas bancárias
    procedure DeleteContaBancaria(ContaId: integer);
    procedure DesativarContaBancaria(ContaId: integer);
    procedure ReativarContaBancaria(ContaId: integer);
    //Plano de contas
    procedure ExcluirConta(Conta: Integer);
    procedure MoverConta(Conta, Parent: Integer);
    function GetContas: TDataset;
    function GetSubcontas(codcon: Integer): TDataset;
    //Recebimentos
    function CancelarRecebimento(const codrec, Motivo: integer; UserLogin: string): boolean;

    property CurrentCosmosModule: TCosmosModules read GetCurrentCosmosModule;

  end;

var
  DMFinanceiroMethods: TDMFinanceiroMethods;

implementation

uses System.StrUtils, cosmos.system.messages, cosmos.servers.sqlcommands,
  cosmos.servers.common.dataacess, cosmos.servers.common.services;

{$R *.DFM}

procedure TDMFinanceiroMethods.SQLContaBeforeOpen(DataSet: TDataSet);
begin
 TSQLDataset(Dataset).SQLConnection := DMServerDataAcess.ConnectionPool.GetConnection;
end;

function TDMFinanceiroMethods.AbrirCaixa(FocusId: integer; UserLogin: string): string;
var
 aData: TCosmosData;
 aDataset: TSQLDataset;
 sNumcaixa: string;
 aYear: word;
 aCurrentDate: TDateTime;
 aNumcaixa, aCaixaId, aUserId: integer;
 sCommand, sCurrentDate: string;
begin
 aData := TCosmosData.Create(10);
 aDataset :=  DMServerDataAcess.CreateDataset;

 try
  aYear := YearOf(Now);
  aDataset.CommandText :=  Format(TFinCommands.CaixasYear, [aYear]) ;
  aDataset.Open;

  aNumcaixa := aDataset.Fields.Fields[0].AsInteger;
  aNumcaixa := aNumcaixa + 1;
  sNumcaixa := aNumCaixa.ToString;
  sNumcaixa := sNumcaixa + '/' + aYear.ToString;

  //Obtém o id do usuário.
  aDataset.Close;
  aDataset.CommandText := Format(TSecurityCommand.UserInfo, [UserLogin.QuotedString]);
  aDataset.Open;
  aUserId := aDataset.FieldValues['codusu'];

  //Insere o novo registro de caixa.
  aCaixaId := DMServerDataAcess.DoGetSequenceValue(TSequencesNames.GEN_CAIXAS);
  aCurrentDate := Now;
  sCurrentDate := TDataConverter.ToFormatedSQLDateTime(aCurrentDate);
  sCommand := sCommand.Format(TFinCommands.CaixaNovo, [aCaixaId, sNumCaixa.QuotedString, FocusId, 0, aUserId, sCurrentDate]);

  DMServerDataAcess.DoExecuteCommand(sCommand);

  aData.WriteValue('Result', True);
  aData.WriteValue('codcai', aCaixaId, 1);
  aData.WriteValue('numcai', sNumcaixa, 2);
  aData.WriteValue('CaixaStart', aCurrentDate, 3);

  Result := aData.XMLData;
  aData.Free;
  aDataset.Free;


 except
  on E: Exception do
   begin
    aData.WriteValue('Result', False);
    aData.WriteValue('Message', '');
    Result := aData.XMLData;

    aData.Free;
    if Assigned(ADataset) then FreeAndNil(ADataset);
    DMCosmosServerServices.RegisterLog(E.Message, '', leOnError);
    raise TDBXError.Create(TCosmosErrorCodes.CaixaNovo, Format(TCosmosErrorFinMsg.CaixaNovo, [UserLogin]));
   end;
 end;
end;

function TDMFinanceiroMethods.CancelarRecebimento(const codrec, Motivo: integer;
  UserLogin: string): boolean;
var
 sCommand, sData: string;
begin
 //Cancela um recebimento.
 sCommand := TFinCommands.RecebimentoCancelar;
 sData := TDataConverter.ToFormatedSQLDateTime(Now);
 sCommand := Format(sCommand, [QuotedStr('S'), sData, Motivo, QuotedStr(UserLogin), QuotedStr(DMCosmosServerServices.ConnectedUser), codrec]);

 try
  DMServerDataAcess.DoExecuteCommand(sCommand);
  Result := True;

 except
  Result := False;
 end;
end;

procedure TDMFinanceiroMethods.DeleteContaBancaria(ContaId: integer);
var
 aDataset: TSQLDataset;
begin
//Exclui uma conta bancária, se possível.
 try
  aDataset := DMServerDataAcess.DoExecuteDQL(Format(TFinCommands.ContarLancamentosConta, [ContaId]));

  if aDataset.Fields.Fields[0].AsInteger = 0 then
   DMServerDataAcess.DoExecuteCommand(Format(TFinCommands.DeleteContaBancaria, [ContaId]))
  else
   raise EContaBancariaEmUso.Create(TCosmosErrorFinMsg.DeleteContaBancariaEmUso);

 except
  on E: EContaBancariaEmUso do
   begin
    if Assigned(aDataset) then FreeAndNil(aDataset);
    DMCosmosServerServices.RegisterLog(E.Message, '', leOnError);
    raise TDBXError.Create(TCosmosErrorCodes.DeleteContaBancaria, TCosmosErrorFinMsg.DeleteContaBancariaEmUso);
   end;
  on E: TDBXError do
   begin
    if Assigned(aDataset) then FreeAndNil(aDataset);
    DMCosmosServerServices.RegisterLog(E.Message, '', leOnError);
   end;
 end;
end;

procedure TDMFinanceiroMethods.DesativarContaBancaria(ContaId: integer);
begin
//Desativa uma conta bancária.
 try
  DMServerDataAcess.DoExecuteCommand(Format(TFinCommands.ChangeStatusContaBancaria, [QuotedStr('N'), ContaId]))

 except
  on E: Exception do
   begin
    DMCosmosServerServices.RegisterLog(E.Message, '', leOnError);
    raise TDBXError.Create(TCosmosErrorCodes.DesativaContaBancaria, TCosmosErrorFinMsg.DesativaContasBancaria);
   end;
 end;
end;

procedure TDMFinanceiroMethods.DspCentroCustoGetDataSetProperties(
  Sender: TObject; DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_CENTROS_CUSTOS, False]);
end;

procedure TDMFinanceiroMethods.DspCentroCustoGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: string);
begin
TableName := TTablesNames.TAB_CENTRO_CUSTOS;
end;

procedure TDMFinanceiroMethods.DspContaBancariaGetDataSetProperties(
  Sender: TObject; DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_CONTAS_BANCARIAS, False]);
end;

procedure TDMFinanceiroMethods.DspContaBancariaGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: string);
begin
 TableName := TTablesNames.TAB_CONTAS_BANCARIAS;
end;

procedure TDMFinanceiroMethods.DspContaGetDataSetProperties(Sender: TObject;
  DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_CONTAS, False]);
end;

procedure TDMFinanceiroMethods.DspContaGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: string);
begin
TableName := TTablesNames.TAB_CONTAS;
end;

procedure TDMFinanceiroMethods.DspContaUpdateError(Sender: TObject;
  DataSet: TCustomClientDataSet; E: EUpdateError; UpdateKind: TUpdateKind;
  var Response: TResolverResponse);
begin
 DMServerDataAcess.OnUpdateError(E, UpdateKind, Response);
end;

procedure TDMFinanceiroMethods.DspPagamentoGetDataSetProperties(Sender: TObject;
  DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_PAGAMENTOS, False]);
end;

procedure TDMFinanceiroMethods.DspPagamentoGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: string);
begin
 TableName := TTablesNames.TAB_PAGAMENTOS;
end;

procedure TDMFinanceiroMethods.DspRecebimentoGetDataSetProperties(
  Sender: TObject; DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_RECEBIMENTOS, False]);
end;

procedure TDMFinanceiroMethods.DspRecebimentoGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: string);
begin
TableName := TTablesNames.TAB_RECEBIMENTOS;
end;

procedure TDMFinanceiroMethods.DspTiposRecebimentosGetDataSetProperties(
  Sender: TObject; DataSet: TDataSet; out Properties: OleVariant);
begin
  Properties := VarArrayCreate([0,1], varVariant);
  Properties[0] := VarArrayOf(['SequenceName', TSequencesNames.GEN_TIPOS_RECEBIMENTOS, False]);
end;

procedure TDMFinanceiroMethods.DspTiposRecebimentosGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: string);
begin
TableName := TTablesNames.TAB_TIPOS_RECEBIMENTOS;
end;

procedure TDMFinanceiroMethods.DspValoresContribuicaoGetTableName(
  Sender: TObject; DataSet: TDataSet; var TableName: string);
begin
 TableName := TTablesNames.TAB_CADASTRADOS;
end;

procedure TDMFinanceiroMethods.ExcluirConta(Conta: Integer);
var
ADataset: TSQLDataset;
begin
//Exclui uma conta do plano de conta, se possível.
 ADataset := DMServerDataAcess.CreateDataset;

 try
  ADataset.CommandText := Format(TFinCommands.DeleteConta, [Conta]);
  ADataset.Open;

  case ADataset.Fields.Fields[0].AsInteger of
   0:  //Deleção feita com sucesso.
    begin
     //AReturn.MessageTitle := sTitlePlanoContas;
    // AReturn.MessageText := sInfoDelecaoPlanoConta;
    end;
   //Deleção cancelada: existem subcontas vinculadas à conta.
   1:raise TDBXError.Create(TCosmosErrorCodes.DeleteContaSubcontas, TCosmosErrorFinMsg.DeleteContaSubcontas);
   //Deleção cancelada: conta encontra-se em uso.
   2: raise TDBXError.Create(TCosmosErrorCodes.DeleteContasUsadas, TCosmosErrorFinMsg.DeleteContasUsadas);
   else //Deleção cancelada: erro desconhecido.
     raise TDBXError.Create(TCosmosErrorCodes.DeleteConta, TCosmosErrorFinMsg.DeleteConta);
  end;

  if Assigned(ADataset) then FreeAndNil(ADataset);

 except
  on E: Exception do
   begin
    if Assigned(ADataset) then FreeAndNil(ADataset);
    DMCosmosServerServices.RegisterLog(E.Message, '', leOnError);
    raise TDBXError.Create(TCosmosErrorCodes.DeleteConta, TCosmosErrorFinMsg.DeleteConta);
   end;
  on E: TDBXError do
   begin
    if Assigned(ADataset) then FreeAndNil(ADataset);
    DMCosmosServerServices.RegisterLog(E.Message, '', leOnError);
    raise;
   end;
 end;

end;

function TDMFinanceiroMethods.FecharCaixa(CaixaID: integer; UserLogin: string;
   Close: Boolean): string;
var
 aDataset: TSQLDataset;
 aCosmosData: TCosmosData;
 aUserId: integer;
 sCommand, sClose: string;
begin
 aDataset :=  DMServerDataAcess.CreateDataset;
 aCosmosData := TCosmosData.Create(10);

 try
  //Obtém o id do usuário.
  aDataset.CommandText := Format(TSecurityCommand.UserInfo, [UserLogin.QuotedString]);
  aDataset.Open;
  aUserId := aDataset.FieldValues['codusu'];

  //Insere o novo registro de caixa.
  DMServerDataAcess.CloseDataset(aDataset);
  sClose := TDataConverter.ToBoleanString(Close, True);
  sCommand := Format(TFinCommands.CaixaFechar, [CaixaId, aUserId, sClose]);

  aDataset.CommandText := sCommand;
  aDataset.Open;

  aCosmosData.WriteValue('codcai', aDataset.FieldValues['codcai']);
  aCosmosData.WriteValue('numcai', aDataset.FieldValues['numcai'], 1);
  aCosmosData.WriteValue('nomcad', aDataset.FieldValues['nomcad'], 2);
  aCosmosData.WriteValue('numrec', aDataset.FieldValues['numrec'], 3);
  aCosmosData.WriteValue('totrec', aDataset.FieldValues['totrec'], 4);
  aCosmosData.WriteValue('numpag', aDataset.FieldValues['numpag'], 5);
  aCosmosData.WriteValue('totpag', aDataset.FieldValues['totpag'], 6);

  Result := aCosmosData.XMLData;

  aDataset.Free;
  aCosmosData.Free;

 except
  on E: Exception do
   begin
    if Assigned(aDataset) then FreeAndNil(aDataset);
    if Assigned(aCosmosData) then FreeAndNil(aCosmosData);
    DMCosmosServerServices.RegisterLog(E.Message, '', leOnError);
    raise TDBXError.Create(TCosmosErrorCodes.CaixaFechar, Format(TCosmosErrorFinMsg.CaixaFechar, [UserLogin]));
   end;
 end;
end;

function TDMFinanceiroMethods.GetContas: TDataset;
begin
 Result := DMServerDataAcess.CreateDataset;

 try
  TSQLDataset(Result).CommandText := TFinCommands.RootContas;
  Result.Open;

 except
  on E: Exception do
   begin
    DMCosmosServerServices.RegisterLog(E.Message, '', leOnError);
    raise TDBXError.Create(TCosmosErrorCodes.SelectData, TCosmosErrorMsg.SelectData);
   end;
 end;
end;

function TDMFinanceiroMethods.GetCurrentCosmosModule: TCosmosModules;
begin
 Result := cmFinanceiro;
end;

function TDMFinanceiroMethods.GetSubcontas(codcon: Integer): TDataset;
begin
 Result := DMServerDataAcess.CreateDataset;

 try
  TSQLDataset(Result).CommandText := Format(TFinCommands.Subcontas, [codcon]);
  Result.Open;

 except
  on E: Exception do
   begin
    DMCosmosServerServices.RegisterLog(E.Message, '', leOnError);
    raise TDBXError.Create(TCosmosErrorCodes.SelectData, TCosmosErrorMsg.SelectData);
   end;
 end;
end;

procedure TDMFinanceiroMethods.MoverConta(Conta, Parent: Integer);
begin
//Altera a relação de dependência de uma conta para com outra.

 try
  DMServerDataAcess.DoExecuteCommand(Format(TFinCommands.MoveConta, [Parent, Conta]))

 except
  on E: Exception do
   begin
    DMCosmosServerServices.RegisterLog(E.Message, '', leOnError);
    raise TDBXError.Create(TCosmosErrorCodes.MoveConta, TCosmosErrorFinMsg.MoveConta);
   end;
 end;

end;

procedure TDMFinanceiroMethods.ReativarContaBancaria(ContaId: integer);
//Reativa uma conta bancária.
begin
 try
  DMServerDataAcess.DoExecuteCommand(Format(TFinCommands.ChangeStatusContaBancaria, [QuotedStr('S'), ContaId]))

 except
  on E: Exception do
   begin
    DMCosmosServerServices.RegisterLog(E.Message, '', leOnError);
    raise TDBXError.Create(TCosmosErrorCodes.ReativaContaBancaria, TCosmosErrorFinMsg.ReativaContasBancaria);
   end;
 end;

end;

end.
