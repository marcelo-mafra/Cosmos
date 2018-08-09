unit cosmos.frames.framefotos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ImgList,
  Vcl.StdActns, Vcl.ExtActns, System.Actions, Vcl.ActnList, Vcl.Menus,
  Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnPopup, Data.DB, Vcl.Clipbrd,
  Cosmos.Framework.Interfaces.Root, cosmos.system.messages, Vcl.Imaging.jpeg;

type
  TFmeFoto = class(TFrame)
    Panel1: TPanel;
    ImgFoto: TImage;
    PopupActionBar1: TPopupActionBar;
    ProcurarFoto1: TMenuItem;
    N1: TMenuItem;
    CopiarFoto1: TMenuItem;
    ColarFoto1: TMenuItem;
    ApagarFoto1: TMenuItem;
    ActionList1: TActionList;
    ActClear: TAction;
    ActCopy: TAction;
    ActPaste: TAction;
    ActLoad: TOpenPicture;
    ImageList1: TImageList;
    procedure ActClearExecute(Sender: TObject);
    procedure ActClearUpdate(Sender: TObject);
    procedure ActLoadAccept(Sender: TObject);
    procedure ActLoadUpdate(Sender: TObject);
    procedure ActCopyExecute(Sender: TObject);
    procedure ActPasteExecute(Sender: TObject);
    procedure ActPasteUpdate(Sender: TObject);
  private
    { Private declarations }
    FDataset: TDataset;
    FICosmosApp: ICosmosApplication ;
    FPicture: TPicture;

  public
    { Public declarations }
    procedure ClearImage;
    procedure LoadFoto;
    procedure UndoDelete;

    property Dataset: TDataset read FDataset write FDataset;
    property ICosmosApp: ICosmosApplication read FICosmosApp write FICosmosApp;
    property Picture: TPicture read FPicture write FPicture;
  end;

implementation

{$R *.dfm}

procedure TFmeFoto.ActClearExecute(Sender: TObject);
begin
 if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.Alunos, TCosmosConfMsg.DelFoto) = mrYes then
  begin
   Dataset.Edit;
   Dataset.Fields.FieldByName('fotcad').Clear;
   ImgFoto.Picture := nil;
  end;
end;

procedure TFmeFoto.ActClearUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := (Dataset <> nil) and (Dataset.Active)
   and not (Dataset.Fields.FieldByName('fotcad').IsNull);
end;

procedure TFmeFoto.ActCopyExecute(Sender: TObject);
var
Formato : Word;
Data: NativeUint;
Palette : HPaleTte;
begin
 ImgFoto.Picture.SaveToClipBoardFormat(Formato, Data, Palette);
 ClipBoard.SetAsHandle(Formato, Data);
end;

procedure TFmeFoto.ActLoadAccept(Sender: TObject);
var
 ABlob: TBlobField;
begin
 Dataset.Edit;
 ABlob := TBlobField(Dataset.Fields.FieldByName('fotcad'));
 ABlob.LoadFromFile(ActLoad.Dialog.FileName);
 ImgFoto.Picture.LoadFromFile(ActLoad.Dialog.FileName);
end;

procedure TFmeFoto.ActLoadUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := (Dataset <> nil) and (Dataset.Active);
end;

procedure TFmeFoto.ActPasteExecute(Sender: TObject);
var
 AStream: TMemoryStream;
 APicture: TPicture;
 AJPEG: TJPEGImage;
begin
{Cola a imagem existente no clipboard e a converte para o formato JPEG.}
 APicture := TPicture.Create;
 AJPEG := TJPEGImage.Create;
 AStream := TMemoryStream.Create;

 try
  APicture.RegisterClipboardFormat(CF_BITMAP, TBITMAP);
  APicture.LoadFromClipboardFormat(CF_BITMAP, ClipBoard.GetAsHandle(CF_BITMAP), 0);
  AJPEG.Assign(APicture.Bitmap);
  AJPEG.SaveToStream(AStream);

  if not AJPEG.Empty then
   begin
    Dataset.Edit;
    TBlobField(Dataset.Fields.FieldByName('fotcad')).LoadFromStream(AStream);
    ImgFoto.Picture.Assign(AJPEG);
   end;

 finally
  if Assigned(AStream) then FreeAndNil(AStream);
  if Assigned(APicture) then FreeAndNil(APicture);
  if Assigned(AJPEG) then FreeAndNil(AJPEG);
 end;
end;

procedure TFmeFoto.ActPasteUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := (Dataset <> nil) and (Dataset.Active) and
  (Clipboard.HasFormat(CF_PICTURE));
end;

procedure TFmeFoto.ClearImage;
begin
 ImgFoto.Picture := nil;
end;

procedure TFmeFoto.UndoDelete;
begin
 if FPicture <> nil then
  ImgFoto.Picture.Assign(FPicture);
end;

procedure TFmeFoto.LoadFoto;
var
 AStream: TMemoryStream;
 ABlob: TBlobField;
 APicture: TPicture;
begin
 if Dataset.Active then
  begin
    ABlob := TBlobField(Dataset.Fields.FieldByName('fotcad'));
    if ABlob.BlobSize > 0 then
     begin
      AStream := TMemoryStream.Create;

      try
       ABlob.SaveToStream(AStream);
       APicture := ICosmosApp.IRemoteCon.GetFotoCadastrado(AStream);
       if APicture <> nil then
        begin
         ImgFoto.Picture.Assign(APicture);
         FPicture := APicture;
        end;

      finally
       if Assigned(AStream) then FreeAndNil(AStream);
      end;
     end;
  end;

end;

end.
