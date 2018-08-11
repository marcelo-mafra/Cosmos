unit cosmos.secretarias.services.serverclass;

interface

uses System.SysUtils, Data.DBXCommon, cosmos.system.messages,Vcl.Forms,
 System.Variants, cosmos.classes.application, Cosmos.Framework.Interfaces.Root,
 Cosmos.Framework.Interfaces.Applications, cosmos.business.focos,
 cosmos.business.secretariats;

type
 TSecretariasServerClass = class(TInterfacedObject, ICosmosSecretarias)
   private
    FSecretariasOptions: TSecretariasOptions;
    function GetICosmosApp: ICosmosApplication;
    function GetSecretariasOptions: TSecretariasOptions;

   public
    constructor Create;
    destructor Destroy;

    {ICosmosSecretarias}

    //Escola Interna
    function CreateCircle(CircleData, Members: Olevariant): boolean;
    function DesactivateCircle(const CircleID: integer): boolean;

    //Movimentação do histórico discipular
    procedure BaptizePeople(const TaggedData: string);
    function DesactivatePeople(const TaggedData: string): boolean;
    function InvalidateEvent(const codhis: integer; Discipulado: string): boolean;
    function  LoadPreviousGrades(const coddis: integer; TM, TPU, SIM, Atual: boolean): TDBXReader;
    function NovaMatricula(const CampoTrabalho: TCampoTrabalho): string;
    function ReactivatePeople(const TaggedData: string): boolean;
    procedure RegisterMarriage(const TaggedData: string);
    function RetrogradatePeople(const TaggedData: string): boolean;
    procedure SendLetter(const TaggedData: string);
    function TransferPeople(const TaggedData: string): boolean;
    procedure UpdateAllYoungPupils(const codfoc: integer);

    //Trabalho Público
    function CloseTeam(const TeamID: integer): boolean;
    function CreatePublicTeam(const FocusID: integer; Team: Olevariant): boolean;
    procedure DeleteTeam(const TeamID: integer);
    function GetPublicTeamId(const FocusId: integer): string;
    function ReactivateTeam(const TeamID: integer): boolean;


    property ICosmosApp: ICosmosApplication read GetICosmosApp;
    property SecretariasOptions: TSecretariasOptions read GetSecretariasOptions;
 end;


implementation

{ TSecretariasServerClass }

function TSecretariasServerClass.CloseTeam(const TeamID: integer): boolean;
var
 ACommand: TDBXCommand;
begin
 {Encerra uma turma do Trabalho Público.}
 ACommand := ICosmosApp.IRemoteCon.CreateCommand;

 try
   ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
   ACommand.Text := 'TCosmosSecTPServerMethods.EncerrarTurmaTP';
   ACommand.Prepare;

   ACommand.Parameters[0].Value.SetInt32(TeamID);
   ACommand.ExecuteUpdate;

   Result := ACommand.Parameters[1].Value.GetBoolean;
   ICosmosApp.MainLog.RegisterRemoteCallSucess(Format(TCosmosLogs.ExecutedRemoteCommand, [ACommand.Text]), ICosmosApp.IRemoteCon.ConnectionParamsInfo);
   ACommand.Free;

 except
   on E: TDBXError do
    begin
     Result := False;
     ICosmosApp.MainLog.RegisterRemoteCallFailure(E.Message + ' - ' + ACommand.Text, ICosmosApp.IRemoteCon.ConnectionParamsInfo);
     if Assigned(ACommand) then FreeAndNil(ACommand);
    end;
   on E: Exception do
    begin
     Result := False;
     ICosmosApp.MainLog.RegisterRemoteCallFailure(Format(TCosmosLogs.ExecutedRemoteCommandFail, [ACommand.Text]), ICosmosApp.IRemoteCon.ConnectionParamsInfo);
     ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, TCosmosErrorMsg.ExecuteOperation);
     if Assigned(ACommand) then FreeAndNil(ACommand);
    end;
 end;
end;

constructor TSecretariasServerClass.Create;
begin
  inherited Create;
  fSecretariasOptions := TSecretariasOptions.Create;
end;

function TSecretariasServerClass.CreateCircle(CircleData,
  Members: Olevariant): boolean;
var
 ACommand: TDBXCommand;
