unit cosmos.financeiro.view.situacaocontribuinte;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Data.DB, Datasnap.DBClient,
  Vcl.StdCtrls, Vcl.ImgList, Vcl.ExtCtrls, GroupHeader, Datasnap.DSConnect,
  cosmos.Framework.Interfaces.Root, cosmos.Framework.Interfaces.DataAcess,
  System.Actions, Vcl.ActnList, Cosmos.classes.Application, Vcl.Buttons;

type
  TFrmSituacao = class(TForm)
    CdsSituacao: TClientDataSet;
    LsvItens: TListView;
    ImageList1: TImageList;
    MSGroupHeader1: TMSGroupHeader;
    EdtAno: TEdit;
    ChkMensalidades: TCheckBox;
    ChkTaxas: TCheckBox;
    Label1: TLabel;
    ActionList1: TActionList;
    ActSearch: TAction;
    BitBtn1: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure CdsSituacaoAfterOpen(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ActSearchExecute(Sender: TObject);
    procedure ActSearchUpdate(Sender: TObject);
    procedure EdtAnoKeyPress(Sender: TObject; var Key: Char);
    procedure LsvItensAdvancedCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; Stage: TCustomDrawStage;
      var DefaultDraw: Boolean);
  private
    { Private declarations }
    FRemoteConnection: TDSProviderConnection;
    FICosmosApp: ICosmosApplication;
    FCodcad: integer;

    procedure LoadData;
    procedure ListData;

  public
    { Public declarations }

    procedure ExibirSituacao(const codcad: integer);
    property  ICosmosApp: ICosmosApplication read FICosmosApp;
  end;

var
  FrmSituacao: TFrmSituacao;

implementation

{$R *.dfm}

{ TFrmSituacao }

procedure TFrmSituacao.ActSearchExecute(Sender: TObject);
begin
 LoadData;
end;

procedure TFrmSituacao.ActSearchUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := Trim(EdtAno.Text) <> '';
end;

procedure TFrmSituacao.CdsSituacaoAfterOpen(DataSet: TDataSet);
begin
 ListData;
end;

procedure TFrmSituacao.EdtAnoKeyPress(Sender: TObject; var Key: Char);
begin
 if not (Key in ['0'.. '9', #8]) then
  Abort;
end;

procedure TFrmSituacao.ExibirSituacao(const codcad: integer);
begin
 FCodcad := codcad;
 ShowModal;
end;

procedure TFrmSituacao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(ICosmosApp) then
   ICosmosApp.IRemoteCon.DropConnection(FRemoteConnection);
end;

procedure TFrmSituacao.FormCreate(Sender: TObject);
var
 aYear, aMonth, aDay: word;
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;

 FRemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scFinanceiro);
 CdsSituacao.RemoteServer := FRemoteConnection;

 DecodeDate(ICosmosApp.IRemoteCon.ServerDateTime, aYear, aMonth, aDay);
 EdtAno.Text := aYear.ToString;
end;

procedure TFrmSituacao.ListData;
var
 aItem: TListItem;
begin
 LsvItens.Items.Clear;

 while not CdsSituacao.Eof do
  begin
   aItem := LsvItens.Items.Add;
   AItem.Caption := CdsSituacao.FieldValues['mesref'];
   AItem.SubItems.Append(CdsSituacao.FieldValues['anoref']);
   if CdsSituacao.FieldValues['valrec'] <> null then
    AItem.SubItems.Append(TDataConverter.ToFormatedCurrency(CdsSituacao.FieldValues['valrec']))
   else
    AItem.SubItems.Append('');
   AItem.SubItems.Append(TDataConverter.ToString(CdsSituacao.FieldValues['datrec']));
   AItem.SubItems.Append(TDataConverter.ToBoleanSimNao(CdsSituacao.FieldValues['indpen']));
   AItem.SubItems.Append(TDataConverter.ToString(CdsSituacao.FieldValues['codrec']));

   if CdsSituacao.FieldValues['indpen'] = 'N' then
    AItem.ImageIndex := 0
   else
    Aitem.ImageIndex := 1;

   if Pos('Men', CdsSituacao.FieldValues['destiprec']) > 0 then
    AItem.GroupID :=  0
   else
    Aitem.GroupID := 1;

   CdsSituacao.Next;
  end;

end;

procedure TFrmSituacao.LoadData;
begin
 if CdsSituacao.Active then
  CdsSituacao.Close;

 CdsSituacao.Params.ParamValues['icodcad'] := Fcodcad;
 CdsSituacao.Params.ParamValues['icodfav'] := ICosmosApp.ActiveFocus.FocusID;
 CdsSituacao.Params.ParamValues['ianoref'] := EdtAno.Text;

 if ChkMensalidades.Checked then
  CdsSituacao.Params.ParamValues['iindmen'] := TDataConverter.ToBoleanString(True)
 else
  CdsSituacao.Params.ParamValues['iindmen'] := TDataConverter.ToBoleanString(False);

 if ChkTaxas.Checked then
  CdsSituacao.Params.ParamValues['iindtax'] := TDataConverter.ToBoleanString(True)
 else
  CdsSituacao.Params.ParamValues['iindtax'] := TDataConverter.ToBoleanString(False);

 CdsSituacao.Open;

end;

procedure TFrmSituacao.LsvItensAdvancedCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; Stage: TCustomDrawStage;
  var DefaultDraw: Boolean);
var
 Pendente : boolean;
begin
 Pendente := TDataConverter.ToBolean(Copy(Item.SubItems[3], 0, 1));
 if Pendente then
  begin
   Sender.Canvas.Font.Color := clRed;
   Sender.Canvas.Font.Style := Sender.Canvas.Font.Style + [fsBold];
  end
 else
  Sender.Canvas.Font.Color := clBlue;

 Canvas.Refresh;
end;

end.
