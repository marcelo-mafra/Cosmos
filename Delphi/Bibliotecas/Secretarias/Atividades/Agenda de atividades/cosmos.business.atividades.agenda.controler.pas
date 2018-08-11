unit cosmos.business.atividades.agenda.controler;

interface

uses
 System.Classes, System.SysUtils, cosmos.classes.application, cosmos.framework.interfaces.root,
 cosmos.framework.interfaces.dialogs, cosmos.system.messages, cosmos.business.focos,
 Vcl.Forms, cosmos.system.types;


type
  TAgendaControler = class(TInterfacedPersistent, IAgendaAtividades)

   protected
    procedure OpenAgendaAtividades;
    procedure NovaAtividade(const CampoTrabalho: TCampoTrabalho; ADefault: TCosmosData);
    procedure EditarAtividade(const CampoTrabalho: TCampoTrabalho; codati: integer);
    procedure EditarEscalasAtividade(const codati: integer);
    procedure EditarParticipantes(const codati: integer);
    procedure CadastrarTiposAtividades;

   public
    { Public declarations }
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses cosmos.secretarias.view.FormEditarAtividadeLEC, cosmos.secretarias.view.FormEditarAtividadeTM,
  cosmos.secretarias.view.FormEditarAtividadeTMB, cosmos.secretarias.view.FormEditarEscalas,
  cosmos.secretarias.view.FormEditarTiposAtividades, cosmos.secretarias.view.FormEditarParticipantes,
  cosmos.secretarias.view.FormEditarAtividadeEI, cosmos.secretarias.view.FormEditarAtividadeTP,
  cosmos.secretarias.view.FormEditarAtividadeSIM;

{ TAgendaControler }

procedure TAgendaControler.CadastrarTiposAtividades;
begin
 if not Assigned(FrmEditarTiposAtividades) then
  FrmEditarTiposAtividades := TFrmEditarTiposAtividades.Create(Application);

 try
  FrmEditarTiposAtividades.EditarTiposAtividades;

 finally
  if Assigned(FrmEditarTiposAtividades) then
   FreeAndNil(FrmEditarTiposAtividades);
 end;
end;

constructor TAgendaControler.Create;
begin
 inherited Create;
end;

destructor TAgendaControler.Destroy;
begin
 inherited Destroy;
end;

procedure TAgendaControler.EditarAtividade(const CampoTrabalho: TCampoTrabalho; codati: integer);
var
ICosmosApp: ICosmosApplication;
AMessage: TMEssageData;
begin
 case CampoTrabalho of
  ctLectorium, ctEI:
    begin
     FrmEditarAtividadesLEC := TFrmEditarAtividadesLEC.Create(Application);
     try
      FrmEditarAtividadesLEC.EditarAtividade(codati);
     finally
      if Assigned(FrmEditarAtividadesLEC) then FreeAndNil(FrmEditarAtividadesLEC)
     end;
    end;
  ctTM:
    begin
     FrmEditarAtividadesTM := TFrmEditarAtividadesTM.Create(Application);
     try
      FrmEditarAtividadesTM.EditarAtividade(codati);
     finally
      if Assigned(FrmEditarAtividadesTM) then FreeAndNil(FrmEditarAtividadesTM)
     end;
    end;
  ctTMB:
    begin
     FrmEditarAtividadesTMB := TFrmEditarAtividadesTMB.Create(Application);
     try
      FrmEditarAtividadesTMB.EditarAtividade(codati);
     finally
      if Assigned(FrmEditarAtividadesTMB) then FreeAndNil(FrmEditarAtividadesTMB)
     end;
    end;
  ctTP:
    begin
     FrmEditarAtividadesTP := TFrmEditarAtividadesTP.Create(Application);
     try
      FrmEditarAtividadesTP.EditarAtividade(codati);
     finally
      if Assigned(FrmEditarAtividadesTP) then FreeAndNil(FrmEditarAtividadesTP)
     end;
    end;
  ctSimpatizantes:
    begin
     FrmEditarAtividadesSIM := TFrmEditarAtividadesSIM.Create(Application);
     try
      FrmEditarAtividadesSIM.EditarAtividade(codati);
     finally
      if Assigned(FrmEditarAtividadesSIM) then FreeAndNil(FrmEditarAtividadesSIM)
     end;
    end;
  ctAll, ctNone:
    begin
     ICosmosApp := Application.MainForm as ICosmosApplication;
     AMessage := ICosmosApp.CreateMessageData(TCosmosInfoMsg.ConferenciaPromotorInvalido, TCosmosTitles.Conferencias, mtpInformation);

     try
      ICosmosApp.DlgMessage.Execute(AMessage);

     finally
      if Assigned(AMessage) then FreeAndNil(AMessage);
      if Assigned(ICosmosApp) then ICosmosApp := nil;
     end;
    end;
 end;
