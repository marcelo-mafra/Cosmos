unit cosmos.system.exceptions;

interface

uses
 System.SysUtils, cosmos.system.messages, IdException, IdExceptionCore;


type
 EDllError = class (Exception);
 ENoneServerError = class (Exception);
 EAbortedConnection = class (Exception);
 ENetActivityError = class (Exception);
 EDatabaseConnectError = class (Exception);
 EInvalidProtocol = class (Exception);
 ECertificateNotFound = class(Exception);
 EInvalidRoleAcess = class (Exception);
 EIncorrectRoleAcess = class (Exception);
 ECosmosSystemFailure = class (Exception);
 ELockedDatabaseError = class (Exception);
 EValidateUser = class (Exception);
 EUnknownUser = class (Exception);
 EBlockedUser = class (Exception);
 EInactivedUser = class (Exception);
 EIncorrectServer = Class (Exception);
 ECantAcessCosmosModule = class (Exception);
 ELockedServerError = class (Exception);
 ESyncronizingStatus = class (Exception);
 EUnknownCommandError = class (Exception);
 EFocusDuplicated = class (Exception);
 EDeleteError = class (Exception);
 EFocusInexists = class (Exception);
 EDuplicatedCosmosUser = Exception;
 ECreateCosmosUser = Exception;
 EUnknownRole = Exception;
 ESetProfileUser = Exception;
 ELogSystem = Exception;
 ETurmaInstalada = Exception;
 EReportException = class(Exception);

 //Database error
 EDataOperationError = Exception;

 //Atividades
 ECannotDeleteActivity = Exception;
 EFrequenciaLevantada = Exception;

 //Classe usada para quando arquivos não forem encontrados.
 ECannotFindFile = Exception;

 //Classe usada para quando uma pesquisa da Central de Pesquisas não for encontrada.
 ECannotFindCommand = Exception;
 EValidateOperation = Exception;

 //Financeiro
 EContaBancariaEmUso = Exception;



 TCosmosErrorCode = LongInt;

 TCosmosErrorCodes =  class
    const
      ///<summary>Parâmetro de pesquisa é inválido.</summary>
      InvalidSearchParams          = -$0001;
      ///<summary>O resultado da busca é vazio.</summary>
      EmptyDataset                  = -$0002;
      ///<summary>Erro genérico que mapeia falha na obtenção de dados.</summary>
      SelectData                = -$0003;
      ///<summary>O cadastrado não pode ser escalado para a atividade da conferência,
      /// pois o mesmo não se encontra inscrito.
      ///</summary>
      InvalidEscaladoConferencia                       = -$0004;
      ///<summary>O cadastrado está falecido.</summary>
      CadastradoFalecido                        = -$0005;
      ///<summary>Código de erro reservado.</summary>
      EscalarFalecido                         = -$0006;
      ///<summary>Falha ao receber um módulo desconhecido do Cosmos durante .
      ///a abertura dos focos que o usuário pode acessar.</summary>
      OpenFocusUnknownModule                         = -$0007;
       ///<summary>O arquivo de configuração de pesquisas da Central de Pesquisas
       /// não foi encontrado no lado servidor.</summary>
      CannotOpenFileCentralPesquisa                      = -$0008;
      ///<summary>A pesquisa da Central de Pesquisas não foi encontrada no
      ///arquivo de configuração do lado servidor.</summary>
      CannotFindCentralPesquisaCmd                    = -$0009;
      ///<summary>Erro ao executar um script de comandos.</summary>
      ExecuteScript                                 = -$000A;
      ///<summary>Erro ao obter o valor de uma sequence.</summary>
      ExecuteCommand                     = -$000B;
      ///<summary>Erro ao selecionar o próximo valor de uma sequence.</summary>
      SelectSequenceData               = -$000C;
      ///<summary>Uma pesquisa previamente definada do Cosmos não foi encontrada.</summary>
      UnknownCosmosSearch                    = -$000D;
      ///<summary>Falha ao efetuar uma busca de dados de um cadastrado.</summary>
      CadastradosSearch                       = -$000E;
      ///<summary>Falha ao atualizar os dados dos membros dos grupos do TM.</summary>
      AtualizarGruposTM               = -$000F;
      ///<summary>Código de erro reservado.</summary>
      FrequenciaComputada                = -$0010;
      ///<summary>Falha ao gerar os dados de frequência em uma conferência.</summary>
      GerarFrequenciaConferencia              = -$0011;
      ///<summary>Não é possível localizar o cadastrado.</summary>
      CannotFindCadastrado                    = -$0012;
      ///<summary>Tentativa de transferência para o mesmo foco.</summary>
      TransferenciaMesmoFoco                   = -$0013;
      ///<summary>Não foi possível descobrir de que tipo o foco é.</summary>
      UnknownFocusType       = -$0014;
      ///<summary>Transferência de um aluno ou jovem do TM para um foco de tipo não permitido.</summary>
      TransferenciaInvalidaAluno                    = -$0015;
      ///<summary>Transferência de um pesquisador para um foco de tipo não permitido.</summary>
      TransferenciaInvalidaPesquisador                    = -$0016;
      ///<summary>O cadastrados já se encontra desligado.</summary>
      CadastradoDesligado                = -$0017;
      ///<summary>Erro genérico, não mapeado, para erros ao executar operações
      ///de salvamento de dados.</summary>
      ExecuteOperation                    = -$0018;
      ///<summary>Somente alunos e jovens do TM podem ser batizados.</summary>
      BatizadoCampo                             = -$0019;
      ///<summary>Somente alunos a partir do probatório podem ser batizados.</summary>
      BatizadoDiscipulado              = -$001A;
      ///<summary>O batizando somente pode ter até 28 anos inteiros.</summary>
      BatizadoIdade                      = -$001B;
      ///<summary>Um dos nubentes já está casado.</summary>
      CasarCasado                  = -$001C;
      ///<summary>A retrogradação não pode ser feita.</summary>
      RetrogradacaoIlegal                     = -$001D;
      ///<summary>A carta de frequência somente pode ser enviada para alunos.</summary>
      CartaFrequenciaCampo                    = -$001E;
      ///<summary>Falha ao mudar a senha do usuário..</summary>
      PasswordUpdate             = -$001F;
      ///<summary>Falha ao tentar resetar a senha do usuário.</summary>
      PasswordReset                       = -$0020;
      ///<summary>Falha ao tentar bloquear um usuário.</summary>
      LockUser               = -$0021;
      ///<summary>Falha genérica que ocorre no processo de autenticação ou na
      ///obtenção de dados sobre o usuário ou suas credenciais de acesso.</summary>
      AuthenticateProcess                 = -$0022;
      ///<summary>Falha ao obter os dados de um cadastrado.</summary>
      DadosCadastrado              = -$0023;
      ///<summary>Código de erro reservado.</summary>
      NovaTurmaTP            = -$0024;
      ///<summary>Código de erro reservado.</summary>
      CantDeleteTurmaTP                = -$0025;
      ///<summary>Código de erro reservado.</summary>
      DeleteTurmaTP                = -$0026;
      NumeroNovaTurmaTP                = -$0027;
      CreateUser                = -$0028;
      DeleteUser                = -$0029;
      GrantPermission                = -$0030;
      RevokePermission                = -$0031;
      GrantAdministrator                = -$0032;
      UnlockUser                = -$0033;
      LoginAlreadyExists                = -$0034;
      CreateUserAttributes         = -$0035;
      IlegalGrantUser         = -$0036;
      IlegalGrantRole         = -$0037;
      ResetPassword         = -$0038;
      UpdateData         = -$0039;
      DuplicatedAttributes   = -$0040;
      DelAttribute           = -$0041;
      SaveAreaStaff           = -$0042;
      DelFlagInscricao        = -$0043;
      CancelarInscricao       = -$0044;
      DesalojarInscrito       = -$0045;
      ClonarAlojamento        = -$0046;
      CantCreateReader        = -$0047;
      ChangeTarefaAreaStaff   = -$0048;
      CantOpenFileConfigurationsAll  = -$0049;
      CreateTurmaInstalacao  = -$0050;
      InstalarTurmaAluno     = -$0051;
      TurmaInstalada         = -$0052;
      ProtocoloAberto         = -$0053;
      NumeroTurmaInstalacao         = -$0054;
      DelMembroTurmaInstalacao         = -$0055;
      NovoInstalando                  = -$0056;
      InstalacaoInvalida                  = -$0057;
      AnularHistorico                  = -$0058;
      NovaMatricula                  = -$0059;
      DeleteLessonEI                  = -$0060;
      CantDeleteLessonEI                  = -$0061;
      ReorderBookEI                    = -$0062;
      ReorderLessonEI                    = -$0063;
      CantDeleteBookEI                    = -$0064;
      DeleteBookEI                    = -$0065;
      NovoCirculoEI                   = -$0066;
      DesativarCirculoEI                   = -$0067;
      DuplicatedMembroCirculoEI                   = -$0068;
      DeleteContaSubcontas                 = -$0069;
      DeleteContasUsadas                   = -$0070;
      DeleteConta                          = -$0071;
      MoveConta                          = -$0072;
      CaixaNovo                          = -$0073;
      CaixaFechar                        = -$0074;
      IdentificaoAtiva                        = -$0075;
      EncerrarTurmaTP                    = -$0076;
      ReativarTurmaTP                    = -$0077;
      DeleteContaBancaria                    = -$0078;
      DesativaContaBancaria                    = -$0079;
      ReativaContaBancaria                    = -$0080;
      ConnectTimeout                    = -$0081;
      SocksServerGeneralError                    = -$0082;
      ConnectError                    = -$0083;
      IncorrectServerModule                    = -$0084;
      UpdateAtributosInscricoes                    = -$0085;


      //Focos e regiões administrativas
      RenameRa                    = -$0500;
      MoveRa                    = -$0501;
      DeleteRa                    = -$0502;
      CannotDeleteRa                    = -$0503;
      CreateRa                    = -$0504;
      DesactiveFoco                    = -$0505;
      CannotDeleteFoco                    = -$0506;
      CannotDeleteFocoHistorico                    = -$0507;
      CannotDeleteFocoCadastrados                    = -$0508;
      CreateFoco = -$0509;
      CreateFocoDuplicado = -$0510;
      MoveFocoRa = -$0511;
      ChangeFocusParent = -$0512;
      ChangeFocusStatus  = -$0513;

      //Códigos vindo do Indy pelo dbExpress
      IndyConnectTimeout          = 10060; //Indy código para timeout de conexão.
      IndyRefusedConnection       = 10061; //Indy código para conexão recusada.
      IndyHostNotFound       =  11001; //Indy código para host não encontrado.


      class function ToMessage(const ErrorCode: TCosmosErrorCode): string;
      class function ToErrorCode(const ErrorCode: TCosmosErrorCode): string;
      class function IndyCodeToCosmosCode(const IndyCode: integer): integer; overload;
      class function IndyCodeToCosmosCode(E: EIdException): integer; overload;
  end;


