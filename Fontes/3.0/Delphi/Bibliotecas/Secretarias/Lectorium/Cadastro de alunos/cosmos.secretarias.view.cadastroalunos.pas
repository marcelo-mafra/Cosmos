unit cosmos.secretarias.view.cadastroalunos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, ExtCtrls, GroupHeader, StdCtrls, ComCtrls,
  DBDateTimePicker, DBCtrls, Mask, cosmos.frames.usuariocad, StdActns, ActnList,
  cosmos.frames.fksearch, ValueComboBox, DBValueComboBox, FrameDBInsertVertical,
  Cosmos.Framework.Interfaces.Root, Cosmos.Framework.Interfaces.DataAcess,
  cosmos.classes.ServerInterface,  cosmos.classes.security,
  ImgList, Menus, ActnPopup, cosmos.system.messages, ExtActns, cosmos.frames.dbeditcalculator,
  Buttons, ActnMan, cosmos.classes.application, PlatformDefaultStyleActnCtrls,
  cosmos.business.focos, System.Actions, Vcl.Clipbrd,
  Cosmos.Framework.Interfaces.Applications, Datasnap.DSConnect,
  cosmos.common.services.utilities, EDBImage;

type
  TFrmCadastroAluno = class(TForm)
    CdsAluno: TClientDataSet;
    MSGroupHeader3: TMSGroupHeader;
    FmeUsuarioCadastrador1: TFmeUsuarioCadastrador;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    MSGroupHeader1: TMSGroupHeader;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label11: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    EdtNascimento: TDBDateTimePicker;
    MSGroupHeader2: TMSGroupHeader;
    Label6: TLabel;
    Label8: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    DBEdit4: TDBEdit;
    DBEdit6: TDBEdit;
    DBComboBox2: TDBComboBox;
    FmeFKProfissoes: TFmeFKSearch;
    MSGroupHeader5: TMSGroupHeader;
    DBCheckBox2: TDBCheckBox;
    DBCheckBox3: TDBCheckBox;
    DBCheckBox4: TDBCheckBox;
    MSGroupHeader6: TMSGroupHeader;
    CBXAlunoMentor: TDBCheckBox;
    Label14: TLabel;
    Label15: TLabel;
    DBCheckBox5: TDBCheckBox;
    MSGroupHeader7: TMSGroupHeader;
    DBMemo1: TDBMemo;
    FmeFKTitular: TFmeFKSearch;
    Label16: TLabel;
    DBValueComboBox1: TDBValueComboBox;
    DBValueComboBox2: TDBValueComboBox;
    FmeDBInsertVertical1: TFmeDBInsertVertical;
    PopupActionBar1: TPopupActionBar;
    ActionList1: TActionList;
    ImageList1: TImageList;
    ApagarFoto1: TMenuItem;
    ProcurarFoto1: TMenuItem;
    CopiarFoto1: TMenuItem;
    ColarFoto1: TMenuItem;
    N1: TMenuItem;
    FmeFkDiscipulados: TFmeFKSearch;
    DBCheckBox1: TDBCheckBox;
    FmeDBCalculator1: TFmeDBCalculator;
    FmeDBCalculator2: TFmeDBCalculator;
    Image1: TImage;
    SpeedButton1: TSpeedButton;
    ActRetirarTitular: TAction;
    SpeedButton2: TSpeedButton;
    ActCopy: TAction;
    ActPaste: TAction;
    ActClear: TAction;
    ActLoad: TOpenPicture;
    ActSavePhoto: TSavePicture;
    SalvarImagem1: TMenuItem;
    N2: TMenuItem;
    Panel1: TPanel;
    ImgFoto: TImage;
    LblDataObito: TLabel;
    EdtDataObito: TDBEdit;
    DBFoto: TEDBImage;
    procedure SpeedButton2Click(Sender: TObject);
    procedure ActRetirarTitularExecute(Sender: TObject);
    procedure CdsAlunoBeforePost(DataSet: TDataSet);
    procedure CdsAlunoAfterPost(DataSet: TDataSet);
    procedure CdsAlunoAfterInsert(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure PopupActionBar1Popup(Sender: TObject);
    procedure ActLoadAccept(Sender: TObject);
    procedure ActCopyExecute(Sender: TObject);
    procedure ActPasteExecute(Sender: TObject);
    procedure ActClearExecute(Sender: TObject);
    procedure ActPasteUpdate(Sender: TObject);
    procedure ActLoadUpdate(Sender: TObject);
    procedure ActCopyUpdate(Sender: TObject);
    procedure ActSavePhotoAccept(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EDBImage1DblClick(Sender: TObject);
    procedure CdsAlunoAfterOpen(DataSet: TDataSet);
    procedure DBFotoLoadCustomImage(var B: TGraphic; Stream: TStream);
    procedure DBFotoDblClick(Sender: TObject);
    procedure CdsAlunoReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
    procedure ActClearUpdate(Sender: TObject);
    procedure ActRetirarTitularUpdate(Sender: TObject);
  private
    { Private declarations }
    FICosmosApp: ICosmosApplication;
    FRemoteConnection: TDSProviderConnection;
    function NovaMatricula: string;
    procedure LoadPhoto;

  public
    { Public declarations }
    procedure EditarAluno(const codcad: integer);
    procedure NovoAluno;

    property ICosmosApp: ICosmosApplication read FICosmosApp;
  end;

var
  FrmCadastroAluno: TFrmCadastroAluno;

implementation

{$R *.dfm}

{ TFrmCadastroAluno }

procedure TFrmCadastroAluno.ActRetirarTitularExecute(Sender: TObject);
begin
 if not CdsAluno.Active then
   Exit;

 if not CdsAluno.Fields.FieldByName('cadtit').IsNull then
   begin
     if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.Alunos, TCosmosConfMsg.DeleteTitular) = mrYes then
       begin
        CdsAluno.Edit;
        CdsAluno.Fields.FieldByName('cadtit').Clear;
        CdsAluno.Fields.FieldByName('nomtit').Clear;
       end;
   end
  else
    ICosmosApp.DlgMessage.Execute(TCosmosTitles.Alunos, TCosmosInfoMsg.TitularInexistente, mtInformation);
end;

procedure TFrmCadastroAluno.ActRetirarTitularUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := (CdsAluno.Active)
   and not (CdsAluno.Fields.FieldByName('cadtit').IsNull)
   and not (CdsAluno.ReadOnly);
end;

procedure TFrmCadastroAluno.ActSavePhotoAccept(Sender: TObject);
begin
 try
  ImgFoto.Picture.SaveToFile(ActSavePhoto.Dialog.FileName);

 except
  on E: Exception do
   begin
    ICosmosApp.MainLog.RegisterError(E.Message);
    ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, TCosmosErrorSecMsg.SavePhoto)
   end;
 end;
