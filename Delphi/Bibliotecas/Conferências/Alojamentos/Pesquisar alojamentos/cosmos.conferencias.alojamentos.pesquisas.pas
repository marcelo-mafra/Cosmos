unit cosmos.conferencias.alojamentos.pesquisas;

interface

uses
 Classes, SysUtils, Controls, cosmos.classes.application, cosmos.framework.interfaces.root,
 cosmos.framework.interfaces.dialogs, cosmos.system.messages;

type

 TPesquisasAlojamentos = class (TInterfacedPersistent, IPesquisarAlojamentos)

  private

  protected
   function PesquisarAlojamentos: TCosmosData;
   function PesquisarQuartos: TCosmosData;
   function PesquisarLeitos: TCosmosData;

  public
   constructor Create;
   destructor Destroy; override;

 end;

implementation

{ TPesquisaAlojamentos }

uses cosmos.conferencias.view.FormPesquisarQuartos, cosmos.conferencias.view.FormPesquisarLeitos,
 cosmos.conferencias.view.FormPesquisarAlojamentos;

constructor TPesquisasAlojamentos.Create;
begin
 inherited Create;
end;

destructor TPesquisasAlojamentos.Destroy;
begin
  inherited;
end;

function TPesquisasAlojamentos.PesquisarAlojamentos: TCosmosData;
begin
 if not Assigned(FrmPesquisarAlojamentos) then
  FrmPesquisarAlojamentos := TFrmPesquisarAlojamentos.Create(nil);

 try
  if FrmPesquisarAlojamentos.ShowModal = mrOk then
   begin
    Result := TCosmosData.Create(5);
    Result.WriteValue('CODALO', FrmPesquisarAlojamentos.GetValue('CODALO'));
    Result.WriteValue('NOMALO', FrmPesquisarAlojamentos.GetValue('NOMALO'), 1);
    Result.WriteValue('INDEXT', FrmPesquisarAlojamentos.GetValue('INDEXT'), 2);
    Result.WriteValue('LOTALO', FrmPesquisarAlojamentos.GetValue('LOTALO'), 3);
   end;

 finally
  if Assigned(FrmPesquisarAlojamentos) then
   FreeAndNil(FrmPesquisarAlojamentos);
 end;
end;

function TPesquisasAlojamentos.PesquisarLeitos: TCosmosData;
begin
 if not Assigned(FrmPesquisarLeitos) then
  FrmPesquisarLeitos := TFrmPesquisarLeitos.Create(nil);

 try
  if FrmPesquisarLeitos.ShowModal = mrOk then
   begin
    Result := TCosmosData.Create(10);
    Result.WriteValue('CODLEI', FrmPesquisarLeitos.GetValue('CODLEI'));
    Result.WriteValue('NUMLEI', FrmPesquisarLeitos.GetValue('NUMLEI'), 1);
    Result.WriteValue('CODQUA', FrmPesquisarLeitos.GetValue('CODQUA'), 2);
    Result.WriteValue('NUMQUA', FrmPesquisarLeitos.GetValue('NUMQUA'), 3);
    Result.WriteValue('ALAQUA', FrmPesquisarLeitos.GetValue('ALAQUA'), 4);
    Result.WriteValue('CODALO', FrmPesquisarLeitos.GetValue('CODALO'), 5);
    Result.WriteValue('NOMALO', FrmPesquisarLeitos.GetValue('NOMALO'), 6);
   end;

 finally
  if Assigned(FrmPesquisarLeitos) then
   FreeAndNil(FrmPesquisarLeitos);
 end;
end;

function TPesquisasAlojamentos.PesquisarQuartos: TCosmosData;
begin
 if not Assigned(FrmPesquisarQuartos) then
  FrmPesquisarQuartos := TFrmPesquisarQuartos.Create(nil);

 try
  if FrmPesquisarQuartos.ShowModal = mrOk then
   begin
    Result := TCosmosData.Create(10);
    Result.WriteValue('CODQUA', FrmPesquisarQuartos.GetValue('CODQUA'));
    Result.WriteValue('NUMQUA', FrmPesquisarQuartos.GetValue('NUMQUA'), 1);
    Result.WriteValue('ALAQUA', FrmPesquisarQuartos.GetValue('ALAQUA'), 2);
    Result.WriteValue('CODALO', FrmPesquisarQuartos.GetValue('CODALO'), 3);
    Result.WriteValue('NOMALO', FrmPesquisarQuartos.GetValue('NOMALO'), 4);
   end;

 finally
  if Assigned(FrmPesquisarQuartos) then
   FreeAndNil(FrmPesquisarQuartos);
 end;
end;

initialization
 RegisterClass(TPesquisasAlojamentos);

finalization
 UnRegisterClass(TPesquisasAlojamentos);

end.
