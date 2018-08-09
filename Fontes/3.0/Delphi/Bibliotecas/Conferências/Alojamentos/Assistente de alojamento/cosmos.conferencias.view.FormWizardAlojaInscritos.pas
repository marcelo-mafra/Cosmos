unit cosmos.conferencias.view.FormWizardAlojaInscritos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  cosmos.framework.view.FrmDefWizard, Wizard, ImgList, ActnList, jpeg, ExtCtrls,
  ComCtrls, StdCtrls, Buttons, cosmos.system.messages, Data.DBXCommon,
  cosmos.classes.application, DB, DBClient, Grids, DBGrids, cosmos.classes.ServerInterface, Vcl.Menus,
  Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnPopup, GroupHeader, ValueComboBox,
  Vcl.Imaging.pngimage, cosmos.frames.gridsearch, Vcl.DBCtrls,
  cosmos.frames.searchdata, System.Actions, Data.SqlExpr;

type
  TProcessoAlojamento = (paAutomatic, paClone, paManual);
  TFrmWizardAlojaInscritos = class(TFrmCosmosWizard)
    TabSheet2: TTabSheet;
    TabClone: TTabSheet;
    TabProcessamento: TTabSheet;
    TrvList: TTreeView;
    TabSheet3: TTabSheet;
    PopupActionBar1: TPopupActionBar;
    ExcluirdaLista1: TMenuItem;
    RdbAutomatico: TRadioButton;
    Label2: TLabel;
    RdbClonar: TRadioButton;
    Label3: TLabel;
    RdbCustomizar: TRadioButton;
    Label4: TLabel;
    Image4: TImage;
    MSGroupHeader1: TMSGroupHeader;
    Label8: TLabel;
    FmeSearchConferencias: TFmeSearchData;
    LsvRules: TListView;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    MSGroupHeader2: TMSGroupHeader;
    ChkImportarAlojamento: TCheckBox;
    MSGroupHeader3: TMSGroupHeader;
    LblConferencia: TLabel;
    CbxRules: TValueComboBox;
    Label5: TLabel;
    LblPromotorCon: TLabel;
    Label6: TLabel;
    LblInicio: TLabel;
    Label7: TLabel;
    LblTermino: TLabel;
    Label9: TLabel;
    LblFocoPromotorCon: TLabel;
    TabInscritos: TTabSheet;
    FmeGridSearch: TFmeGridSearch;
    CdsInscritos: TClientDataSet;
    DsrInscritos: TDataSource;
    DBNavigator1: TDBNavigator;
    procedure WzCosmosBeforeNextPage(Sender: TObject; CurrentPage: Integer);
    procedure ActProximoUpdate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PopupActionBar1Popup(Sender: TObject);
  private
    { Private declarations }
    FConferenceData: TCosmosData;
    FProcessoAlojamento: TProcessoAlojamento;
    procedure LoadRules;
    procedure OnSelectDataConference(Sender: TObject);
    procedure AddReportItem(const ResultId: integer; Inscrito: string);
    procedure DoExecuteAutomatic;

  public
    { Public declarations }
    function Execute(Data: TCosmosData): boolean; override;
    property ConferenceData: TCosmosData read FConferenceData;
    property ProcessoAlojamento: TProcessoAlojamento read FProcessoAlojamento write FProcessoAlojamento;
  end;

var
  FrmWizardAlojaInscritos: TFrmWizardAlojaInscritos;

implementation

{$R *.dfm}

{ TFrmWizardAlojaInscritos }

procedure TFrmWizardAlojaInscritos.ActProximoUpdate(Sender: TObject);
begin
  inherited;
 case WzCosmos.ActivePageIndex of
  0, 1: TAction(Sender).Enabled := True;
  2: TAction(Sender).Enabled :=  (LsvRules.Items.Count > 0);
  3: TAction(Sender).Enabled :=  FmeSearchConferencias.CosmosData <> nil;
  4: TAction(Sender).Enabled :=  (CdsInscritos.Active) and not (CdsInscritos.IsEmpty);
 end;
