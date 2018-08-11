unit cosmos.common.view.EditLogradouros;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, DB, DBClient, cosmos.frames.fkSearch, Mask, DBCtrls,
  Buttons, GraphicHeader, cosmos.framework.interfaces.root, cosmos.classes.ServerInterface,
  Cosmos.Framework.Interfaces.DataAcess, GroupHeader, FrameDBInsertVertical,
  cosmos.system.messages, Datasnap.DSConnect, cosmos.classes.security;

type
  TFrmEditLogradouros = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    Label1: TLabel;
    Bevel1: TBevel;
    MSGraphicHeader1: TMSGraphicHeader;
    Label2: TLabel;
    Label3: TLabel;
    MSGraphicHeader2: TMSGraphicHeader;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    FmeFKSearchBairro: TFmeFKSearch;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    CdsLogradouros: TClientDataSet;
    BtnNovoBairro: TSpeedButton;
    BtnNovoPais: TSpeedButton;
    BtnNovaCidade: TSpeedButton;
    BtnNovoEstado: TSpeedButton;
    FmeDBInsertVertical1: TFmeDBInsertVertical;
    procedure BtnNovaCidadeClick(Sender: TObject);
    procedure BtnNovoEstadoClick(Sender: TObject);
    procedure BtnNovoPaisClick(Sender: TObject);
    procedure BtnNovoBairroClick(Sender: TObject);
    procedure CdsLogradourosReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
    procedure CdsLogradourosBeforePost(DataSet: TDataSet);
    procedure CdsLogradourosAfterPost(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FICosmosApp: ICosmosApplication;
    FRemoteConnection: TDSProviderConnection;

  public
    { Public declarations }
    procedure NovoLogradouro;
    procedure EditLogradouro(const codlog: variant);

    property ICosmosApp: ICosmosApplication read FICosmosApp;

  end;

var
  FrmEditLogradouros: TFrmEditLogradouros;

implementation

uses cosmos.common.view.EditBairros, cosmos.common.view.EditPaises,
  cosmos.common.view.EditEstados, cosmos.common.view.EditCidades;


{$R *.dfm}

procedure TFrmEditLogradouros.EditLogradouro(const codlog: variant);
begin
 CdsLogradouros.Params.Items[0].value := codlog;
 CdsLogradouros.Open;
 ShowModal;
end;

procedure TFrmEditLogradouros.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if CdsLogradouros.Active then CdsLogradouros.Close;
 CdsLogradouros.RemoteServer := nil;

 if Assigned(FRemoteConnection) then
  ICosmosApp.IRemoteCon.DropConnection(FRemoteConnection);
end;

procedure TFrmEditLogradouros.FormCreate(Sender: TObject);
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;
 FRemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scLogradouros);
 CdsLogradouros.RemoteServer := FRemoteConnection;
 
 FmeFKSearchBairro.Configure('codbai', csBairros);
 FmeFKSearchBairro.FullScan := True;

 CdsLogradouros.ReadOnly := (Assigned(ICosmosApp.IRemoteCon))
   and not (cfCadastrarLogradouros in ICosmosApp.IRemoteCon.CurrentConnectionInfo.AuthorizedFeatures);

 BtnNovoPais.Visible := not CdsLogradouros.ReadOnly;
 BtnNovoEstado.Visible := not CdsLogradouros.ReadOnly;
 BtnNovaCidade.Visible := not CdsLogradouros.ReadOnly;
 BtnNovoBairro.Visible := not CdsLogradouros.ReadOnly;
 FmeFKSearchBairro.Enabled := not CdsLogradouros.ReadOnly;
end;

procedure TFrmEditLogradouros.NovoLogradouro;
begin
 CdsLogradouros.Open;
 ShowModal;
end;

procedure TFrmEditLogradouros.BtnNovoBairroClick(Sender: TObject);
begin
 try
  if not Assigned(FrmEditBairros) then
   FrmEditBairros := TFrmEditBairros.Create(self);

  FrmEditBairros.NovoBairro;

 finally
  if Assigned(FrmEditBairros) then
   FreeAndNil(FrmEditBairros);
 end;
end;

procedure TFrmEditLogradouros.BtnNovoPaisClick(Sender: TObject);
begin
 try
  if not Assigned(FrmDlgPaises) then
   FrmDlgPaises := TFrmDlgPaises.Create(self);
  FrmDlgPaises.EditarPaises;

 finally
  if Assigned(FrmDlgPaises) then
   FreeAndNil(FrmDlgPaises);
 end;
end;

procedure TFrmEditLogradouros.BtnNovaCidadeClick(Sender: TObject);
begin
 try
   if not Assigned(FrmEditCidades) then
     FrmEditCidades := TFrmEditCidades.Create(self);
   FrmEditCidades.ShowModal;

 finally
  if Assigned(FrmEditCidades) then
   FreeAndNil(FrmEditCidades);
 end;
end;

procedure TFrmEditLogradouros.BtnNovoEstadoClick(Sender: TObject);
begin
 try
  if not Assigned(FrmEditEstados) then
   FrmEditEstados := TFrmEditEstados.Create(self);
  FrmEditEstados.NovoEstado;

 finally
  if Assigned(FrmEditEstados) then
   FreeAndNil(FrmEditEstados);
 end;
end;

procedure TFrmEditLogradouros.CdsLogradourosAfterPost(DataSet: TDataSet);
begin
 CdsLogradouros.ApplyUpdates(0);
end;

procedure TFrmEditLogradouros.CdsLogradourosBeforePost(DataSet: TDataSet);
var
SequenceName: string;
begin
 if Length(Dataset.Fields.FieldByName('ceplog').AsString) <> 9 then
  if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.Logradouros, TCosmosConfMsg.ConfCep) = mrNo then
   begin
    Dataset.Fields.FieldByName('ceplog').FocusControl;
    Abort;
   end;

 if Dataset.State = dsInsert then
  begin
   SequenceName := TClientDataset(DataSet).GetOptionalParam('SequenceName'); //do not localize!
   Dataset.Fields.Fields[0].Value := ICosmosApp.IRemoteCon.GetSequenceValue(SequenceName);
   if Dataset.Fields.Fields[0].Value = unassigned then
    Dataset.Cancel;
  end;
end;

procedure TFrmEditLogradouros.CdsLogradourosReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
 ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, E.Message);
end;

end.
