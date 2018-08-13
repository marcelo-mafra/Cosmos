unit cosmos.common.view.FormCadastroEndereco;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, GroupHeader, DB, DBClient, cosmos.classes.application,
  cosmos.Framework.Interfaces.Root, Cosmos.Framework.Interfaces.DataAcess,
  Cosmos.Framework.Interfaces.Dialogs, StdCtrls, Mask, DBCtrls, cosmos.frames.fkSearch,
  cosmos.classes.ServerInterface, ValueComboBox, DBValueComboBox, cosmos.frames.gridsearch,
  cosmos.frames.usuariocad, cosmos.system.types, cosmos.system.messages, FrameDeleteButtons,
  cosmos.classes.security, Datasnap.DSConnect, cosmos.system.dataconverter;

type
  TFrmCadastroEndereco = class(TForm, ICosmosEnderecos)
    MSGroupHeader1: TMSGroupHeader;
    CdsEnderecos: TClientDataSet;
    FmeFKSearch1: TFmeFKSearch;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    CBXTipoEndereco: TDBValueComboBox;
    DBCheckBox1: TDBCheckBox;
    Label9: TLabel;
    MSGroupHeader3: TMSGroupHeader;
    FmeUsuarioCadastrador1: TFmeUsuarioCadastrador;
    FmeDBDelButtons1: TFmeDBDelButtons;
    FmeGridSearch1: TFmeGridSearch;
    MSGroupHeader2: TMSGroupHeader;
    DBEdit8: TDBEdit;
    Label10: TLabel;
    DBEdit9: TDBEdit;
    Label11: TLabel;
    Label12: TLabel;
    DBEdit10: TDBEdit;
    CdsEnderecosFoco: TClientDataSet;
    procedure CdsEnderecosBeforeDelete(DataSet: TDataSet);
    procedure CdsEnderecosAfterPost(DataSet: TDataSet);
    procedure CdsEnderecosBeforePost(DataSet: TDataSet);
    procedure CdsEnderecosAfterInsert(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CdsEnderecosAfterOpen(DataSet: TDataSet);
    procedure CdsEnderecosReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
  private
    { Private declarations }
    FICosmosApp: ICosmosApplication;
    FRemoteConnection: TDSProviderConnection;
    function EnderecoCartaExiste(const codcad: integer): TCosmosData;

  protected
    procedure GetEnderecosCadastrado(const codcad: integer);
    procedure GetEnderecosFoco(const codfoc: integer);    

  public
    { Public declarations }
    property ICosmosApp: ICosmosApplication read FICosmosApp;
  end;

var
  FrmCadastroEndereco: TFrmCadastroEndereco;

implementation

{$R *.dfm}

procedure TFrmCadastroEndereco.CdsEnderecosAfterInsert(DataSet: TDataSet);
begin
{Insere os valores dos campo "codfoc" ou "codcad", conforme se esteja inserindo
 endereços de pessoas ou focos.}

 if CdsEnderecosFoco.Active then //Focos
     begin
      with CdsEnderecosFoco.Fields do
       begin
        FieldByName('codfoc').AsInteger := CdsEnderecos.Params.Items[0].AsInteger;
        FieldByName('indcor').AsString := TDataConverter.ToBoleanString(True);
       end;
     end;

 if CdsEnderecos.Active then  //Cadastrados
     begin
      with CdsEnderecos.Fields do
       begin
        FieldByName('codcad').AsInteger := CdsEnderecos.Params.Items[0].AsInteger;
        FieldByName('tipend').AsString := TCosmosMiscellaneous.Residencial;
        FieldByName('indcor').AsString := TDataConverter.ToBoleanString(True);
       end;
     end;
end;

procedure TFrmCadastroEndereco.CdsEnderecosAfterOpen(DataSet: TDataSet);
begin
 TClientDataset(Dataset).ReadOnly := (Assigned(ICosmosApp.IRemoteCon))
   and (ICosmosApp.IRemoteCon.CurrentConnectionMode <> cmWrite);
end;

procedure TFrmCadastroEndereco.CdsEnderecosAfterPost(DataSet: TDataSet);
begin
 if TClientDataset(Dataset).ChangeCount > 0 then
  TClientDataset(Dataset).ApplyUpdates(0);
end;

procedure TFrmCadastroEndereco.CdsEnderecosBeforeDelete(DataSet: TDataSet);
begin
 if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.Enderecos, TCosmosConfMsg.DeleteAddress) = mrNo then
  Abort;
end;

