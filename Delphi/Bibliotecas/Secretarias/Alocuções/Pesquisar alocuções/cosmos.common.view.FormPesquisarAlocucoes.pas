unit cosmos.common.view.FormPesquisarAlocucoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, GroupHeader, Buttons, cosmos.frames.gridsearch,
  ValueComboBox, DB, DBClient, Cosmos.Framework.Interfaces.DataAcess,
  Cosmos.Framework.Interfaces.Dialogs,ActnList, ImgList, Data.SqlExpr,
  cosmos.classes.application, cosmos.classes.ServerInterface, System.Actions;

type
  TFrmPesquisarAlocucoes = class(TForm, ISearchAlocucoes)
    MSGroupHeader1: TMSGroupHeader;
    ChkLR: TCheckBox;
    ChkTMO: TCheckBox;
    ChkTMB: TCheckBox;
    ChkTPU: TCheckBox;
    Bevel1: TBevel;
    EdtArgument: TEdit;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    FmeGridSearch1: TFmeGridSearch;
    CBXSearchField: TValueComboBox;
    DsrData: TDataSource;
    CdsData: TClientDataSet;
    ImageList1: TImageList;
    ActionList1: TActionList;
    ActSelect: TAction;
    ActCancel: TAction;
    ActHelp: TAction;
    ActSearch: TAction;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    Label2: TLabel;
    Bevel2: TBevel;
    procedure EdtArgumentKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CdsDataAfterOpen(DataSet: TDataSet);
    procedure FmeGridSearch1DBGrid1DblClick(Sender: TObject);
    procedure ActSearchUpdate(Sender: TObject);
    procedure ActSearchExecute(Sender: TObject);
    procedure ActSelectUpdate(Sender: TObject);
    procedure ActHelpExecute(Sender: TObject);
    procedure ActCancelExecute(Sender: TObject);
    procedure ActSelectExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure DoSearch;
    function GetDisplayLabel(const FieldName: string): string;

  protected
    function GetDataset: TDataset;

    property Dataset: TDataset read GetDataset;
    function Execute: boolean; overload;
    function Execute(const LEC, TMO, TMB, TPU: boolean): boolean; overload;

  public
    { Public declarations }
  end;

var
  FrmPesquisarAlocucoes: TFrmPesquisarAlocucoes;

implementation

{$R *.dfm}

procedure TFrmPesquisarAlocucoes.ActCancelExecute(Sender: TObject);
begin
 ModalResult := mrCancel;
end;

procedure TFrmPesquisarAlocucoes.ActHelpExecute(Sender: TObject);
begin
 if Self.HelpContext <> 0 then
  Application.HelpSystem.ShowContextHelp(Self.HelpContext, Application.CurrentHelpFile);
end;

procedure TFrmPesquisarAlocucoes.ActSearchExecute(Sender: TObject);
begin
 DoSearch;
end;

procedure TFrmPesquisarAlocucoes.ActSearchUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := (CBXSearchField.ItemIndex >= 0) and
  (Trim(EdtArgument.Text) <> '');
end;

procedure TFrmPesquisarAlocucoes.ActSelectExecute(Sender: TObject);
begin
 if (CdsData.Active) and not (CdsData.IsEmpty) then
   ModalResult := mrOk;
end;

procedure TFrmPesquisarAlocucoes.ActSelectUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := (CdsData.Active) and not (CdsData.IsEmpty);
end;

procedure TFrmPesquisarAlocucoes.CdsDataAfterOpen(DataSet: TDataSet);
var
I: integer;
begin
 for I := 0 to Pred(CdsData.Fields.Count) do
  CdsData.Fields.Fields[i].DisplayLabel := GetDisplayLabel(CdsData.Fields.Fields[i].FieldName);
end;

procedure TFrmPesquisarAlocucoes.DoSearch;
var
AParams: TCosmosData;
IRemoteCon: ICosmosRemoteConnection;
ADataset: TSQLDataset;
begin
//Executa a pesquisa
 IRemoteCon := Application.MainForm as ICosmosRemoteConnection;
 AParams := TCosmosData.Create(6);

 ADataset := TSQLDataset.Create(nil);

 try
  CdsData.DisableControls;
  AParams.WriteValue('TIPPES', CBXSearchField.GetValue);
  AParams.WriteValue('ARGUMENT', QuotedStr(EdtArgument.Text + '%'), 1);
  AParams.WriteValue('LEC', ChkLR.Checked, 2);
  AParams.WriteValue('TMO', ChkTMO.Checked, 3);
  AParams.WriteValue('TMB', ChkTMB.Checked, 4);
  AParams.WriteValue('TPU', ChkTPU.Checked, 5);

  ADataset := IRemoteCon.ExecuteDQL(csAlocucoes, AParams.Data) as TSQLDataset;
  if (ADataset <> nil) and (ADataset.Active) then
   CdsData := IRemoteCon.ToClientDataset(ADataset);

 finally
  CdsData.EnableControls;
  if Assigned(AParams) then AParams.Free;
 end;
end;

procedure TFrmPesquisarAlocucoes.EdtArgumentKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
 if (Key = 13) and (ActSearch.Enabled) then
  ActSearch.Execute;
end;

function TFrmPesquisarAlocucoes.Execute(const LEC, TMO, TMB,
  TPU: boolean): boolean;
begin
 ChkLR.Checked := LEC;
 ChkLR.Enabled := LEC;

 ChkTMO.Checked := TMO;
 ChkTMO.Enabled := TMO;

 ChkTMB.Checked := TMB;
 ChkTMB.Enabled := TMB;

 ChkTPU.Checked := TPU;
 ChkTPU.Enabled := TPU;

 Result := ShowModal = mrOk;
end;

function TFrmPesquisarAlocucoes.Execute: boolean;
begin
 Result := ShowModal = mrOk;
end;

procedure TFrmPesquisarAlocucoes.FmeGridSearch1DBGrid1DblClick(Sender: TObject);
begin
 if (CdsData.Active) and not (CdsData.IsEmpty) then
  ModalResult := mrOk;
end;

procedure TFrmPesquisarAlocucoes.FormCreate(Sender: TObject);
var
IRemoteCon: ICosmosRemoteConnection;
begin
 IRemoteCon := Application.MainForm as ICosmosRemoteConnection;
 CdsData.RemoteServer := IRemoteCon.ConnectionBroker;
 CBXSearchField.ItemIndex := 0;
 FmeGridSearch1.SearchFields := 'TITALO';
end;

function TFrmPesquisarAlocucoes.GetDataset: TDataset;
begin
 Result := CdsData;
end;

function TFrmPesquisarAlocucoes.GetDisplayLabel(
  const FieldName: string): string;
begin
 Result := FieldName;

 if FieldName = 'TITALO' then
  Result := 'Título'
 else
 if FieldName = 'FRAALO' then
  Result := 'Frase de Abertura'
 else
 if FieldName = 'NOMAUT' then
  Result := 'Autor(es)';

end;


initialization
 RegisterClass(TFrmPesquisarAlocucoes);

finalization
 UnRegisterClass(TFrmPesquisarAlocucoes);

end.
