unit cosmos.financeiro.view.FormDispensas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBClient, ComCtrls, DBDateTimePicker, cosmos.frames.gridsearch, StdCtrls,
  Cosmos.Framework.Interfaces.DataAcess, cosmos.system.messages,
  DB, ExtCtrls, GroupHeader, FrameDeleteButtons, cosmos.frames.usuariocad,
  Datasnap.DSConnect, Cosmos.Framework.Interfaces.Root,
  Cosmos.Framework.Interfaces.Dialogs;

type
  TFrmDispensas = class(TForm, IDispensasDialgs)
    CdsDispensas: TClientDataSet;
    MSGroupHeader1: TMSGroupHeader;
    EdtCadastrado: TEdit;
    MSGroupHeader2: TMSGroupHeader;
    Label1: TLabel;
    FmeGridSearch1: TFmeGridSearch;
    DBDateTimePicker1: TDBDateTimePicker;
    DBDateTimePicker2: TDBDateTimePicker;
    Label2: TLabel;
    MSGroupHeader3: TMSGroupHeader;
    FmeUsuarioCadastrador1: TFmeUsuarioCadastrador;
    FmeDBDelButtons1: TFmeDBDelButtons;
    procedure FormCreate(Sender: TObject);
    procedure CdsDispensasBeforePost(DataSet: TDataSet);
    procedure CdsDispensasAfterInsert(DataSet: TDataSet);
    procedure CdsDispensasBeforeDelete(DataSet: TDataSet);
    procedure CdsDispensasAfterPost(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CdsDispensasReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
  private
    { Private declarations }
    FICosmosApp: ICosmosApplication;
    FRemoteConnection: TDSProviderConnection;

  protected
    procedure Execute(codcad: integer; nomcad: string);

  public
    { Public declarations }
    property ICosmosApp: ICosmosApplication read FICosmosApp;
  end;

var
  FrmDispensas: TFrmDispensas;

implementation

{$R *.dfm}

{ TFrmDispensas }

procedure TFrmDispensas.Execute(codcad: integer;
  nomcad: string);
begin
 EdtCadastrado.Text := nomcad;

 with CdsDispensas do
  begin
   Params.Items[0].AsInteger := codcad;
   Open;
   Insert;
  end;

 ShowModal;
end;

procedure TFrmDispensas.CdsDispensasAfterInsert(DataSet: TDataSet);
begin
 with CdsDispensas do
  begin
   Fields.FieldByName('codcad').AsInteger := Params.Items[0].AsInteger;
   Fields.FieldByName('inidis').Value := ICosmosApp.IRemoteCon.ServerDateTime;
   Fields.FieldByName('terdis').Value := Fields.FieldByName('inidis').Value;
  end;
end;

procedure TFrmDispensas.CdsDispensasAfterPost(DataSet: TDataSet);
begin
 if CdsDispensas.ChangeCount > 0 then
  CdsDispensas.ApplyUpdates(0);
end;

procedure TFrmDispensas.CdsDispensasBeforeDelete(DataSet: TDataSet);
begin
 if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.Recebimentos, TCosmosConfMsg.DelDispensa)= mrNo then
  Abort;
end;

procedure TFrmDispensas.CdsDispensasBeforePost(DataSet: TDataSet);
var
SequenceName: string;
IRemoteCon: ICosmosRemoteConnection;
begin
  IRemoteCon := Application.MainForm as ICosmosRemoteConnection;

  try
   DataSet.Fields.FieldByName('USURES').Value := UpperCase(IRemoteCon.ConnectedUser);;
   DataSet.Fields.FieldByName('DATCAD').Value := IRemoteCon.ServerDateTime;

   with CdsDispensas do
    begin
     if State = dsInsert then
      begin
       SequenceName := GetOptionalParam('SequenceName');
       Fields.Fields[0].AsInteger := IRemoteCon.GetSequenceValue(SequenceName);
      end;
    end;
  finally
   if IRemoteCon <> nil then
    IRemoteCon := nil;
  end;
end;

procedure TFrmDispensas.CdsDispensasReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
 Action := ICosmosApp.IRemoteCon.ReconcileError(E, UpdateKind);
end;

procedure TFrmDispensas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(ICosmosApp.IRemoteCon) then
   ICosmosApp.IRemoteCon.DropConnection(FRemoteConnection);
end;

procedure TFrmDispensas.FormCreate(Sender: TObject);
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;
 FRemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scFinanceiro);
 CdsDispensas.RemoteServer := FRemoteConnection;
end;

initialization
 RegisterClass(TFrmDispensas);

finalization
 UnRegisterClass(TFrmDispensas);

end.
