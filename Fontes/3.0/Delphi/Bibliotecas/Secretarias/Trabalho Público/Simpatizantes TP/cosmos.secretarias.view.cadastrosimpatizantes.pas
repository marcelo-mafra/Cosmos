unit cosmos.secretarias.view.cadastrosimpatizantes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cosmos.classes.application, cosmos.classes.ServerInterface,
  cosmos.classes.security, Cosmos.Framework.Interfaces.Root, cosmos.system.messages,
  Cosmos.Framework.Interfaces.DataAcess, Data.DB, Datasnap.DBClient,
  FrameDBInsertVertical, cosmos.frames.usuariocad, Vcl.ExtCtrls, GroupHeader,
  Vcl.StdCtrls, ValueComboBox, DBValueComboBox, Vcl.Mask, Vcl.DBCtrls,
  Vcl.ComCtrls, DBDateTimePicker, EDBImage, cosmos.frames.fkSearch, Vcl.Menus,
  Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnPopup, Vcl.ExtActns, Vcl.StdActns,
  System.Actions, Vcl.ActnList, Vcl.ImgList, Vcl.Clipbrd, Datasnap.DSConnect,
  cosmos.common.services.utilities;

type
  TFrmCadastroSimpatizante = class(TForm)
    CdsSimpatizante: TClientDataSet;
    FmeDBInsertVertical1: TFmeDBInsertVertical;
    MSGroupHeader3: TMSGroupHeader;
    FmeUsuarioCadastrador1: TFmeUsuarioCadastrador;
    MSGroupHeader1: TMSGroupHeader;
    Label2: TLabel;
    Label4: TLabel;
    DBEdit2: TDBEdit;
    DBValueComboBox1: TDBValueComboBox;
    MSGroupHeader4: TMSGroupHeader;
    DBMemo1: TDBMemo;
    DBFoto: TEDBImage;
    Label5: TLabel;
    EdtNascimento: TDBDateTimePicker;
    MSGroupHeader2: TMSGroupHeader;
    Label6: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBComboBox1: TDBComboBox;
    DBRadioGroup1: TDBRadioGroup;
    FmeFKProfissoes: TFmeFKSearch;
    Label1: TLabel;
    ImageList1: TImageList;
    ActionList1: TActionList;
    ActCopy: TAction;
    ActPaste: TAction;
    ActClear: TAction;
    ActLoad: TOpenPicture;
    ActSavePhoto: TSavePicture;
    PopupActionBar1: TPopupActionBar;
    ProcurarFoto1: TMenuItem;
    N1: TMenuItem;
    CopiarFoto1: TMenuItem;
    ColarFoto1: TMenuItem;
    ApagarFoto1: TMenuItem;
    N2: TMenuItem;
    SalvarImagem1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure CdsSimpatizanteAfterOpen(DataSet: TDataSet);
    procedure CdsSimpatizanteAfterPost(DataSet: TDataSet);
    procedure CdsSimpatizanteBeforePost(DataSet: TDataSet);
    procedure CdsSimpatizanteAfterInsert(DataSet: TDataSet);
    procedure PopupActionBar1Popup(Sender: TObject);
    procedure ActCopyExecute(Sender: TObject);
    procedure ActCopyUpdate(Sender: TObject);
    procedure ActPasteExecute(Sender: TObject);
    procedure ActPasteUpdate(Sender: TObject);
    procedure ActClearExecute(Sender: TObject);
    procedure ActLoadAccept(Sender: TObject);
    procedure ActLoadUpdate(Sender: TObject);
    procedure ActSavePhotoAccept(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBFotoLoadCustomImage(var B: TGraphic; Stream: TStream);
    procedure CdsSimpatizanteReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
  private
    { Private declarations }
    FICosmosApp: ICosmosApplication;
    ARemoteConnection: TDSProviderConnection;

  public
    { Public declarations }
    procedure NovoSimpatizante;
    procedure EditarSimpatizante(const codsim: integer);
    property ICosmosApp: ICosmosApplication read FICosmosApp;
  end;

var
  FrmCadastroSimpatizante: TFrmCadastroSimpatizante;

implementation

{$R *.dfm}

procedure TFrmCadastroSimpatizante.ActClearExecute(Sender: TObject);
begin
 CdsSimpatizante.Edit;
 CdsSimpatizante.Fields.FieldByName('fotcad').Clear;
end;

procedure TFrmCadastroSimpatizante.ActCopyExecute(Sender: TObject);
begin
 DBFoto.CopyToClipboard;
end;

procedure TFrmCadastroSimpatizante.ActCopyUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled :=  (CdsSimpatizante.Active) and not (CdsSimpatizante.Fields.FieldByName('fotcad').IsNull);
end;

procedure TFrmCadastroSimpatizante.ActLoadAccept(Sender: TObject);
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

procedure TFrmCadastroSimpatizante.ActLoadUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := (CdsSimpatizante.Active);
end;

procedure TFrmCadastroSimpatizante.ActPasteExecute(Sender: TObject);
begin
 DBFoto.PasteFromClipboard;
end;

procedure TFrmCadastroSimpatizante.ActPasteUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := (CdsSimpatizante.Active) and (Clipboard.HasFormat(CF_PICTURE));
end;

procedure TFrmCadastroSimpatizante.ActSavePhotoAccept(Sender: TObject);
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

procedure TFrmCadastroSimpatizante.CdsSimpatizanteAfterInsert(
  DataSet: TDataSet);
begin
  with CdsSimpatizante.Fields do
   begin
    FieldByName('codfoc').AsInteger := ICosmosApp.ActiveFocus.FocusID;
    FieldByName('indati').AsString := 'S';
    FieldByName('sexcad').AsString := 'M';
    FieldByName('naccad').AsString := TCosmosMiscellaneous.Nacionalidade;
    FieldByName('conesc').AsInteger := 1;
   end;
end;

procedure TFrmCadastroSimpatizante.CdsSimpatizanteAfterOpen(DataSet: TDataSet);
begin
 //Somente deixa editável o dataset quando o usuário puder alterá-lo.
 TClientDataset(Dataset).ReadOnly := (ICosmosApp.IRemoteCon.CurrentConnectionMode <> cmWrite)
  and (CdsSimpatizante.Fields.FieldByName('indati').Value = 'S');
end;

procedure TFrmCadastroSimpatizante.CdsSimpatizanteAfterPost(DataSet: TDataSet);
begin
 if CdsSimpatizante.ChangeCount > 0 then
  CdsSimpatizante.ApplyUpdates(0);
end;

procedure TFrmCadastroSimpatizante.CdsSimpatizanteBeforePost(DataSet: TDataSet);
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

procedure TFrmCadastroSimpatizante.CdsSimpatizanteReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
 Action := ICosmosApp.IRemoteCon.ReconcileError(E, UpdateKind);
end;

procedure TFrmCadastroSimpatizante.DBFotoLoadCustomImage(var B: TGraphic;
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

procedure TFrmCadastroSimpatizante.EditarSimpatizante(const codsim: integer);
begin
 CdsSimpatizante.Params.Items[0].AsInteger := codsim;
 CdsSimpatizante.Open;

 ShowModal;
end;

procedure TFrmCadastroSimpatizante.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 if CdsSimpatizante.Active then
   CdsSimpatizante.Close;

 CdsSimpatizante.RemoteServer := nil;

 if Assigned(ARemoteConnection) then
  ICosmosApp.IRemoteCon.DropConnection(ARemoteConnection);
end;

procedure TFrmCadastroSimpatizante.FormCreate(Sender: TObject);
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;
 ARemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scPesquisadores);
 CdsSimpatizante.RemoteServer := ARemoteConnection;

 FmeFKProfissoes.Configure('codpro', csProfissoes);
 EdtNascimento.MaxDate := ICosmosApp.IRemoteCon.ServerDateTime;
end;

procedure TFrmCadastroSimpatizante.NovoSimpatizante;
begin
 CdsSimpatizante.Params.Items[0].AsInteger := 0;
 CdsSimpatizante.Open;
 CdsSimpatizante.Insert;

 ShowModal;
end;

procedure TFrmCadastroSimpatizante.PopupActionBar1Popup(Sender: TObject);
begin
 TPopupActionBar(Sender).Style := ICosmosApp.InterfaceStyle;
end;

end.
