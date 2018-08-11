unit cosmos.common.view.simplesearcher;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.ExtCtrls, Vcl.Buttons, Data.DB, Datasnap.DBClient,
  Cosmos.Framework.Interfaces.DataAcess, Cosmos.Framework.Interfaces.Dialogs,
  cosmos.classes.ServerInterface, cosmos.system.messages, cosmos.frames.gridsearch,
  cosmos.classes.application, cosmos.framework.Interfaces.root, cosmos.system.winshell;

type
  TFrmSearcher = class(TForm, ICosmosSimpleSearch)
    LblDesc: TLabel;
    DsrSearch: TDataSource;
    CdsSearch: TClientDataSet;
    Bevel1: TBevel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Bevel2: TBevel;
    FmeGridSearch: TFmeGridSearch;
    Image2: TImage;
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FmeGridSearchSbnSearchClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CdsSearchAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
    FICosmosApp: ICosmosApplication;
    function DoExecuteSearch(const Search: TCosmosSearch; Params: Olevariant): boolean; inline;

    procedure PrintDescription(const Search: TCosmosSearch); inline;

  protected

   {ICosmosSimpleSearch}
    function GetDataset: TDataset;
    function GetValue(FieldName: string): variant;

    function ExecuteSearch(Search: TCosmosSearch; Params: Olevariant;
      Target: TDataset): boolean; overload;
    function ExecuteSearch(const Search: TCosmosSearch; Params: Olevariant): boolean; overload;

    property Dataset: TDataset read GetDataset;

  public
    { Public declarations }
    property ICosmosApp: ICosmosApplication read FICosmosApp;


  end;

var
  FrmSearcher: TFrmSearcher;

implementation

{$R *.dfm}

procedure TFrmSearcher.BitBtn1Click(Sender: TObject);
begin
 if (CdsSearch.Active) and not (CdsSearch.IsEmpty) then
  ModalResult := mrOk;
end;

procedure TFrmSearcher.BitBtn3Click(Sender: TObject);
begin
 if Self.HelpContext <> 0 then
  Application.HelpSystem.ShowContextHelp(Self.HelpContext, Application.CurrentHelpFile);
end;

procedure TFrmSearcher.CdsSearchAfterOpen(DataSet: TDataSet);
begin
 if Assigned(ICosmosApp.IRemoteCon) then
   ICosmosApp.IRemoteCon.LoadFieldsInfo(Dataset);
end;

function TFrmSearcher.DoExecuteSearch(const Search: TCosmosSearch; Params: Olevariant): boolean;
begin
 {Executa um comando SQL representado por um tipo TCosmosSearch.}
 PrintDescription(Search);

 try
   ICosmosApp.IRemoteCon.ExecuteDQL(Search, Params, CdsSearch);
   Result := CdsSearch.Active;
   CdsSearch.ReadOnly := True;

 except
  raise;
 end;
end;

function TFrmSearcher.ExecuteSearch(const Search: TCosmosSearch;
  Params: Olevariant): boolean;
begin
 Result := self.DoExecuteSearch(Search, Params);
 if Result then
  Result := ShowModal = mrOk;
end;

function TFrmSearcher.ExecuteSearch(Search: TCosmosSearch; Params: Olevariant;
  Target: TDataset): boolean;
var
I: integer;
TargetField: TField;
begin
 Result := self.DoExecuteSearch(Search, Params);

 if Result then
  begin
   if ShowModal = mrOk then
    begin
     if Target.Active then
      begin
       for I := 0 to Pred(CdsSearch.Fields.Count) do
        begin
         TargetField := Target.FindField(CdsSearch.Fields.Fields[I].FieldName);
         if  TargetField <> nil then
          TargetField.Value := CdsSearch.Fields.Fields[I].Value;
        end;
      end;
    end;
  end;
end;

procedure TFrmSearcher.FmeGridSearchSbnSearchClick(Sender: TObject);
begin
  FmeGridSearch.SbnSearchClick(Sender);
end;

procedure TFrmSearcher.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if Assigned(ICosmosApp) then
  FICosmosApp := nil;
end;

procedure TFrmSearcher.FormCreate(Sender: TObject);
begin
 FmeGridSearch.ShowSearchBar := True;
 FICosmosApp := Application.MainForm as ICosmosApplication;
 CdsSearch.RemoteServer := ICosmosApp.IRemoteCon.ConnectionBroker;
