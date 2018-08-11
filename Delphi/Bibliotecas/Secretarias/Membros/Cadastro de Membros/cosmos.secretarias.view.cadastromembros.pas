unit cosmos.secretarias.view.cadastromembros;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, ExtCtrls, GroupHeader, StdCtrls, ComCtrls,
  DBDateTimePicker, DBCtrls, Mask, cosmos.frames.usuariocad, cosmos.classes.application,
  cosmos.frames.fksearch, ValueComboBox, DBValueComboBox, FrameDBInsertVertical,
  cosmos.classes.ServerInterface, StdActns, ActnList, ImgList, Cosmos.Framework.Interfaces.Root,
  Menus, ActnPopup, cosmos.classes.security,
  cosmos.system.messages, ExtActns, cosmos.framework.interfaces.DataAcess,
  cosmos.frames.dbeditcalculator, Buttons, ActnMan, PlatformDefaultStyleActnCtrls,
  System.Actions, EDBImage, Cosmos.Framework.Interfaces.Secretarias,
  cosmos.business.focos;

type
  TFrmCadastroMembros = class(TForm)
    CdsMembro: TClientDataSet;
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
    MSGroupHeader6: TMSGroupHeader;
    Label14: TLabel;
    Label15: TLabel;
    DBCheckBox5: TDBCheckBox;
    MSGroupHeader7: TMSGroupHeader;
    DBMemo1: TDBMemo;
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
    ActRetirarTitular: TAction;
    SpeedButton2: TSpeedButton;
    DBCheckBox1: TDBCheckBox;
    ImgFoto: TEDBImage;
    procedure SpeedButton2Click(Sender: TObject);
    procedure ActLoadUpdate(Sender: TObject);
    procedure ActLoadAccept(Sender: TObject);
    procedure ActPasteExecute(Sender: TObject);
    procedure ActCopyExecute(Sender: TObject);
    procedure ActClearUpdate(Sender: TObject);
    procedure ActClearExecute(Sender: TObject);
    procedure CdsMembroReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
    procedure CdsMembroBeforePost(DataSet: TDataSet);
    procedure CdsMembroAfterPost(DataSet: TDataSet);
    procedure CdsMembroAfterInsert(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure PopupActionBar1Popup(Sender: TObject);
    procedure CdsMembroBeforeOpen(DataSet: TDataSet);
  private
    { Private declarations }
    FICosmosApp: ICosmosApplication;
    function NovaMatricula: string;

  public
    { Public declarations }
    procedure EditarMembro(const codcad: integer);
    procedure NovoMembro;

    property ICosmosApp: ICosmosApplication read FICosmosApp;
  end;

var
  FrmCadastroMembros: TFrmCadastroMembros;

implementation

{$R *.dfm}

{ TFrmCadastroAluno }

procedure TFrmCadastroMembros.ActClearExecute(Sender: TObject);
begin
 if ICosmosApp.DlgMessage.ConfirmationMessage(sTitleTMB, sConfDelFoto) = mrYes then
  begin
   CdsMembro.Edit;
   CdsMembro.Fields.FieldByName('fotcad').Clear;
  end;
end;

procedure TFrmCadastroMembros.ActClearUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := (CdsMembro.Active) and not (CdsMembro.Fields.FieldByName('fotcad').IsNull);
end;

procedure TFrmCadastroMembros.ActCopyExecute(Sender: TObject);
begin
 ImgFoto.CopyToClipboard;
end;

procedure TFrmCadastroMembros.ActPasteExecute(Sender: TObject);
begin
 ImgFoto.PasteFromClipboard;
end;

procedure TFrmCadastroMembros.CdsMembroAfterInsert(DataSet: TDataSet);
begin
   with CdsMembro.Fields do
    begin
     FieldByName('codfoc').AsInteger := ICosmosApp.ActiveFocus.FocusID;
     FieldByName('indati').AsString := 'S';
     FieldByName('indlic').AsString := 'N';
     FieldByName('indextnuc').AsString := 'N';
     FieldByName('indgrujov').AsString := 'N';
     FieldByName('indfre').AsString := 'N';
     FieldByName('indligroz').AsString := 'N';
     FieldByName('indmen').AsString := 'N';
     FieldByName('sexcad').AsString := 'M';
     FieldByName('estciv').AsString := 'SOL';
     FieldByName('naccad').AsString := 'Brasileira';
     FieldByName('datnas').AsDateTime := EdtNascimento.MaxDate;
     FieldByName('matcad').AsString := NovaMatricula;
     FieldByName('nomcad').FocusControl;
    end;
end;

procedure TFrmCadastroMembros.CdsMembroAfterPost(DataSet: TDataSet);
begin
 if CdsMembro.ChangeCount > 0 then
  CdsMembro.ApplyUpdates(0);
end;

procedure TFrmCadastroMembros.CdsMembroBeforeOpen(DataSet: TDataSet);
begin
  ICosmosApp.IRemoteCon.ServerClass := scMembros;
end;

procedure TFrmCadastroMembros.CdsMembroBeforePost(DataSet: TDataSet);
var
SequenceName: string;
begin
 if Dataset.State = dsInsert then
  begin
   SequenceName := TClientDataset(DataSet).GetOptionalParam('SequenceName');
   Dataset.Fields.Fields[0].AsInteger := ICosmosApp.IRemoteCon.GetSequenceValue(SequenceName);
  end;

 DataSet.Fields.FieldByName('USURES').Value := UpperCase(ICosmosApp.IRemoteCon.ConnectedUser);;
 DataSet.Fields.FieldByName('DATCAD').Value := ICosmosApp.IRemoteCon.ServerDateTime;
end;

procedure TFrmCadastroMembros.CdsMembroReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
 ICosmosApp.DlgMessage.ErrorMessage(sTitleTMB, E.Message);
end;

procedure TFrmCadastroMembros.EditarMembro(const codcad: integer);
begin
 CdsMembro.Params.Items[0].AsInteger := codcad;
 CdsMembro.Open;
 ShowModal;
end;

procedure TFrmCadastroMembros.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 if CdsMembro.Active then
  CdsMembro.Close;
 CdsMembro.ConnectionBroker := nil;
end;

procedure TFrmCadastroMembros.FormCreate(Sender: TObject);
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;
 CdsMembro.RemoteServer := ICosmosApp.IRemoteCon.ConnectionBroker;
 FmeFKProfissoes.Configure('codpro', csProfissoes);
 FmeFKDiscipulados.Configure('coddis', csDiscipuladosTMB);
 EdtNascimento.MaxDate := ICosmosApp.IRemoteCon.ServerDateTime;

 //Somente deixa editável o dataset quando o usuário puder alterá-lo.
 CdsMembro.ReadOnly := (ICosmosApp.IRemoteCon.CurrentConnectionMode <> cmWrite)
  and (CdsMembro.Fields.FieldByName('indati').Value = 'S')
  and (cfAlterarMembro in ICosmosApp.IRemoteCon.CurrentConnectionInfo.AuthorizedFeatures);
end;

function TFrmCadastroMembros.NovaMatricula: string;
var
 ISecretarias: ICosmosSecretarias;
begin
 ISecretarias := Application.MainForm as ICosmosSecretarias;

 try
  Result := ISecretarias.NovaMatricula(ctTMB);

 finally
  if Assigned(ISecretarias) then
   ISecretarias := nil;
 end;
end;

procedure TFrmCadastroMembros.NovoMembro;
begin
 with CdsMembro do
  begin
   Params.Items[0].AsInteger := 0;
   Open;
  end;

 ShowModal;
end;

procedure TFrmCadastroMembros.PopupActionBar1Popup(Sender: TObject);
var
ICosmosApp: ICosmosApplication;
begin
 ICosmosApp := Application.MainForm as ICosmosApplication;

 try
  TPopupActionBar(Sender).Style := ICosmosApp.InterfaceStyle;

 finally
  if ICosmosApp <> nil then
   ICosmosApp := nil;
 end;
end;

procedure TFrmCadastroMembros.SpeedButton2Click(Sender: TObject);
begin
 with CdsMembro do
  begin
   if State = dsBrowse then Edit;
   Fields.FieldByName('matcad').AsString := NovaMatricula;
  end;
end;

procedure TFrmCadastroMembros.ActLoadAccept(Sender: TObject);
begin
 ImgFoto.Picture.LoadFromFile(ActLoad.Dialog.FileName);
end;

procedure TFrmCadastroMembros.ActLoadUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := CdsMembro.Active;
end;

end.
