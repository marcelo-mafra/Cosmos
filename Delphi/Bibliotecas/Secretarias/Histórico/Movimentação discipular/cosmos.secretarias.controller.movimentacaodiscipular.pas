unit cosmos.secretarias.controller.movimentacaodiscipular;

interface

uses
 System.Classes, System.SysUtils, cosmos.classes.application, cosmos.framework.interfaces.root,
 cosmos.framework.interfaces.dialogs, cosmos.system.messages, Vcl.Forms;


type
  TMovimentacaoDiscipularControler = class(TInterfacedPersistent, IDialogMovimentacaoDiscipular)
   private
    //function GetDiscipuladoCadastrado(const codcad: integer): integer;

   protected
     procedure BatizarCadastrado(const codcad: integer);
     function DesligarCadastrado(const codcad: integer): boolean;
     procedure EnviarCarta(const codcad: integer);
     procedure RegistrarCasamento(codcad: integer);
     function ReligarCadastrado(const codcad: integer): boolean;
     function RetrogradarCadastrado(const codcad: integer): boolean;
     function TransferirCadastrado(const codcad: integer): boolean;
     function TransferirAluno(const codcad: integer): boolean;

   public
    { Public declarations }
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TMovimentacaoDiscipularControler }

uses cosmos.secretarias.view.batismos, cosmos.secretarias.view.cartasfrequencia,
  cosmos.secretarias.view.casamentos, cosmos.secretarias.view.desligamentos,
  cosmos.secretarias.view.religamentos, cosmos.secretarias.view.retrogradacoes,
  cosmos.secretarias.view.transferencias, cosmos.framework.interfaces.dataacess;

procedure TMovimentacaoDiscipularControler.BatizarCadastrado(
  const codcad: integer);
begin
 FrmBatismo := TFrmBatismo.Create(Application);

 try
  FrmBatismo.BatizarCadastrado(codcad);

 finally
  if Assigned(FrmBatismo) then
   FreeAndNil(FrmBatismo);
 end;
end;

constructor TMovimentacaoDiscipularControler.Create;
begin
 inherited Create;
end;

function TMovimentacaoDiscipularControler.DesligarCadastrado(
  const codcad: integer): boolean;
begin
 FrmDesligamento := TFrmDesligamento.Create(Application);

 try
  Result := FrmDesligamento.DesligarCadastrado(codcad);

 finally
  if Assigned(FrmDesligamento) then
   FreeAndNil(FrmDesligamento);
 end;
end;

destructor TMovimentacaoDiscipularControler.Destroy;
begin
 inherited Destroy;
end;

procedure TMovimentacaoDiscipularControler.EnviarCarta(const codcad: integer);
begin
 FrmCartaFrequencia := TFrmCartaFrequencia.Create(Application);

 try
  FrmCartaFrequencia.EnviarCarta(codcad)

 finally
  if Assigned(FrmCartaFrequencia) then
   FreeAndNil(FrmCartaFrequencia);
 end;
end;

procedure TMovimentacaoDiscipularControler.RegistrarCasamento(codcad: integer);
begin
 FrmCasamento := TFrmCasamento.Create(Application);

 try
  FrmCasamento.RegistrarCasamento(codcad);

 finally
  if Assigned(FrmCasamento) then
   FreeAndNil(FrmCasamento);
 end;
end;

function TMovimentacaoDiscipularControler.ReligarCadastrado(
  const codcad: integer): boolean;
begin
 FrmReligar := TFrmReligar.Create(Application);

 try
  Result := FrmReligar.ReligarCadastrados(codcad)

 finally
  if Assigned(FrmReligar) then
   FreeAndNil(FrmReligar);
 end;
end;

function TMovimentacaoDiscipularControler.RetrogradarCadastrado(
  const codcad: integer): boolean;
begin
 FrmRetrogradar := TFrmRetrogradar.Create(Application);

 try
  Result := FrmRetrogradar.Retrogradar(codcad);

 finally
  if Assigned(FrmRetrogradar) then
   FreeAndNil(FrmRetrogradar);
 end;
end;

function TMovimentacaoDiscipularControler.TransferirAluno(
  const codcad: integer): boolean;
begin
 FrmTransferencia := TFrmTransferencia.Create(Application);

 try
  Result := FrmTransferencia.TransferirAluno(codcad);

 finally
  if Assigned(FrmTransferencia) then
   FreeAndNil(FrmTransferencia);
 end;
end;

function TMovimentacaoDiscipularControler.TransferirCadastrado(
  const codcad: integer): boolean;
begin
 FrmTransferencia := TFrmTransferencia.Create(Application);

 try
  Result := FrmTransferencia.TransferirCadastrado(codcad);

 finally
  if Assigned(FrmTransferencia) then
   FreeAndNil(FrmTransferencia);
 end;
end;


initialization
 RegisterClass(TMovimentacaoDiscipularControler);

finalization
 UnRegisterClass(TMovimentacaoDiscipularControler);

end.
