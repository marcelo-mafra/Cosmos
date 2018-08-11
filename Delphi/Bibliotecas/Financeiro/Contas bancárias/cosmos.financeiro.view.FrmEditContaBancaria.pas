unit cosmos.financeiro.view.FrmEditContaBancaria;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FormCosmosDialog, DB, DBClient, FrameDBInsertVertical, StdCtrls,
  DBCtrls, cosmos.frames.fkSearch, Buttons, Mask, ExtCtrls, GroupHeader,
  cosmos.system.messages, cosmos.classes.ServerInterface, cosmos.classes.application,
  cosmos.framework.interfaces.Root, Datasnap.DSConnect, cosmos.framework.interfaces.Dataacess,
  ValueComboBox, DBValueComboBox, Data.DBXCommon;

type
  TFrmEditContaBancaria = class(TFrmCosmosDialog)
    CdsContaBancaria: TClientDataSet;
    FmeDBInsertVertical1: TFmeDBInsertVertical;
    MSGroupHeader1: TMSGroupHeader;
    Label1: TLabel;
    Label2: TLabel;
    DBEdit1: TDBEdit;
    MSGroupHeader2: TMSGroupHeader;
    FmeFKFocos: TFmeFKSearch;
    DBCheckBox1: TDBCheckBox;
    DBEdit3: TDBEdit;
    Label3: TLabel;
    Label6: TLabel;
    DBEdit2: TDBEdit;
    DBEdit4: TDBEdit;
    Label4: TLabel;
    CBXBancos: TDBComboBox;
    DBRadioGroup1: TDBRadioGroup;
    procedure CdsContaBancariaBeforePost(DataSet: TDataSet);
    procedure CdsContaBancariaAfterPost(DataSet: TDataSet);
    procedure CdsContaBancariaAfterInsert(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CBXBancosChange(Sender: TObject);
    procedure CdsContaBancariaAfterOpen(DataSet: TDataSet);
    procedure CdsContaBancariaReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
  private
    { Private declarations }
    FRemoteConnection: TDSProviderConnection;
    FNumerosBancos: TStringList;
    procedure Listarbancos;

  public
    { Public declarations }
    procedure NovaContaBancaria;
    property NumerosBancos: TStringList read FNumerosBancos;
    procedure EditarContaBancaria(const codconban: integer);
  end;

var
  FrmEditContaBancaria: TFrmEditContaBancaria;

implementation

{$R *.dfm}

procedure TFrmEditContaBancaria.CBXBancosChange(Sender: TObject);
begin
 if CBXBancos.ItemIndex >= 0 then
  begin
   CdsContaBancaria.Edit;
   CdsContaBancaria.FieldValues['numban'] := NumerosBancos.Strings[CBXBancos.ItemIndex ];
  end;
end;

procedure TFrmEditContaBancaria.CdsContaBancariaAfterInsert(DataSet: TDataSet);
begin
  inherited;
 with Dataset.Fields do
  begin
    FieldByName('indati').Value := TDataConverter.ToBoleanString(True);
    FieldByName('codfoc').Value := ICosmosApp.ActiveFocus.FocusID;
    FieldByName('nomfoc').Value := ICosmosApp.ActiveFocus.FocusName;
    FieldByName('camtra').Value := 'LEC';
  end;
end;

procedure TFrmEditContaBancaria.CdsContaBancariaAfterOpen(DataSet: TDataSet);
begin
 if not Dataset.IsEmpty then
  TClientDataset(Dataset).ReadOnly := Dataset.FieldValues['codfoc'] <> ICosmosApp.ActiveFocus.FocusID
 else
  TClientDataset(Dataset).ReadOnly := False;
end;

procedure TFrmEditContaBancaria.CdsContaBancariaAfterPost(DataSet: TDataSet);
begin
  inherited;
 if CdsContaBancaria.ChangeCount > 0 then
  CdsContaBancaria.ApplyUpdates(0);
end;

procedure TFrmEditContaBancaria.CdsContaBancariaBeforePost(DataSet: TDataSet);
var
SequenceName: string;
begin
 inherited;
 if Dataset.State = dsInsert then
  begin
   SequenceName := TClientDataset(DataSet).GetOptionalParam('SequenceName');
   Dataset.Fields.Fields[0].AsInteger := IRemoteCon.GetSequenceValue(SequenceName);
  end;
end;

procedure TFrmEditContaBancaria.CdsContaBancariaReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
 Action := ICosmosApp.IRemoteCon.ReconcileError(E, UpdateKind);
end;

procedure TFrmEditContaBancaria.EditarContaBancaria(const codconban: integer);
begin
 with CdsContaBancaria do
  begin
    Params.Items[0].Value := codconban;
    Open;
  end;

 ShowModal;
end;

procedure TFrmEditContaBancaria.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if Assigned(NumerosBancos) then NumerosBancos.Free;

  if Assigned(IRemoteCon) then
   IRemoteCon.DropConnection(FRemoteConnection);
end;

procedure TFrmEditContaBancaria.FormCreate(Sender: TObject);
begin
  inherited;
  FRemoteConnection := IRemoteCon.CreateConnection(scFinanceiro);
  CdsContaBancaria.RemoteServer := FRemoteConnection;
  FmeFKFocos.Configure('codfoc', csFocos);

  FNumerosBancos := TStringList.Create;
  ListarBancos;
end;

procedure TFrmEditContaBancaria.Listarbancos;
var
 aReader: TDBXReader;
begin
 CBXBancos.Items.Clear;
 NumerosBancos.Clear;

 aReader := ICosmosApp.IRemoteCon.ListData(csInstituicoesBancarias, null);

 while aReader.Next do
  begin
   CBXBancos.Items.Append(aReader.Value['nomban'].AsString);
   NumerosBancos.Append(aReader.Value['numban'].AsString);
  end;
end;

procedure TFrmEditContaBancaria.NovaContaBancaria;
begin
 with CdsContaBancaria do
  begin
    Params.Items[0].Value := 0;
    Open;
    Insert;
  end;

 ShowModal;
end;

end.
