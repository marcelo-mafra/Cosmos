unit cosmos.secretarias.view.transferencias;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, GroupHeader, StdCtrls, ComCtrls, Buttons,
  cosmos.classes.ServerInterface, Cosmos.Framework.Interfaces.Root,
  cosmos.classes.application, cosmos.system.messages, cosmos.frames.searchdata,
  Data.DBXCommon, Cosmos.Framework.Interfaces.Applications;


type
  TFrmTransferencia = class(TForm)
    MSGroupHeader1: TMSGroupHeader;
    MSGroupHeader2: TMSGroupHeader;
    Label6: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    EdtDataTransferencia: TDateTimePicker;
    ChkManterCirculo: TCheckBox;
    MmoObservacoes: TMemo;
    EdtNome: TEdit;
    EdtDiscipulado: TEdit;
    EdtFocoAtual: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    FmeSearchNovoFoco: TFmeSearchData;
    procedure BitBtn3Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FICosmosApp: ICosmosApplication;
    procedure FillCadastradoInfo(const codcad: integer);
    function DoTransferir(const codcad: integer): boolean;

  public
    { Public declarations }
    function TransferirCadastrado(const codcad: integer): boolean;
    function TransferirAluno(const codcad: integer): boolean;
    property ICosmosApp: ICosmosApplication read FICosmosApp;

  end;

var
  FrmTransferencia: TFrmTransferencia;

implementation

{$R *.dfm}

procedure TFrmTransferencia.BitBtn3Click(Sender: TObject);
begin
 if Self.HelpContext <> 0 then
  Application.HelpSystem.ShowContextHelp(Self.HelpContext, Application.CurrentHelpFile);
end;

function TFrmTransferencia.DoTransferir(const codcad: integer): boolean;
var
AData: TCosmosData;
ISecretarias: ICosmosSecretarias;
begin
  AData := TCosmosData.Create(6);
  ISecretarias := Application.MainForm as ICosmosSecretarias;

  try
    AData.WriteValue('CADASTRADO', codcad);
    AData.WriteValue('DATA', EdtDataTransferencia.Date, 1);
    AData.WriteValue('NOVOFOCO', FmeSearchNovoFoco.ReadValue('CODFOC'), 2);
    AData.WriteValue('MANTERCIRCULO', ChkManterCirculo.Checked, 3);
    AData.WriteValue('OBSERVACAO',  MmoObservacoes.Lines.CommaText, 4);
    AData.WriteValue('USUARIO', ICosmosApp.IRemoteCon.CurrentUser.UserName.ToUpper, 5);

    Result := ISecretarias.TransferPeople(AData.TaggedData);

  finally
   if Assigned(AData) then FreeAndNil(AData);
   if Assigned(ISecretarias) then ISecretarias := nil;
  end;
end;

procedure TFrmTransferencia.FillCadastradoInfo(const codcad: integer);
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
    EdtNome.Text := AReader.Value['nomcad'].ToString;
    EdtDiscipulado.Text :=  AReader.Value['sigdis'].ToString;
    EdtFocoAtual.Text := ICosmosApp.ActiveFocus.FocusName;
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

procedure TFrmTransferencia.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
 if ModalResult = mrOk then
  begin
   CanClose := FmeSearchNovoFoco.ControlValue <> '';
   if not CanClose then
    begin
     ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.TransferirCadastrado, TCosmosErrorMsg.DadosIncompletosOperacao);
     Exit;
    end;

   CanClose := (FmeSearchNovoFoco.ReadValue('CODFOC') <> ICosmosApp.ActiveFocus.FocusID);
   if not CanClose then ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.TransferirCadastrado, TCosmosErrorMsg.TransferenciaMesmoFoco);
  end;
end;

procedure TFrmTransferencia.FormCreate(Sender: TObject);
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;

 FmeSearchNovoFoco.CosmosSearch := csFocos;

 EdtDataTransferencia.Date := ICosmosApp.IRemoteCon.ServerDateTime;
 EdtDataTransferencia.MaxDate := ICosmosApp.IRemoteCon.ServerDateTime;
end;

function TFrmTransferencia.TransferirAluno(const codcad: integer): boolean;
begin
 Result := False;

 FillCadastradoInfo(codcad);
 ChkManterCirculo.Enabled := True;

 if ShowModal = mrOk then
  begin
   if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.TransferirCadastrado, TCosmosConfMsg.TransferirAluno) = mrYes then
    Result := DoTransferir(codcad);
  end;
end;

function TFrmTransferencia.TransferirCadastrado(const codcad: integer): boolean;
begin
 Result := False;

 FillCadastradoInfo(codcad);
 ChkManterCirculo.Enabled := False;

 if ShowModal = mrOk then
  begin
   if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.TransferirCadastrado, TCosmosConfMsg.TransferirCadastrado) = mrYes then
    Result := DoTransferir(codcad);
  end;
end;

end.
