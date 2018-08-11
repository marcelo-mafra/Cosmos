unit cosmos.secretarias.view.novoevento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, GroupHeader, DB, DBClient, StdCtrls, Mask, DBCtrls,
  cosmos.frames.usuariocad, ComCtrls, DBDateTimePicker, FrameDBInsertVertical,
  cosmos.frames.dbfieldinfo, Cosmos.Framework.Interfaces.DataAcess, cosmos.framework.interfaces.root,
  Cosmos.classes.ServerInterface, cosmos.frames.fkSearch, cosmos.system.messages,
  cosmos.classes.security, Datasnap.DSConnect;

type
  TFrmInsEventoDiscipular = class(TForm)
    MSGroupHeader1: TMSGroupHeader;
    CdsEvento: TClientDataSet;
    Label1: TLabel;
    Label2: TLabel;
    DBEdit4: TDBEdit;
    Label4: TLabel;
    MSGroupHeader3: TMSGroupHeader;
    FmeUsuarioCadastrador1: TFmeUsuarioCadastrador;
    Label5: TLabel;
    MSGroupHeader2: TMSGroupHeader;
    Label8: TLabel;
    MSGroupHeader4: TMSGroupHeader;
    Label7: TLabel;
    DBEdit9: TDBEdit;
    DBDateTimePicker1: TDBDateTimePicker;
    DBComboBox1: TDBComboBox;
    MSGroupHeader5: TMSGroupHeader;
    DBMemo1: TDBMemo;
    FmeDBInsertVertical1: TFmeDBInsertVertical;
    FmeFKTipoEvento: TFmeFKSearch;
    FmeFKFocos: TFmeFKSearch;
    FmeDiscipulado: TFmeFKSearch;
    Label3: TLabel;
    procedure CdsEventoAfterInsert(DataSet: TDataSet);
    procedure CdsEventoAfterPost(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure CdsEventoBeforePost(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CdsEventoReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
  private
    { Private declarations }
    fcodcad: Integer;
    FICosmosApp: ICosmosApplication;
    FRemoteConnection: TDSProviderConnection;
    procedure AlterStatusButton(Sender: TObject);

  public
    { Public declarations }
    procedure InsertEvent(const codcad: integer);

    property codcad: integer read fcodcad;
    property ICosmosApp: ICosmosApplication read FICosmosApp;
  end;

var
  FrmInsEventoDiscipular: TFrmInsEventoDiscipular;

implementation

{$R *.dfm}

procedure TFrmInsEventoDiscipular.AlterStatusButton(Sender: TObject);
begin
 FmeDiscipulado.ButtonEnabled := CdsEvento.Fields.FieldByName('coddis').IsNull;
end;

procedure TFrmInsEventoDiscipular.CdsEventoAfterInsert(DataSet: TDataSet);
begin
 Dataset.Fields.FieldByName('dathis').Value := ICosmosApp.IRemoteCon.ServerDateTime;
 CdsEvento.Fields.FieldByName('codcad').Value := self.fcodcad;
 CdsEvento.Fields.FieldByName('codfoc').Value := ICosmosApp.ActiveFocus.FocusID;
 CdsEvento.Fields.FieldByName('nomfoc').Value := ICosmosApp.ActiveFocus.FocusName;
end;

procedure TFrmInsEventoDiscipular.CdsEventoAfterPost(DataSet: TDataSet);
begin
 if CdsEvento.ChangeCount > 0 then
  CdsEvento.ApplyUpdates(0);
end;

procedure TFrmInsEventoDiscipular.CdsEventoBeforePost(DataSet: TDataSet);
var
SequenceName: string;
begin
 Dataset.Fields.FieldByName('USURES').Value := UpperCase(ICosmosApp.IRemoteCon.ConnectedUser);
 Dataset.Fields.FieldByName('DATCAD').Value := ICosmosApp.IRemoteCon.ServerDateTime;

 if Dataset.State = dsInsert then
   begin
    SequenceName := TClientDataset(DataSet).GetOptionalParam('SequenceName');
    Dataset.Fields.Fields[0].AsInteger := ICosmosApp.IRemoteCon.GetSequenceValue(SequenceName)
   end;
end;

procedure TFrmInsEventoDiscipular.CdsEventoReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
 Action := ICosmosApp.IRemoteCon.ReconcileError(E, UpdateKind);
end;

procedure TFrmInsEventoDiscipular.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 FmeDiscipulado.OnSelectData :=  nil;

 if CdsEvento.Active then CdsEvento.Close;

 CdsEvento.RemoteServer := nil;

 if Assigned(FRemoteConnection) then
  ICosmosApp.IRemoteCon.DropConnection(FRemoteConnection);

 if ICosmosApp <> nil then
  FICosmosApp := nil;
end;

procedure TFrmInsEventoDiscipular.FormCreate(Sender: TObject);
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;
 FRemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scHistorico);
 CdsEvento.RemoteServer := FRemoteConnection;

 self.FmeFKTipoEvento.Configure('codtipeve', csEventosDiscipulares);
 self.FmeFKFocos.Configure('codfoc', csFocos);
 self.FmeDiscipulado.Configure('coddis', csDiscipulados);
 self.FmeDiscipulado.ButtonEnabled := True;
 self.FmeDiscipulado.OnSelectData :=  self.AlterStatusButton;

 //Somente deixa editável o dataset quando o usuário puder alterá-lo.
 CdsEvento.ReadOnly := (Assigned(ICosmosApp.IRemoteCon))
   and (ICosmosApp.IRemoteCon.CurrentConnectionMode <> cmWrite);
end;

procedure TFrmInsEventoDiscipular.InsertEvent(const codcad: integer);
begin
 self.fcodcad := codcad;
 CdsEvento.Params.Items[0].AsInteger := 0;
 CdsEvento.Open;
 ShowModal;
end;

end.
