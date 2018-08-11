unit cosmos.secretarias.view.FormCadastroFamiliares;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, ExtCtrls, GroupHeader, StdCtrls, DBCtrls,
  ValueComboBox, DBValueComboBox, Mask, cosmos.frames.gridsearch, FrameDeleteButtons,
  cosmos.framework.interfaces.root, cosmos.framework.interfaces.DataAcess, Cosmos.Framework.Interfaces.Dialogs,
  cosmos.classes.application, cosmos.system.messages, Datasnap.DSConnect,
  cosmos.classes.security;

type
  TFrmCadastroFamiliares = class(TForm, ICosmosFamiliares)
    MSGroupHeader1: TMSGroupHeader;
    CdsFamiliares: TClientDataSet;
    DBEdit1: TDBEdit;
    DBValueComboBox1: TDBValueComboBox;
    DBEdit2: TDBEdit;
    DBCheckBox1: TDBCheckBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    FmeGridSearch1: TFmeGridSearch;
    FmeDBDelButtons1: TFmeDBDelButtons;
    DBCheckBox2: TDBCheckBox;
    procedure CdsFamiliaresBeforeDelete(DataSet: TDataSet);
    procedure CdsFamiliaresAfterInsert(DataSet: TDataSet);
    procedure CdsFamiliaresAfterPost(DataSet: TDataSet);
    procedure CdsFamiliaresBeforePost(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CdsFamiliaresReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
  private
    { Private declarations }
    FICosmosApp: ICosmosApplication;
    FRemoteConnection: TDSProviderConnection;

  protected
    procedure ShowFamiliares(const codcad: integer);

  public
    { Public declarations }
    property ICosmosApp: ICosmosApplication read FICosmosApp;
  end;

var
  FrmCadastroFamiliares: TFrmCadastroFamiliares;

implementation

{$R *.dfm}

procedure TFrmCadastroFamiliares.CdsFamiliaresAfterInsert(DataSet: TDataSet);
begin
 with Dataset.Fields do
  begin
   FieldByName('codcad').AsInteger := CdsFamiliares.Params.Items[0].AsInteger;
   FieldByName('indfam').AsString := 'N';
   FieldByName('indcar').AsString := 'S';   
  end;
end;

procedure TFrmCadastroFamiliares.CdsFamiliaresAfterPost(DataSet: TDataSet);
begin
 if CdsFamiliares.ChangeCount > 0 then
  CdsFamiliares.ApplyUpdates(0);
end;

procedure TFrmCadastroFamiliares.CdsFamiliaresBeforeDelete(DataSet: TDataSet);
begin
 if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.Familiares, TCosmosConfMsg.DeleteFamiliar) = mrNo then
  Abort;
end;

procedure TFrmCadastroFamiliares.CdsFamiliaresBeforePost(DataSet: TDataSet);
var
SequenceName: string;
begin
 if Dataset.State = dsInsert then
  begin
   SequenceName := TClientDataset(DataSet).GetOptionalParam('SequenceName');
   Dataset.Fields.Fields[0].AsInteger := ICosmosApp.IRemoteCon.GetSequenceValue(SequenceName);
  end;
end;

procedure TFrmCadastroFamiliares.CdsFamiliaresReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
 Action := ICosmosApp.IRemoteCon.ReconcileError(E, UpdateKind);
end;

procedure TFrmCadastroFamiliares.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 if CdsFamiliares.Active then CdsFamiliares.Close;

 CdsFamiliares.RemoteServer := nil;

 if Assigned(FRemoteConnection) then
  ICosmosApp.IRemoteCon.DropConnection(FRemoteConnection);

 if ICosmosApp <> nil then
  FICosmosApp := nil;
end;

procedure TFrmCadastroFamiliares.FormCreate(Sender: TObject);
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;
 FRemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scCommon);
 CdsFamiliares.RemoteServer := FRemoteConnection;

 FmeGridSearch1.ShowSearchBar := False;
 CdsFamiliares.ReadOnly := (Assigned(ICosmosApp.IRemoteCon))
   and (ICosmosApp.IRemoteCon.CurrentConnectionMode <> cmWrite);
end;

procedure TFrmCadastroFamiliares.ShowFamiliares(const codcad: integer);
begin
 with CdsFamiliares do
  begin
   try
    DisableControls;
    if Active then
     Close;
    Params.Items[0].AsInteger := codcad;
    Open;

   finally
    EnableControls;
   end;
  end;
 ShowModal; 
end;

initialization
 RegisterClass(TFrmCadastroFamiliares);

finalization
 UnRegisterClass(TFrmCadastroFamiliares);

end.
