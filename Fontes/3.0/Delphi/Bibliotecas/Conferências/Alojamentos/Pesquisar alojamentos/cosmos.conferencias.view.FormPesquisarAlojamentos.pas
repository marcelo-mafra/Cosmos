unit cosmos.conferencias.view.FormPesquisarAlojamentos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ActnList, Vcl.ImgList, Data.DB,
  Datasnap.DBClient, cosmos.frames.gridsearch, Vcl.StdCtrls, ValueComboBox, Vcl.Buttons,
  Vcl.ExtCtrls, cosmos.classes.application, cosmos.framework.interfaces.root,
  cosmos.framework.interfaces.dataacess, cosmos.classes.ServerInterface,
  System.Actions;

type
  TFrmPesquisarAlojamentos = class(TForm)
    Bevel2: TBevel;
    Label2: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    CBXFoco: TValueComboBox;
    CdsSearch: TClientDataSet;
    DsrSearch: TDataSource;
    ImageList1: TImageList;
    ActionList1: TActionList;
    ActSelect: TAction;
    ActCancel: TAction;
    ActHelp: TAction;
    FmeGridSearch: TFmeGridSearch;
    procedure FormCreate(Sender: TObject);
    procedure ActSelectExecute(Sender: TObject);
    procedure ActSelectUpdate(Sender: TObject);
    procedure ActCancelExecute(Sender: TObject);
  private
    { Private declarations }
    FICosmosApp: ICosmosApplication;
    procedure ListarAlojamentos;
  public
    { Public declarations }
   function GetValue(const FieldName: string): variant;
   property ICosmosApp: ICosmosApplication read FICosmosApp;
  end;

var
  FrmPesquisarAlojamentos: TFrmPesquisarAlojamentos;

implementation

{$R *.dfm}

{ TFrmPesquisarAlojamentos }

procedure TFrmPesquisarAlojamentos.ActCancelExecute(Sender: TObject);
begin
 ModalResult := mrCancel;
end;

procedure TFrmPesquisarAlojamentos.ActSelectExecute(Sender: TObject);
begin
 ModalResult := mrOk;
end;

procedure TFrmPesquisarAlojamentos.ActSelectUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := (CdsSearch.Active) and not (CdsSearch.IsEmpty);
end;

procedure TFrmPesquisarAlojamentos.FormCreate(Sender: TObject);
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;

 CBXFoco.Items.Add(ICosmosApp.ActiveFocus.FocusName);
 CBXFoco.Values.Add(IntToStr(ICosmosApp.ActiveFocus.FocusID));
 CBXFoco.ItemIndex := 0;

 ListarAlojamentos;
end;

function TFrmPesquisarAlojamentos.GetValue(const FieldName: string): variant;
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

procedure TFrmPesquisarAlojamentos.ListarAlojamentos;
var
AParams: TCosmosData;
begin
{Lista os alojamentos associados com o foco corrente.}

 AParams := TCosmosData.Create(1);
 try
  AParams.WriteValue('FOCUS_ID', StrToInt(CBXFoco.GetValue));
  ICosmosApp.IRemoteCon.ExecuteDQL(csAlojamentosFoco, AParams.Data, CdsSearch);
  ICosmosApp.IRemoteCon.LoadFieldsInfo(CdsSearch);

 finally
  if Assigned(AParams) then
   FreeAndNil(AParams);
 end;
end;

end.
