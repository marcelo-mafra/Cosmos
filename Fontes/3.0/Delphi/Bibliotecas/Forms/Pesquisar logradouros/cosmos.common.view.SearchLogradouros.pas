unit cosmos.common.view.SearchLogradouros;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Grids, DBGrids, DB, DBClient, Mask, ActnList,
  Cosmos.Framework.Interfaces.Root, Cosmos.Framework.Interfaces.DataAcess,
  Cosmos.Framework.Interfaces.Dialogs, cosmos.frames.gridsearch,
  cosmos.classes.security, Datasnap.DSConnect,
  InvokeRegistry, Rio, SOAPHTTPClient, Buttons, //cosmos.framework.forms.mydialogs,
  cosmos.system.messages, ImgList, GroupHeader, System.Actions;

type
  TFrmSearchLogradouro = class(TForm, ICosmosLocateLogradouros)
    Panel1: TPanel;
    Image1: TImage;
    Label1: TLabel;
    Bevel1: TBevel;
    BtnSelect: TButton;
    Button2: TButton;
    Button3: TButton;
    EdtCep: TMaskEdit;
    DsrLogradouros: TDataSource;
    CdsLogradouros: TClientDataSet;
    Label2: TLabel;
    BtnSearch: TButton;
    Bevel2: TBevel;
    Button4: TButton;
    Button5: TButton;
    ActionList1: TActionList;
    ActPesquisar: TAction;
    ActNovo: TAction;
    ActEditar: TAction;
    FmeGridSearch1: TFmeGridSearch;
    HTTPRIO1: THTTPRIO;
    ActCosultarECT: TAction;
    ImageList1: TImageList;
    MSGroupHeader1: TMSGroupHeader;
    BitBtn1: TBitBtn;
    EdtLogradouro: TEdit;
    EdtBairro: TEdit;
    EdtCidade: TEdit;
    EdtUF: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    procedure Button3Click(Sender: TObject);
    procedure ActCosultarECTUpdate(Sender: TObject);
    procedure ActCosultarECTExecute(Sender: TObject);
    procedure ActNovoUpdate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ActEditarUpdate(Sender: TObject);
    procedure ActEditarExecute(Sender: TObject);
    procedure ActNovoExecute(Sender: TObject);
    procedure ActPesquisarExecute(Sender: TObject);
    procedure BtnSelectClick(Sender: TObject);
    procedure EdtCepKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FExecutionMode: TExecutionMode;
    FICosmosApp: ICosmosApplication;
    FRemoteConnection: TDSProviderConnection;
    FCanConnect: boolean;

    procedure CloseDataset; inline;
    procedure ClearControls; inline;
    function GetCosmosRemoteConnection: ICosmosRemoteConnection;

  protected

    function GetValue(const FieldName: string): variant;
    function Execute(ExecMode: TExecutionMode): boolean;

  public
    { Public declarations }
    property CanConnect: boolean read FCanConnect;
    property ExecutionMode: TExecutionMode read FExecutionMode;
    property ICosmosApp: ICosmosApplication read FICosmosApp;
    property IRemoteCon: ICosmosRemoteConnection read GetCosmosRemoteConnection;
  end;




implementation

uses cosmos.common.view.EditLogradouros, cep;

{$R *.dfm}

function TFrmSearchLogradouro.Execute(ExecMode: TExecutionMode): boolean;
begin
 FExecutionMode := emSelectData;
 Result := ShowModal = mrOk;
end;

procedure TFrmSearchLogradouro.ClearControls;
begin
  EdtLogradouro.Text := '';
  EdtBairro.Text := '';
  EdtCidade.Text := '';
  EdtUF.Text := '';
end;

procedure TFrmSearchLogradouro.EdtCepKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if key = 13 then
  BtnSearch.Click;
end;


procedure TFrmSearchLogradouro.FormCreate(Sender: TObject);
begin
 FExecutionMode := emUnselectData; //default
 FICosmosApp := Application.MainForm as ICosmosApplication;
 FRemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scLogradouros);
 CdsLogradouros.RemoteServer := FRemoteConnection;

 FmeGridSearch1.SearchFields := 'nomlog';
 FCanConnect := False;
end;

procedure TFrmSearchLogradouro.FormDestroy(Sender: TObject);
begin
  if CdsLogradouros.Active then CdsLogradouros.Close;
 CdsLogradouros.RemoteServer := nil;

 if Assigned(FRemoteConnection) then
  ICosmosApp.IRemoteCon.DropConnection(FRemoteConnection);
end;

procedure TFrmSearchLogradouro.FormShow(Sender: TObject);
begin
 BtnSelect.Visible := ExecutionMode = emSelectData;
end;

