unit cosmos.frames.searchdata;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls,
  Cosmos.classes.ServerInterface, Data.DB, cosmos.classes.application,
  cosmos.framework.interfaces.root, Cosmos.Framework.Interfaces.Dialogs, dbClient,
  cosmos.framework.forms.datadialogs, cosmos.framework.forms.conferencias,
  cosmos.framework.forms.acessorias, cosmos.framework.forms.logradouros,
  cosmos.framework.forms.focos, cosmos.business.focos;

type
  EMasterDataError = Exception;

  TFmeSearchData = class(TFrame)
    EdtSearch: TEdit;
    SbnButton: TSpeedButton;
    procedure EdtSearchKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SbnButtonClick(Sender: TObject);
  private
    { Private declarations }
    FCosmosData: TCosmosData;
    FOnSelectData: TNotifyEvent;
    FOnClearData: TNotifyEvent;
    FMasterFrame: TFmeSearchData;
    FControlEnabled: boolean;
    FCosmosSearch: TCosmosSearch;
    FCanEdit: boolean;

    procedure DoSearch;
    procedure SetControlEnabled(const Value: boolean);
    function GetControlValue: variant;

    procedure PesquisarAlunos(const Sexo: TSexoCadastrado); overload;
    procedure PesquisarAlunos(const Exclude: integer); overload;
    procedure PesquisarPaises;
    procedure PesquisarEstados;
    procedure PesquisarCidade;
    procedure PesquisarBairro;
    procedure PesquisarDiscipuladosTMB;
    procedure PesquisarProfissoes;
    procedure PesquisarRegioes;

    procedure SetCanEdit(value: boolean);


  public
    { Public declarations }
   property CanEdit: boolean read FCanEdit write SetCanEdit;

   property CosmosData: TCosmosData read FCosmosData;
   property ControlEnabled: boolean read FControlEnabled write SetControlEnabled default True;
   property ControlValue: variant read GetControlValue;
   property MasterFrame: TFmeSearchData read FMasterFrame write FMasterFrame;
   property CosmosSearch: TCosmosSearch read FCosmosSearch write FCosmosSearch;
   property OnSelectData: TNotifyEvent read FOnSelectData write FOnSelectData;
   property OnClearData: TNotifyEvent read FOnClearData write FOnClearData;

   procedure ClearData;
   procedure CreateMemoryData(const FieldNum: integer);
   procedure DoClick;
   function ReadValue(const FieldName: string): variant;
   function WriteData(Data: TCosmosData; TextField: string = ''): boolean; overload;
   procedure WriteData(Field: string; Value: variant; Position: integer); overload;
  end;

implementation

uses Cosmos.system.messages;

{$R *.dfm}

{ TFmeSearchData }

procedure TFmeSearchData.ClearData;
begin
 if (CosmosData <> nil) then
  begin
   CosmosData.ClearData;
   EdtSearch.Clear;
   if Assigned(FOnClearData) then
    FOnClearData(self);
  end;
end;

procedure TFmeSearchData.CreateMemoryData(const FieldNum: integer);
begin
 if not Assigned(FCosmosData) then
  FCosmosData := TCosmosData.Create(FIeldNum);
end;

procedure TFmeSearchData.DoClick;
begin
 SbnButton.Click;
end;

