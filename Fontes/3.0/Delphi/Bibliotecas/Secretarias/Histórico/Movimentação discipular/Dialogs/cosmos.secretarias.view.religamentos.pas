unit cosmos.secretarias.view.religamentos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ComCtrls, ValueComboBox, GroupHeader, cosmos.classes.application,
  Cosmos.Framework.Interfaces.Root, Cosmos.Framework.Interfaces.DataAcess,
  cosmos.system.messages, Data.DBXCommon, Cosmos.classes.ServerInterface,
  Cosmos.Framework.Interfaces.Applications, Datasnap.DBClient;

type
  TFrmReligar = class(TForm)
    MSGroupHeader1: TMSGroupHeader;
    MSGroupHeader2: TMSGroupHeader;
    Label1: TLabel;
    Label2: TLabel;
    EdtNome: TEdit;
    EdtFoco: TEdit;
    Label3: TLabel;
    EdtDiscipulado: TEdit;
    Label4: TLabel;
    CBXDiscipulados: TValueComboBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    MSGroupHeader3: TMSGroupHeader;
    Label5: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    EdtDataReligamento: TDateTimePicker;
    MmoObservacoes: TMemo;
    EdtDescricao: TEdit;
    CBXCampo: TValueComboBox;
    procedure BitBtn3Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure CBXCampoChange(Sender: TObject);
  private
    { Private declarations }
    FICosmosApp: ICosmosApplication;
    procedure FillCadastradoInfo(const codcad: integer);
    procedure LoadGrades;

  public
    { Public declarations }
    function ReligarCadastrados(const codcad: integer): boolean;

    property ICosmosApp: ICosmosApplication read FICosmosApp;
  end;

var
  FrmReligar: TFrmReligar;

implementation

{$R *.dfm}

procedure TFrmReligar.BitBtn3Click(Sender: TObject);
begin
 if Self.HelpContext <> 0 then
  Application.HelpSystem.ShowContextHelp(Self.HelpContext, Application.CurrentHelpFile);
end;

procedure TFrmReligar.CBXCampoChange(Sender: TObject);
begin
 LoadGrades;
end;

procedure TFrmReligar.FillCadastradoInfo(const codcad: integer);
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

procedure TFrmReligar.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
 if ModalResult = mrOk then
  begin
   CanClose := (CBXDiscipulados.ItemIndex >= 0) and (Trim(EdtDescricao.Text) <> '');
   if not CanClose then
    ICosmosApp.DlgMessage.InfoMessage(TCosmosTitles.ReativarCadastrado, TCosmosErrorMsg.ReligarDescricao);
  end;
end;

procedure TFrmReligar.FormCreate(Sender: TObject);
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;

 EdtDataReligamento.DateTime := ICosmosApp.IRemoteCon.ServerDateTime;
 EdtDataReligamento.MaxDate := ICosmosApp.IRemoteCon.ServerDateTime;
end;

procedure TFrmReligar.LoadGrades;
var
 aDataset: TClientDataset;
 aParams: TSQLParams;
begin
 //Executa uma pesquisa SQL no banco de dados remoto.
 aParams := TSQLParams.Create(2);
 aDataset := TClientDataset.Create(nil);

 aParams.AppendData(QuotedStr(CBXCampo.GetValue));
 aParams.AppendData(TDataConverter.ToBoleanString(True, True), 1);

 try
  CBXDiscipulados.Items.Clear;
  CBXDiscipulados.Values.Clear;
  ICosmosApp.IRemoteCon.ExecuteDQL(csDiscipuladosCampo, aParams.Params, aDataset);

  if (aDataset <> nil) and (aDataset.Active) then
   begin
    while not aDataset.Eof do
     begin
      CBXDiscipulados.Items.Append(aDataset.FieldValues['nomdis']);
      CBXDiscipulados.Values.Append(aDataset.FieldValues['coddis']);
      aDataset.Next;
     end;

    aDataset.Free;
    aParams.Free;
   end;

 except
  on E: Exception do
   begin
    if Assigned(aDataset) then FreeAndNil(aDataset);
    if Assigned(aParams) then FreeAndNil(aParams);
    raise;
   end;
 end

end;

function TFrmReligar.ReligarCadastrados(const codcad: integer): boolean;
var
AData: TCosmosData;
ISecretarias: ICosmosSecretarias;
begin
 Result := False;

 FillCadastradoInfo(codcad);

 if ShowModal = mrOK then
   begin
     AData := TCosmosData.Create(6);
     ISecretarias := Application.MainForm as ICosmosSecretarias;

     try
       AData.WriteValue('CADASTRADO', codcad);
       AData.WriteValue('DATA', EdtDataReligamento.Date, 1);
       AData.WriteValue('DISCIPULADO', CBXDiscipulados.GetValue, 2);
       AData.WriteValue('DESCRICAO', EdtDescricao.Text, 3);
       AData.WriteValue('OBSERVACAO',  MmoObservacoes.Lines.CommaText, 4);
       AData.WriteValue('USUARIO', ICosmosApp.IRemoteCon.CurrentUser.UserName.ToUpper, 5);

       Result := ISecretarias.ReactivatePeople(AData.TaggedData);

     finally
       if Assigned(AData) then FreeAndNil(AData);
       if Assigned(ISecretarias) then ISecretarias := nil;
     end;
   end;
end;


end.
