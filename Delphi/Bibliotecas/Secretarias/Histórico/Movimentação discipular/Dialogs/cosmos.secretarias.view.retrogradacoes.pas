unit cosmos.secretarias.view.retrogradacoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ComCtrls, ValueComboBox, GroupHeader, cosmos.classes.application,
  Cosmos.Framework.Interfaces.Root, Cosmos.Framework.Interfaces.DataAcess,
  cosmos.system.messages, Data.DBXCommon, Cosmos.classes.ServerInterface,
  Cosmos.Framework.Interfaces.Applications;

type
  TFrmRetrogradar = class(TForm)
    MSGroupHeader1: TMSGroupHeader;
    EdtFoco: TEdit;
    EdtNome: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    MSGroupHeader2: TMSGroupHeader;
    EdtData: TDateTimePicker;
    CBXMotivo: TComboBox;
    Label3: TLabel;
    Label4: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    MmoObservacoes: TMemo;
    Label5: TLabel;
    Label6: TLabel;
    CBXDiscipulados: TValueComboBox;
    EdtDescricao: TEdit;
    Label7: TLabel;
    EdtDiscipulado: TEdit;
    Label8: TLabel;
    procedure BitBtn3Click(Sender: TObject);
    procedure CBXMotivoChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FICosmosApp: ICosmosApplication;
    sCampoTrabalho: string;

    procedure FillCadastradoInfo(const codcad: integer);
    procedure LoadPreviousGrades(const coddis: integer);

  public
    { Public declarations }
    function Retrogradar(const codcad: integer): boolean;

    property ICosmosApp: ICosmosApplication read FICosmosApp;
  end;

var
  FrmRetrogradar: TFrmRetrogradar;

implementation

{$R *.dfm}

procedure TFrmRetrogradar.BitBtn3Click(Sender: TObject);
begin
 if Self.HelpContext <> 0 then
  Application.HelpSystem.ShowContextHelp(Self.HelpContext, Application.CurrentHelpFile);
end;

procedure TFrmRetrogradar.CBXMotivoChange(Sender: TObject);
begin
 if Trim(EdtDescricao.Text) = '' then
  EdtDescricao.Text := CBXMotivo.Text;
end;

procedure TFrmRetrogradar.FillCadastradoInfo(const codcad: integer);
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
    EdtNome.Text := AReader.Value['nomcad'].GetAnsiString;
    EdtDiscipulado.Text :=  AReader.Value['sigdis'].GetAnsiString;
    EdtFoco.Text := ICosmosApp.ActiveFocus.FocusName;
    sCampoTrabalho := AReader.Value['camdis'].GetAnsiString
   end;

  LoadPreviousGrades(AReader.Value['coddis'].GetInt32);

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

procedure TFrmRetrogradar.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
 if ModalResult = mrOk then
  begin
   //Checa se informou o discipulado
   CanClose := Trim(CBXDiscipulados.Text) <> '';
   if not CanClose then
    begin
     ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.RetrogradarCadastrado, TCosmosErrorMsg.DiscipuladoUnselected);
     Abort;
    end;

   //Checa se informou o motivo da retrogradação
   CanClose := Trim(CBXMotivo.Text) <> '';
   if not CanClose then
    begin
     ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.RetrogradarCadastrado, TCosmosErrorMsg.MotivoUnknown);
     Abort;
    end;

   //Checa se informou uma descrição
   CanClose := Trim(EdtDescricao.Text) <> '';
   if not CanClose then
    begin
     ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.RetrogradarCadastrado, TCosmosErrorMsg.DescricaoHistorico);
     Abort;
    end;

   //Checa se a data da retrogradação é inferior ou igual à atual
   CanClose := EdtData.Date <= ICosmosApp.IRemoteCon.ServerDateTime;
   if not CanClose then
     begin
      ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.RetrogradarCadastrado, TCosmosErrorMsg.DataFutura);
      Abort;
     end;
  end;
end;

procedure TFrmRetrogradar.FormCreate(Sender: TObject);
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;

 EdtData.DateTime := ICosmosApp.IRemoteCon.ServerDateTime;
 EdtData.MaxDate := ICosmosApp.IRemoteCon.ServerDateTime;
end;

procedure TFrmRetrogradar.LoadPreviousGrades(const coddis: integer);
var
 ISecretarias: ICosmosSecretarias;
 AReader: TDBXReader;
 ADisc: string;
begin
 //Lista os discipulados para os quais o cadastrado por ser retrogradado.
 ISecretarias := Application.MainForm as ICosmosSecretarias;

 try
  if (self.sCampoTrabalho = 'LEC') or (self.sCampoTrabalho = 'EI') then
   AReader := ISecretarias.LoadPreviousGrades(coddis, False, True, True, False)
  else
  if self.sCampoTrabalho = 'TPU' then
   AReader := ISecretarias.LoadPreviousGrades(coddis, False, True, True, False)
  else
  if self.sCampoTrabalho = 'TMO' then
   AReader := ISecretarias.LoadPreviousGrades(coddis, True, True, True, False);

  if Assigned(AReader) then
   begin
    while AReader.Next do
     begin
      ADisc := ADisc.Format('%s (%s)', [AReader.Value['nomdis'].GetAnsiString,
        AReader.Value['camdis'].GetAnsiString]);
      CBXDiscipulados.Items.Append(ADisc);
      CBXDiscipulados.Values.Append(IntToStr(AReader.Value['coddis'].GetInt32));
     end;
   end;

 finally
   begin
    if Assigned(ISecretarias) then ISecretarias := nil;
    if Assigned(AReader) then FreeAndNil(AReader);
   end;
 end
end;

function TFrmRetrogradar.Retrogradar(const codcad: integer): boolean;
var
AData: TCosmosData;
ISecretarias: ICosmosSecretarias;
AMessage: string;
begin
{Retrograda um cadastrado para um discipulado anterior ao atual.}
 Result := False;

 FillCadastradoInfo(codcad);

 if CBXDiscipulados.Items.Count = 0 then
   begin
    AMessage := Format(TCosmosInfoMsg.RetrogradacaoImpossivel, [EdtNome.Text]);
    ICosmosApp.DlgMessage.InfoMessage(TCosmosTitles.RetrogradarCadastrado, AMessage);
    Abort;
   end;

    if ShowModal = mrOK then
     begin
       if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.RetrogradarCadastrado, TCosmosConfMsg.RetrogradarCadastrado) = mrYes then
        begin
         AData := TCosmosData.Create(7);
         ISecretarias := Application.MainForm as ICosmosSecretarias;

         try
          AData.WriteValue('CADASTRADO', codcad);
          AData.WriteValue('DATA', EdtData.Date, 1);
          AData.WriteValue('DISCIPULADO', CBXDiscipulados.GetValue, 2);
          AData.WriteValue('DESCRICAO', EdtDescricao.Text, 3);
          AData.WriteValue('MOTIVO', CBXMotivo.Text, 4);
          AData.WriteValue('OBSERVACAO',  MmoObservacoes.Lines.CommaText, 5);
          AData.WriteValue('USUARIO', ICosmosApp.IRemoteCon.CurrentUser.UserName.ToUpper, 6);

          Result := ISecretarias.RetrogradatePeople(AData.TaggedData);

         finally
          if Assigned(AData) then FreeAndNil(AData);
          if Assigned(ISecretarias) then ISecretarias := nil;
         end;
     end;
   end;
end;

end.