begin
 ACommand := ICosmosApp.IRemoteCon.CreateCommand;

 try
  ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
  ACommand.Text := 'TCosmosSecEIServerMethods.NovoCirculo';
  ACommand.Prepare;

  ACommand.Parameters.Parameter[0].Value.AsVariant := CircleData;
  ACommand.Parameters.Parameter[1].Value.AsVariant := Members;
  ACommand.Parameters.Parameter[2].Value.SetString(ICosmosApp.IRemoteCon.ConnectedUser.ToUpper);
  ACommand.ExecuteUpdate;

  Result := ACommand.Parameters.Parameter[3].Value.GetBoolean;
  ICosmosApp.MainLog.RegisterRemoteCallSucess(ACommand.Text, ICosmosApp.IRemoteCon.ConnectionParamsInfo);

  ACommand.Free;

 except
   on E: Exception do
    begin
      Result := ACommand.Parameters.Parameter[2].Value.GetBoolean;;
      ICosmosApp.MainLog.RegisterRemoteCallFailure(E.Message, ACommand.Text);
      if Assigned(ACommand) then  FreeAndNil(ACommand);
     end;
   end;
end;


function TSecretariasServerClass.CreatePublicTeam(const FocusID: integer;
  Team: Olevariant): boolean;
var
 ACommand: TDBXCommand;
begin
  {Cria uma nova turma do Trabalho Público.}
  ACommand := ICosmosApp.IRemoteCon.CreateCommand;

  try
   ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
   ACommand.Text := 'TCosmosSecTPServerMethods.NovaTurmaTP';
   ACommand.Prepare;

   ACommand.Parameters[0].Value.SetInt32(FocusID);
   ACommand.Parameters[1].Value.AsVariant := Team;
   ACommand.ExecuteUpdate;

   Result := ACommand.Parameters[2].Value.AsBoolean;
   ICosmosApp.MainLog.RegisterRemoteCallSucess(Format(TCosmosLogs.ExecutedRemoteCommand, [ACommand.Text]), ICosmosApp.IRemoteCon.ConnectionParamsInfo);

   ACommand.Free;

 except
   on E: TDBXError do
    begin
     Result := False;
     ICosmosApp.MainLog.RegisterRemoteCallFailure(E.Message + ' - ' + ACommand.Text, ICosmosApp.IRemoteCon.ConnectionParamsInfo);
     if Assigned(ACommand) then FreeAndNil(ACommand);
    end;
   on E: Exception do
    begin
     Result := False;
     ICosmosApp.MainLog.RegisterRemoteCallFailure(Format(TCosmosLogs.ExecutedRemoteCommandFail, [ACommand.Text]), ICosmosApp.IRemoteCon.ConnectionParamsInfo);
     ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, TCosmosErrorMsg.ExecuteOperation);
     if Assigned(ACommand) then FreeAndNil(ACommand);
    end;
 end;
end;

procedure TSecretariasServerClass.BaptizePeople(const TaggedData: string);
var
 ACommand: TDBXCommand;
begin
 {Registra o batismo de um aluno ou jovem no seu histórico discipular.}
 ACommand := ICosmosApp.IRemoteCon.CreateCommand;

  try
   ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
   ACommand.Text := 'TCosmosSecHistoricoServerMethods.BatizarCadastrado';
   ACommand.Prepare;

   ACommand.Parameters[0].Value.AsVariant := TaggedData;
   ACommand.ExecuteUpdate;

   if ACommand.Parameters[1].Value.GetInt32 = 0 then
     begin
       ICosmosApp.MainLog.RegisterRemoteCallSucess(Format(TCosmosLogs.ExecutedRemoteCommand, [ACommand.Text]), ICosmosApp.IRemoteCon.ConnectionParamsInfo);
       ICosmosApp.DlgMessage.InfoMessage(TCosmosTitles.BatizarCadastrado, TCosmosInfoMsg.BatismoRegistrado);
     end;

   ACommand.Free;

  except
    on E: TDBXError do
       begin
        ICosmosApp.MainLog.RegisterRemoteCallFailure(E.Message + ' - ' + ACommand.Text, ICosmosApp.IRemoteCon.ConnectionParamsInfo);
        if Assigned(ACommand) then FreeAndNil(ACommand);
       end;
    on E: Exception do
       begin
        ICosmosApp.MainLog.RegisterRemoteCallFailure(E.Message + ' - ' + ACommand.Text, ICosmosApp.IRemoteCon.ConnectionParamsInfo);
        if Assigned(ACommand) then FreeAndNil(ACommand);
        ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, TCosmosErrorMsg.ExecuteOperation);
       end;
   end;
