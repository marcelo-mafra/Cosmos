unit cosmos.secretarias.view.FormDadosCirculo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, StdCtrls, ExtCtrls, GroupHeader, Mask, DBCtrls,
  cosmos.frames.fkSearch, FrameDBEditVertical, Cosmos.Framework.Interfaces.Root,
  Cosmos.Framework.Interfaces.DataAcess, cosmos.classes.ServerInterface,
  cosmos.system.messages, cosmos.frames.usuariocad, cosmos.classes.security,
  Datasnap.DSConnect;

type
  TFrmDadosCirculo = class(TForm)
    CdsCirculo: TClientDataSet;
    MSGroupHeader1: TMSGroupHeader;
    EdtFoco: TEdit;
    Label1: TLabel;
    MSGroupHeader2: TMSGroupHeader;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    FmeFKSearch1: TFmeFKSearch;
    FmeFKSearch2: TFmeFKSearch;
    Label3: TLabel;
    Label4: TLabel;
    FmeDBEditVertical1: TFmeDBEditVertical;
    MSGroupHeader3: TMSGroupHeader;
    Label6: TLabel;
    DBEdit2: TDBEdit;
    EdtConfirmacao: TEdit;
    Label5: TLabel;
    MSGroupHeader4: TMSGroupHeader;
    FmeUsuarioCadastrador1: TFmeUsuarioCadastrador;
    FmeFKDiscipulado: TFmeFKSearch;
    Label7: TLabel;
    MSGroupHeader5: TMSGroupHeader;
    Label8: TLabel;
    FmeFKSearchLicao: TFmeFKSearch;
    procedure CdsCirculoBeforePost(DataSet: TDataSet);
    procedure CdsCirculoAfterPost(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CdsCirculoReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
  private
    { Private declarations }
    FICosmosApp: ICosmosApplication;
    FRemoteConnection: TDSProviderConnection;

  public
    { Public declarations }
    procedure EditCirculo(const codgru: integer);

    property ICosmosApp: ICosmosApplication read FICosmosApp;
  end;

var
  FrmDadosCirculo: TFrmDadosCirculo;

implementation

{$R *.dfm}

{ TFrmDadosCirculo }

procedure TFrmDadosCirculo.CdsCirculoAfterPost(DataSet: TDataSet);
begin
 CdsCirculo.ApplyUpdates(0);
end;

procedure TFrmDadosCirculo.CdsCirculoBeforePost(DataSet: TDataSet);
var
FPassword: TField;
begin
 FPassword := CdsCirculo.Fields.FieldByName('sencon');
 if FPassword.OldValue <> FPassword.NewValue then
  begin
   if FPassword.AsString <> EdtConfirmacao.Text then
    begin
       ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.EI, TCosmosInfoMsg.IncorrectPassword);
      Abort;
    end;
  end;
end;

procedure TFrmDadosCirculo.CdsCirculoReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
 Action := ICosmosApp.IRemoteCon.ReconcileError(E, UpdateKind);
end;

procedure TFrmDadosCirculo.EditCirculo(const codgru: integer);
begin
 CdsCirculo.Params.Items[0].AsInteger := codgru;
 CdsCirculo.Open;
 ShowModal;
end;

procedure TFrmDadosCirculo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 CdsCirculo.RemoteServer := nil;

 if (Assigned(ICosmosApp.IRemoteCon)) and (Assigned(FRemoteConnection)) then
   ICosmosApp.IRemoteCon.DropConnection(FRemoteConnection);
end;

procedure TFrmDadosCirculo.FormCreate(Sender: TObject);
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;
 FRemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scEscolaInterna);
 CdsCirculo.RemoteServer := FRemoteConnection;

 EdtFoco.Text := ICosmosApp.ActiveFocus.FocusName;
 FmeFKDiscipulado.Configure('coddis', csDiscipuladosEI);
 FmeFkSearch1.Configure('codsac',csMentoresEI);
 FmeFkSearch2.Configure('codsaz',csMentorasEI);
 FmeFkSearchLicao.Configure('codlic',csLicoesEI);

 //Somente deixa editável o dataset quando o usuário puder alterá-lo.
 CdsCirculo.ReadOnly := ICosmosApp.IRemoteCon.CurrentConnectionMode <> cmWrite;
end;

end.