function TFrmSearchLogradouro.GetCosmosRemoteConnection: ICosmosRemoteConnection;
begin
 if ICosmosApp <> nil then
  Result := ICosmosApp.IRemoteCon
 else
  Result := nil;
end;

function TFrmSearchLogradouro.GetValue(const FieldName: string): variant;
begin
 if CdsLogradouros.Active then
  begin
    if CdsLogradouros.FindField(FieldName) <> nil then
     Result := CdsLogradouros.Fields.FieldByName(FieldName).Value
    else
     Result := unassigned;
  end
 else
  Result := unassigned;
end;

procedure TFrmSearchLogradouro.BtnSelectClick(Sender: TObject);
begin
 if (CdsLogradouros.Active) and not (CdsLogradouros.IsEmpty) then
  ModalResult := mrOk;
end;

procedure TFrmSearchLogradouro.Button3Click(Sender: TObject);
begin
 if Self.HelpContext <> 0 then
  Application.HelpSystem.ShowContextHelp(Self.HelpContext, Application.CurrentHelpFile);
end;

procedure TFrmSearchLogradouro.CloseDataset;
begin
 if CdsLogradouros.Active then
  CdsLogradouros.Close;
end;

procedure TFrmSearchLogradouro.ActPesquisarExecute(Sender: TObject);
begin
 try
  with CdsLogradouros do
   begin
    DisableControls;
    CloseDataset;
    Params.Items[0].AsString := EdtCep.Text;
    Open;
   end;

 finally
  CdsLogradouros.EnableControls;
 end;
end;

procedure TFrmSearchLogradouro.ActNovoExecute(Sender: TObject);
begin
try
  if not Assigned(FrmEditLogradouros) then
   FrmEditLogradouros := TFrmEditLogradouros.Create(self);
  FrmEditLogradouros.NovoLogradouro;

 finally
  if Assigned(FrmEditLogradouros) then
   FreeAndNil(FrmEditLogradouros);
 end;
end;

procedure TFrmSearchLogradouro.ActNovoUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled :=
  (cfCadastrarLogradouros in IRemoteCon.CurrentConnectionInfo.AuthorizedFeatures);
end;

procedure TFrmSearchLogradouro.ActCosultarECTExecute(Sender: TObject);
var
 ObjSoap : CEPServicePort;
 sCep, s: widestring;
 I: integer;

begin
 if not CanConnect then
  FCanConnect := ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.Logradouros, TCosmosConfMsg.ConsultaCEP) = mrYes;

 if not CanConnect then
  Exit;

  ClearControls;

  ObjSoap := HTTPRIO1 as CEPServicePort;
  if ObjSoap = nil then
   begin
    ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.Logradouros, TCosmosErrorMsg.ConsultaCEP);
    Exit;
   end;
  

 try
  sCep := ObjSOAP.obterLogradouro(EdtCep.Text);

  if (Pos(WideString('Cep'), sCep) <> 0) then
   ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.Logradouros,TCosmosErrorMsg.CepNotFount)
  else
   begin
    I := Pos(',', sCEP);
    s := Copy(sCEP, 1, I - 1);
    Delete(sCEP, 1, I);
    EdtLogradouro.Text := s;

    I := Pos(',', sCEP);
    s := Copy(sCEP, 1, I - 1);
    Delete(sCEP, 1, I );
    EdtBairro.Text := TrimLeft(s);

    I := Pos(',', sCEP);
    s := Copy(sCEP, 1, I - 1);
    Delete(sCEP, 1, I );
    EdtCidade.Text := TrimLeft(s);

    EdtUF.Text := TrimLeft(sCEP);
   end;

 except
  raise;
 end;

end;

procedure TFrmSearchLogradouro.ActCosultarECTUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := (Trim(EdtCep.Text) <> '-');
end;

procedure TFrmSearchLogradouro.ActEditarExecute(Sender: TObject);
begin
 try
  if not Assigned(FrmEditLogradouros) then
   FrmEditLogradouros := TFrmEditLogradouros.Create(self);
  FrmEditLogradouros.EditLogradouro(CdsLogradouros.Fields.FieldByName('codlog').Value);

 finally
  if Assigned(FrmEditLogradouros) then
   FreeAndNil(FrmEditLogradouros);
 end;
end;

procedure TFrmSearchLogradouro.ActEditarUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := (CdsLogradouros.Active) and not (CdsLogradouros.IsEmpty)
  and (cfCadastrarLogradouros in IRemoteCon.CurrentConnectionInfo.AuthorizedFeatures);
end;

initialization
 RegisterClass(TFrmSearchLogradouro);

finalization
 UnregisterClass(TFrmSearchLogradouro);

end.