end;

procedure TSecretariasServerClass.DeleteTeam(const TeamID: integer);
var
 ACommand: TDBXCommand;
begin
 {Exclui uma turma do Trabalho Público}
 ACommand := ICosmosApp.IRemoteCon.CreateCommand;

 try
   ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
   ACommand.Text := 'TCosmosSecTPServerMethods.DeleteTurmaTP';
   ACommand.Prepare;

   ACommand.Parameters[0].Value.SetInt32(TeamID);
   ACommand.ExecuteUpdate;

   ICosmosApp.MainLog.RegisterRemoteCallSucess(ACommand.Text, ICosmosApp.IRemoteCon.ConnectionParamsInfo);
   ACommand.Free;

  except
   on E: Exception do
     begin
       ICosmosApp.MainLog.RegisterRemoteCallFailure(E.Message, ACommand.Text);
       if Assigned(ACommand) then FreeAndNil(ACommand);
     end;
  end;
end;

function TSecretariasServerClass.DesactivateCircle(
  const CircleID: integer): boolean;
var
ACommand: TDBXCommand;
begin
  //Desativa um círculo da Escola Interna.
  ACommand := ICosmosApp.IRemoteCon.CreateCommand;

  try
   ACommand.Text := 'TCosmosSecEIServerMethods.DesativarCirculo';
   ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
   ACommand.Prepare;
   ACommand.Parameters.Parameter[0].Value.SetInt32(CircleID);

   ACommand.ExecuteUpdate;

   Result := True;
   ICosmosApp.MainLog.RegisterRemoteCallSucess(ACommand.Text, ICosmosApp.IRemoteCon.ConnectionParamsInfo);
   ACommand.Free;

  except
   on E: Exception do
     begin
       Result := False;
       ICosmosApp.MainLog.RegisterRemoteCallFailure(E.Message, ACommand.Text);
       if Assigned(ACommand) then FreeAndNil(ACommand);
     end;
  end;
end;

function TSecretariasServerClass.DesactivatePeople(
  const TaggedData: string): boolean;
var
 ACommand: TDBXCommand;
begin
 {Desliga um aluno, jovem, pesquisador ou simpatizante.}
 Result := False;

 ACommand := ICosmosApp.IRemoteCon.CreateCommand;

  try
    ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
    ACommand.Text := 'TCosmosSecHistoricoServerMethods.DesligarCadastrado';
    ACommand.Prepare;

    ACommand.Parameters[0].Value.AsVariant := TaggedData;
    ACommand.ExecuteUpdate;

    Result := ACommand.Parameters[1].Value.GetInt32 = 0;

    if Result then
      begin
       ICosmosApp.MainLog.RegisterRemoteCallSucess(Format(TCosmosLogs.ExecutedRemoteCommand, [ACommand.Text]), ICosmosApp.IRemoteCon.ConnectionParamsInfo);
       ICosmosApp.DlgMessage.InfoMessage(TCosmosTitles.DesligarCadastrado, TCosmosInfoMsg.DesligamentoRegistrado);
      end;

    ACommand.Free;

  except
    on E: TDBXError do
       begin
        Result := False;
        ICosmosApp.MainLog.RegisterRemoteCallFailure(E.Message + ' - ' + ACommand.Text, ICosmosApp.IRemoteCon.ConnectionParamsInfo);
        if Assigned(ACommand) then FreeAndNil(ACommand);
       end;
    on E: Exception do
       begin
        Result := False;
        ICosmosApp.MainLog.RegisterRemoteCallFailure(E.Message + ' - ' + ACommand.Text, ICosmosApp.IRemoteCon.ConnectionParamsInfo);
        if Assigned(ACommand) then FreeAndNil(ACommand);
        ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, TCosmosErrorMsg.ExecuteOperation);
       end;
    end;
end;

function TSecretariasServerClass.InvalidateEvent(const codhis: integer;
  Discipulado: string): boolean;
