unit cosmos.financeiro.view.frmeditrecebimentos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, Cosmos.Framework.Interfaces.DataAcess, StdCtrls,
  ValueComboBox, DBValueComboBox, ExtCtrls, GroupHeader, FrameDBInsertVertical,
  Mask, DBCtrls, cosmos.frames.dbeditcalculator, cosmos.frames.usuariocad, ComCtrls,
  DBDateTimePicker, cosmos.Framework.Interfaces.Root, cosmos.system.messages,
  cosmos.classes.application, cosmos.system.types, Datasnap.DSConnect,
  cosmos.frames.fkSearch, cosmos.classes.ServerInterface, Data.DBXCommon,
  Cosmos.Framework.Interfaces.Applications;

type
  TFrmEditarRecebimento = class(TForm)
    CdsRecebimento: TClientDataSet;
    FmeDBInsertVertical1: TFmeDBInsertVertical;
    MSGroupHeader2: TMSGroupHeader;
    FmeUsuarioCadastrador1: TFmeUsuarioCadastrador;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabCancelamento: TTabSheet;
    MSGroupHeader1: TMSGroupHeader;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    CBXTipos: TDBValueComboBox;
    DBValueComboBox1: TDBValueComboBox;
    DBEdit1: TDBEdit;
    FmeDBCalculator1: TFmeDBCalculator;
    FmeDBCalculator2: TFmeDBCalculator;
    DBEdit2: TDBEdit;
    EdtDataRecebimento: TDBDateTimePicker;
    MSGroupHeader3: TMSGroupHeader;
    Label7: TLabel;
    Label8: TLabel;
    FmeFocoFavorecido: TFmeFKSearch;
    FmeFocoRecebedor: TFmeFKSearch;
    MSGroupHeader4: TMSGroupHeader;
    Label9: TLabel;
    Label10: TLabel;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    MSGroupHeader5: TMSGroupHeader;
    Label11: TLabel;
    Label12: TLabel;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBRadioGroup1: TDBRadioGroup;
    ChkAutomaticPrint: TCheckBox;
    procedure CdsRecebimentoAfterPost(DataSet: TDataSet);
    procedure CdsRecebimentoBeforePost(DataSet: TDataSet);
    procedure CdsRecebimentoAfterInsert(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CdsRecebimentoAfterApplyUpdates(Sender: TObject;
      var OwnerData: OleVariant);
    procedure CdsRecebimentoAfterOpen(DataSet: TDataSet);
    procedure CdsRecebimentoReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
  private
    { Private declarations }
    Fcodcad, FValor: variant;
    FCodTipo: integer;
    FCurrentDate: TDateTime;
    FICosmosApp: ICosmosApplication;
    FRemoteConnection: TDSProviderConnection;
    function GetIRemoteCon: ICosmosRemoteConnection;
    procedure LoadTipos; inline;
    procedure LoadDefaultValues;
  public
    { Public declarations }
    property ICosmosApp: ICosmosApplication read FICosmosApp;
    property IRemoteCon: ICosmosRemoteConnection read GetIRemoteCon;
    procedure NovoRecebimento(const codcad: integer; Valor: variant); overload;
    procedure NovoRecebimento(const codcad: integer; Valor: variant;
     Tipo: string); overload;
    procedure EditarRecebimento(const codrec, codcad: integer; Data: Olevariant);

    property CurrentDate: TDateTime read FCurrentDate;

  end;

var
  FrmEditarRecebimento: TFrmEditarRecebimento;

implementation

{$R *.dfm}

procedure TFrmEditarRecebimento.CdsRecebimentoAfterApplyUpdates(Sender: TObject;
  var OwnerData: OleVariant);
var
 IFinanc: ICosmosFinanceiro;
begin
 IRemoteCon.ActiveDataNavigator.UpdateData;

 //Imprime o recibo do recebimento.
 if ChkAutomaticPrint.Checked then
  begin
    IFinanc := Application.MainForm as ICosmosFinanceiro;

    try
      IFinanc.ImprimirRecibo(CdsRecebimento.FieldValues['codrec']);

    finally
      IFinanc := nil;
    end;
  end;
end;

procedure TFrmEditarRecebimento.CdsRecebimentoAfterInsert(DataSet: TDataSet);
begin
 self.LoadDefaultValues;
end;

procedure TFrmEditarRecebimento.CdsRecebimentoAfterOpen(DataSet: TDataSet);
begin
 TabCancelamento.Enabled := (Dataset.Active) and (Dataset.FieldValues['indcan'] = 'S');
end;

procedure TFrmEditarRecebimento.CdsRecebimentoAfterPost(DataSet: TDataSet);
begin
 if CdsRecebimento.ChangeCount > 0 then
   CdsRecebimento.ApplyUpdates(0);

 FCodtipo := CBXTipos.GetValue.ToInteger;
end;

procedure TFrmEditarRecebimento.CdsRecebimentoBeforePost(DataSet: TDataSet);
var
SequenceName: string;
begin
 if Dataset.State = dsInsert then
  begin
   SequenceName := TClientDataset(DataSet).GetOptionalParam('SequenceName');
   Dataset.Fields.Fields[0].AsInteger := IRemoteCon.GetSequenceValue(SequenceName);
  end;

 DataSet.Fields.FieldByName('USURES').Value := UpperCase(IRemoteCon.ConnectedUser);
 DataSet.Fields.FieldByName('DATCAD').Value := IRemoteCon.ServerDateTime;
end;

procedure TFrmEditarRecebimento.CdsRecebimentoReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
 Action := ICosmosApp.IRemoteCon.ReconcileError(E, UpdateKind);
end;

procedure TFrmEditarRecebimento.EditarRecebimento(const codrec, codcad: integer;
  Data: Olevariant);
begin
  with CdsRecebimento do
   begin
    Params.Items[0].Value := codrec;
    Params.Items[1].Value := codcad;
    Open;
   end;

  ShowModal;
end;

procedure TFrmEditarRecebimento.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if Assigned(IRemoteCon) then
   IRemoteCon.DropConnection(FRemoteConnection);
end;

procedure TFrmEditarRecebimento.FormCreate(Sender: TObject);
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;

 FRemoteConnection := IRemoteCon.CreateConnection(scFinanceiro);
 CdsRecebimento.RemoteServer := FRemoteConnection;

 FCurrentDate := IRemoteCon.ServerDateTime;
 FCodtipo := 0; //default

 FmeFocoFavorecido.Configure('codfav', csFocos);
 FmeFocoRecebedor.Configure('codloc', csFocos);
 EdtDataRecebimento.MaxDate := CurrentDate;
 LoadTipos;
end;

function TFrmEditarRecebimento.GetIRemoteCon: ICosmosRemoteConnection;
begin
 Result := ICosmosApp.IRemoteCon;
end;

procedure TFrmEditarRecebimento.LoadDefaultValues;
var
Y, M, D: word;
ICosmosFin: ICosmosFinanceiro;
begin
 ICosmosFin := Application.MainForm as ICosmosFinanceiro;

 try
 with CdsRecebimento.Fields do
  begin
   FieldByName('datrec').AsDateTime := self.CurrentDate;
   DecodeDate(FieldByName('datrec').AsDateTime, Y, M, D);
   FieldByName('mesref').Value := M;
   FieldByName('anoref').Value := Y;
   FieldByName('codcad').Value := CdsRecebimento.Params.Items[1].Value;
   FieldByName('codtiprec').Value := FCodTipo;
   FieldByName('indcan').Value := TDataConverter.ToBoleanString(False);

   //Foco favorecido
   FieldByName('codfav').Value := ICosmosApp.ActiveFocus.FocusID;
   FieldByName('nomfav').Value := ICosmosApp.ActiveFocus.FocusName;
   //Foco recebedor
   FieldByName('codloc').Value := ICosmosApp.ActiveFocus.FocusID;
   FieldByName('nomloc').Value := ICosmosApp.ActiveFocus.FocusName;

   //Caixa recebedor
   FieldByName('codcai').Value := ICosmosFin.CurrentCaixa.CaixaID;
   FieldByName('numcai').Value := ICosmosFin.CurrentCaixa.NumCaixa;
   FieldByName('nomcad').Value := ICosmosFin.CurrentCaixa.UserName;

   if FValor <> unassigned then
    begin
     FieldByName('valpre').Value := FValor;
     FieldByName('valrec').Value := FValor;
    end;
  end;

 finally
  ICosmosFin := nil;
 end;
end;

procedure TFrmEditarRecebimento.LoadTipos;
var
 aReader: TDBXReader;
begin
 aReader := IRemoteCon.ListData(csTiposRecebimentos, null);

 CBXTipos.Items.Clear;
 CBXTipos.Values.Clear;

 while aReader.Next do
   begin
    CBXTipos.Items.Append(aReader.Value['destiprec'].AsString);
    CBXTipos.Values.Append(aReader.Value['codtiprec'].AsString);
   end;
end;

procedure TFrmEditarRecebimento.NovoRecebimento(const codcad: integer;
  Valor: variant; Tipo: string);
begin
  FCodcad := codcad;
  FValor := Valor;

  with CdsRecebimento do
   begin
    Params.Items[0].Value := 0;
    Params.Items[1].Value := codcad;
    Open;
    Insert;
   end;

  ShowModal;
end;

procedure TFrmEditarRecebimento.NovoRecebimento(const codcad: integer;
  Valor: variant);
begin
  FCodcad := codcad;
  FValor := Valor;

  with CdsRecebimento do
   begin
    Params.Items[0].Value := 0;
    Params.Items[1].Value := codcad;
    Open;
    Insert;
   end;

  ShowModal;
end;

end.
