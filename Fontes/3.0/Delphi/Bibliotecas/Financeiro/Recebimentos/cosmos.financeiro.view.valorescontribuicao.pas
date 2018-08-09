unit cosmos.financeiro.view.valorescontribuicao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient,
  Vcl.ExtCtrls, GroupHeader, Vcl.StdCtrls, cosmos.frames.dbeditcalculator,
  Vcl.DBCtrls, Vcl.DBActns, System.Actions, Vcl.ActnList, Vcl.ImgList,
  Vcl.Buttons, FrameDBEditVertical, Datasnap.DSConnect, cosmos.Framework.Interfaces.Root,
  Cosmos.Framework.Interfaces.DataAcess, cosmos.system.messages;

type
  TFrmValores = class(TForm)
    MSGroupHeader1: TMSGroupHeader;
    MSGroupHeader2: TMSGroupHeader;
    CdsValores: TClientDataSet;
    DBText1: TDBText;
    DBText2: TDBText;
    FmeDBMensalidade: TFmeDBCalculator;
    Label1: TLabel;
    FmeDBTaxa: TFmeDBCalculator;
    Label2: TLabel;
    FmeDBEditVertical: TFmeDBEditVertical;
    BitBtn2: TBitBtn;
    BitBtn1: TBitBtn;
    BtnCancel: TBitBtn;
    BtnSave: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CdsValoresAfterPost(DataSet: TDataSet);
    procedure CdsValoresAfterOpen(DataSet: TDataSet);
    procedure CdsValoresReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
  private
    { Private declarations }
    FICosmosApp: ICosmosApplication;
    FRemoteConnection: TDSProviderConnection;
  public
    { Public declarations }
    property ICosmosApp: ICosmosApplication read FICosmosApp;
    procedure EditarValores(const codcad: integer);
  end;

var
  FrmValores: TFrmValores;

implementation

{$R *.dfm}

procedure TFrmValores.CdsValoresAfterOpen(DataSet: TDataSet);
begin
{Somente permite alterar os valores de contribuição quando o contribuinte
 for vinculado ao foco correntemente aberto.}
 if (ICosmosApp.ActiveFocus.FocusID <> CdsValores.FieldValues['codfoc']) then
  begin
    ICosmosApp.DlgMessage.InfoMessage(TCosmosTitles.Recebimentos, TCosmosInfoMsg.ValoresContribuicaoFoco);
    CdsValores.ReadOnly := True;
  end;
end;

procedure TFrmValores.CdsValoresAfterPost(DataSet: TDataSet);
begin
 if CdsValores.ChangeCount > 0 then
  CdsValores.ApplyUpdates(0);
end;

procedure TFrmValores.CdsValoresReconcileError(DataSet: TCustomClientDataSet;
  E: EReconcileError; UpdateKind: TUpdateKind; var Action: TReconcileAction);
begin
 Action := ICosmosApp.IRemoteCon.ReconcileError(E, UpdateKind);
end;

procedure TFrmValores.EditarValores(const codcad: integer);
begin
 CdsValores.Params.Items[0].Value := codcad;
 CdsValores.Open;

 ShowModal;
end;

procedure TFrmValores.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(ICosmosApp) then
   ICosmosApp.IRemoteCon.DropConnection(FRemoteConnection);
end;

procedure TFrmValores.FormCreate(Sender: TObject);
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;

 FRemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scFinanceiro);
 CdsValores.RemoteServer := FRemoteConnection;
end;

end.