var
 ACommand: TDBXCommand;
begin
 {Anula um evento do histórico discipular de uma pessoa.}
 Result := False;
 ACommand := ICosmosApp.IRemoteCon.CreateCommand;

 try
  ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
  ACommand.Text := 'TCosmosSecHistoricoServerMethods.AnularEventoHistorico';
  ACommand.Prepare;

  ACommand.Parameters[0].Value.SetInt32(codhis);
  ACommand.Parameters[1].Value.SetWideString(Discipulado);
  ACommand.Parameters[2].Value.SetWideString(ICosmosApp.IRemoteCon.CurrentUser.UserName.ToUpper);
  ACommand.ExecuteUpdate;

  ACommand.Free;
  Result := True;

 except
  on E: Exception do
   begin
    Result := False;
    if Assigned(ACommand) then FreeAndNil(ACommand);
    ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, E.Message);
   end;
 end;
end;

destructor TSecretariasServerClass.Destroy;
begin
  fSecretariasOptions.Free;
  inherited;
end;

function TSecretariasServerClass.ReactivatePeople(const TaggedData: string): boolean;
var
ACommand: TDBXCommand;
begin
{Religa um aluno, jovem, pesquisador ou simpatizante.}
 Result := False;
 ACommand := ICosmosApp.IRemoteCon.CreateCommand;

 try
   ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
   ACommand.Text := 'TCosmosSecHistoricoServerMethods.ReativarCadastrado';
   ACommand.Prepare;

   ACommand.Parameters[0].Value.AsVariant := TaggedData;
   ACommand.ExecuteUpdate;

   Result := ACommand.Parameters[1].Value.GetInt32 = 0;
     if Result then
       begin
         ICosmosApp.MainLog.RegisterRemoteCallSucess(Format(TCosmosLogs.ExecutedRemoteCommand, [ACommand.Text]), ICosmosApp.IRemoteCon.ConnectionParamsInfo);
         ICosmosApp.DlgMessage.InfoMessage(TCosmosTitles.ReativarCadastrado, TCosmosInfoMsg.ReligamentoRegistrado);
       end;

   ACommand.Free;

 except
   on E: TDBXError do
     begin
       Result := False;
       ICosmosApp.MainLog.RegisterRemoteCallFailure(E.Message + ' - ' + ACommand.Text, ICosmosApp.IRemoteCon.ConnectionParamsInfo);
       if Assigned(ACommand) then FreeAndNil(ACommand);
     end;
   on E: Exception do
     begin
       Result := False;
       ICosmosApp.MainLog.RegisterRemoteCallFailure(E.Message + ' - ' + ACommand.Text, ICosmosApp.IRemoteCon.ConnectionParamsInfo);
       if Assigned(ACommand) then FreeAndNil(ACommand);
       ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, TCosmosErrorMsg.ExecuteOperation);
     end;
   end;
end;


function TSecretariasServerClass.ReactivateTeam(const TeamID: integer): boolean;
var
 ACommand: TDBXCommand;
begin
 {Reativa uma turma do Trabalho Público.}
 ACommand := ICosmosApp.IRemoteCon.CreateCommand;

 try
   ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
   ACommand.Text := 'TCosmosSecTPServerMethods.ReativarTurmaTP';
   ACommand.Prepare;

   ACommand.Parameters[0].Value.SetInt32(TeamID);
   ACommand.ExecuteUpdate;

   Result := ACommand.Parameters[1].Value.GetBoolean = True;
   ICosmosApp.MainLog.RegisterRemoteCallSucess(Format(TCosmosLogs.ExecutedRemoteCommand, [ACommand.Text]), ICosmosApp.IRemoteCon.ConnectionParamsInfo);
   ACommand.Free;

 except
   on E: TDBXError do
    begin
     Result := False;
     ICosmosApp.MainLog.RegisterRemoteCallFailure(E.Message + ' - ' + ACommand.Text, ICosmosApp.IRemoteCon.ConnectionParamsInfo);
     if Assigned(ACommand) then FreeAndNil(ACommand);
    end;
   on E: Exception do
    begin
     Result := False;
     ICosmosApp.MainLog.RegisterRemoteCallFailure(Format(TCosmosLogs.ExecutedRemoteCommandFail, [ACommand.Text]), ICosmosApp.IRemoteCon.ConnectionParamsInfo);
     ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, TCosmosErrorMsg.ExecuteOperation);
     if Assigned(ACommand) then FreeAndNil(ACommand);
    end;
 end;
