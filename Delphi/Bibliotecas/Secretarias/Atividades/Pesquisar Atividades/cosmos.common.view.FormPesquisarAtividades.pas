unit cosmos.common.view.FormPesquisarAtividades;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,  DB, DBClient, ExtCtrls, GroupHeader, cosmos.frames.gridsearch, StdCtrls,
  Buttons, ActnList, ImgList, ValueComboBox, DateUtils, Spin, cosmos.classes.security,
  Cosmos.Framework.Interfaces.Root, Cosmos.Framework.Interfaces.DataAcess,
  Cosmos.Framework.Interfaces.Dialogs, cosmos.classes.application, cosmos.classes.ServerInterface,
  cosmos.business.focos, cosmos.system.winshell, cosmos.system.messages,
  System.Actions, cosmos.system.dataconverter, System.ImageList;

type
  TFrmPesquisarAtividades = class(TForm, ISearchAtividades)
    MSGroupHeader1: TMSGroupHeader;
    MSGroupHeader2: TMSGroupHeader;
    FmeGridSearch: TFmeGridSearch;
    DsrData: TDataSource;
    Bevel1: TBevel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    ActionList1: TActionList;
    ImageList1: TImageList;
    ActSelect: TAction;
    ActCancel: TAction;
    ActHelp: TAction;
    ChkFocoAtual: TCheckBox;
    CBXCampo: TValueComboBox;
    Label1: TLabel;
    Label2: TLabel;
    EdtAno: TSpinEdit;
    Label3: TLabel;
    BitBtn4: TBitBtn;
    ActSearch: TAction;
    Bevel2: TBevel;
    CBXMes: TValueComboBox;
    RdbComControle: TRadioButton;
    RdbSemControle: TRadioButton;
    procedure ActSearchExecute(Sender: TObject);
    procedure FmeGridSearchDBGrid1DblClick(Sender: TObject);
    procedure ActHelpExecute(Sender: TObject);
    procedure ActCancelExecute(Sender: TObject);
    procedure ActSelectUpdate(Sender: TObject);
    procedure ActSelectExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FICosmosApp: ICosmosApplication;
    CdsData: TClientDataset;

  protected
    function GetDataset: TDataset;
    function GetValue(FieldName: string): variant;

    property Dataset: TDataset read GetDataset;
    function Execute: boolean; overload;
    function Execute(const CampoTrabalho: TCampoTrabalho): boolean; overload;
    function ExecuteSecurityContext: boolean;    

  public
    { Public declarations }
    property ICosmosApp: ICosmosApplication read FICosmosApp;
  end;

var
  FrmPesquisarAtividades: TFrmPesquisarAtividades;

implementation

{$R *.dfm}

procedure TFrmPesquisarAtividades.ActCancelExecute(Sender: TObject);
begin
 ModalResult := mrCancel;
end;

procedure TFrmPesquisarAtividades.ActHelpExecute(Sender: TObject);
begin
 if Self.HelpContext <> 0 then
  Application.HelpSystem.ShowContextHelp(Self.HelpContext, Application.CurrentHelpFile);
end;

procedure TFrmPesquisarAtividades.ActSearchExecute(Sender: TObject);
var
 AParams: TCosmosData;
 ACosmosSearch: TCosmosSearch;
begin
{Executa um comando SQL representado por um tipo TCosmosSearch.}
 AParams := TCosmosData.Create(6);

 try
  AParams.WriteValue('MONTH', CBXMes.GetValue.ToInteger);
  AParams.WriteValue('YEAR', EdtAno.Value, 1);
  AParams.WriteValue('CAMPO', CBXCampo.GetValue.QuotedString, 2);
  AParams.WriteValue('INDFRE', TDataConverter.ToBoleanString(RdbComControle.Checked, True) , 3);

  if ChkFocoAtual.Checked then
   begin
    ACosmosSearch :=  csAtividadesDatasCampoFoco;
    AParams.WriteValue('FOCO', ICosmosApp.ActiveFocus.FocusID, 4);
   end
  else
   begin
    ACosmosSearch := csAtividadesDatasCampo;
   end;

  if Assigned(CdsData) then
    begin
     CdsData.DisableControls;
     FreeAndNil(CdsData);
    end;

  screen.Cursor := crHourGlass;

  CdsData := TClientDataset.Create(self);
  ICosmosApp.IRemoteCon.ExecuteDQL(ACosmosSearch, AParams.Data, CdsData);

 finally
  screen.Cursor := crDefault;

  if Assigned(CdsData) and (CdsData.Active) then
   begin
    ICosmosApp.IRemoteCon.LoadFieldsInfo(CdsData);
    DsrData.DataSet := CdsData;
    CdsData.EnableControls;
   end;

  if Assigned(AParams) then FreeAndNil(AParams);
 end;