end;

function TFrmSearcher.GetDataset: TDataset;
begin
Result := CdsSearch;
end;

function TFrmSearcher.GetValue(FieldName: string): variant;
begin
 if CdsSearch.Active then
  begin
    if CdsSearch.FindField(FieldName) <> nil then
     Result := CdsSearch.Fields.FieldByName(FieldName).Value
    else
     Result := unassigned;
  end
 else
  Result := unassigned;
end;

procedure TFrmSearcher.PrintDescription(const Search: TCosmosSearch);
begin
 case Search of
   csRegioes:
     begin
      Caption := TCosmosSearchsInfo.SearchRegioesAdministrativas;
      LblDesc.Caption:=  TCosmosSearchsInfo.SearchDescRegioesAdministrativas;
     end;
   csFocosDependentes: ;
   csFocos:
     begin
      Caption := TCosmosSearchsInfo.SearchFocos;
      LblDesc.Caption := TCosmosSearchsInfo.SearchDescFocos;
     end;
   csCentros: ;
   csNucleos: ;
   csSalasTP: ;
   csLocaisTP: ;
   csMeiosContatos:
     begin
      Caption := TCosmosSearchsInfo.SearchMeiosContatos;
      LblDesc.Caption := TCosmosSearchsInfo.SearchDescMeiosContatos;
     end;
   csEnderecosFocos: ;
   csLogradouros: ;
   csPaises: ;
   csEstados: ;
   csCidades: ;
   csBairros: ;
   csFocosAtivos: ;
   csAlunos: ;
   csCargos:
     begin
      Caption := TCosmosSearchsInfo.SearchCargos;
      LblDesc.Caption := TCosmosSearchsInfo.SearchDescCargos;
     end;
   csOrgaosGestores: ;
   csOrgaosSuperiores: ;
   csMentoresEI: ;
   csMentoresEIFoco: ;
   csMentorasEI: ;
   csMentorasEIFoco: ;
   csDirigentesEI: ;
   csJovensAlunos: ;
   csJovensAlunosFoco: ;
   csDiscipuladosEI:
     begin
      Caption := TCosmosSearchsInfo.SearchDiscipuladosEI;
      LblDesc.Caption := TCosmosSearchsInfo.SearchDescDiscipuladosEI;
     end;
   csDiscipuladosEE:
     begin
      Caption := TCosmosSearchsInfo.SearchDiscipuladosEE;
      LblDesc.Caption := TCosmosSearchsInfo.SearchDescDiscipuladosEE;
     end;
   csLicoesEI:
     begin
      Caption := TCosmosSearchsInfo.SearchLicoesEI;
      LblDesc.Caption := TCosmosSearchsInfo.SearchDescLicoesEI;
     end;
   csProfissoes:
     begin
      Caption := TCosmosSearchsInfo.SearchProfissoes;
      LblDesc.Caption := TCosmosSearchsInfo.SearchDescProfissoes;
     end;
   csTiposEventosTP:
     begin
      Caption := TCosmosSearchsInfo.SearchEventosDiscipulares;
      LblDesc.Caption := TCosmosSearchsInfo.SearchDescTipoEvento;
     end;
   csDiscipulados: ;
   csDiscipuladosLectorium:
     begin
      Caption := TCosmosSearchsInfo.SearchDiscipuladosLEC;
      LblDesc.Caption := TCosmosSearchsInfo.SearchDescDiscipuladosLEC;
     end;
   csAlunoTitular: ;
   csEnfermidades:
     begin
      Caption := TCosmosSearchsInfo.SearchEnfermidades;
      LblDesc.Caption := TCosmosSearchsInfo.SearchDescEnfermidades;
     end;
   csAlunosHomens: ;
   csAlunosMulheres: ;
   csAreasAptidoes:
     begin
      Caption := TCosmosSearchsInfo.SearchAptidoes;
      LblDesc.Caption := TCosmosSearchsInfo.SearchDescAptidoes;
     end;
   csTiposAtividades: ;
   csAlocucoes: ;
   csTipoAtuacao:
     begin
      Caption := TCosmosSearchsInfo.SearchFuncoes;
      LblDesc.Caption := TCosmosSearchsInfo.SearchDescTipoAtuacao;
     end;
   csCadastrados: ;
   csTiposAtividadesTM: ;
   csTiposAtividadesTMB: ;
   csTiposAtividadesTP: ;
   csTiposAtividadesEI: ;
   csCirculoEI: ;
   csTurmasTP: ;
   csDiscipuladosTM:
     begin
      Caption := TCosmosSearchsInfo.SearchDiscipuladosTM;
      LblDesc.Caption := TCosmosSearchsInfo.SearchDescDiscipuladosTM;
     end;
   csDiscipuladosTMB:
     begin
      Caption := TCosmosSearchsInfo.SearchDiscipuladosTMB;
      LblDesc.Caption := TCosmosSearchsInfo.SearchDescDiscipuladosTMB;
     end;
   csFocosConferencias: ;
   csConferencias: ;
   csGruposUsuarios: ;
   csFuncoes:
     begin
      Caption := TCosmosSearchsInfo.SearchFuncoes;
      LblDesc.Caption := TCosmosSearchsInfo.SearchDescFuncoes;
     end;
   csCartasTP:
     begin
      Caption := TCosmosSearchsInfo.SearchCartasTP;
      LblDesc.Caption := TCosmosSearchsInfo.SearchDescCartasTP;
     end;
   csConferenciasLEC: ;
   csConferenciasTMO: ;
   csConferenciasTMB: ;
   csConferenciasTPU: ;
   csConferenciasEI: ;
   csPlanoContas: ;
   csFocosAlunos:
     begin
      Caption := TCosmosSearchsInfo.SearchFocos;
      LblDesc.Caption := TCosmosSearchsInfo.SearchDescFocosWithPupils;
     end;
   csFocosPesquisadores:
     begin
      Caption := TCosmosSearchsInfo.SearchFocos;
      LblDesc.Caption := TCosmosSearchsInfo.SearchDescFocosPesquisadores;
     end;
   csEventosDiscipulares: ;
   csListaCadastrados: ;
   csCarteirinhaCadastrado: ;
   csExternalReportsCategories: ;
   csCountAtividadeTipo: ;
   csGeneralSelect: ;
   csConferenciasFocoAno: ;
   csAlocucoesDataCadastro: ;
   csALocucoesDataLeitura: ;
   csAlocucoesIneditas: ;
   csAlocucoesAssunto: ;
   csAlocucoesAutor: ;
   csAlocucoesCamposTrabalho: ;
   csFuncoesCadastrado: ;
   csFichaUsuario: ;
   csDadosCadastrado: ;
   csCadastradoMatricula: ;
   csCadastradoMatriculaFoco: ;
   csCadastradoNome: ;
   csCadastradoNomeFoco: ;
   csCadastradoApelido: ;
   csCadastradoApelidoFoco: ;
   csDiscEventoHistorico: ;
   csCadastradoDiscipulado: ;
   csListaCadastradosDiscipuladoFoco: ;
   csListaCadastradosNomeFoco: ;
   csSincStatus: ;
   csClassificadoresLeitos:
    begin
     Caption := TCosmosSearchsInfo.SearchClassificadoresLeito;
     LblDesc.Caption := TCosmosSearchsInfo.SearchDescClassificadoresLeito;
    end;
   csClassificadoresCadastrados:
    begin
     Caption := TCosmosSearchsInfo.SearchClassificadores;
     LblDesc.Caption := TCosmosSearchsInfo.SearchDescClassificadoresCadastrado;
    end;
   csAlojamentosFoco:
    begin
     Caption := TCosmosSearchsInfo.SearchAlojamentos;
     LblDesc.Caption := TCosmosSearchsInfo.SearchDescAlojamentos;
    end;
   csLeitosAlojamento:
    begin
     Caption := TCosmosSearchsInfo.SearchLeitosAlojamentos;
     LblDesc.Caption := TCosmosSearchsInfo.SearchDescLeitosAlojamentos;
    end;
   csFlagsInscricoes, csGeneralFlagsInscricoes:
    begin
     Caption := TCosmosSearchsInfo.SearchFlagsInscricoes;
     LblDesc.Caption := TCosmosSearchsInfo.SearchDescFlagsInscricoes;
    end;
 end;
end;


initialization
 RegisterClass(TFrmSearcher);

finalization
 UnregisterClass(TFrmSearcher);

end.