end;

procedure TSecretariasServerClass.RegisterMarriage(const TaggedData: string);
var
 ACommand: TDBXCommand;
begin
 {Registra no histórico discipular a ocorrência de um casamento.}
  ACommand := ICosmosApp.IRemoteCon.CreateCommand;

  try
    ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
    ACommand.Text := 'TCosmosSecHistoricoServerMethods.CasarCadastrados';
    ACommand.Prepare;

    ACommand.Parameters[0].Value.AsVariant := TaggedData;
    ACommand.ExecuteUpdate;

    if ACommand.Parameters[1].Value.GetInt32 = 0 then
      begin
        ICosmosApp.MainLog.RegisterRemoteCallSucess(Format(TCosmosLogs.ExecutedRemoteCommand, [ACommand.Text]), ICosmosApp.IRemoteCon.ConnectionParamsInfo);
        ICosmosApp.DlgMessage.InfoMessage(TCosmosTitles.CasarCadastrados, TCosmosInfoMsg.CasamentoRegistrado);
      end;

    ACommand.Free;

  except
    on E: TDBXError do
       begin
        ICosmosApp.MainLog.RegisterRemoteCallFailure(E.Message + ' - ' + ACommand.Text, ICosmosApp.IRemoteCon.ConnectionParamsInfo);
        if Assigned(ACommand) then FreeAndNil(ACommand);
       end;
    on E: Exception do
       begin
        ICosmosApp.MainLog.RegisterRemoteCallFailure(E.Message + ' - ' + ACommand.Text, ICosmosApp.IRemoteCon.ConnectionParamsInfo);
        if Assigned(ACommand) then FreeAndNil(ACommand);
        ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, TCosmosErrorMsg.ExecuteOperation);
       end;
     end;
end;

function TSecretariasServerClass.RetrogradatePeople(const TaggedData: string): boolean;
var
ACommand: TDBXCommand;
begin
{Retrograda um aluno, jovem, pesquisador ou simpatizante para outro discipulado.}
 Result := False;
 ACommand := ICosmosApp.IRemoteCon.CreateCommand;

 try
   ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
   ACommand.Text := 'TCosmosSecHistoricoServerMethods.RetrogradarAluno';
   ACommand.Prepare;

   ACommand.Parameters[0].Value.AsVariant := TaggedData;
   ACommand.ExecuteUpdate;

   Result := ACommand.Parameters[1].Value.GetInt32 = 0;
   if Result then
     begin
       ICosmosApp.MainLog.RegisterRemoteCallSucess(Format(TCosmosLogs.ExecutedRemoteCommand, [ACommand.Text]), ICosmosApp.IRemoteCon.ConnectionParamsInfo);
       ICosmosApp.DlgMessage.InfoMessage(TCosmosTitles.RetrogradarCadastrado, TCosmosInfoMsg.RetrogradacaoRegistrada);
     end;

   ACommand.Free;

 except
   on E: TDBXError do
     begin
       Result := False;
       ICosmosApp.MainLog.RegisterRemoteCallFailure(E.Message + ' - ' + ACommand.Text, ICosmosApp.IRemoteCon.ConnectionParamsInfo);
       if Assigned(ACommand) then FreeAndNil(ACommand);
     end;
   on E: Exception do
     begin
       Result := False;
       ICosmosApp.MainLog.RegisterRemoteCallFailure(E.Message + ' - ' + ACommand.Text, ICosmosApp.IRemoteCon.ConnectionParamsInfo);
       if Assigned(ACommand) then FreeAndNil(ACommand);
       ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, TCosmosErrorMsg.ExecuteOperation);
     end;
 end;
end;