end;

procedure TFrmPesquisarAtividades.ActSelectExecute(Sender: TObject);
begin
 if (CdsData.Active) and not (CdsData.IsEmpty) then
   ModalResult := mrOk;
end;

procedure TFrmPesquisarAtividades.ActSelectUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := (Assigned(CdsData)) and (CdsData.Active) and not (CdsData.IsEmpty);
end;

function TFrmPesquisarAtividades.Execute(const CampoTrabalho: TCampoTrabalho): boolean;
begin
 case CampoTrabalho of
   ctLectorium: CBXCampo.ItemIndex := 0;
   ctTM: CBXCampo.ItemIndex := 1;
   ctSimpatizantes: CBXCampo.ItemIndex := 2;
   ctTP: CBXCampo.ItemIndex := 3;
   ctEI: CBXCampo.ItemIndex := 4;
 end;

 CBXCampo.Enabled := CampoTrabalho = ctAll;
 Result := ShowModal = mrOk;
end;

function TFrmPesquisarAtividades.ExecuteSecurityContext: boolean;
begin
 try
  if ctLectorium in ICosmosApp.IRemoteCon.CurrentConnectionInfo.CamposTrabalho then
   CbxCampo.ItemIndex := 0
  else
  if ctTM in ICosmosApp.IRemoteCon.CurrentConnectionInfo.CamposTrabalho then
   CbxCampo.ItemIndex := 1
  else
  if ctTMB in ICosmosApp.IRemoteCon.CurrentConnectionInfo.CamposTrabalho then
   CbxCampo.ItemIndex := 2
  else
  if ctTP in ICosmosApp.IRemoteCon.CurrentConnectionInfo.CamposTrabalho then
   CbxCampo.ItemIndex := 3
  else
  if ctEI in ICosmosApp.IRemoteCon.CurrentConnectionInfo.CamposTrabalho then
   CbxCampo.ItemIndex := 4 ;

  CbxCampo.Enabled := ICosmosApp.IRemoteCon.CurrentConnectionInfo.CamposTrabalho = [ctLectorium, ctTM, ctTMB, ctTP, ctEI];

  ActSearch.Execute;
  Result := ShowModal = mrOk;

 except
  on E: Exception do
   ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.PesquisaDados, E.Message)
 end;
end;

function TFrmPesquisarAtividades.Execute: boolean;
begin
 Result := ShowModal = mrOk;
end;

procedure TFrmPesquisarAtividades.FmeGridSearchDBGrid1DblClick(Sender: TObject);
begin
 if (CdsData.Active) and not (CdsData.IsEmpty) then
  ActSelect.Execute;
end;

procedure TFrmPesquisarAtividades.FormCreate(Sender: TObject);
var
 Data: TDateTime;
 Y, M, D: word;
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;

 FmegridSearch.SearchFields := 'DESTIPATI';
 Data := ICosmosApp.IRemoteCon.ServerDateTime;
 DecodeDate(Data, Y, M, D);
 EdtAno.Value := Y;
 CBXMes.ItemIndex := M - 1;
 CBXCampo.ItemIndex := 0; //LEC
end;

function TFrmPesquisarAtividades.GetDataset: TDataset;
begin
 Result := CdsData;
end;

function TFrmPesquisarAtividades.GetValue(FieldName: string): variant;
begin
 if CdsData.Active then
  begin
    if CdsData.FindField(FieldName) <> nil then
     Result := CdsData.Fields.FieldByName(FieldName).Value
    else
     Result := unassigned;
  end
 else
  Result := unassigned;
end;


initialization
 RegisterClass(TFrmPesquisarAtividades);

finalization
 UnRegisterClass(TFrmPesquisarAtividades);

end.
