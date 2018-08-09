unit cosmos.secretarias.view.casamentos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ComCtrls, ValueComboBox, GroupHeader, cosmos.classes.application,
  Cosmos.Framework.Interfaces.Root, Cosmos.Framework.Interfaces.DataAcess,
  Cosmos.Framework.Interfaces.Dialogs,  cosmos.system.messages, Data.DBXCommon,
  Cosmos.classes.ServerInterface, cosmos.frames.searchdata,
  Cosmos.Framework.Interfaces.Applications;

type
  TFrmCasamento = class(TForm)
    MSGroupHeader1: TMSGroupHeader;
    Label1: TLabel;
    Label2: TLabel;
    MSGroupHeader2: TMSGroupHeader;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    EdtData: TDateTimePicker;
    EdtRegistro: TEdit;
    EdtDescricao: TEdit;
    MmoObservacoes: TMemo;
    FmeSearchDataNoiva: TFmeSearchData;
    FmeSearchDataNoivo: TFmeSearchData;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    procedure BitBtn3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EdtRegistroKeyPress(Sender: TObject; var Key: Char);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    FICosmosApp: ICosmosApplication;
    procedure FillCadastradoInfo(const codcad: integer);

  public
    { Public declarations }
    procedure RegistrarCasamento(codcad: integer);

    property ICosmosApp: ICosmosApplication read FICosmosApp;
  end;

var
  FrmCasamento: TFrmCasamento;

implementation

{$R *.dfm}

procedure TFrmCasamento.BitBtn3Click(Sender: TObject);
begin
 if Self.HelpContext <> 0 then
  Application.HelpSystem.ShowContextHelp(Self.HelpContext, Application.CurrentHelpFile);
end;

procedure TFrmCasamento.EdtRegistroKeyPress(Sender: TObject; var Key: Char);
begin
if not CharInSet(Key, ['0'..'9']) then
  Abort;
end;

procedure TFrmCasamento.FillCadastradoInfo(const codcad: integer);
var
 AReader: TDBXReader;
 AParam: TSQLParams;
begin
 AParam := TSQLParams.Create(1);
{Preenche os dados da noiva ou do noivo.}
 try
  AParam.AppendData(codcad);
  AReader := ICosmosApp.IRemoteCon.ListData(csCadastradoCode, AParam.Params);

  if AReader.Next then
   begin
    if AReader.Value['sexcad'].GetAnsiString = 'M' then
     begin
       FmeSearchDataNoivo.CreateMemoryData(2);
       FmeSearchDataNoivo.WriteData('CODCAD', codcad, 0);
       FmeSearchDataNoivo.WriteData('NOMCAD', AReader.Value['nomcad'].GetAnsiString, 1);
       FmeSearchDataNoivo.EdtSearch.Text := AReader.Value['nomcad'].GetAnsiString;
     end
    else
     begin
       FmeSearchDataNoiva.CreateMemoryData(2);
       FmeSearchDataNoiva.WriteData('CODCAD', codcad, 0);
       FmeSearchDataNoiva.WriteData('NOMCAD', AReader.Value['nomcad'].GetAnsiString, 1);
       FmeSearchDataNoiva.EdtSearch.Text := AReader.Value['nomcad'].GetAnsiString;
     end;
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

procedure TFrmCasamento.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
 if ModalResult = mrOk then
  begin
   CanClose := FmeSearchDataNoiva.CosmosData <> nil;
   if not CanClose then
    begin
     ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.CasarCadastrados, TCosmosErrorMsg.NoivaAusente);
     Abort;
    end;

   CanClose := FmeSearchDataNoivo.CosmosData <> nil;
   if not CanClose then
    begin
     ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.CasarCadastrados, TCosmosErrorMsg.NoivoAusente);
     Abort;
    end;

   CanClose := Trim(EdtRegistro.Text) <> '';
   if not CanClose then
    begin
     ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.CasarCadastrados, TCosmosErrorMsg.NumRegistroNulo);
     Abort;
    end;

   CanClose := Trim(EdtDescricao.Text) <> '';
   if not CanClose then
    begin
     ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.CasarCadastrados, TCosmosErrorMsg.DescricaoHistorico);
     Abort;
    end;
  end;
end;


procedure TFrmCasamento.FormCreate(Sender: TObject);
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;

 FmeSearchDataNoiva.CosmosSearch := csAlunosMulheres;
 FmeSearchDataNoivo.CosmosSearch := csAlunosHomens;

 EdtData.DateTime := ICosmosApp.IRemoteCon.ServerDateTime;
 EdtData.MaxDate := EdtData.DateTime;
end;

procedure TFrmCasamento.RegistrarCasamento(codcad: integer);
var
 AData: TCosmosData;
 ISecretarias: ICosmosSecretarias;
begin
 FillCadastradoInfo(codcad);

 if ShowModal = mrOk then
   begin
     AData := TCosmosData.Create(8);
     ISecretarias := Application.MainForm as ICosmosSecretarias;

     try
       AData.WriteValue('NOIVO', FmeSearchDataNoivo.ReadValue('CODCAD'));
       AData.WriteValue('NOIVA', FmeSearchDataNoiva.ReadValue('CODCAD'), 1);
       AData.WriteValue('DATA', EdtData.Date, 2);
       AData.WriteValue('REGISTRO', EdtRegistro.Text, 3);
       AData.WriteValue('DESCRICAO', EdtDescricao.Text, 4);
       AData.WriteValue('OBSERVACAO',  MmoObservacoes.Lines.CommaText, 5);
       AData.WriteValue('USUARIO', ICosmosApp.IRemoteCon.CurrentUser.UserName.ToUpper, 6);
       AData.WriteValue('FOCO', ICosmosApp.ActiveFocus.FocusID, 7);

       ISecretarias.RegisterMarriage(AData.TaggedData);

     finally
        if Assigned(AData) then FreeAndNil(AData);
        if Assigned(ISecretarias) then ISecretarias := nil;
     end;
   end;
end;


end.
