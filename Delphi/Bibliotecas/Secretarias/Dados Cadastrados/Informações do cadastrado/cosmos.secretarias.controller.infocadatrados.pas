unit cosmos.secretarias.controller.infocadatrados;

interface

uses
  Windows, Messages, System.SysUtils, System.Classes,
  Cosmos.Framework.Interfaces.Dialogs;

 type
  TInfoCadastradoController = class(TInterfacedPersistent, IInformacoesCadastrado)

   private

   protected
    procedure CadastrarAptidoes(const codcad: integer; nomcad: string);
    procedure CadastrarFuncoes(const codcad: integer; nomcad: string);
    procedure CadastrarInfoMedicas(const codcad: integer; nomcad: string);


   public
    constructor Create;
    destructor Destroy; override;

 end;

implementation

{ TInfoCadastradoController }

uses cosmos.secretarias.view.FormAptidoes,
  cosmos.secretarias.view.FormFuncoesCadastrados,
  cosmos.secretarias.view.FormInformacoesMedicas;

constructor TInfoCadastradoController.Create;
begin
 inherited Create;
end;

destructor TInfoCadastradoController.Destroy;
begin
 inherited Destroy;
end;

procedure TInfoCadastradoController.CadastrarAptidoes(const codcad: integer;
  nomcad: string);
begin
  FrmAptidoes := TFrmAptidoes.Create(nil);

  try
   FrmAptidoes.CadastrarAptdoes(codcad, nomcad);

  finally
   if Assigned(FrmAptidoes) then
    FreeAndNil(FrmAptidoes);
  end;
end;

procedure TInfoCadastradoController.CadastrarFuncoes(const codcad: integer;
  nomcad: string);
begin
  FrmFuncoesCadastrados := TFrmFuncoesCadastrados.Create(nil);

  try
   FrmFuncoesCadastrados.CadastrarFuncoes(codcad, nomcad);

  finally
   if Assigned(FrmFuncoesCadastrados) then
    FreeAndNil(FrmFuncoesCadastrados);
  end;
end;

procedure TInfoCadastradoController.CadastrarInfoMedicas(const codcad: integer;
  nomcad: string);
begin
  FrmInformacoesMedicas := TFrmInformacoesMedicas.Create(nil);

  try
   FrmInformacoesMedicas.CadastrarInfoMedicas(codcad, nomcad);

  finally
   if Assigned(FrmInformacoesMedicas) then
    FreeAndNil(FrmInformacoesMedicas);
  end;
end;

initialization
 RegisterClass(TInfoCadastradoController);

finalization
 UnRegisterClass(TInfoCadastradoController);

end.
