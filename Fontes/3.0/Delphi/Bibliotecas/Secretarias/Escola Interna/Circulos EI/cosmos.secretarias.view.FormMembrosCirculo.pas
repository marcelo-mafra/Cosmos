unit cosmos.secretarias.view.FormMembrosCirculo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, cosmos.frames.gridsearch, StdCtrls, ExtCtrls, GroupHeader,
  Buttons, FrameFecharAjuda, ActnList, cosmos.system.messages,
  Cosmos.Framework.Interfaces.Root, Cosmos.Framework.Interfaces.DataAcess,
  Cosmos.Framework.Interfaces.Dialogs, cosmos.classes.application,
  cosmos.business.focos, cosmos.Framework.forms.datadialogs,
  cosmos.classes.security, System.Actions, Datasnap.DSConnect;

type
  TFrmMembrosCirculo = class(TForm)
    CdsMembros: TClientDataSet;
    DsrMembros: TDataSource;
    MSGroupHeader1: TMSGroupHeader;
    Button1: TButton;
    Button2: TButton;
    Image1: TImage;
    Image2: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Bevel1: TBevel;
    FmeGridSearch1: TFmeGridSearch;
    ActionList1: TActionList;
    ActNovoAluno: TAction;
    ActDesligar: TAction;
    Image3: TImage;
    Button3: TButton;
    Label3: TLabel;
    ActContato: TAction;
    FmeFecharAjuda1: TFmeFecharAjuda;
    procedure ActContatoExecute(Sender: TObject);
    procedure CdsMembrosAfterInsert(DataSet: TDataSet);
    procedure CdsMembrosBeforePost(DataSet: TDataSet);
    procedure CdsMembrosAfterPost(DataSet: TDataSet);
    procedure ActNovoAlunoUpdate(Sender: TObject);
    procedure ActNovoAlunoExecute(Sender: TObject);
    procedure ActDesligarUpdate(Sender: TObject);
    procedure ActDesligarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CdsMembrosReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
  private
    { Private declarations }
    FICosmosApp: ICosmosApplication;
    FRemoteConnection: TDSProviderConnection;

  public
    { Public declarations }
    procedure ShowMembrosCirculo(const codgru: integer; nomgru: string);
    property ICosmosApp: ICosmosApplication read FICosmosApp;
  end;

var
  FrmMembrosCirculo: TFrmMembrosCirculo;

implementation

{$R *.dfm}

procedure TFrmMembrosCirculo.ActContatoExecute(Sender: TObject);
var
Contato: boolean;
Aluno: string;
begin
//Define o aluno que será o contato do círculo
 Contato := UpperCase(CdsMembros.Fields.FieldByName('indcon').Value) = 'SIM';
 Aluno := CdsMembros.Fields.FieldByName('nomcad').AsString;

 if Contato then
  begin
   if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.EI, Format(TCosmosConfMsg.DelContatoCirculo, [Aluno])) = mrYes then
    begin
     try
      CdsMembros.DisableControls;
      CdsMembros.Edit;
      CdsMembros.Fields.FieldByName('indcon').Value := 'N';
      CdsMembros.Post;

     finally
      Cdsmembros.Refresh;
      CdsMembros.EnableControls;
     end;
    end;
  end
 else
  begin
   if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.EI, Format(TCosmosConfMsg.DefContatoCirculo, [Aluno])) = mrYes then
    begin
     try
      CdsMembros.DisableControls;
      CdsMembros.Edit;
      CdsMembros.Fields.FieldByName('indcon').Value := 'S';
      CdsMembros.Post;

     finally
      Cdsmembros.Refresh;
      CdsMembros.EnableControls;
     end;
    end;
  end;
end;

procedure TFrmMembrosCirculo.ActDesligarExecute(Sender: TObject);
begin
 //Desliga o aluno do círculo atual, sem desligá-lo do Lectorium Rosicrucianum.
  if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.EI, TCosmosConfMsg.DelMembroCirculoEI) = mrYes then
   begin
    CdsMembros.Delete;
   end;
end;

procedure TFrmMembrosCirculo.ActDesligarUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := (CdsMembros.Active)
  and not (CdsMembros.IsEmpty)
  and (ICosmosApp.IRemoteCon.CurrentConnectionMode = cmWrite);
end;

procedure TFrmMembrosCirculo.ActNovoAlunoExecute(Sender: TObject);
var
 AData: TCosmosData;
begin
 //Cadastra um novo membro do círculo
 AData := TCosmosCadastradosDialogs.SelecionarCadastrado(ctLectorium, scTodos, False);

 try
  if AData <> nil then
   begin
    with CdsMembros do
     begin
      DisableControls;
      Append;
      Fields.FieldByName('codcad').Value := AData.FindValue('codcad');
      Fields.FieldByName('matcad').Value := AData.FindValue('matcad');
      Fields.FieldByName('nomcad').Value := AData.FindValue('nomcad');
      Fields.FieldByName('indcon').Value := 'N';
      Post;
      Refresh;
      EnableControls;
     end;
   end;

 except
  if CdsMembros.ChangeCount > 0 then
    CdsMembros.CancelUpdates;
  CdsMembros.EnableControls;
 end;
end;

procedure TFrmMembrosCirculo.ActNovoAlunoUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := (CdsMembros.Active)
   and (ICosmosApp.IRemoteCon.CurrentConnectionMode = cmWrite) ;
end;

procedure TFrmMembrosCirculo.CdsMembrosAfterInsert(DataSet: TDataSet);
begin
 with CdsMembros do
  begin
   Fields.FieldByName('codgru').Value := Params.Items[0].Value;
  end;
end;

procedure TFrmMembrosCirculo.CdsMembrosAfterPost(DataSet: TDataSet);
begin
 if CdsMembros.ChangeCount > 0 then
  CdsMembros.ApplyUpdates(0);
end;

procedure TFrmMembrosCirculo.CdsMembrosBeforePost(DataSet: TDataSet);
var
SequenceName: string;
begin
 if Dataset.State = dsInsert then
  begin
   SequenceName := TClientDataset(DataSet).GetOptionalParam('SequenceName');
   Dataset.Fields.Fields[0].AsInteger := ICosmosApp.IRemoteCon.GetSequenceValue(SequenceName);
  end;
end;

procedure TFrmMembrosCirculo.CdsMembrosReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
 Action := ICosmosApp.IRemoteCon.ReconcileError(E, UpdateKind);
end;

procedure TFrmMembrosCirculo.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 CdsMembros.RemoteServer := nil;

 if (Assigned(ICosmosApp.IRemoteCon)) and (Assigned(FRemoteConnection)) then
  ICosmosApp.IRemoteCon.DropConnection(FRemoteConnection);
end;

procedure TFrmMembrosCirculo.FormCreate(Sender: TObject);
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;
 FRemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scEscolaInterna);
 CdsMembros.RemoteServer := FRemoteConnection;

 FmeGridSearch1.SearchFields := 'nomcad';
 FmeGridSearch1.ShowSearchBar := False;
end;

procedure TFrmMembrosCirculo.ShowMembrosCirculo(const codgru: integer;
  nomgru: string);
begin
 CdsMembros.Params.Items[0].AsInteger := codgru;
 CdsMembros.Open;
 Caption := Caption + ' - ' + nomgru; 
 ShowModal;
end;

end.
