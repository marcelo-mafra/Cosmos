unit cosmos.conferencias.view.FormPesquisarLeitos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, cosmos.classes.ServerInterface, DBClient,
  cosmos.framework.interfaces.DataAcess, StdCtrls, Buttons, ExtCtrls,
  cosmos.framework.interfaces.root, cosmos.classes.application, ValueComboBox,
  cosmos.frames.gridsearch, ImgList, ActnList, cosmos.system.messages,
  System.Actions;

type
  TFrmPesquisarLeitos = class(TForm)
    CdsSearch: TClientDataSet;
    Bevel2: TBevel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    CBXAlojamentos: TValueComboBox;
    Label1: TLabel;
    FmeGridSearch: TFmeGridSearch;
    DsrSearch: TDataSource;
    ImageList1: TImageList;
    ActionList1: TActionList;
    ActSelect: TAction;
    ActCancel: TAction;
    ActHelp: TAction;
    CBXAlas: TValueComboBox;
    Label3: TLabel;
    ChkApenasLeitosVazios: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure CBXAlojamentosChange(Sender: TObject);
    procedure ActSelectExecute(Sender: TObject);
    procedure ActSelectUpdate(Sender: TObject);
    procedure ActCancelExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CdsSearchAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
   FIConference: ICosmosConference;
   FICosmosApp: ICosmosApplication;
   procedure ListarAlojamentos;
   procedure PesquisarLeitos;

  public
    { Public declarations }
    function GetValue(const FieldName: string): variant;
    property IConference: ICosmosConference read FIConference;
    property ICosmosApp: ICosmosApplication read FICosmosApp;
  end;

var
  FrmPesquisarLeitos: TFrmPesquisarLeitos;

implementation

{$R *.dfm}

procedure TFrmPesquisarLeitos.ActCancelExecute(Sender: TObject);
begin
 ModalResult := mrCancel;
end;

procedure TFrmPesquisarLeitos.ActSelectExecute(Sender: TObject);
begin
 ModalResult := mrOk;
end;

procedure TFrmPesquisarLeitos.ActSelectUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := (CdsSearch.Active) and not (CdsSearch.IsEmpty);
end;

procedure TFrmPesquisarLeitos.CBXAlojamentosChange(Sender: TObject);
begin
 if self.Visible then
  PesquisarLeitos;
end;

procedure TFrmPesquisarLeitos.CdsSearchAfterOpen(DataSet: TDataSet);
begin
 ICosmosApp.IRemoteCon.LoadFieldsInfo(Dataset);
end;

procedure TFrmPesquisarLeitos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 if IConference <> nil then
  FIConference := nil;

 if ICosmosApp <> nil then
  FICosmosApp := nil;
end;

procedure TFrmPesquisarLeitos.FormCreate(Sender: TObject);
begin
 FIConference := Application.MainForm as ICosmosConference;
 FICosmosApp := Application.MainForm as ICosmosApplication;

 if IConference <> nil then
  begin
   ChkApenasLeitosVazios.Checked := IConference.ActiveConference <> nil;
   ChkApenasLeitosVazios.Enabled := IConference.ActiveConference <> nil;
  end;

 ListarAlojamentos;
end;

function TFrmPesquisarLeitos.GetValue(const FieldName: string): variant;
begin
 if CdsSearch.Active then
  begin
    if CdsSearch.FindField(FieldName) <> nil then
     Result := CdsSearch.Fields.FieldByName(FieldName).Value
    else
     Result := unassigned;
  end
 else
  Result := unassigned;
end;

procedure TFrmPesquisarLeitos.ListarAlojamentos;
var
ADataset: TClientDataset;
AParams: TCosmosData;
begin
{Lista os alojamentos associados com o foco corrente.}
 ADataset := TClientDataset.Create(self);
 AParams := TCosmosData.Create(1);

 try
  AParams.WriteValue('FOCUS_ID', ICosmosApp.ActiveFocus.FocusID);
  ICosmosApp.IRemoteCon.ExecuteDQL(csAlojamentosFoco, AParams.Data, ADataset);

  while not ADataset.Eof do
   begin
    CBXAlojamentos.Items.Append(ADataset.Fields.FieldByName('nomalo').AsString);
    CBXAlojamentos.Values.Append(ADataset.Fields.FieldByName('codalo').AsString);
    ADataset.Next;
   end;

 finally
  if Assigned(AParams) then FreeAndNil(AParams);
  if Assigned(ADataset) then FreeAndNil(ADataset);
  if CBXAlojamentos.Items.Count > 0 then
   CBXAlojamentos.ItemIndex := 0;
 end;
end;


procedure TFrmPesquisarLeitos.PesquisarLeitos;
var
AParams: TCosmosData;
begin
 AParams := TCosmosData.Create(5);

 try
   if CBXAlojamentos.Items.Count = 0 then //não existem alojamentos cadastrados...
     ICosmosApp.DlgMessage.Execute(TCosmosTitles.Alojamentos, TCosmosInfoMsg.AlojamentosNaoCadastrados, mtInformation)
   else
    begin
     AParams.WriteValue('CODALO', CBXAlojamentos.GetValue.ToInteger);
     AParams.WriteValue('ALAQUA', CBXAlas.GetValue.QuotedString, 1);

     if self.ChkApenasLeitosVazios.Checked then
      begin
       AParams.WriteValue('CODCON', IConference.ActiveConference.ConferenceID, 2);
       ICosmosApp.IRemoteCon.ExecuteDQL(csLeitosLivresAlojamento, AParams.Data, CdsSearch);
      end
     else
      ICosmosApp.IRemoteCon.ExecuteDQL(csLeitosAlojamento, AParams.Data, CdsSearch);
    end;

   finally
    if Assigned(AParams) then
     FreeAndNil(AParams);
   end;
end;

end.
