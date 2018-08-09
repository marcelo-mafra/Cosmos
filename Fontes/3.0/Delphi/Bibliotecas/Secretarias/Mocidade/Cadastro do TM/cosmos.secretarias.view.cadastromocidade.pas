unit cosmos.secretarias.view.cadastromocidade;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, ExtCtrls, GroupHeader, StdCtrls, ComCtrls,
  DBDateTimePicker, DBCtrls, Mask, cosmos.frames.usuariocad,
  cosmos.frames.fksearch, ValueComboBox, DBValueComboBox, FrameDBInsertVertical,
  cosmos.classes.ServerInterface, StdActns, ActnList, ImgList, Menus, ActnPopup,
  cosmos.system.messages, ExtActns, cosmos.frames.dbeditcalculator, Buttons, ActnMan,
  Cosmos.Framework.Interfaces.Root, cosmos.classes.application, cosmos.classes.security,
  PlatformDefaultStyleActnCtrls, System.Actions, EDBImage, Vcl.Clipbrd,
  Cosmos.Framework.Interfaces.DataAcess, Cosmos.Framework.Interfaces.Applications,
  cosmos.business.focos, Datasnap.DSConnect, cosmos.common.services.utilities;

type
  TFrmCadastroJovensTM = class(TForm)
    CdsJovemTM: TClientDataSet;
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
    DBCheckBox4: TDBCheckBox;
    MSGroupHeader6: TMSGroupHeader;
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
    ActClear: TAction;
    ApagarFoto1: TMenuItem;
    ProcurarFoto1: TMenuItem;
    ActCopy: TAction;
    ActPaste: TAction;
    CopiarFoto1: TMenuItem;
    ColarFoto1: TMenuItem;
    N1: TMenuItem;
    ActLoad: TOpenPicture;
    FmeFkDiscipulados: TFmeFKSearch;
    FmeDBCalculator1: TFmeDBCalculator;
    FmeDBCalculator2: TFmeDBCalculator;
    Image1: TImage;
    SpeedButton1: TSpeedButton;
    ActRetirarTitular: TAction;
    SpeedButton2: TSpeedButton;
    DBFoto: TEDBImage;
    ActSavePhoto: TSavePicture;
    SalvarImagem1: TMenuItem;
    N2: TMenuItem;
    procedure SpeedButton2Click(Sender: TObject);
    procedure ActRetirarTitularExecute(Sender: TObject);
    procedure ActLoadUpdate(Sender: TObject);
    procedure ActLoadAccept(Sender: TObject);
    procedure ActPasteExecute(Sender: TObject);
    procedure ActCopyExecute(Sender: TObject);
    procedure ActClearUpdate(Sender: TObject);
    procedure ActClearExecute(Sender: TObject);
    procedure CdsJovemTMBeforePost(DataSet: TDataSet);
    procedure CdsJovemTMAfterPost(DataSet: TDataSet);
    procedure CdsJovemTMAfterInsert(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure PopupActionBar1Popup(Sender: TObject);
    procedure ActPasteUpdate(Sender: TObject);
    procedure ActSavePhotoAccept(Sender: TObject);
    procedure CdsJovemTMAfterOpen(DataSet: TDataSet);
    procedure DBFotoLoadCustomImage(var B: TGraphic; Stream: TStream);
    procedure CdsJovemTMReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
    procedure ActRetirarTitularUpdate(Sender: TObject);
  private
    { Private declarations }
    FICosmosApp: ICosmosApplication;
    FRemoteConnection: TDSProviderConnection;
    function NovaMatricula: string;

  public
    { Public declarations }
    procedure EditarJovemTM(const codcad: integer);
    procedure NovoJovemTM;

    property ICosmosApp: ICosmosApplication read FICosmosApp;
  end;

var
  FrmCadastroJovensTM: TFrmCadastroJovensTM;

implementation

{$R *.dfm}

{ TFrmCadastroAluno }

procedure TFrmCadastroJovensTM.ActClearExecute(Sender: TObject);
begin
 CdsJovemTM.Edit;
 CdsJovemTM.Fields.FieldByName('fotcad').Clear;
end;

procedure TFrmCadastroJovensTM.ActClearUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := (CdsJovemTM.Active) and not (CdsJovemTM.Fields.FieldByName('fotcad').IsNull);
end;

procedure TFrmCadastroJovensTM.ActCopyExecute(Sender: TObject);
begin
 DBFoto.CopyToClipboard;
end;

procedure TFrmCadastroJovensTM.ActPasteExecute(Sender: TObject);
begin
 DBFoto.PasteFromClipboard;
end;

procedure TFrmCadastroJovensTM.ActPasteUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := (CdsJovemTM.Active) and (Clipboard.HasFormat(CF_PICTURE));
end;

procedure TFrmCadastroJovensTM.ActRetirarTitularExecute(Sender: TObject);
begin
 if not CdsJovemTM.Active then
   Exit;

 if not CdsJovemTM.Fields.FieldByName('cadtit').IsNull then
   begin
     if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.TM, TCosmosConfMsg.DelTitularJovemTM) = mrYes then
       begin
        CdsJovemTM.Edit;
        CdsJovemTM.Fields.FieldByName('cadtit').Clear;
        CdsJovemTM.Fields.FieldByName('nomtit').Clear;
       end;
   end
 else
  ICosmosApp.DlgMessage.InfoMessage(TCosmosTitles.TM, TCosmosInfoMsg.TitularJovemTMInexistente);
