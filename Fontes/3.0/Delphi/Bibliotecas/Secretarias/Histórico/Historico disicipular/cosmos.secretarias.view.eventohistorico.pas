unit cosmos.secretarias.view.eventohistorico;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, GroupHeader, DB, DBClient, FrameDBEditVertical, StdCtrls,
  Mask, DBCtrls, cosmos.frames.usuariocad, ComCtrls, DBDateTimePicker,
  cosmos.frames.dbfieldinfo, cosmos.classes.security, Datasnap.DSConnect,
  Cosmos.Framework.Interfaces.Root, Cosmos.Framework.Interfaces.DataAcess;

type
  TFrmEventoDiscipular = class(TForm)
    MSGroupHeader1: TMSGroupHeader;
    CdsEvento: TClientDataSet;
    FmeDBEditVertical1: TFmeDBEditVertical;
    DBEdit1: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    DBEdit4: TDBEdit;
    Label4: TLabel;
    MSGroupHeader3: TMSGroupHeader;
    FmeUsuarioCadastrador1: TFmeUsuarioCadastrador;
    Label5: TLabel;
    DBEdit5: TDBEdit;
    MSGroupHeader2: TMSGroupHeader;
    Label8: TLabel;
    MSGroupHeader4: TMSGroupHeader;
    Label7: TLabel;
    DBEdit9: TDBEdit;
    DBEdit7: TDBEdit;
    Label9: TLabel;
    DBDateTimePicker1: TDBDateTimePicker;
    FmeDBFieldInfo1: TFmeDBFieldInfo;
    DBComboBox1: TDBComboBox;
    MSGroupHeader5: TMSGroupHeader;
    DBMemo1: TDBMemo;
    procedure CdsEventoAfterPost(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CdsEventoReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
  private
    { Private declarations }
    FICosmosApp: ICosmosApplication;
    FRemoteConnection: TDSProviderConnection;

  public
    { Public declarations }
    procedure EditarHistorico(const codhis: integer);

    property ICosmosApp: ICosmosApplication read FICosmosApp;
  end;

var
  FrmEventoDiscipular: TFrmEventoDiscipular;

implementation

{$R *.dfm}

procedure TFrmEventoDiscipular.CdsEventoAfterPost(DataSet: TDataSet);
begin
 if CdsEvento.ChangeCount > 0 then
  CdsEvento.ApplyUpdates(0);
end;

procedure TFrmEventoDiscipular.CdsEventoReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
 Action := ICosmosApp.IRemoteCon.ReconcileError(E, UpdateKind);
end;

procedure TFrmEventoDiscipular.EditarHistorico(const codhis: integer);
begin
 CdsEvento.Params.Items[0].AsInteger := codhis;
 CdsEvento.Open;
 ShowModal;
end;

procedure TFrmEventoDiscipular.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 if CdsEvento.Active then CdsEvento.Close;

 CdsEvento.RemoteServer := nil;

 if Assigned(FRemoteConnection) then
  ICosmosApp.IRemoteCon.DropConnection(FRemoteConnection);

 if Assigned(ICosmosApp) then
  FICosmosApp := nil
end;

procedure TFrmEventoDiscipular.FormCreate(Sender: TObject);
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;
 FRemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scHistorico);
 CdsEvento.RemoteServer := FRemoteConnection;

 //Somente deixa editável o dataset quando o usuário puder alterá-lo.
 CdsEvento.ReadOnly := (Assigned(ICosmosApp.IRemoteCon))
   and (ICosmosApp.IRemoteCon.CurrentConnectionMode <> cmWrite);
end;

end.
