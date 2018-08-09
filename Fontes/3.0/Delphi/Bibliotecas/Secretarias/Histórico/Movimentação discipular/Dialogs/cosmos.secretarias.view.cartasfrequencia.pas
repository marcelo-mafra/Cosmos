unit cosmos.secretarias.view.cartasfrequencia;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.ComCtrls, Vcl.Buttons, GroupHeader, Cosmos.Framework.Interfaces.Root,
  Cosmos.Framework.Interfaces.DataAcess, cosmos.system.messages,
  cosmos.classes.application, cosmos.classes.ServerInterface, Data.DBXCommon,
  Cosmos.Framework.Interfaces.Applications;

type
  TFrmCartaFrequencia = class(TForm)
    MSGroupHeader1: TMSGroupHeader;
    Label1: TLabel;
    Label2: TLabel;
    EdtFoco: TEdit;
    EdtAluno: TEdit;
    MSGroupHeader2: TMSGroupHeader;
    Label3: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    EdtData: TDateTimePicker;
    MmoObservacoes: TMemo;
    EdtDescricao: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    EdtDiscipulado: TEdit;
    Label4: TLabel;
    procedure BitBtn3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    FICosmosApp: ICosmosApplication;
    procedure FillCadastradoInfo(const codcad: integer);

  public
    { Public declarations }
    procedure EnviarCarta(const codcad: integer);
    property ICosmosApp: ICosmosApplication read FICosmosApp;
  end;

var
  FrmCartaFrequencia: TFrmCartaFrequencia;

implementation

{$R *.dfm}

procedure TFrmCartaFrequencia.BitBtn3Click(Sender: TObject);
begin
 if Self.HelpContext <> 0 then
  Application.HelpSystem.ShowContextHelp(Self.HelpContext, Application.CurrentHelpFile);
end;

procedure TFrmCartaFrequencia.EnviarCarta(const codcad: integer);
var
 AData: TCosmosData;
 ISecretarias: ICosmosSecretarias;
begin
 FillCadastradoInfo(codcad);

 if ShowModal = mrOk then
  begin
     AData := TCosmosData.Create(5);
     ISecretarias := Application.MainForm as ICosmosSecretarias;

     try
       AData.WriteValue('CADASTRADO', codcad);
       AData.WriteValue('DATA', EdtData.Date, 1);
       AData.WriteValue('DESCRICAO', EdtDescricao.Text, 2);
       AData.WriteValue('OBSERVACAO',  MmoObservacoes.Lines.CommaText, 3);
       AData.WriteValue('USUARIO', ICosmosApp.IRemoteCon.CurrentUser.UserName.ToUpper, 4);

       ISecretarias.SendLetter(AData.TaggedData);

     finally
       if Assigned(AData) then FreeAndNil(AData);
       if Assigned(ISecretarias) then ISecretarias := nil;
     end;
  end;
end;


procedure TFrmCartaFrequencia.FillCadastradoInfo(const codcad: integer);
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
    EdtAluno.Text := AReader.Value['nomcad'].GetAnsiString;
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

procedure TFrmCartaFrequencia.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
 if ModalResult = mrOk then
  begin
   CanClose := Trim(EdtDescricao.Text) <> '';

   if not CanClose then
    begin
     ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.CartaFrequencia, TCosmosErrorMsg.DadosIncompletosOperacao);
     EdtDescricao.SetFocus;
    end;
  end;
end;

procedure TFrmCartaFrequencia.FormCreate(Sender: TObject);
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;

 EdtFoco.Text := ICosmosApp.ActiveFocus.FocusName;
 EdtData.DateTime := ICosmosApp.IRemoteCon.ServerDateTime;
 EdtData.MaxDate := ICosmosApp.IRemoteCon.ServerDateTime;

end;


end.
