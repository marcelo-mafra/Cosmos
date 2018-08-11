unit cosmos.secretarias.view.cadastropesquisadores;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, ComCtrls, StdCtrls, ValueComboBox, DBValueComboBox, Mask,
  DBCtrls, ExtCtrls, GroupHeader, FrameDBInsertVertical, cosmos.frames.usuariocad,
  cosmos.classes.application, cosmos.classes.ServerInterface, cosmos.classes.security,
  Cosmos.Framework.Interfaces.Root, Cosmos.Framework.Interfaces.DataAcess, cosmos.data.dataobjects,
  DBEditDateTimePicker, cosmos.system.messages, DBDateTimePicker, cosmos.system.files,
  Cosmos.Framework.Interfaces.Applications, cosmos.business.focos,
  Datasnap.DSConnect;

type
  TFrmCadastroPesquisador = class(TForm)

    CdsPesquisador: TClientDataSet;
    MSGroupHeader1: TMSGroupHeader;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    DBValueComboBox1: TDBValueComboBox;
    MSGroupHeader2: TMSGroupHeader;
    Label6: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBComboBox1: TDBComboBox;
    FmeDBInsertVertical1: TFmeDBInsertVertical;
    MSGroupHeader3: TMSGroupHeader;
    FmeUsuarioCadastrador1: TFmeUsuarioCadastrador;
    MSGroupHeader4: TMSGroupHeader;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox2: TDBCheckBox;
    DBRadioGroup1: TDBRadioGroup;
    EdtNascimento: TDBDateTimePicker;
    Label8: TLabel;
    DBMemo1: TDBMemo;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CdsPesquisadorBeforePost(DataSet: TDataSet);
    procedure CdsPesquisadorAfterPost(DataSet: TDataSet);
    procedure CdsPesquisadorAfterInsert(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure CdsPesquisadorAfterOpen(DataSet: TDataSet);
    procedure CdsPesquisadorReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
  private
    { Private declarations }
    FDiscipuladoCode: Integer;
    FICosmosApp: ICosmosApplication;
    FRemoteConnection: TDSProviderConnection;

  public
    { Public declarations }
    procedure NovoPesquisador;
    procedure EditarPesquisador(const codcad: integer);
    property DiscipuladoCode : Integer read FDiscipuladoCode write FDiscipuladoCode;
    property ICosmosApp: ICosmosApplication read FICosmosApp;
  end;

var
  FrmCadastroPesquisador: TFrmCadastroPesquisador;

implementation

{$R *.dfm}

{ TFrmCadastroPesquisador }

procedure TFrmCadastroPesquisador.CdsPesquisadorAfterInsert(DataSet: TDataSet);
var
 ISecretarias: ICosmosSecretarias;
begin
 ISecretarias := Application.MainForm as ICosmosSecretarias;

 try
  with Dataset.Fields do
   begin
    FieldByName('codfoc').Value := ICosmosApp.ActiveFocus.FocusID;
    FieldByName('indextnuc').Value := 'N';
    FieldByName('indprecon').Value := 'N';
    FieldByName('sexcad').Value := 'F';
    FieldByName('conesc').Value := 1;
    FieldByName('naccad').Value := TCosmosMiscellaneous.Nacionalidade;
    FieldByName('coddis').Value := DiscipuladoCode;
    FieldByName('datnas').Value := EdtNascimento.MaxDate;
    FieldByName('matcad').AsString := ISecretarias.NovaMatricula(ctTP);
   end;

 finally
  if Assigned(ISecretarias) then
   ISecretarias := nil;
 end;
end;

procedure TFrmCadastroPesquisador.CdsPesquisadorAfterOpen(DataSet: TDataSet);
begin
 //Somente deixa editável o dataset quando o usuário puder alterá-lo.
 TClientDataset(Dataset).ReadOnly := (CdsPesquisador.Fields.FieldByName('indati').Value = 'S')
   and Assigned(ICosmosApp.IRemoteCon)
   and (ICosmosApp.IRemoteCon.CurrentConnectionMode <> cmWrite)
   and (sfAlterarPesquisador in ICosmosApp.IRemoteCon.CurrentConnectionInfo.SecretariasFeatures);
end;

procedure TFrmCadastroPesquisador.CdsPesquisadorAfterPost(DataSet: TDataSet);
begin
 if CdsPesquisador.ChangeCount > 0 then
  CdsPesquisador.ApplyUpdates(0);
end;

procedure TFrmCadastroPesquisador.CdsPesquisadorBeforePost(DataSet: TDataSet);
var
SequenceName: string;
begin
 if Dataset.State = dsInsert then
  begin
   SequenceName := TClientDataset(DataSet).GetOptionalParam('SequenceName');
   Dataset.Fields.Fields[0].AsInteger := ICosmosApp.IRemoteCon.GetSequenceValue(SequenceName);
  end;

 Dataset.Fields.FieldByName('USURES').Value := UpperCase(ICosmosApp.IRemoteCon.ConnectedUser);;
 Dataset.Fields.FieldByName('DATCAD').Value := ICosmosApp.IRemoteCon.ServerDateTime;
end;

procedure TFrmCadastroPesquisador.CdsPesquisadorReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
var
 sMessage, sMatricula: string;
begin
//Trata o erro de tentativa de inserir matrículas duplicadas.
 if Pos('IX_CADASTRADOS_MATRICULAS', E.Message) >= 0 then
  begin
    sMessage := TCosmosErrorMsg.MatriculaDuplicada;
    sMatricula := CdsPesquisador.Fields.FieldByName('matcad').AsString;
    sMatricula := sMatricula.Trim;
    sMessage := string.Format(sMessage, [sMatricula]);
    ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.TP, sMessage);
  end
 else
   Action := ICosmosApp.IRemoteCon.ReconcileError(E, UpdateKind);

  Action := raCancel;
end;

procedure TFrmCadastroPesquisador.EditarPesquisador(const codcad: integer);
begin
 CdsPesquisador.Params.Items[0].AsInteger := codcad;
 CdsPesquisador.Open;
 ShowModal;
end;

procedure TFrmCadastroPesquisador.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 if CdsPesquisador.Active then CdsPesquisador.Close;
 CdsPesquisador.RemoteServer := nil;

 if Assigned(FRemoteConnection) then
  ICosmosApp.IRemoteCon.DropConnection(FRemoteConnection);
end;

procedure TFrmCadastroPesquisador.FormCreate(Sender: TObject);
var
ADataset: TClientDataset;
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;
 FRemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scPesquisadores);
 CdsPesquisador.RemoteServer := FRemoteConnection;

 try
  EdtNascimento.MaxDate := ICosmosApp.IRemoteCon.ServerDateTime;
  ADataset := ICosmosApp.IRemoteCon.OpenBufferedData(TCosmosFiles.BufDiscipulados);
  ADataset.Filter := Format(TFilterData.CAMDIS, [QuotedStr('TPU')]);
  ADataset.Filtered := True;
  DiscipuladoCode := ADataset.Fields.FieldByName('coddis').AsInteger;
  ADataset.Close;

 finally
  if Assigned(ADataset) then
   ADataset.Free;
 end;
end;

procedure TFrmCadastroPesquisador.NovoPesquisador;
begin
 CdsPesquisador.Params.Items[0].AsInteger := 0;
 CdsPesquisador.Open;
 CdsPesquisador.Insert;
 ShowModal;
end;



end.