function TSecretariasServerClass.TransferPeople(const TaggedData: string): boolean;
var
ACommand: TDBXCommand;
begin
{Transfere um aluno, jovem, pesquisador ou simpatizante para determinado foco.}
 ACommand := ICosmosApp.IRemoteCon.CreateCommand;

 try
   ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
   ACommand.Text := 'TCosmosSecHistoricoServerMethods.TransferirCadastrado';
   ACommand.Prepare;

   ACommand.Parameters[0].Value.AsVariant := TaggedData;
   ACommand.ExecuteUpdate;

   Result := ACommand.Parameters[1].Value.GetInt32 = 0;  //tranferência feita com sucesso.
   if Result then
      ICosmosApp.MainLog.RegisterRemoteCallSucess(Format(TCosmosLogs.ExecutedRemoteCommand, [ACommand.Text]), ICosmosApp.IRemoteCon.ConnectionParamsInfo);

   ACommand.Free;

 except
   on E: TDBXError do
    begin
     Result := False;
     ICosmosApp.MainLog.RegisterRemoteCallFailure(E.Message + ' - ' + ACommand.Text, ICosmosApp.IRemoteCon.ConnectionParamsInfo);
     if Assigned(ACommand) then FreeAndNil(ACommand);
    end;
   on E: Exception do
    begin
     Result := False;
     if Assigned(ACommand) then FreeAndNil(ACommand);
       ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, TCosmosErrorMsg.ExecuteOperation);
    end;
 end;
end;

function TSecretariasServerClass.GetICosmosApp: ICosmosApplication;
begin
 Result := Application.MainForm as ICosmosApplication;
end;

function TSecretariasServerClass.GetPublicTeamId(
  const FocusId: integer): string;
var
 ACommand: TDBXCommand;
begin
  {Obtém um novo código para turmas do Trabalho Público.}
  ACommand := ICosmosApp.IRemoteCon.CreateCommand;

  try
   ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
   ACommand.Text := 'TCosmosSecTPServerMethods.GetNextTurmaTPID';
   ACommand.Prepare;

   ACommand.Parameters[0].Value.SetInt32(FocusID);
   ACommand.ExecuteUpdate;

   Result := ACommand.Parameters[1].Value.AsString;
   ICosmosApp.MainLog.RegisterRemoteCallSucess(ACommand.Text, ICosmosApp.IRemoteCon.ConnectionParamsInfo);

   ACommand.Free;

  except
   on E: TDBXError do
    begin
     ICosmosApp.MainLog.RegisterRemoteCallFailure(E.Message + ' - ' + ACommand.Text, ICosmosApp.IRemoteCon.ConnectionParamsInfo);
     if Assigned(ACommand) then FreeAndNil(ACommand);
    end;
   on E: Exception do
    begin
     ICosmosApp.MainLog.RegisterRemoteCallFailure(E.Message + ' - ' + ACommand.Text, ICosmosApp.IRemoteCon.ConnectionParamsInfo);
     if Assigned(ACommand) then FreeAndNil(ACommand);
     ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, TCosmosErrorMsg.ExecuteOperation);
    end;
  end;
end;

function TSecretariasServerClass.GetSecretariasOptions: TSecretariasOptions;
begin
 Result := FSecretariasOptions;
end;

function TSecretariasServerClass.LoadPreviousGrades(
  const coddis: integer;  TM, TPU, SIM, Atual: boolean): TDBXReader;
var
 ACommand: TDBXCommand;
begin
 {Retorna os discipulados anteriores a determinado discipulado.}
 ACommand := ICosmosApp.IRemoteCon.CreateCommand;

 try
  ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
  ACommand.Text := 'TCosmosSecHistoricoServerMethods.GetDiscipuladosAnteriores';
  ACommand.Prepare;

  ACommand.Parameters[0].Value.SetInt32(coddis);
  ACommand.Parameters[1].Value.SetBoolean(TM);
  ACommand.Parameters[2].Value.SetBoolean(TPU);
  ACommand.Parameters[3].Value.SetBoolean(SIM);
  ACommand.Parameters[4].Value.SetBoolean(Atual);
  ACommand.ExecuteUpdate;

  Result := ACommand.Parameters[5].Value.GetDBXReader(False);
  ICosmosApp.MainLog.RegisterRemoteCallSucess(Format(TCosmosLogs.ExecutedRemoteCommand, [ACommand.Text]), ICosmosApp.IRemoteCon.ConnectionParamsInfo);

  ACommand.Free;

 except
  on E: Exception do
   begin
     ICosmosApp.MainLog.RegisterRemoteCallFailure(Format(TCosmosLogs.ExecutedRemoteCommandFail, [ACommand.Text]), ICosmosApp.IRemoteCon.ConnectionParamsInfo);
    if Assigned(ACommand) then FreeAndNil(ACommand);
    raise;
   end;
 end
