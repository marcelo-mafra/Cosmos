unit cosmos.secretarias.view.batismos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ComCtrls, ValueComboBox, GroupHeader, cosmos.classes.application,
  Cosmos.Framework.Interfaces.Root, Cosmos.Framework.Interfaces.DataAcess,
  cosmos.system.messages, Data.DBXCommon, Cosmos.classes.ServerInterface,
  Cosmos.Framework.Interfaces.Applications;

type
  TFrmBatismo = class(TForm)
    MSGroupHeader1: TMSGroupHeader;
    MSGroupHeader2: TMSGroupHeader;
    EdtFoco: TEdit;
    EdtCadastrado: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    EdtData: TDateTimePicker;
    EdtRegistro: TEdit;
    EdtDescricao: TEdit;
    MmoObservacoes: TMemo;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    procedure BitBtn3Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure EdtRegistroKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FICosmosApp: ICosmosApplication;

    procedure FillCadastradoInfo(const codcad: integer);

  public
    { Public declarations }
   procedure BatizarCadastrado(const codcad: integer);

    property ICosmosApp: ICosmosApplication read FICosmosApp;
  end;

var
  FrmBatismo: TFrmBatismo;

implementation

{$R *.dfm}

{ TFrmBatismo }

procedure TFrmBatismo.BatizarCadastrado(const codcad: integer);
var
 AData: TCosmosData;
 ISecretarias: ICosmosSecretarias;
begin
 FillCadastradoInfo(codcad);

 if ShowModal = mrOk then
   begin
     AData := TCosmosData.Create(6);
     ISecretarias := Application.MainForm as ICosmosSecretarias;

     try
       AData.WriteValue('CADASTRADO', codcad);
       AData.WriteValue('DATA', EdtData.Date, 1);
       AData.WriteValue('REGISTRO', EdtRegistro.Text, 2);
       AData.WriteValue('DESCRICAO', EdtDescricao.Text, 3);
       AData.WriteValue('OBSERVACAO',  MmoObservacoes.Lines.CommaText, 4);
       AData.WriteValue('USUARIO', ICosmosApp.IRemoteCon.CurrentUser.UserName.ToUpper, 5);

       ISecretarias.BaptizePeople(AData.TaggedData);

     finally
       if Assigned(AData) then FreeAndNil(AData);
       if Assigned(ISecretarias) then ISecretarias := nil;
     end;
   end;
end;

procedure TFrmBatismo.BitBtn3Click(Sender: TObject);
begin
 if Self.HelpContext <> 0 then
  Application.HelpSystem.ShowContextHelp(Self.HelpContext, Application.CurrentHelpFile);
end;

procedure TFrmBatismo.EdtRegistroKeyPress(Sender: TObject; var Key: Char);
begin
if not CharInSet(Key, ['0'..'9']) then
  Abort;
end;

procedure TFrmBatismo.FillCadastradoInfo(const codcad: integer);
var
 AReader: TDBXReader;
 AParam: TSQLParams;
begin
 AParam := TSQLParams.Create(1);

 try
  AParam.AppendData(codcad);
  AReader := ICosmosApp.IRemoteCon.ListData(csCadastradoCode, AParam.Params);

  if AReader.Next then
   begin
    EdtCadastrado.Text := AReader.Value['nomcad'].GetAnsiString;
    EdtFoco.Text :=  AReader.Value['nomfoc'].GetAnsiString;
   end;

  AParam.Free;
  AReader.Free;

 except
  on E: Exception do
   begin
    AParam.Free;
    if Assigned(AReader) then FreeAndNil(AReader);
    raise;
   end;
 end;
end;

procedure TFrmBatismo.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
 if ModalResult = mrOk then
  begin
   CanClose := Trim(EdtRegistro.Text) <> '';
   if not CanClose then
    begin
     ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.BatizarCadastrado, TCosmosErrorMsg.NumRegistroNulo);
     Abort;
    end;

   CanClose := Trim(EdtDescricao.Text) <> '';
   if not CanClose then
    begin
     ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.BatizarCadastrado, TCosmosErrorMsg.DescricaoHistorico);
     Abort;
    end;
  end;
end;

procedure TFrmBatismo.FormCreate(Sender: TObject);
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;

 EdtData.DateTime := ICosmosApp.IRemoteCon.ServerDateTime;
 EdtData.MaxDate := ICosmosApp.IRemoteCon.ServerDateTime;
end;

end.