end;

procedure TFrmCadastroJovensTM.ActRetirarTitularUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := (CdsJovemTM.Active)
   and not (CdsJovemTM.Fields.FieldByName('cadtit').IsNull)
   and not (CdsJovemTM.ReadOnly);
end;

procedure TFrmCadastroJovensTM.ActSavePhotoAccept(Sender: TObject);
begin
 try
  DBFoto.SaveToFile(ActSavePhoto.Dialog.FileName);

 except
  on E: Exception do
   begin
    ICosmosApp.MainLog.RegisterError(E.Message);
    ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, TCosmosErrorSecMsg.SavePhoto)
   end;
 end;

end;

procedure TFrmCadastroJovensTM.CdsJovemTMAfterInsert(DataSet: TDataSet);
begin
 CdsJovemTM.Fields.FieldByName('codfoc').AsInteger := ICosmosApp.ActiveFocus.FocusID;

  with CdsJovemTM.Fields do
   begin
    FieldByName('indati').AsString := 'S';
    FieldByName('indextnuc').AsString := 'N';
    FieldByName('indfre').AsString := 'N';
    FieldByName('indligroz').AsString := 'N';
    FieldByName('sexcad').AsString := 'M';
    FieldByName('estciv').AsString := 'SOL';
    FieldByName('naccad').AsString := TCosmosMiscellaneous.Nacionalidade;
    FieldByName('datnas').AsDateTime := EdtNascimento.MaxDate;
    FieldByName('matcad').AsString := NovaMatricula;
   end;
end;

procedure TFrmCadastroJovensTM.CdsJovemTMAfterOpen(DataSet: TDataSet);
begin
 //Somente deixa editável o dataset quando o usuário puder alterá-lo.
 CdsJovemTM.ReadOnly :=   (CdsJovemTM.Fields.FieldByName('indati').Value = 'S')
  and (Assigned(ICosmosApp.IRemoteCon))
  and (ICosmosApp.IRemoteCon.CurrentConnectionMode <> cmWrite)
  and (sfAlterarJovem in ICosmosApp.IRemoteCon.CurrentConnectionInfo.SecretariasFeatures);
end;

procedure TFrmCadastroJovensTM.CdsJovemTMAfterPost(DataSet: TDataSet);
begin
 if CdsJovemTM.ChangeCount > 0 then
  CdsJovemTM.ApplyUpdates(0);