procedure TFrmCadastroEndereco.CdsEnderecosBeforePost(DataSet: TDataSet);
var
SequenceName: string;
AData: TCosmosData;
begin
{O tratamento abaixo é feito para atender à regra de que cada cadastrado somente
 pode possuir um único endereço para recebimento de correspondências.}
 DataSet.Fields.FieldByName('USURES').Value := UpperCase(ICosmosApp.IRemoteCon.ConnectedUser);
 DataSet.Fields.FieldByName('DATCAD').Value := ICosmosApp.IRemoteCon.ServerDateTime;

 if Dataset.State = dsInsert then
  begin
   SequenceName := TClientDataset(DataSet).GetOptionalParam('SequenceName');
   Dataset.Fields.Fields[0].AsInteger := ICosmosApp.IRemoteCon.GetSequenceValue(SequenceName);

   if CdsEnderecos.Active then //As validações abaixo não são feitas no Gestor de Focos.
    begin
       if (Dataset.FieldValues['INDCOR'] = 'S') then
        begin
         if EnderecoCartaExiste(Dataset.FieldValues['CODCAD']) <> nil then
          begin
           ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.Enderecos, TCosmosErrorMsg.EnderecosCorrespondencia);
           Dataset.FieldValues['INDCOR'] := TDataConverter.ToBoleanString(False);
          end;
        end;
      end;

     if Dataset.State = dsEdit then
      begin
       if (Dataset.FieldValues['INDCOR'] = 'S') then
        begin
         AData := EnderecoCartaExiste(Dataset.FieldValues['CODCAD']);
         if AData <> nil then
          begin
           if (Dataset.FieldValues['CODEND']) <> (AData.FindValue('CODEND')) then
            begin
             ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.Enderecos, TCosmosErrorMsg.EnderecosCorrespondencia);
             Dataset.FieldValues['INDCOR'] := TDataConverter.ToBoleanString(False);
            end;
          end;
        end;
      end;
  end;
end;

procedure TFrmCadastroEndereco.CdsEnderecosReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
 Action := ICosmosApp.IRemoteCon.ReconcileError(E, UpdateKind);
end;

function TFrmCadastroEndereco.EnderecoCartaExiste(
  const codcad: integer): TCosmosData;
var
 aDataset: TClientDataset;
 AParam: TParam;
begin
 Result := nil; //valor padrão. Existe um endereço cadastrado como para receber correspondência.
 aDataset := TClientDataset.Create(self);

 try
  aDataset.RemoteServer := FRemoteConnection;
  aDataset.ProviderName := 'DspEndereco';  //do not localize!
  AParam := aDataset.Params.AddParameter;
  AParam.DataType := ftInteger;
  AParam.Name := 'codcad';
  AParam.ParamType := ptInput;
  AParam.AsInteger := codcad;
  aDataset.Open;
  aDataset.Filter := 'INDCOR = ' + '''' + 'S' + ''''; //do not localize!
  aDataset.Filtered := True;
  if aDataset.RecordCount > 0 then
   begin
    Result := TCosmosData.Create(3);
    Result.WriteValue('CODEND', aDataset.FieldValues['codend']);
   end;

 finally
  if Assigned(aDataset) then FreeAndNil(aDataset);
 end;
end;

procedure TFrmCadastroEndereco.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 if CdsEnderecos.Active then CdsEnderecos.Close;
 if CdsEnderecosFoco.Active then CdsEnderecosFoco.Close;

 CdsEnderecos.RemoteServer := nil;
 CdsEnderecosFoco.RemoteServer := nil;

 if Assigned(FRemoteConnection) then
  ICosmosApp.IRemoteCon.DropConnection(FRemoteConnection);

 if ICosmosApp <> nil then FICosmosApp := nil;
end;

procedure TFrmCadastroEndereco.FormCreate(Sender: TObject);
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;

 FmeFKSearch1.Configure('codlog',csLogradouros);
 FmeGridSearch1.SearchFields := 'nomlog';
end;

procedure TFrmCadastroEndereco.GetEnderecosCadastrado(const codcad: integer);
begin
 FRemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scLogradouros);
 CdsEnderecos.RemoteServer := FRemoteConnection;
 FmeDBDelButtons1.DataSource1.DataSet := CdsEnderecos;
 CdsEnderecos.Params.Items[0].AsInteger := codcad;
 CdsEnderecos.Open;

 ShowModal;
end;

procedure TFrmCadastroEndereco.GetEnderecosFoco(const codfoc: integer);
begin
 FRemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scFocos);
 CdsEnderecosFoco.RemoteServer := FRemoteConnection;
 FmeDBDelButtons1.DataSource1.DataSet := CdsEnderecosFoco;

 //Campo "Tipo do endereço" não é fornecido para endereços de focos...
 CBXTipoEndereco.DataField := '';
 CBXTipoEndereco.Visible := False;
 Label9.Visible := False;
 
 CdsEnderecosFoco.Params.Items[0].AsInteger := codfoc;
 CdsEnderecosFoco.Open;

 ShowModal;
end;


initialization
 RegisterClass(TFrmCadastroEndereco);

finalization
 UnRegisterClass(TFrmCadastroEndereco);

end.
