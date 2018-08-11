unit cosmos.conferencias.view.FormPesquisarQuartos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, cosmos.classes.ServerInterface, DBClient,
  cosmos.framework.interfaces.DataAcess, StdCtrls, Buttons, ExtCtrls,
  cosmos.framework.interfaces.root, cosmos.classes.application, ValueComboBox,
  cosmos.frames.gridsearch, ImgList, ActnList, cosmos.system.messages,
  System.Actions;

type
  TFrmPesquisarQuartos = class(TForm)
    CdsSearch: TClientDataSet;
    Bevel2: TBevel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    CBXAlojamentos: TValueComboBox;
    CBXFoco: TValueComboBox;
    Label1: TLabel;
    Label2: TLabel;
    FmeGridSearch: TFmeGridSearch;
    DsrSearch: TDataSource;
    ImageList1: TImageList;
    ActionList1: TActionList;
    ActSelect: TAction;
    ActCancel: TAction;
    ActHelp: TAction;
    procedure FormCreate(Sender: TObject);
    procedure CBXAlojamentosChange(Sender: TObject);
    procedure ActSelectExecute(Sender: TObject);
    procedure ActSelectUpdate(Sender: TObject);
    procedure ActCancelExecute(Sender: TObject);
  private
    { Private declarations }
   FIRemoteCon: ICosmosRemoteConnection;
   procedure ListarAlojamentos;

  public
    { Public declarations }
    function GetValue(const FieldName: string): variant;

    property IRemoteCon: ICosmosRemoteConnection read FIRemoteCon;
  end;

var
  FrmPesquisarQuartos: TFrmPesquisarQuartos;

implementation

{$R *.dfm}

procedure TFrmPesquisarQuartos.ActCancelExecute(Sender: TObject);
begin
 ModalResult := mrCancel;
end;

procedure TFrmPesquisarQuartos.ActSelectExecute(Sender: TObject);
begin
 ModalResult := mrOk;
end;

procedure TFrmPesquisarQuartos.ActSelectUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := (CdsSearch.Active) and not (CdsSearch.IsEmpty);
end;

procedure TFrmPesquisarQuartos.CBXAlojamentosChange(Sender: TObject);
var
AParams: TCosmosData;
ICosmosApp: ICosmosApplication;
begin
 if CBXAlojamentos.Items.Count = 0 then //não existem alojamentos cadastrados...
  begin
   ICosmosApp := Application.MainForm as ICosmosApplication;

   try
    ICosmosApp.DlgMessage.Execute(TCosmosTitles.Alojamentos, TCosmosInfoMsg.AlojamentosNaoCadastrados, mtInformation);

   finally
    if Assigned(ICosmosApp)  then
     ICosmosApp := nil;
   end;
  end
 else
  begin
   AParams := TCosmosData.Create(1);

   try
    AParams.WriteValue('CODALO', StrToInt(CBXAlojamentos.GetValue));
    IRemoteCon.ExecuteDQL(csQuartosAlojamento, AParams.Data, CdsSearch);

   finally
    if Assigned(AParams) then
     FreeAndNil(AParams);
   end;
  end;
end;

procedure TFrmPesquisarQuartos.FormCreate(Sender: TObject);
var
ICosmosApp: ICosmosApplication;
begin
 FIRemoteCon := Application.MainForm as ICosmosRemoteConnection;
 ICosmosApp := Application.MainForm as ICosmosApplication;

 try
  CBXFoco.Items.Add(ICosmosApp.ActiveFocus.FocusName);
  CBXFoco.Values.Add(IntToStr(ICosmosApp.ActiveFocus.FocusID));
  CBXFoco.ItemIndex := 0;

 finally
  if Assigned(ICosmosApp) then
   ICosmosApp := nil;
 end;

 ListarAlojamentos;
end;

function TFrmPesquisarQuartos.GetValue(const FieldName: string): variant;
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

procedure TFrmPesquisarQuartos.ListarAlojamentos;
var
ADataset: TClientDataset;
AParams: TCosmosData;
begin
{Lista os alojamentos associados com o foco corrente.}
 ADataset := TClientDataset.Create(self);
 AParams := TCosmosData.Create(1);

 try
  AParams.WriteValue('FOCUS_ID', StrToInt(CBXFoco.GetValue));
  IRemoteCon.ExecuteDQL(csAlojamentosFoco, AParams.Data, ADataset);

  while not ADataset.Eof do
   begin
    CBXAlojamentos.Items.Append(ADataset.Fields.FieldByName('nomalo').AsString);
    CBXAlojamentos.Values.Append(ADataset.Fields.FieldByName('codalo').AsString);
    ADataset.Next;
   end;

 finally
  if Assigned(AParams) then
   FreeAndNil(AParams);
  if Assigned(ADataset) then
   FreeAndNil(ADataset);
 end;
end;

end.