procedure TFmeSearchData.DoSearch;
begin
   case CosmosSearch of
     csRegioes: PesquisarRegioes;
     csFocos:
      begin
       FCosmosData := TCosmosFocosDialogs.SelecionarFocos;
       if CosmosData <> nil then
        EdtSearch.Text := CosmosData.FindValue('nomfoc');
      end;
     csPaises: PesquisarPaises;
     csEstados: PesquisarEstados;
     csCidades: PesquisarCidade;
     csBairros: PesquisarBairro;
     csAlunos, csAlunoTitular: PesquisarAlunos(scTodos);
     csAlunosHomens: PesquisarAlunos(scMasculino);
     csAlunosMulheres: PesquisarAlunos(scFeminino);
     csProfissoes: PesquisarProfissoes;
     csDiscipuladosTMB: PesquisarDiscipuladosTMB;
     csFocosConferencias:
      begin
       FCosmosData := TCosmosConferenciasDialogs.SelecionarConferencia(ctAll, True);
       if CosmosData <> nil then
        EdtSearch.Text := CosmosData.FindValue('nomcon');
      end;
     csConferenciasLEC, csConferenciasEI:
      begin
       FCosmosData := TCosmosConferenciasDialogs.SelecionarConferencia(ctLectorium, True);
       if CosmosData <> nil then
        EdtSearch.Text := CosmosData.FindValue('nomcon');
      end;
     csConferenciasTMO:
      begin
       FCosmosData := TCosmosConferenciasDialogs.SelecionarConferencia(ctTM, True);
       if CosmosData <> nil then
        EdtSearch.Text := CosmosData.FindValue('nomcon');
      end;
     csConferenciasTMB:
      begin
       FCosmosData := TCosmosConferenciasDialogs.SelecionarConferencia(ctTMB, True);
       if CosmosData <> nil then
        EdtSearch.Text := CosmosData.FindValue('nomcon');
      end;
     csConferenciasTPU:
      begin
       FCosmosData := TCosmosConferenciasDialogs.SelecionarConferencia(ctTP, True);
       if CosmosData <> nil then
        EdtSearch.Text := CosmosData.FindValue('nomcon');
      end;
     csConferenciasSIM:
      begin
       FCosmosData := TCosmosConferenciasDialogs.SelecionarConferencia(ctSimpatizantes, True);
       if CosmosData <> nil then
        EdtSearch.Text := CosmosData.FindValue('nomcon');
      end;
   end;

   if Assigned(FOnSelectData) then
    FOnSelectData(self);
end;

procedure TFmeSearchData.EdtSearchKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if Key = 13 then
  DoClick;
end;

function TFmeSearchData.GetControlValue: variant;
begin
 Result := EdtSearch.Text;
end;

procedure TFmeSearchData.SetCanEdit(value: boolean);
begin
 FCanEdit := Value;
 self.EdtSearch.ReadOnly := not CanEdit;
end;

procedure TFmeSearchData.SetControlEnabled(const Value: boolean);
begin
  FControlEnabled := Value;
  EdtSearch.Enabled := Value;
  SbnButton.Enabled := Value;
end;

procedure TFmeSearchData.WriteData(Field: string; Value: variant; Position: integer);
begin
 if Assigned(FCosmosData) then
  FCosmosData.WriteValue(Field, Value, Position);
end;

function TFmeSearchData.WriteData(Data: TCosmosData; TextField: string): boolean;
begin
 if Assigned(Data) then
  begin
   FCosmosData := Data;
   if TextField <> '' then
    EdtSearch.Text := self.ReadValue(TextField);
  end;
end;

procedure TFmeSearchData.SbnButtonClick(Sender: TObject);
begin
 DoSearch;
end;

procedure TFmeSearchData.PesquisarAlunos(const Exclude: integer);
begin
 inherited;
//Faz a pesquisa padrão de busca de alunos, excluindo o aluno cujo código
//tenha sido passoa em "Exclude"
 FCosmosData := TCosmosCadastradosDialogs.SelecionarCadastrado(ctLectorium, scTodos, False);

 if CosmosData <> nil then
  self.EdtSearch.Text := CosmosData.FindValue('nomcad')
end;

procedure TFmeSearchData.PesquisarBairro;
begin
 if not CanEdit then
  begin
   FCosmosData := TCosmosLocaisDialogs.SelecionarBairros;
   if CosmosData <> nil then
    EdtSearch.Text := CosmosData.FindValue('nombai');
  end
 else
  begin
   if Assigned(self.OnSelectData) then
    FCosmosData := TCosmosData.Create(10);
  end;
end;

procedure TFmeSearchData.PesquisarCidade;
begin
 if not CanEdit then
  begin
   FCosmosData := TCosmosLocaisDialogs.SelecionarCidades;
   if CosmosData <> nil then
    EdtSearch.Text := CosmosData.FindValue('nomcid');
  end
 else
  begin
   if Assigned(self.OnSelectData) then
    FCosmosData := TCosmosData.Create(10);
  end;
end;

procedure TFmeSearchData.PesquisarDiscipuladosTMB;
begin
 FCosmosData := TCosmosFocosDialogs.SelecionarDiscipulados([ctTMB]);
 if CosmosData <> nil then
  EdtSearch.Text := CosmosData.FindValue('nomdis');