end;

procedure TFrmCadastroAluno.CdsAlunoAfterInsert(DataSet: TDataSet);
begin
  with CdsAluno.Fields do
   begin
    FieldByName('codfoc').AsInteger := ICosmosApp.ActiveFocus.FocusID;
    FieldByName('indati').AsString := 'S';
    FieldByName('indlic').AsString := 'N';
    FieldByName('indextnuc').AsString := 'N';
    FieldByName('indgrujov').AsString := 'N';
    FieldByName('indfre').AsString := 'N';
    FieldByName('indligroz').AsString := 'N';
    FieldByName('indmen').AsString := 'N';
    FieldByName('datnas').AsDateTime := EdtNascimento.MaxDate;
    FieldByName('sexcad').AsString := 'M';
    FieldByName('naccad').AsString := TCosmosMiscellaneous.Nacionalidade;
    FieldByName('nomcad').FocusControl;
    ImgFoto.Picture.Assign(nil);
   end;
end;

procedure TFrmCadastroAluno.CdsAlunoAfterOpen(DataSet: TDataSet);
begin
 //Somente deixa editável o dataset para o usuário com permissões.
 CdsAluno.ReadOnly := (ICosmosApp.IRemoteCon <> nil)
  and (ICosmosApp.IRemoteCon.CurrentConnectionMode <> cmWrite)
  and (CdsAluno.Fields.FieldByName('indati').Value = 'S')
  and (sfAlterarAluno in ICosmosApp.IRemoteCon.CurrentConnectionInfo.SecretariasFeatures);

 EdtDataObito.Enabled := CdsAluno.FieldValues['datobi'] <> null;