end;

procedure TFrmWizardAlojaInscritos.AddReportItem(const ResultId: integer;
  Inscrito: string);
var
 ARoot, AItem: TTreeNode;
begin
 case ResultId of
  1:
   begin
    ARoot := TrvList.Items.Item[0];
    AItem := TrvList.Items.AddChild(ARoot, Inscrito);
   end;
  2:
   begin
    ARoot := TrvList.Items.Item[0];
    ARoot := ARoot.getNextSibling;
    AItem := TrvList.Items.AddChild(ARoot, Inscrito);
   end;
 end;
end;

procedure TFrmWizardAlojaInscritos.DoExecuteAutomatic;
var
 aParams: TSQLParams;
 aDataset: TClientDataset;
begin
// Aloja automaticamente os inscritos de uma conferência.
 aParams := TSQLParams.Create(3);
 aDataset := TClientDataset.Create(self);

 try
  aParams.AppendData(ConferenceData.FindValue('CODCON'));
  aParams.AppendData(1, 1); //Modo de alojamento automático
  aParams.AppendData('null', 2); //Último parâmetro não válido para alojamento automático.
  IRemoteCon.ExecuteDQL(csAlojarInscritos, aParams.Params, aDataset);

  if aDataset.Active then
   begin
     while not aDataset.Eof do
      begin
        AddReportItem(aDataset.FindField('OSITUACAO').Value, aDataset.FindField('ONOMCAD').Value);
        aDataset.Next;
      end;
   end;

 finally
  aParams.Free;
  aDataset.Free;
 end;
end;

function TFrmWizardAlojaInscritos.Execute(Data: TCosmosData): boolean;
begin
  FConferenceData.CopyData(Data);
  LblConferencia.Caption := ConferenceData.FindValue('nomcon');
  WzCosmos.StartWizard;
  Result := ShowModal = mrOk;
end;

procedure TFrmWizardAlojaInscritos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if Assigned(FConferenceData) then
   FreeAndNil(FConferenceData);
end;

procedure TFrmWizardAlojaInscritos.FormCreate(Sender: TObject);
begin
  inherited;
  FConferenceData := TCosmosData.Create(5);
  FmeSearchConferencias.CosmosSearch :=  csFocosConferencias;
  FmeSearchConferencias.OnSelectData := OnSelectDataConference;
end;

procedure TFrmWizardAlojaInscritos.LoadRules;
var
 Cds: TClientDataset;
begin
 CBXRules.Items.Clear;
 CBXRules.Values.Clear;
 Cds := TClientDataset.Create(nil);

 try
  while not Cds.Eof do
   begin
    CBXRules.Items.Append(Cds.FieldValues['']);
    CBXRules.Values.Append(Cds.FieldValues['']);
    Cds.Next;
   end;

 finally
  if Assigned(Cds) then
   FreeAndNil(Cds);
 end;
end;

procedure TFrmWizardAlojaInscritos.OnSelectDataConference(Sender: TObject);
begin
 LblInicio.Caption := FmeSearchConferencias.ReadValue('DATINI');
 LblTermino.Caption := FmeSearchConferencias.ReadValue('DATTER');
 LblPromotorCon.Caption := FmeSearchConferencias.ReadValue('CAMCON');
 LblFocoPromotorCon.Caption := FmeSearchConferencias.ReadValue('NOMFOC');
end;

procedure TFrmWizardAlojaInscritos.PopupActionBar1Popup(Sender: TObject);
begin
  inherited;
  TPopupActionBar(Sender).Style := ICosmosApp.InterfaceStyle;
end;

procedure TFrmWizardAlojaInscritos.WzCosmosBeforeNextPage(Sender: TObject;
  CurrentPage: Integer);
var
 AInscrito, Params: TCosmosData;
 sConfMessage: string;
 ACommand: TDBXCommand;
 ADataset: TSQLDataset;