end;

procedure TFmeSearchData.PesquisarEstados;
var
 AParams: TCosmosData;
 CdsData: TClientDataset;
 ICosmosApp: ICosmosApplication;
begin
 if not CanEdit then
  begin
   FCosmosData := TCosmosLocaisDialogs.SelecionarEstados;
   if CosmosData <> nil then
    EdtSearch.Text := CosmosData.FindValue('nomest');
  end
 else
  begin
   ICosmosApp := Application.MainForm as ICosmosApplication;
   CdsData := TClientDataset.Create(nil);
   AParams := TCosmosData.Create(1);

   try
    AParams.WriteValue('NOME', QuotedStr(ControlValue));
    ICosmosApp.IRemoteCon.ExecuteDQL(csEstados, AParams.Data, CdsData);

    if CdsData <> nil then
     begin
      FCosmosData := TCosmosData.Create(5);
      FCosmosData.WriteValue('codest', CdsData.FieldValues['codest']);
      FCosmosData.WriteValue('nomest', CdsData.FieldValues['nomest'], 1);
      FCosmosData.WriteValue('nompai', CdsData.FieldValues['nompai'], 2);
      self.EdtSearch.Text := CdsData.FieldValues['nomest'];
     end;

   finally
    if Assigned(ICosmosApp) then ICosmosApp := nil;
    if Assigned(CdsData) then FreeAndNil(CdsData);
    if Assigned(AParams) then FreeAndNil(AParams);
   end;
  end;
end;

procedure TFmeSearchData.PesquisarPaises;
var
 AParams: TCosmosData;
 CdsData: TClientDataset;
 ICosmosApp: ICosmosApplication;
begin
 if not CanEdit then
  begin
   FCosmosData := TCosmosLocaisDialogs.SelecionarPaises;
   if CosmosData <> nil then
    EdtSearch.Text := CosmosData.FindValue('nompai');
  end
 else
  begin
   ICosmosApp := Application.MainForm as ICosmosApplication;
   CdsData := TClientDataset.Create(nil);
   AParams := TCosmosData.Create(1);

   try
    AParams.WriteValue('NOME', QuotedStr(ControlValue));
    ICosmosApp.IRemoteCon.ExecuteDQL(csPaises, AParams.Data, CdsData);

    if CdsData <> nil then
     begin
      if not CdsData.IsEmpty then
       begin
        FCosmosData := TCosmosData.Create(2);
        FCosmosData.WriteValue('codpai', CdsData.FieldValues['codpai']);
        FCosmosData.WriteValue('nompai', CdsData.FieldValues['nompai'], 1);
        EdtSearch.Text := CdsData.FieldValues['nompai'];
       end
      else
       begin
         EdtSearch.Clear;
         if Assigned(CosmosData) then
          FreeAndNil(FCosmosData);
       end;
     end;

   finally
    if Assigned(ICosmosApp) then
     ICosmosApp := nil;
    if Assigned(CdsData) then
     FreeAndNil(CdsData);
    if Assigned(AParams) then
     FreeAndNil(AParams);
   end;
  end;
end;

procedure TFmeSearchData.PesquisarProfissoes;
begin
 FCosmosData := TCosmosAcessoriasDialogs.SelecionarProfissoes;
 if CosmosData <> nil then
  EdtSearch.Text := CosmosData.FindValue('despro');
end;

procedure TFmeSearchData.PesquisarRegioes;
begin
 FCosmosData := TCosmosFocosDialogs.SelecionarRegioesAdministrativas;
 if CosmosData <> nil then
  EdtSearch.Text := CosmosData.FindValue('NOMRA');
end;

function TFmeSearchData.ReadValue(const FieldName: string): variant;
begin
 Result := null;
 if FCosmosData <> nil then
  Result := CosmosData.FindValue(FieldName);
end;

procedure TFmeSearchData.PesquisarAlunos(const Sexo: TSexoCadastrado);
begin
 inherited;
 FCosmosData := TCosmosCadastradosDialogs.SelecionarCadastrado(ctLectorium, Sexo, False);

 if CosmosData <> nil then
  EdtSearch.Text := CosmosData.FindValue('nomcad');
end;


end.