end;

procedure TFrmCadastroAluno.CdsAlunoAfterPost(DataSet: TDataSet);
begin
 if CdsAluno.ChangeCount > 0 then
  CdsAluno.ApplyUpdates(0);
end;

procedure TFrmCadastroAluno.CdsAlunoBeforePost(DataSet: TDataSet);
var
SequenceName: string;
begin
 if Dataset.State = dsInsert then
  begin
   SequenceName := TClientDataset(DataSet).GetOptionalParam('SequenceName');
   Dataset.Fields.Fields[0].AsInteger := ICosmosApp.IRemoteCon.GetSequenceValue(SequenceName);
  end
 else //Somente pode ser checado em atualizações!
  begin
   if CdsAluno.Fields.FieldByName('cadtit').Value = CdsAluno.Fields.FieldByName('codcad').Value then
     begin
      //O cadastrado não pode ser titular de si mesmo!
      ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.Alunos, TCosmosErrorSecMsg.AutoTitular);
      Abort;
     end;
  end;

  with Dataset.Fields do
   begin
    FieldByName('USURES').Value := ICosmosApp.IRemoteCon.ConnectedUser.ToUpper;
    FieldByName('DATCAD').Value := ICosmosApp.IRemoteCon.ServerDateTime;
   end;
end;

procedure TFrmCadastroAluno.CdsAlunoReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
var
 sMessage, sMatricula: string;
begin
//Trata o erro de tentativa de inserir matrículas duplicadas.
 if Pos('IX_CADASTRADOS_MATRICULAS', E.Message) >= 0 then
  begin
    sMessage := TCosmosErrorMsg.MatriculaDuplicada;
    sMatricula := CdsAluno.Fields.FieldByName('matcad').AsString;
    sMatricula := sMatricula.Trim;
    sMessage := string.Format(sMessage, [sMatricula]);
    ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.Alunos, sMessage);
  end
 else
  Action := ICosmosApp.IRemoteCon.ReconcileError(E, UpdateKind);

  Action := raCancel;
end;

procedure TFrmCadastroAluno.DBFotoDblClick(Sender: TObject);
begin
 ActLoad.Execute;
end;

procedure TFrmCadastroAluno.DBFotoLoadCustomImage(var B: TGraphic;
  Stream: TStream);
var
 AMStream: TMemoryStream;
begin
{Carrega um dos formatos de imagem não nativos no controle de dados. Os formatos
 não nativos do componente TEDBImage são PNG, GIF e TIFF. Os demais formatos
 não usam esse método.}
 AMStream := TMemoryStream.Create;

 try
  //Copia o stream da imagem para um TMemoryStream.
  AMStream.CopyFrom(Stream, Stream.Size);
  //Descobre qual o tipo da imagem e cria o TGraphicClass apropriado.
  B := TGraphicUtilities.GetImageGraphicClass(AMStream);
  Stream.Position := 0;

  //Carrega o stream original para o TGraphicClass.
  if B <> nil then
    B.LoadFromStream(Stream);

  AMStream.Free;

 except
  on E: Exception do
   begin
    AMStream.Free;
    ICosmosApp.MainLog.RegisterError(E.Message);
    ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.Alunos, TCosmosErrorSecMsg.LoadPhoto);
   end;
 end;

end;

procedure TFrmCadastroAluno.ActClearExecute(Sender: TObject);
begin
 CdsAluno.Edit;
 CdsAluno.Fields.FieldByName('fotcad').Clear;
end;

procedure TFrmCadastroAluno.ActClearUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := (CdsAluno.Active)
   and not (CdsAluno.Fields.FieldByName('fotcad').IsNull)
   and not (CdsAluno.ReadOnly);
end;

procedure TFrmCadastroAluno.ActCopyExecute(Sender: TObject);
begin
 DBFoto.CopyToClipboard;
end;

procedure TFrmCadastroAluno.ActCopyUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := (CdsAluno.Active) and not (CdsAluno.Fields.FieldByName('fotcad').IsNull);
end;