implementation

{ TCosmosErrorCodes }

class function TCosmosErrorCodes.IndyCodeToCosmosCode(
  const IndyCode: integer): integer;
begin
 case IndyCode of
  10001: Result := TCosmosErrorCodes.IndyHostNotFound; //Host not found.
 end;
end;

class function TCosmosErrorCodes.IndyCodeToCosmosCode(E: EIdException): integer;
begin
 //Retorna um código de erro do Cosmos a partir de uma classe de exceção do Indy.
 if E is EIdConnectTimeout then Result := ConnectTimeout
 else
 if E is EIdSocksServerGeneralError then Result := SocksServerGeneralError
 else
 if E is EIdConnectException  then Result := ConnectError
 else
  Result := 0;
end;

class function TCosmosErrorCodes.ToErrorCode(
  const ErrorCode: TCosmosErrorCode): string;
begin
 //Retorna, para efeito de logs, um texto contendo o código do erro.
 Result := Format('Error code: %d', [ErrorCode]); //do not localize!
end;

class function TCosmosErrorCodes.ToMessage(const ErrorCode: TCosmosErrorCode): string;
begin
 case ErrorCode of
   TCosmosErrorCodes.InvalidSearchParams: Result := TCosmosErrorMsg.InvalidSearchParams;
   TCosmosErrorCodes.EmptyDataset: Result := TCosmosErrorMsg.EmptyDataset;
   TCosmosErrorCodes.SelectData: Result :=  TCosmosErrorMsg.SelectData;
   TCosmosErrorCodes.InvalidEscaladoConferencia: Result :=  TCosmosErrorMsg.EscalaConferenciaInvalida;
   TCosmosErrorCodes.CadastradoFalecido: Result :=  TCosmosErrorMsg.CadastradoFalecido;
   TCosmosErrorCodes.EscalarFalecido: Result :=  TCosmosErrorMsg.EscalarFalecido;
   TCosmosErrorCodes.OpenFocusUnknownModule: Result :=  TCosmosErrorMsg.OpenFocusUnknownModule;
   TCosmosErrorCodes.CannotOpenFileCentralPesquisa: Result := TCosmosErrorMsg.CannotOpenFileCentralPesquisaServer;
   TCosmosErrorCodes.CannotFindCentralPesquisaCmd: Result := TCosmosErrorMsg.CannotFindCentralPesquisaCmd;
   TCosmosErrorCodes.ExecuteScript: Result :=  TCosmosErrorMsg.ExecuteScript;
   TCosmosErrorCodes.ExecuteCommand: Result :=  TCosmosErrorMsg.ExecuteCommand;
   TCosmosErrorCodes.SelectSequenceData: Result :=  TCosmosErrorMsg.SelectSequenceData;
   TCosmosErrorCodes.UnknownCosmosSearch: Result :=  TCosmosErrorMsg.UnknownCosmosSearch;
   TCosmosErrorCodes.CadastradosSearch: Result :=  TCosmosErrorMsg.CadastradosSearch;
   TCosmosErrorCodes.AtualizarGruposTM: Result :=  TCosmosErrorMsg.AtualizarGruposTM;
   TCosmosErrorCodes.FrequenciaComputada: Result :=  TCosmosInfoMsg.FrequenciaComputada;
   TCosmosErrorCodes.GerarFrequenciaConferencia: Result :=  TCosmosErrorMsg.GerarFrequenciaConferencia;
   TCosmosErrorCodes.CannotFindCadastrado: Result :=  TCosmosErrorMsg.CannotFindCadastrado;
   TCosmosErrorCodes.TransferenciaMesmoFoco: Result := TCosmosErrorMsg.TransferenciaMesmoFoco;
   TCosmosErrorCodes.UnknownFocusType: Result := TCosmosErrorMsg.UnknownFocusType;
   TCosmosErrorCodes.TransferenciaInvalidaAluno: Result := TCosmosErrorMsg.TransferenciaInvalidaAluno;
   TCosmosErrorCodes.TransferenciaInvalidaPesquisador: Result := TCosmosErrorMsg.TransferenciaInvalidaPesquisador;
   TCosmosErrorCodes.CadastradoDesligado: Result := TCosmosErrorMsg.CadastradoDesligado;
   TCosmosErrorCodes.ExecuteOperation: Result := TCosmosErrorMsg.ExecuteOperation;
   TCosmosErrorCodes.BatizadoCampo: Result :=  TCosmosErrorMsg.BatizadoCampo;
   TCosmosErrorCodes.BatizadoDiscipulado: Result :=  TCosmosErrorMsg.BatizadoDiscipulado;
   TCosmosErrorCodes.BatizadoIdade: Result :=  TCosmosErrorMsg.BatizadoIdade;
   TCosmosErrorCodes.CasarCasado: Result :=  TCosmosErrorMsg.CasarCasado;
   TCosmosErrorCodes.RetrogradacaoIlegal: Result :=  TCosmosErrorMsg.RetrogradacaoIlegal;
   TCosmosErrorCodes.CartaFrequenciaCampo: Result :=  TCosmosErrorMsg.CartaFrequenciaCampo;
   TCosmosErrorCodes.PasswordUpdate: Result :=  TCosmosErrorMsg.PasswordUpdate;
   TCosmosErrorCodes.PasswordReset: Result :=  TCosmosErrorMsg.PasswordReset;
   TCosmosErrorCodes.LockUser: Result :=  TCosmosErrorMsg.LockUser;
   TCosmosErrorCodes.AuthenticateProcess: Result :=  TCosmosErrorMsg.AuthenticateProcess;
   TCosmosErrorCodes.DadosCadastrado: Result :=  TCosmosErrorMsg.DadosCadastrado;
   TCosmosErrorCodes.NovaTurmaTP: Result :=  TCosmosErrorMsg.NovaTurmaTP;
   TCosmosErrorCodes.CantDeleteTurmaTP: Result :=  TCosmosErrorMsg.CantDeleteTurmaTP;
   TCosmosErrorCodes.DeleteTurmaTP: Result :=  TCosmosErrorMsg.DeleteTurmaTP;
   TCosmosErrorCodes.NumeroNovaTurmaTP: Result :=  TCosmosErrorMsg.NumeroNovaTurmaTP;
   TCosmosErrorCodes.CreateUser: Result :=  TCosmosErrorMsg.CreateUser;
   TCosmosErrorCodes.DeleteUser: Result :=  TCosmosErrorMsg.DeleteUser;
   TCosmosErrorCodes.GrantPermission: Result :=  TCosmosErrorMsg.GrantPermission;
   TCosmosErrorCodes.RevokePermission: Result :=  TCosmosErrorMsg.RevokePermission;
   TCosmosErrorCodes.GrantAdministrator: Result :=  TCosmosErrorMsg.GrantAdministrator;
   TCosmosErrorCodes.UnlockUser: Result :=  TCosmosErrorMsg.UnlockUser;
   TCosmosErrorCodes.LoginAlreadyExists: Result :=  TCosmosErrorMsg.LoginAlreadyExists;
   TCosmosErrorCodes.CreateUserAttributes: Result :=  TCosmosErrorMsg.CreateUserAttributes;
   TCosmosErrorCodes.IlegalGrantUser: Result :=  TCosmosErrorMsg.IlegalGrantUser;
   TCosmosErrorCodes.IlegalGrantRole: Result :=  TCosmosErrorMsg.IlegalGrantRole;
   TCosmosErrorCodes.ResetPassword: Result :=  TCosmosErrorMsg.ResetPassword;
   TCosmosErrorCodes.UpdateData: Result :=  TCosmosErrorMsg.UpdateData;
   TCosmosErrorCodes.DuplicatedAttributes: Result :=  TCosmosErrorMsg.DuplicatedAttributes;
   TCosmosErrorCodes.DelAttribute: Result :=  TCosmosErrorMsg.DelAttribute;
   TCosmosErrorCodes.SaveAreaStaff: Result :=  TCosmosErrorMsg.SaveAreaStaff;
   TCosmosErrorCodes.DelFlagInscricao: Result :=  TCosmosErrorMsg.DelFlagInscricao;
   TCosmosErrorCodes.CancelarInscricao: Result :=  TCosmosErrorMsg.CancelarInscricao;
   TCosmosErrorCodes.DesalojarInscrito: Result :=  TCosmosErrorMsg.DesalojarInscrito;
   TCosmosErrorCodes.ClonarAlojamento: Result :=  TCosmosErrorMsg.ClonarAlojamento;
   TCosmosErrorCodes.CantCreateReader: Result :=  TCosmosErrorMsg.CantCreateReader;
   TCosmosErrorCodes.ChangeTarefaAreaStaff: Result :=  TCosmosErrorMsg.ChangeTarefaAreaStaff;
   TCosmosErrorCodes.CantOpenFileConfigurationsAll: Result :=  TCosmosErrorMsg.CantOpenFileConfigurationsAll;
   TCosmosErrorCodes.CreateTurmaInstalacao: Result :=  TCosmosErrorSecMsg.CreateTurmaInstalacao;
   TCosmosErrorCodes.InstalarTurmaAluno: Result :=  TCosmosErrorSecMsg.InstalarTurmaAluno;
   TCosmosErrorCodes.TurmaInstalada: Result :=  TCosmosErrorSecMsg.TurmaInstalada;
   TCosmosErrorCodes.ProtocoloAberto: Result :=  TCosmosInfoMsg.ProtocoloAberto;
   TCosmosErrorCodes.NumeroTurmaInstalacao: Result :=  TCosmosErrorSecMsg.NumeroTurmaInstalacao;
   TCosmosErrorCodes.DelMembroTurmaInstalacao: Result :=  TCosmosErrorSecMsg.DelMembroTurmaInstalacao;
   TCosmosErrorCodes.NovoInstalando: Result :=  TCosmosErrorSecMsg.NovoInstalando;
   TCosmosErrorCodes.InstalacaoInvalida: Result :=  TCosmosErrorSecMsg.InstalacaoInvalida;
   TCosmosErrorCodes.AnularHistorico: Result :=  TCosmosErrorSecMsg.AnularHistorico;
   TCosmosErrorCodes.NovaMatricula: Result :=  TCosmosErrorSecMsg.NovaMatricula;
   TCosmosErrorCodes.DeleteLessonEI: Result :=  TCosmosErrorSecMsg.DeleteLessonEI;
   TCosmosErrorCodes.CantDeleteLessonEI: Result :=  TCosmosErrorSecMsg.CantDeleteLessonEI;
   TCosmosErrorCodes.ReorderBookEI: Result :=  TCosmosErrorSecMsg.ReorderBookEI;
   TCosmosErrorCodes.ReorderLessonEI: Result :=  TCosmosErrorSecMsg.ReorderLessonEI;
   TCosmosErrorCodes.CantDeleteBookEI: Result :=  TCosmosErrorSecMsg.CantDeleteBookEI;
   TCosmosErrorCodes.DeleteBookEI: Result :=  TCosmosErrorSecMsg.DeleteBookEI;
   TCosmosErrorCodes.NovoCirculoEI: Result :=  TCosmosErrorSecMsg.NovoCirculoEI;
   TCosmosErrorCodes.DesativarCirculoEI: Result :=  TCosmosErrorSecMsg.DesativarCirculoEI;
   TCosmosErrorCodes.DuplicatedMembroCirculoEI: Result :=  TCosmosErrorSecMsg.DuplicatedMembroCirculoEI;
   TCosmosErrorCodes.DeleteContaSubcontas: Result :=  TCosmosErrorFinMsg.DeleteContaSubcontas;
   TCosmosErrorCodes.DeleteContasUsadas: Result :=  TCosmosErrorFinMsg.DeleteContasUsadas;
   TCosmosErrorCodes.DeleteConta: Result :=  TCosmosErrorFinMsg.DeleteConta;
   TCosmosErrorCodes.MoveConta: Result :=  TCosmosErrorFinMsg.MoveConta;
   TCosmosErrorCodes.CaixaNovo: Result :=  TCosmosErrorFinMsg.CaixaNovo;
   TCosmosErrorCodes.CaixaFechar: Result :=  TCosmosErrorFinMsg.CaixaFechar;
   TCosmosErrorCodes.IdentificaoAtiva: Result :=  TCosmosErrorMsg.IdentificaoAtiva;
   TCosmosErrorCodes.EncerrarTurmaTP: Result :=  TCosmosErrorSecMsg.EncerrarTurmaTP;
   TCosmosErrorCodes.ReativarTurmaTP: Result :=  TCosmosErrorSecMsg.ReativarTurmaTP;
   //Focos e regiões administrativas
   TCosmosErrorCodes.RenameRa: Result :=  TCosmosErrorFocMsg.RenameRa;
   TCosmosErrorCodes.MoveRa: Result :=  TCosmosErrorFocMsg.MoveRa;
   TCosmosErrorCodes.DeleteRa: Result :=  TCosmosErrorFocMsg.DeleteRa;
   TCosmosErrorCodes.CannotDeleteRa: Result :=  TCosmosErrorFocMsg.DeleteRa;
   TCosmosErrorCodes.CreateRa: Result :=  TCosmosErrorFocMsg.CreateRa;
   TCosmosErrorCodes.DesactiveFoco: Result :=  TCosmosErrorFocMsg.DesactiveFoco;
   TCosmosErrorCodes.CannotDeleteFoco: Result := TCosmosErrorFocMsg.CannotDeleteFoco;
   TCosmosErrorCodes.CannotDeleteFocoCadastrados: Result := TCosmosErrorFocMsg.CannotDeleteFocoCadastrados;
   TCosmosErrorCodes.CannotDeleteFocoHistorico: Result := TCosmosErrorFocMsg.CannotDeleteFocoHistorico;
   TCosmosErrorCodes.CreateFoco: Result := TCosmosErrorFocMsg.CreateFoco;
   TCosmosErrorCodes.CreateFocoDuplicado: Result := TCosmosErrorFocMsg.CreateFocoDuplicado;
   TCosmosErrorCodes.MoveFocoRa: Result := TCosmosErrorFocMsg.MoveFocoRa;
   TCosmosErrorCodes.ChangeFocusParent: Result := TCosmosErrorFocMsg.ChangeFocusParent;
   TCosmosErrorCodes.ChangeFocusStatus: Result := TCosmosErrorFocMsg.ChangeFocusStatus;
   //Códigos de erros usados pelo Indy
   TCosmosErrorCodes.IndyConnectTimeout: Result := TCosmosErrorMsg.ConnectionTimeout;
   TCosmosErrorCodes.IndyHostNotFound: Result := TCosmosErrorMsg.HostNotFound;
   TCosmosErrorCodes.IndyRefusedConnection: Result := TCosmosErrorMsg.RefusedConnection;
   //Conexão
   TCosmosErrorCodes.ConnectTimeout: Result :=  TCosmosErrorMsg.ConnectionTimeout;
   TCosmosErrorCodes.SocksServerGeneralError: Result :=  TCosmosErrorMsg.SocksServerGeneralError;
   TCosmosErrorCodes.ConnectError: Result :=  TCosmosErrorMsg.ConnectError;

 end;

end;

end.
