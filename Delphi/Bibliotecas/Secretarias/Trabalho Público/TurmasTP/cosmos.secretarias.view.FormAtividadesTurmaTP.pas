unit cosmos.secretarias.view.FormAtividadesTurmaTP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, GroupHeader, Grids, DBGrids, DB, DBClient, StdCtrls,
  cosmos.frames.gridsearch, Buttons, Cosmos.Framework.Interfaces.Root,
  Cosmos.Framework.Interfaces.DataAcess, cosmos.classes.security,
  Datasnap.DSConnect;

type
  TFrmAtividadesTurmaTP = class(TForm)
    MSGroupHeader1: TMSGroupHeader;
    MSGroupHeader2: TMSGroupHeader;
    CdsAtividades: TClientDataSet;
    DsrAtividadesTurma: TDataSource;
    EdtTurma: TEdit;
    FmeGridSearch1: TFmeGridSearch;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure BitBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FICosmosApp: ICosmosApplication;
    FRemoteConnection: TDSProviderConnection;

  public
    { Public declarations }
    procedure ShowAtividades(const codtur, turma: integer);

    property ICosmosApp: ICosmosApplication read FICosmosApp;
  end;

var
  FrmAtividadesTurmaTP: TFrmAtividadesTurmaTP;

implementation

{$R *.dfm}

{ TFrmAtividadesTurmaTP }

procedure TFrmAtividadesTurmaTP.BitBtn2Click(Sender: TObject);
begin
 if Self.HelpContext <> 0 then
  Application.HelpSystem.ShowContextHelp(Self.HelpContext, Application.CurrentHelpFile);
end;

procedure TFrmAtividadesTurmaTP.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if CdsAtividades.Active then CdsAtividades.Close;
 CdsAtividades.RemoteServer := nil;

 if Assigned(FRemoteConnection) then
  ICosmosApp.IRemoteCon.DropConnection(FRemoteConnection)
end;

procedure TFrmAtividadesTurmaTP.FormCreate(Sender: TObject);
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;
 FRemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scPesquisadores);
 CdsAtividades.RemoteServer := FRemoteConnection;

 FmeGridSearch1.ShowSearchBar := False;
end;

procedure TFrmAtividadesTurmaTP.ShowAtividades(const codtur, turma: integer);
begin
 EdtTurma.Text := IntToStr(Turma);
 CdsAtividades.Params.Items[0].AsInteger := codtur;
 CdsAtividades.Open;
 ShowModal;
end;

end.