procedure TFrmCadastroAluno.ActLoadAccept(Sender: TObject);
begin
 try
 DBFoto.LoadFromFile(ActLoad.Dialog.FileName);

 except
  on E: Exception do
   begin
    ICosmosApp.MainLog.RegisterError(E.Message);
    ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.Alunos, TCosmosErrorMsg.LoadPhotoFromFile);
   end;
 end;
end;

procedure TFrmCadastroAluno.ActLoadUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := (CdsAluno.Active) and not (CdsAluno.ReadOnly);
end;

procedure TFrmCadastroAluno.ActPasteExecute(Sender: TObject);
begin
 DBFoto.PasteFromClipboard;
end;

procedure TFrmCadastroAluno.ActPasteUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := (CdsAluno.Active) and (Clipboard.HasFormat(CF_PICTURE));
end;

procedure TFrmCadastroAluno.EDBImage1DblClick(Sender: TObject);
begin
 ActLoad.Execute;
end;

procedure TFrmCadastroAluno.EditarAluno(const codcad: integer);
begin
 try
  CdsAluno.Params.Items[0].AsInteger := codcad;
  CdsAluno.Open;

  ShowModal;

 except
  Close;
 end;
end;

procedure TFrmCadastroAluno.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 if CdsAluno.Active then CdsAluno.Close;
 CdsAluno.RemoteServer := nil;

 if Assigned(FRemoteConnection) then
  ICosmosApp.IRemoteCon.DropConnection(FRemoteConnection);
end;

procedure TFrmCadastroAluno.FormCreate(Sender: TObject);
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;
 FRemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scLectorium);
 CdsAluno.RemoteServer := FRemoteConnection;

 FmeFKProfissoes.Configure('codpro', csProfissoes);
 FmeFKDiscipulados.Configure('coddis', csDiscipuladosLectorium);
 FmeFKTitular.Configure('cadtit', csAlunoTitular);

 //Somente disponibiliza o botão para troca manual de discipulados a usuários autorizados.
 FmeFKDiscipulados.ButtonEnabled := sfTrocarDiscipulado in ICosmosApp.IRemoteCon.CurrentConnectionInfo.SecretariasFeatures;

 EdtNascimento.MaxDate := ICosmosApp.IRemoteCon.ServerDateTime;
 CBXAlunoMentor.Enabled := ctEI in ICosmosApp.IRemoteCon.CurrentConnectionInfo.CamposTrabalho;
end;

procedure TFrmCadastroAluno.LoadPhoto;
var
 aStream: TMemoryStream;
begin
{Carrega a foto da pessoa.}
 if not CdsAluno.Fields.FieldByName('fotcad').IsNull then
  begin
   aStream := TMemoryStream.Create;

   try
    TGraphicField(CdsAluno.Fields.FieldByName('fotcad')).SaveToStream(aStream);

    if aStream.Size > 0 then
     begin
       TGraphicUtilities.LoadPictureFromStream(aStream, ImgFoto.Picture);
       aStream.Free;
     end;

   except
    on E: Exception do
     begin
      aStream.Free;
      ICosmosApp.MainLog.RegisterError(E.Message);
      ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.Alunos, TCosmosErrorSecMsg.LoadPhoto);
     end;
   end;
  end;
end;

function TFrmCadastroAluno.NovaMatricula: string;
var
 ISecretarias: ICosmosSecretarias;
begin
 ISecretarias := Application.MainForm as ICosmosSecretarias;

 try
  Result := ISecretarias.NovaMatricula(ctLectorium);

 finally
  if Assigned(ISecretarias) then ISecretarias := nil;
 end;
end;

procedure TFrmCadastroAluno.NovoAluno;
begin
 CdsAluno.Params.Items[0].AsInteger := 0;
 CdsAluno.Open;
 ShowModal;
end;

procedure TFrmCadastroAluno.PopupActionBar1Popup(Sender: TObject);
begin
 TPopupActionBar(Sender).Style := ICosmosApp.InterfaceStyle;
end;

procedure TFrmCadastroAluno.SpeedButton2Click(Sender: TObject);
begin
 if not CdsAluno.ReadOnly then
  begin
   if CdsAluno.State = dsBrowse then
    CdsAluno.Edit;
   CdsAluno.Fields.FieldByName('matcad').AsString := NovaMatricula;
  end;
end;

end.
