unit cosmos.usuarios.view.FormAddFoco;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,  Vcl.ExtCtrls, GroupHeader,
  cosmos.classes.ServerInterface, Data.DB, cosmos.framework.interfaces.root,
  Datasnap.DBClient, Vcl.DBCtrls, cosmos.frames.fkSearch, FrameDBInsertVertical,
  cosmos.system.messages, Datasnap.DSConnect, cosmos.Framework.Interfaces.DataAcess,
  cosmos.classes.application, cosmos.system.dataconverter;

type
  TFrmAddFoco = class(TForm)
    MSGroupHeader1: TMSGroupHeader;
    CdsFocos: TClientDataSet;
    DBRadioGroup1: TDBRadioGroup;
    FmeFkFocos: TFmeFKSearch;
    FmeDBInsertVertical1: TFmeDBInsertVertical;
    MSGroupHeader2: TMSGroupHeader;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox2: TDBCheckBox;
    DBCheckBox3: TDBCheckBox;
    DBCheckBox4: TDBCheckBox;
    DBCheckBox5: TDBCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure CdsFocosAfterPost(DataSet: TDataSet);
    procedure CdsFocosBeforePost(DataSet: TDataSet);
    procedure CdsFocosAfterInsert(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CdsFocosReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
  private
    { Private declarations }
    FICosmosApp: ICosmosApplication;
    FRemoteConnection: TDSProviderConnection;

  public
    { Public declarations }
    property ICosmosApp: ICosmosApplication read FICosmosApp;
    procedure InsertAcessedFocus(const codusu: integer);
    procedure EditAcessedFocus(const codusu, codpri: integer);
  end;

var
  FrmAddFoco: TFrmAddFoco;

implementation

{$R *.dfm}

procedure TFrmAddFoco.CdsFocosAfterInsert(DataSet: TDataSet);
begin
 CdsFocos.Fields.FieldByName('codusu').Value := CdsFocos.Params.Items[0].Value;
 CdsFocos.Fields.FieldByName('tipper').Value := 'E'; //do not localize!

 CdsFocos.Fields.FieldByName('indsec').Value := TDataConverter.ToBoleanString(False);
 CdsFocos.Fields.FieldByName('indfin').Value := TDataConverter.ToBoleanString(False);
 CdsFocos.Fields.FieldByName('indfoc').Value := TDataConverter.ToBoleanString(False);
 CdsFocos.Fields.FieldByName('indcon').Value := TDataConverter.ToBoleanString(False);
 CdsFocos.Fields.FieldByName('indusu').Value := TDataConverter.ToBoleanString(True);
end;

procedure TFrmAddFoco.CdsFocosAfterPost(DataSet: TDataSet);
begin
 if CdsFocos.ChangeCount > 0 then
   CdsFocos.ApplyUpdates(0);
end;

procedure TFrmAddFoco.CdsFocosBeforePost(DataSet: TDataSet);
var
SequenceName: string;
begin
 if Dataset.State = dsInsert then
  begin
   SequenceName := TClientDataset(DataSet).GetOptionalParam('SequenceName');
   Dataset.Fields.Fields[0].AsInteger := ICosmosApp.IRemoteCon.GetSequenceValue(SequenceName);
  end;
end;

procedure TFrmAddFoco.CdsFocosReconcileError(DataSet: TCustomClientDataSet;
  E: EReconcileError; UpdateKind: TUpdateKind; var Action: TReconcileAction);
begin
 Action := ICosmosApp.IRemoteCon.ReconcileError(E, UpdateKind);
end;

procedure TFrmAddFoco.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if CdsFocos.Active then
  CdsFocos.Close;

  if Assigned(ICosmosApp.IRemoteCon) then
   ICosmosApp.IRemoteCon.DropConnection(FRemoteConnection);

 if Assigned(FICosmosApp) then
  FICosmosApp := nil;
end;

procedure TFrmAddFoco.FormCreate(Sender: TObject);
begin
  FICosmosApp := Application.MainForm as ICosmosApplication;
  FRemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scUsuarios);
  CdsFocos.RemoteServer := FRemoteConnection;

  FmeFkFocos.Configure('codfoc', csFocos);
end;

procedure TFrmAddFoco.InsertAcessedFocus(const codusu: integer);
begin
 CdsFocos.Params.Items[0].Value := codusu;
 CdsFocos.Params.Items[1].Value := 0;
 CdsFocos.Open;
 CdsFocos.Insert;
end;

procedure TFrmAddFoco.EditAcessedFocus(const codusu, codpri: integer);
begin
 CdsFocos.Params.Items[0].Value := codusu;
 CdsFocos.Params.Items[1].Value := codpri;
 CdsFocos.Open;
end;

end.