end;

procedure TFrmCadastroJovensTM.CdsJovemTMBeforePost(DataSet: TDataSet);
var
SequenceName: string;
begin
 with Dataset do
  begin
   Fields.FieldByName('USURES').Value := UpperCase(ICosmosApp.IRemoteCon.ConnectedUser);;
   Fields.FieldByName('DATCAD').Value := ICosmosApp.IRemoteCon.ServerDateTime;

   if State = dsInsert then
    begin
     SequenceName := TClientDataset(DataSet).GetOptionalParam('SequenceName');
     Fields.Fields[0].AsInteger := ICosmosApp.IRemoteCon.GetSequenceValue(SequenceName);
    end;
  end;
end;

procedure TFrmCadastroJovensTM.CdsJovemTMReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
var
 sMessage, sMatricula: string;
begin
//Trata o erro de tentativa de inserir matrículas duplicadas.
 if Pos('IX_CADASTRADOS_MATRICULAS', E.Message) >= 0 then
  begin
    sMessage := TCosmosErrorMsg.MatriculaDuplicada;
    sMatricula := CdsJovemTM.Fields.FieldByName('matcad').AsString;
    sMatricula := sMatricula.Trim;
    sMessage := string.Format(sMessage, [sMatricula]);
    ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.TM, sMessage);
  end
 else
   Action := ICosmosApp.IRemoteCon.ReconcileError(E, UpdateKind);

  Action := raCancel;
end;

procedure TFrmCadastroJovensTM.EditarJovemTM(const codcad: integer);
begin
 CdsJovemTM.Params.Items[0].AsInteger := codcad;
 CdsJovemTM.Open;
 ShowModal;
end;

procedure TFrmCadastroJovensTM.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 if CdsJovemTM.Active then CdsJovemTM.Close;
 CdsJovemTM.RemoteServer := nil;

 if Assigned(FRemoteConnection) then
  ICosmosApp.IRemoteCon.DropConnection(FRemoteConnection);
end;

procedure TFrmCadastroJovensTM.FormCreate(Sender: TObject);
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;
 FRemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scMocidade);
 CdsJovemTM.RemoteServer := FRemoteConnection;

 FmeFKProfissoes.Configure('codpro', csProfissoes);
 FmeFKDiscipulados.Configure('coddis', csDiscipuladosTM);
 FmeFKDiscipulados.ButtonEnabled := True;
 FmeFKTitular.Configure('cadtit', csAlunoTitular);
 EdtNascimento.MaxDate := ICosmosApp.IRemoteCon.ServerDateTime;
end;

procedure TFrmCadastroJovensTM.DBFotoLoadCustomImage(var B: TGraphic;
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

function TFrmCadastroJovensTM.NovaMatricula: string;
var
 ISecretarias: ICosmosSecretarias;
begin
 ISecretarias := Application.MainForm as ICosmosSecretarias;

 try
  Result := ISecretarias.NovaMatricula(ctTM);

 finally
  if Assigned(ISecretarias) then
   ISecretarias := nil;
 end;
end;

procedure TFrmCadastroJovensTM.NovoJovemTM;
begin
 with CdsJovemTM do
  begin
   Params.Items[0].AsInteger := 0;
   Open;
  end;

 ShowModal;
end;

procedure TFrmCadastroJovensTM.PopupActionBar1Popup(Sender: TObject);
begin
 TPopupActionBar(Sender).Style := ICosmosApp.InterfaceStyle;
end;

procedure TFrmCadastroJovensTM.SpeedButton2Click(Sender: TObject);
begin
 with CdsJovemTM do
  begin
   if State = dsBrowse then Edit;
   Fields.FieldByName('matcad').AsString := NovaMatricula;
  end;
end;

procedure TFrmCadastroJovensTM.ActLoadAccept(Sender: TObject);
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

procedure TFrmCadastroJovensTM.ActLoadUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := CdsJovemTM.Active;
end;

end.
