unit cosmos.secretarias.view.desligamentos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ComCtrls, GroupHeader, Cosmos.Framework.Interfaces.Root,
  cosmos.classes.ServerInterface, Data.DBXCommon, cosmos.classes.application,
  cosmos.system.messages, Cosmos.Framework.Interfaces.Applications;

type
  TFrmDesligamento = class(TForm)

    MSGroupHeader1: TMSGroupHeader;
    MSGroupHeader2: TMSGroupHeader;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    EdtNome: TEdit;
    Label6: TLabel;
    Label5: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Label7: TLabel;
    EdtDiscipulado: TEdit;
    EdtFoco: TEdit;
    Label8: TLabel;
    CBXMotivo: TComboBox;
    EdtDataDesligamento: TDateTimePicker;
    EdtDataFalecimento: TDateTimePicker;
    MmoObservacoes: TMemo;
    procedure BitBtn3Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure CBXMotivoChange(Sender: TObject);
  private
    { Private declarations }
    FICosmosApp: ICosmosApplication;
    procedure FillCadastradoInfo(const codcad: integer);

  public
    { Public declarations }
    function DesligarCadastrado(const codcad: integer): boolean;
    property ICosmosApp: ICosmosApplication read FICosmosApp;
  end;

var
  FrmDesligamento: TFrmDesligamento;

implementation

{$R *.dfm}

procedure TFrmDesligamento.BitBtn3Click(Sender: TObject);
begin
 if Self.HelpContext <> 0 then
  Application.HelpSystem.ShowContextHelp(Self.HelpContext, Application.CurrentHelpFile);
end;

procedure TFrmDesligamento.CBXMotivoChange(Sender: TObject);
begin
 EdtDataFalecimento.Enabled := TComboBox(Sender).ItemIndex = 2;
end;

function TFrmDesligamento.DesligarCadastrado(const codcad: integer): boolean;
var
 AData: TCosmosData;
 ISecretarias: ICosmosSecretarias;
begin
 Result := False;

 FillCadastradoInfo(codcad);

 if ShowModal = mrOk then
  begin
   if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.DesligarCadastrado, TCosmosConfMsg.DesligarCadastrado) = mrYes then
    begin
     AData := TCosmosData.Create(6);
     ISecretarias := Application.MainForm as ICosmosSecretarias;

     try
       AData.WriteValue('CADASTRADO', codcad);
       AData.WriteValue('DATA', EdtDataDesligamento.Date, 1);
       AData.WriteValue('MOTIVO', CBXMotivo.Text, 2);

       if EdtDataFalecimento.Enabled then
         AData.WriteValue('OBITO', EdtDataFalecimento.Date, 3)
       else
         AData.WriteValue('OBITO', null, 3);

       AData.WriteValue('OBSERVACAO',  MmoObservacoes.Lines.CommaText, 4);
       AData.WriteValue('USUARIO', ICosmosApp.IRemoteCon.CurrentUser.UserName.ToUpper, 5);

       Result := ISecretarias.DesactivatePeople(AData.TaggedData);

     finally
      if Assigned(AData) then FreeAndNil(AData);
      if Assigned(ISecretarias) then ISecretarias := nil;
     end;
    end;
  end;
end;

procedure TFrmDesligamento.FillCadastradoInfo(const codcad: integer);
var
 AReader: TDBXReader;
 AParam: TSQLParams;
begin
 AParam := TSQLParams.Create(1);

 try
  AParam.AppendData(codcad);;
  AReader := ICosmosApp.IRemoteCon.ListData(csCadastradoCode, AParam.Params);

  if AReader.Next then
   begin
    EdtNome.Text := AReader.Value['nomcad'].GetAnsiString;
    EdtDiscipulado.Text :=  AReader.Value['sigdis'].GetAnsiString;
    EdtFoco.Text := ICosmosApp.ActiveFocus.FocusName;
   end;

  AParam.Free;
  AReader.Free;

 except
  on E: Exception do
   begin
    AParam.Free;
    raise;
   end;
 end;
end;

procedure TFrmDesligamento.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
 if ModalResult = mrOk then
  begin
   CanClose := CBXMotivo.Text <> '';
   if not CanClose then
    begin
     ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.DesligarCadastrado, TCosmosErrorMsg.DadosIncompletosOperacao);
     Exit;
    end;

   CanClose := EdtDataFalecimento.Date <= ICosmosApp.IRemoteCon.ServerDateTime;
   if not CanClose then
     ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.DesligarCadastrado, TCosmosErrorMsg.DataObito);
   end;
end;

procedure TFrmDesligamento.FormCreate(Sender: TObject);
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;

 EdtFoco.Text := ICosmosApp.ActiveFocus.FocusName;

 EdtDataDesligamento.DateTime := ICosmosApp.IRemoteCon.ServerDateTime;
 EdtDataFalecimento.DateTime := ICosmosApp.IRemoteCon.ServerDateTime;
 EdtDataDesligamento.MaxDate := ICosmosApp.IRemoteCon.ServerDateTime;
 EdtDataFalecimento.MaxDate := ICosmosApp.IRemoteCon.ServerDateTime;
end;


end.
