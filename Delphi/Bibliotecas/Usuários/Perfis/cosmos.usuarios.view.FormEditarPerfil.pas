unit cosmos.usuarios.view.FormEditarPerfil;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DBCtrls, GroupHeader, Mask, DB, DBClient,
  FrameDBInsertVertical, Cosmos.Framework.Interfaces.Root, cosmos.classes.application,
  Cosmos.Framework.Interfaces.DataAcess, Datasnap.DSConnect, cosmos.system.dataconverter;

type
  TFrmEditarPerfil = class(TForm)
    DBEdit1: TDBEdit;
    MSGroupHeader1: TMSGroupHeader;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox2: TDBCheckBox;
    DBCheckBox3: TDBCheckBox;
    DBCheckBox4: TDBCheckBox;
    DBCheckBox5: TDBCheckBox;
    DBRadioGroup1: TDBRadioGroup;
    Label1: TLabel;
    CdsPerfil: TClientDataSet;
    FmeDBInsertVertical1: TFmeDBInsertVertical;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    procedure CdsPerfilAfterInsert(DataSet: TDataSet);
    procedure CdsPerfilBeforePost(DataSet: TDataSet);
    procedure CdsPerfilAfterPost(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CdsPerfilReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
  private
    { Private declarations }
    FICosmosApp: ICosmosApplication;
    FRemoteConnection: TDSProviderConnection;

  public
    { Public declarations }
    procedure NovoPerfil;
    procedure EditarPerfil(const codper: integer);

    property ICosmosApp: ICosmosApplication read FICosmosApp;
  end;

var
  FrmEditarPerfil: TFrmEditarPerfil;

implementation

{$R *.dfm}

procedure TFrmEditarPerfil.CdsPerfilAfterInsert(DataSet: TDataSet);
begin
//escreve as opções padrão.
 with CdsPerfil.Fields do
  begin
    FieldByName('indlec').Value := TDataConverter.ToBoleanString(False) ;
    FieldByName('indtmo').Value := TDataConverter.ToBoleanString(False);
    FieldByName('indtmb').Value := TDataConverter.ToBoleanString(False);
    FieldByName('indtpu').Value := TDataConverter.ToBoleanString(False);
    FieldByName('indein').Value := TDataConverter.ToBoleanString(False);
    FieldByName('indsim').Value := TDataConverter.ToBoleanString(False);
    FieldByName('abrper').Value := 'L'; //do not localize!
  end;
end;

procedure TFrmEditarPerfil.CdsPerfilAfterPost(DataSet: TDataSet);
begin
 if CdsPerfil.ChangeCount > 0 then
  CdsPerfil.ApplyUpdates(0);
end;

procedure TFrmEditarPerfil.CdsPerfilBeforePost(DataSet: TDataSet);
 var
SequenceName: string;
begin
 if Dataset.State = dsInsert then
  begin
   SequenceName := TClientDataset(DataSet).GetOptionalParam('SequenceName');
   Dataset.Fields.Fields[0].AsInteger := ICosmosApp.IRemoteCon.GetSequenceValue(SequenceName);
  end;
end;

procedure TFrmEditarPerfil.CdsPerfilReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
 Action := ICosmosApp.IRemoteCon.ReconcileError(E, UpdateKind);
end;

procedure TFrmEditarPerfil.EditarPerfil(const codper: integer);
begin
 with CdsPerfil do
  begin
    Params.Items[0].Value := codper;
    Open;
  end;

  self.ShowModal;
end;

procedure TFrmEditarPerfil.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if CdsPerfil.Active then
  CdsPerfil.Close;

 ICosmosApp.IRemoteCon.DropConnection(self.FRemoteConnection);

 if Assigned(FICosmosApp) then
  FICosmosApp := nil;
end;

procedure TFrmEditarPerfil.FormCreate(Sender: TObject);
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;
 FRemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scUsuarios);
 CdsPerfil.RemoteServer := FRemoteConnection;

end;

procedure TFrmEditarPerfil.NovoPerfil;
begin
 with CdsPerfil do
  begin
    Params.Items[0].Value := 0;
    Open;
    Insert;
  end;

  ShowModal;
end;

end.