begin
  inherited;
  case CurrentPage of
   1: //Página de escolha do tipo de processo de alojamento dos inscritos.
    begin
      if RdbAutomatico.Checked then ProcessoAlojamento := paAutomatic
       else
      if RdbClonar.Checked then ProcessoAlojamento := paClone
       else
       ProcessoAlojamento := paManual;

      case ProcessoAlojamento of
        paAutomatic:
         begin
          wzCosmos.Pages[2].Visible := False;
          wzCosmos.Pages[3].Visible := False;
          wzCosmos.Pages[4].Visible := False;
         end;
        paClone:
         begin
          wzCosmos.Pages[2].Visible := False;
          wzCosmos.Pages[3].Visible := True;
          wzCosmos.Pages[4].Visible := True;
         end;
        paManual:
         begin
          wzCosmos.Pages[2].Visible := True;
          wzCosmos.Pages[3].Visible := False;
          wzCosmos.Pages[4].Visible := False;
         end;
      end;

      if ProcessoAlojamento = paAutomatic then
       begin
         if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.Alojamentos, TCosmosConfMsg.ConfirmarAlojamento) = mrYes then
          begin
           DoExecuteAutomatic;
          end
         else
          Abort;
       end;
    end;
   3: //Página de conferência modelo
    begin
     //verifica se a conferência modelo não é a mesma da conferência corrente.
     if FmeSearchConferencias.ReadValue('CODCON') = ConferenceData.FindValue('CODCON')  then
      begin
       ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.Alojamentos, TCosmosErrorMsg.ConferenciaModelo);
       Abort;
      end;

     //Pega os inscritos da conferência modelo selecionada.
     Params := TCosmosData.Create(1);

     try
      Params.WriteValue('CODCON', FmeSearchConferencias.ReadValue('CODCON'));
      IRemoteCon.ExecuteDQL(csInscritosConferencia, Params.Data, CdsInscritos);
      CdsInscritos.ReadOnly := False;

     finally
      if Assigned(Params) then
       FreeAndNil(Params);
     end;

    end;
   4://Lista dos inscritos da conferência modelo.
    begin
     sConfMessage := Format(TCosmosConfMsg.ClonarInscricoes, [FmeSearchConferencias.ReadValue('NOMCON'), ConferenceData.FindValue('NOMCON')]);
     if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.InscricoesConferencia, sConfMessage) = mrNo then
       Abort
     else
       begin
        //Envia os dados dos inscritos para a nova conferência.
        TrvList.Items.Item[0].DeleteChildren;
        TrvList.Items.Item[1].DeleteChildren;
        TrvList.Items.Item[2].DeleteChildren;
        TrvList.Items.Item[3].DeleteChildren;

        CdsInscritos.DisableControls;
        AInscrito := TCosmosData.Create(5);

        try
         CdsInscritos.First;
         ACommand := IRemoteCon.CreateCommand;
         ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
         ACommand.Text := 'TDMCosmosConferenciasMethods.ClonarAlojamento'; //do not localize!
         ACommand.Prepare;

         ACommand.Parameters[0].Value.SetDBXReader(IRemoteCon.CreateReader(CdsInscritos), True);
         ACommand.Parameters[1].Value.SetInt32(FmeSearchConferencias.ReadValue('CODCON'));
         ACommand.ExecuteUpdate;

         ADataset := TSQLDataset.Create(self, ACommand.Parameters[2].Value.GetDBXReader(False), True);

         TrvList.FullExpand;
         CdsInscritos.EnableControls;

        except
         on E: Exception do
          begin
           TrvList.FullExpand;
           CdsInscritos.EnableControls;
          end;
        end;
       end;

    end;
   5: //"Clone" do alojamento de uma conferência anterior...
    begin


    end;
   6: //...
    begin

    end;
  end;
end;

initialization
 RegisterClass(TFrmWizardAlojaInscritos);

finalization
 UnRegisterClass(TFrmWizardAlojaInscritos);

end.
