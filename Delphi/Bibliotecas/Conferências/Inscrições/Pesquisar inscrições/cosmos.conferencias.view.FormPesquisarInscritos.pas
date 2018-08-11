unit cosmos.conferencias.view.FormPesquisarInscritos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, cosmos.framework.interfaces.dialogs, cosmos.classes.ServerInterface,
  DBClient, cosmos.framework.interfaces.DataAcess, StdCtrls, Buttons, ExtCtrls,
  cosmos.framework.interfaces.root, cosmos.classes.application, ImgList, ActnList,
  cosmos.system.messages, cosmos.frames.gridsearch, cosmos.frames.searchdata,
  System.Actions;

type
  TFrmPesquisarInscritos = class(TForm, ICosmosDataSearch)
    CdsSearch: TClientDataSet;
    Bevel2: TBevel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    DsrSearch: TDataSource;
    ImageList1: TImageList;
    ActionList1: TActionList;
    ActSelect: TAction;
    ActCancel: TAction;
    ActHelp: TAction;
    FmeGridSearch: TFmeGridSearch;
    FmeSearchConferencia: TFmeSearchData;
    procedure FormCreate(Sender: TObject);
    procedure ActSelectExecute(Sender: TObject);
    procedure ActSelectUpdate(Sender: TObject);
    procedure ActCancelExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CdsSearchAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
   FICosmosApp: ICosmosApplication;
   function GetDataset: TDataset;
   procedure UpdateDate(Sender: TObject);

  protected
   function GetValue(const FieldName: string): variant;
   function ExecuteSearch(Search: TCosmosSearch; Params: Olevariant; Target: TDataset): boolean; overload;
   function ExecuteSearch(const Search: TCosmosSearch; Params: Olevariant): boolean; overload;

   property Dataset: TDataset read GetDataset;

  public
    { Public declarations }
    property ICosmosApp: ICosmosApplication read FICosmosApp;
  end;

var
  FrmPesquisarInscritos: TFrmPesquisarInscritos;

implementation

{$R *.dfm}

function TFrmPesquisarInscritos.ExecuteSearch(Search: TCosmosSearch;
  Params: Olevariant; Target: TDataset): boolean;
var
I: integer;
TargetField: TField;
begin
 Result := ShowModal = mrOk;
 if Result then
  begin
   if Target.Active then
    begin
     for I := 0 to Pred(CdsSearch.Fields.Count) do
      begin
       TargetField := Target.FindField(CdsSearch.Fields.Fields[I].FieldName);
       if  TargetField <> nil then
        begin
         Target.Edit;
         TargetField.Value := CdsSearch.Fields.Fields[I].Value;
        end;
      end;
    end;
  end;
end;

procedure TFrmPesquisarInscritos.ActCancelExecute(Sender: TObject);
begin
 ModalResult := mrCancel;
end;

procedure TFrmPesquisarInscritos.ActSelectExecute(Sender: TObject);
begin
 ModalResult := mrOk;
end;

procedure TFrmPesquisarInscritos.ActSelectUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := (CdsSearch.Active) and not (CdsSearch.IsEmpty);
end;

procedure TFrmPesquisarInscritos.CdsSearchAfterOpen(DataSet: TDataSet);
begin
 ICosmosApp.IRemoteCon.LoadFieldsInfo(Dataset);
end;

function TFrmPesquisarInscritos.ExecuteSearch(const Search: TCosmosSearch;
  Params: Olevariant): boolean;
begin
  Result := ShowModal = mrOk;
end;

procedure TFrmPesquisarInscritos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 if ICosmosApp <> nil then
  FICosmosApp := nil;
end;

procedure TFrmPesquisarInscritos.FormCreate(Sender: TObject);
var
 IConferencia: ICosmosConference;
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;
 FmeSearchConferencia.CosmosSearch := csFocosConferencias;

 FmeSearchConferencia.OnSelectData := self.UpdateDate;

 IConferencia := Application.MainForm as ICosmosConference;
 if (IConferencia <> nil) and(IConferencia.ActiveConference <> nil) then
  begin
   FmeSearchConferencia.CosmosData.WriteValue('CODCON', IConferencia.ActiveConference.ConferenceID);
   FmeSearchConferencia.CosmosData.WriteValue('NOMCON', IConferencia.ActiveConference.ConferenceName);
   FmeSearchConferencia.EdtSearch.Text := IConferencia.ActiveConference.ConferenceName;
  end;
end;

function TFrmPesquisarInscritos.GetDataset: TDataset;
begin
 Result := CdsSearch;
end;

function TFrmPesquisarInscritos.GetValue(const FieldName: string): variant;
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

procedure TFrmPesquisarInscritos.UpdateDate(Sender: TObject);
var
AParams: TCosmosData;
begin
 AParams := TCosmosData.Create(1);

 try
  AParams.WriteValue('CODCON', FmeSearchConferencia.ReadValue('CODCON'));
  ICosmosApp.IRemoteCon.ExecuteDQL(csReportInscritosConferencia, AParams.Data, CdsSearch);

 finally
  if Assigned(AParams) then
   FreeAndNil(AParams);
 end;
end;

initialization
 RegisterClass(TFrmPesquisarInscritos);

finalization
 UnRegisterClass(TFrmPesquisarInscritos);

end.
