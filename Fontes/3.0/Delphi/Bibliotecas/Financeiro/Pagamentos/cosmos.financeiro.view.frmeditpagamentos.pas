unit cosmos.financeiro.view.frmeditpagamentos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, Cosmos.Framework.Interfaces.DataAcess, StdCtrls,
  ValueComboBox, DBValueComboBox, ExtCtrls, GroupHeader, FrameDBInsertVertical,
  Mask, DBCtrls, cosmos.frames.dbeditcalculator, cosmos.frames.usuariocad, ComCtrls,
  DBDateTimePicker, cosmos.Framework.Interfaces.Root, cosmos.system.messages,
  cosmos.classes.application, cosmos.system.types, Datasnap.DSConnect,
  cosmos.frames.fkSearch, cosmos.classes.ServerInterface,
  Cosmos.Framework.Interfaces.Applications;

type
  TFrmEditarPagamento = class(TForm)
    CdsPagamento: TClientDataSet;
    FmeDBInsertVertical1: TFmeDBInsertVertical;
    MSGroupHeader2: TMSGroupHeader;
    FmeUsuarioCadastrador1: TFmeUsuarioCadastrador;
    PageControl1: TPageControl;
    Pagamento: TTabSheet;
    TabCancelamento: TTabSheet;
    MSGroupHeader1: TMSGroupHeader;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label1: TLabel;
    Label4: TLabel;
    DBValueComboBox1: TDBValueComboBox;
    DBEdit1: TDBEdit;
    FmeDBCalculator1: TFmeDBCalculator;
    EdtDataPagamento: TDBDateTimePicker;
    DBRadioGroup1: TDBRadioGroup;
    FmeFontePagadora: TFmeFKSearch;
    DBMemo1: TDBMemo;
    MSGroupHeader4: TMSGroupHeader;
    Label9: TLabel;
    Label10: TLabel;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    MSGroupHeader5: TMSGroupHeader;
    Label11: TLabel;
    Label12: TLabel;
    DBEdit2: TDBEdit;
    DBEdit6: TDBEdit;
    DBRadioGroup2: TDBRadioGroup;
    DBComboBox1: TDBComboBox;
    procedure CdsPagamentoAfterPost(DataSet: TDataSet);
    procedure CdsPagamentoBeforePost(DataSet: TDataSet);
    procedure CdsPagamentoAfterInsert(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CdsPagamentoAfterApplyUpdates(Sender: TObject;
      var OwnerData: OleVariant);
    procedure CdsPagamentoAfterOpen(DataSet: TDataSet);
    procedure CdsPagamentoReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
  private
    { Private declarations }
    FCurrentDate: TDateTime;
    FICosmosApp: ICosmosApplication;
    FRemoteConnection: TDSProviderConnection;
    function GetIRemoteCon: ICosmosRemoteConnection;
    procedure LoadDefaultValues;
  public
    { Public declarations }
    property ICosmosApp: ICosmosApplication read FICosmosApp;
    property IRemoteCon: ICosmosRemoteConnection read GetIRemoteCon;

    procedure NovoPagamento;
    procedure EditarPagamento(const codpag: integer);
    property CurrentDate: TDateTime read FCurrentDate;

  end;

var
  FrmEditarPagamento: TFrmEditarPagamento;

implementation

{$R *.dfm}

procedure TFrmEditarPagamento.CdsPagamentoAfterApplyUpdates(Sender: TObject;
  var OwnerData: OleVariant);
begin
 IRemoteCon.ActiveDataNavigator.UpdateData;
end;

procedure TFrmEditarPagamento.CdsPagamentoAfterInsert(DataSet: TDataSet);
begin
 self.LoadDefaultValues;
end;

procedure TFrmEditarPagamento.CdsPagamentoAfterOpen(DataSet: TDataSet);
begin
 TabCancelamento.Enabled := (Dataset.Active) and (Dataset.FieldValues['indcan'] = 'S');
end;

procedure TFrmEditarPagamento.CdsPagamentoAfterPost(DataSet: TDataSet);
begin
 if CdsPagamento.ChangeCount > 0 then
  CdsPagamento.ApplyUpdates(0);
end;

procedure TFrmEditarPagamento.CdsPagamentoBeforePost(DataSet: TDataSet);
var
SequenceName: string;
begin
 if Dataset.State = dsInsert then
  begin
   SequenceName := TClientDataset(DataSet).GetOptionalParam('SequenceName');
   Dataset.Fields.Fields[0].AsInteger := IRemoteCon.GetSequenceValue(SequenceName);
  end;

 DataSet.Fields.FieldByName('USURES').Value := UpperCase(IRemoteCon.ConnectedUser);;
 DataSet.Fields.FieldByName('DATCAD').Value := IRemoteCon.ServerDateTime;
end;

procedure TFrmEditarPagamento.CdsPagamentoReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
 Action := ICosmosApp.IRemoteCon.ReconcileError(E, UpdateKind);
end;

procedure TFrmEditarPagamento.EditarPagamento(const codpag: integer);
begin
 CdsPagamento.Params.Items[0].Value := codpag;
 CdsPagamento.Open;

 ShowModal;
end;

procedure TFrmEditarPagamento.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if Assigned(IRemoteCon) then
   IRemoteCon.DropConnection(FRemoteConnection);
end;

procedure TFrmEditarPagamento.FormCreate(Sender: TObject);
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;

 FRemoteConnection := IRemoteCon.CreateConnection(scFinanceiro);
 CdsPagamento.RemoteServer := FRemoteConnection;

 FCurrentDate := IRemoteCon.ServerDateTime;
 FmeFontePagadora.Configure('codfoc', csFocos);
 EdtDataPagamento.MaxDate := CurrentDate;
end;

function TFrmEditarPagamento.GetIRemoteCon: ICosmosRemoteConnection;
begin
 Result := ICosmosApp.IRemoteCon;
end;

procedure TFrmEditarPagamento.LoadDefaultValues;
var
Y, M, D: word;
ICosmosFin: ICosmosFinanceiro;
begin
 ICosmosFin := Application.MainForm as ICosmosFinanceiro;

 try
 with CdsPagamento.Fields do
  begin
   FieldByName('datpag').AsDateTime := self.CurrentDate;
   DecodeDate(FieldByName('datpag').AsDateTime, Y, M, D);
   FieldByName('mesref').Value := M;
   FieldByName('anoref').Value := Y;

   FieldByName('indcan').Value := TDataConverter.ToBoleanString(False);
   FieldByName('forpag').Value := 'TRA'; //do not localize!

   //Fonte pagadora
   FieldByName('codfoc').Value := ICosmosApp.ActiveFocus.FocusID;
   FieldByName('nomfoc').Value := ICosmosApp.ActiveFocus.FocusName;

   //Caixa recebedor
   FieldByName('codcai').Value := ICosmosFin.CurrentCaixa.CaixaID;
   FieldByName('numcai').Value := ICosmosFin.CurrentCaixa.NumCaixa;
   FieldByName('nomcad').Value := ICosmosFin.CurrentCaixa.UserName;
  end;

 finally
  ICosmosFin := nil;
 end;
end;

procedure TFrmEditarPagamento.NovoPagamento;
begin
 CdsPagamento.Params.Items[0].Value := 0;
 CdsPagamento.Open;

 CdsPagamento.Insert;

 ShowModal;
end;



end.
