unit cosmos.conferencias.view.frmeditconferencias;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cosmos.frames.usuariocad, ExtCtrls, GroupHeader, DB, DBClient,
  FrameDBEditVertical, StdCtrls, Mask, DBCtrls, ValueComboBox, DBValueComboBox,
  Cosmos.Framework.Interfaces.Root, Cosmos.Framework.Interfaces.DataAcess,
  ComCtrls, DBDateTimePicker, cosmos.classes.ServerInterface,
  cosmos.classes.security, cosmos.frames.fkSearch, Datasnap.DSConnect;

type
  TFrmEditarConferencia = class(TForm)
    FmeDBEditVertical1: TFmeDBEditVertical;
    CdsConferencia: TClientDataSet;
    MSGroupHeader4: TMSGroupHeader;
    FmeUsuarioCadastrador1: TFmeUsuarioCadastrador;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    MSGroupHeader1: TMSGroupHeader;
    Label1: TLabel;
    Label2: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    MSGroupHeader2: TMSGroupHeader;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    DBDateTimePicker1: TDBDateTimePicker;
    DBDateTimePicker2: TDBDateTimePicker;
    DBDateTimePicker3: TDBDateTimePicker;
    DBDateTimePicker4: TDBDateTimePicker;
    MSGroupHeader3: TMSGroupHeader;
    Label8: TLabel;
    Label9: TLabel;
    DBDateTimePicker5: TDBDateTimePicker;
    DBEdit3: TDBEdit;
    MSGroupHeader5: TMSGroupHeader;
    Label11: TLabel;
    DBEdit4: TDBEdit;
    MSGroupHeader6: TMSGroupHeader;
    DBRadioGroup1: TDBRadioGroup;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox2: TDBCheckBox;
    MSGroupHeader7: TMSGroupHeader;
    DBMemo1: TDBMemo;
    MSGroupHeader8: TMSGroupHeader;
    DBRadioGroup2: TDBRadioGroup;
    DBValueComboBox2: TDBValueComboBox;
    Label16: TLabel;
    DBRadioGroup3: TDBRadioGroup;
    procedure CdsConferenciaAfterPost(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure CdsConferenciaBeforePost(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CdsConferenciaReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
  private
    { Private declarations }
    FRemoteConnection: TDSProviderConnection;
    FICosmosApp: ICosmosApplication;

  public
    { Public declarations }
    procedure EditarConferencia(const codcon: integer);

    property ICosmosApp: ICosmosApplication read FICosmosApp;
  end;

var
  FrmEditarConferencia: TFrmEditarConferencia;

implementation

{$R *.dfm}

procedure TFrmEditarConferencia.CdsConferenciaAfterPost(DataSet: TDataSet);
begin
 if CdsConferencia.ChangeCount > 0 then
  CdsConferencia.ApplyUpdates(0);
end;

procedure TFrmEditarConferencia.CdsConferenciaBeforePost(DataSet: TDataSet);
begin
 inherited;
 DataSet.Fields.FieldByName('USURES').Value := UpperCase(ICosmosApp.IRemoteCon.ConnectedUser);
 DataSet.Fields.FieldByName('DATCAD').Value := ICosmosApp.IRemoteCon.ServerDateTime;
end;

procedure TFrmEditarConferencia.CdsConferenciaReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
 Action := ICosmosApp.IRemoteCon.ReconcileError(E, UpdateKind);
end;

procedure TFrmEditarConferencia.EditarConferencia(const codcon: integer);
begin
 with CdsConferencia do
  begin
   Params.Items[0].Value := codcon;
   Open;
  end;

 ShowModal;
end;

procedure TFrmEditarConferencia.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 if CdsConferencia.Active then CdsConferencia.Close;
 CdsConferencia.RemoteServer := nil;

 if (Assigned(ICosmosApp.IRemoteCon)) and (Assigned(FRemoteConnection)) then
   ICosmosApp.IRemoteCon.DropConnection(FRemoteConnection);
end;

procedure TFrmEditarConferencia.FormCreate(Sender: TObject);
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;

 FRemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scConferencias);
 CdsConferencia.RemoteServer := FRemoteConnection;

 CdsConferencia.ReadOnly := ICosmosApp.IRemoteCon.CurrentConnectionMode <> cmWrite;
end;

end.