end;

procedure TAgendaControler.EditarEscalasAtividade(const codati: integer);
begin
 if not Assigned(FrmEditarEscalas) then
  FrmEditarEscalas := TFrmEditarEscalas.Create(Application);

 try
  FrmEditarEscalas.EditarEscalas(codati);

 finally
  if Assigned(FrmEditarEscalas) then
   FreeAndNil(FrmEditarEscalas);
 end;
end;

procedure TAgendaControler.EditarParticipantes(const codati: integer);
begin
 if not Assigned(FrmEditarParticipantes) then
  FrmEditarParticipantes := TFrmEditarParticipantes.Create(Application);

 try
  FrmEditarParticipantes.EditarParticipantes(codati);

 finally
  if Assigned(FrmEditarParticipantes) then
   FreeAndNil(FrmEditarParticipantes);
 end;
end;

procedure TAgendaControler.NovaAtividade(const CampoTrabalho: TCampoTrabalho;
  ADefault: TCosmosData);
var
ICosmosApp: ICosmosApplication;
AMessage: TMessageData;
begin
 case CampoTrabalho  of
  ctLectorium:
    begin
     FrmEditarAtividadesLEC := TFrmEditarAtividadesLEC.Create(Application);
     try
      FrmEditarAtividadesLEC.NovaAtividade(ADefault);
     finally
      if Assigned(FrmEditarAtividadesLEC) then FreeAndNil(FrmEditarAtividadesLEC)
     end;
    end;
  ctTM:
    begin
     FrmEditarAtividadesTM := TFrmEditarAtividadesTM.Create(Application);
     try
      FrmEditarAtividadesTM.NovaAtividade(ADefault);
     finally
      if Assigned(FrmEditarAtividadesTM) then FreeAndNil(FrmEditarAtividadesTM)
     end;
    end;
  ctTMB:
    begin
     FrmEditarAtividadesTMB := TFrmEditarAtividadesTMB.Create(Application);
     try
      FrmEditarAtividadesTMB.NovaAtividade(ADefault);
     finally
      if Assigned(FrmEditarAtividadesTMB) then FreeAndNil(FrmEditarAtividadesTMB)
     end;
    end;
  ctTP:
    begin
     FrmEditarAtividadesTP := TFrmEditarAtividadesTP.Create(Application);
     try
      FrmEditarAtividadesTP.NovaAtividade(ADefault);
     finally
      if Assigned(FrmEditarAtividadesTP) then FreeAndNil(FrmEditarAtividadesTP)
     end;
    end;
  ctSimpatizantes:
    begin
     FrmEditarAtividadesSIM := TFrmEditarAtividadesSIM.Create(Application);
     try
      FrmEditarAtividadesSIM.NovaAtividade(ADefault);
     finally
      if Assigned(FrmEditarAtividadesSIM) then FreeAndNil(FrmEditarAtividadesSIM)
     end;
    end;
  ctEI:
    begin
     FrmEditarAtividadesEI := TFrmEditarAtividadesEI.Create(Application);
     try
      FrmEditarAtividadesEI.NovaAtividade(ADefault);
     finally
      if Assigned(FrmEditarAtividadesEI) then FreeAndNil(FrmEditarAtividadesEI)
     end;
    end;
  ctAll, ctNone:
    begin
     ICosmosApp := Application.MainForm as ICosmosApplication;
     AMessage := ICosmosApp.CreateMessageData(TCosmosInfoMsg.ConferenciaPromotorInvalido, TCosmosTitles.Conferencias, mtpInformation);

     try
      ICosmosApp.DlgMessage.Execute(AMessage);

     finally
      if Assigned(AMessage) then FreeAndNil(AMessage);
      if Assigned(ICosmosApp) then ICosmosApp := nil;
     end;
    end;
 end;
end;

procedure TAgendaControler.OpenAgendaAtividades;
begin

end;

initialization
 RegisterClass(TAgendaControler);

finalization
 UnRegisterClass(TAgendaControler);

end.
