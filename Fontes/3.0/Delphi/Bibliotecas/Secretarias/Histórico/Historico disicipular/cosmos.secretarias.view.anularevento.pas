unit cosmos.secretarias.view.anularevento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, DBCtrls, DB, DBClient, cosmos.system.messages,
  cosmos.classes.application, cosmos.framework.interfaces.root, cosmos.business.focos,
  Cosmos.Framework.Interfaces.DataAcess, Data.DBXCommon, Datasnap.DSConnect,
  cosmos.framework.interfaces.Applications;

type
  TFrmAnularEvento = class(TForm)
    Image1: TImage;
    Bevel1: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    LblTipoEvento: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Bevel2: TBevel;
    Label3: TLabel;
    Label4: TLabel;
    DBText1: TDBText;
    DBText2: TDBText;
    DsrEvento: TDataSource;
    CdsEvento: TClientDataSet;
    CBXDisc: TComboBox;
    Label5: TLabel;
    procedure Button3Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    ARemoteConnection: TDSProviderConnection;
    procedure ListarDiscipulados(Campos: TCamposTrabalho);

  public
    { Public declarations }
    function AnularHistorico(const codhis: integer; TipoEvento: string): boolean;
  end;

var
  FrmAnularEvento: TFrmAnularEvento;

implementation

{$R *.dfm}

{ TFrmAnularEvento }

function TFrmAnularEvento.AnularHistorico(const codhis: integer;
  TipoEvento: string): boolean;
var
 ISecretarias: ICosmosSecretarias;
 ICosmosApp: ICosmosApplication;
begin
 {Anula um evento do histórico discipular de uma pessoa.}
 Result := False;

 ICosmosApp := Application.MainForm as ICosmosApplication;

 ARemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scHistorico);
 CdsEvento.RemoteServer := ARemoteConnection;

 LblTipoEvento.Caption := TipoEvento;
 CdsEvento.Params.Items[0].Value := codhis;
 CdsEvento.Open;

 ListarDiscipulados([ctTM, ctTP, ctTMB, ctLectorium]);

 if ShowModal = mrOk then
  begin
   ISecretarias := Application.MainForm as ICosmosSecretarias;

   try
    Result := ISecretarias.InvalidateEvent(codhis, CBXDisc.Text)

   finally
    begin
     if Assigned(ISecretarias) then ISecretarias := nil;
    end;
   end;
  end;
end;

procedure TFrmAnularEvento.Button3Click(Sender: TObject);
begin
 if Self.HelpContext <> 0 then
  Application.HelpSystem.ShowContextHelp(Self.HelpContext, Application.CurrentHelpFile);
end;

procedure TFrmAnularEvento.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
 if ModalResult = mrOk then
  CanClose := CBXDisc.Text <> '';
end;

procedure TFrmAnularEvento.ListarDiscipulados(Campos: TCamposTrabalho);
var
  I: Integer;
  Campo: TCampoTrabalho;
  CdsDiscipulados: TClientDataset;
  IRemoteCon: ICosmosRemoteConnection;
begin
 CBXDisc.Items.Clear;
 IRemoteCon := Application.MainForm as ICosmosRemoteConnection;

 CdsDiscipulados := TClientDataset.Create(nil);

 try
  CdsDiscipulados := IRemoteCon.OpenBufferedData(TCosmosFiles.BufDiscipulados);

  for I := 0 to Integer(ctAll) do
   begin
    Campo := TCampoTrabalho(I);
    CdsDiscipulados.Filtered := False;

    if Campo = ctTP then
     CdsDiscipulados.Filter := Format('CAMDIS = %s and INDATI = %s',[QuotedStr('TPU'), QuotedStr('S')])
    else
    if Campo = ctTM then
     CdsDiscipulados.Filter := Format('CAMDIS = %s and INDATI = %s',[QuotedStr('TMO'), QuotedStr('S')])
    else
    if Campo = ctLectorium then
     CdsDiscipulados.Filter := Format('CAMDIS = %s and INDATI = %s',[QuotedStr('LEC'), QuotedStr('S')])
    else
    if Campo = ctTMB then
     CdsDiscipulados.Filter := Format('CAMDIS = %s and INDATI = %s',[QuotedStr('TMB'), QuotedStr('S')])
    else
     Continue;


    CdsDiscipulados.Filtered := True;

    while not CdsDiscipulados.Eof do
     begin
      CBXDisc.Items.Append(CdsDiscipulados.Fields.FieldByName('sigdis').AsString);
      CdsDiscipulados.Next;
     end;
   end;

 finally
  if Assigned(CdsDiscipulados) then
   FreeAndNil(CdsDiscipulados);
  if Assigned(IRemoteCon) then
   IRemoteCon := nil;
 end;
end;

end.