end;

function TSecretariasServerClass.NovaMatricula(
  const CampoTrabalho: TCampoTrabalho): string;
var
 ACommand: TDBXCommand;
begin
 //Gera uma nova matrícula.
 ACommand := ICosmosApp.IRemoteCon.CreateCommand;

 try
  ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
  ACommand.Text := 'TCosmosSecHistoricoServerMethods.NovaMatricula';

  ACommand.Prepare;
  ACommand.Parameters[0].Value.SetInt32(ICosmosApp.ActiveFocus.FocusID);
  ACommand.Parameters[1].Value.SetInt32(Ord(CampoTrabalho));
  ACommand.Parameters[2].Value.SetInt32(Ord(SecretariasOptions.NewMatriculaMode));
  ACommand.ExecuteUpdate;

  Result := ACommand.Parameters[3].Value.GetWideString;
  ICosmosApp.MainLog.RegisterRemoteCallSucess(Format(TCosmosLogs.ExecutedRemoteCommand, [ACommand.Text]), ICosmosApp.IRemoteCon.ConnectionParamsInfo);
  ACommand.Free;

 except
  on E: Exception do
   begin
    ICosmosApp.MainLog.RegisterRemoteCallFailure(E.Message + ' - ' + ACommand.Text, ICosmosApp.IRemoteCon.ConnectionParamsInfo);
    if Assigned(ACommand) then FreeAndNil(ACommand);
    ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, E.Message);
   end;
 end;
end;

procedure TSecretariasServerClass.UpdateAllYoungPupils(const codfoc: integer);
var
 ACommand: TDBXCommand;
begin
{Atualiza automaticamente o flag que indica que o aluno pertence ao grupo de
 jovens alunos. O fator que determina isso é apenas a idade.}

 ACommand := ICosmosApp.IRemoteCon.CreateCommand;

 try
  ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
  ACommand.Text := 'TDMSecLectoriumServerMethods.AtualizarJovensAlunos';
  ACommand.Prepare;

  ACommand.Parameters[0].Value.SetInt32(codfoc);
  ACommand.ExecuteUpdate;

  ACommand.Free;

 except
  on E: Exception do
   begin
    if Assigned(ACommand) then FreeAndNil(ACommand);
    ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, E.Message);
   end;
  end;
end;

procedure TSecretariasServerClass.SendLetter(const TaggedData: string);
var
 ACommand: TDBXCommand;
begin
 {Registra no histórico o envio de uma carta de freqüência.}
 ACommand := ICosmosApp.IRemoteCon.CreateCommand;

  try
   ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
   ACommand.Text := 'TCosmosSecHistoricoServerMethods.EnviarCartaFrequencia';
   ACommand.Prepare;

   ACommand.Parameters[0].Value.AsVariant := TaggedData;
   ACommand.ExecuteUpdate;

   if ACommand.Parameters[1].Value.GetInt32 = 0 then
     begin
       ICosmosApp.MainLog.RegisterRemoteCallSucess(Format(TCosmosLogs.ExecutedRemoteCommand, [ACommand.Text]), ICosmosApp.IRemoteCon.ConnectionParamsInfo);
       ICosmosApp.DlgMessage.InfoMessage(TCosmosTitles.CartaFrequencia, TCosmosInfoMsg.CartaFrequenciaRegistrada);
     end;

   ACommand.Free;

  except
    on E: TDBXError do
      begin
        ICosmosApp.MainLog.RegisterRemoteCallFailure(E.Message + ' - ' + ACommand.Text, ICosmosApp.IRemoteCon.ConnectionParamsInfo);
        if Assigned(ACommand) then FreeAndNil(ACommand);
      end;
    on E: Exception do
      begin
        ICosmosApp.MainLog.RegisterRemoteCallFailure(E.Message + ' - ' + ACommand.Text, ICosmosApp.IRemoteCon.ConnectionParamsInfo);
        if Assigned(ACommand) then FreeAndNil(ACommand);
        ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, TCosmosErrorMsg.ExecuteOperation);
      end;
  end;
end;



end.
