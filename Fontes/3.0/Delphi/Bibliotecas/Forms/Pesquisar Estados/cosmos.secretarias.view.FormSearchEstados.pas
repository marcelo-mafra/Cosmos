unit cosmos.secretarias.view.FormSearchEstados;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FormDefaultSearchs, ImgList, ActnList, DB, DBClient, StdCtrls,
  Buttons, ExtCtrls, Cosmos.Framework.Interfaces.Dialogs, cosmos.frames.gridsearch,
  GroupHeader, cosmos.system.messages, cosmos.classes.application,
  cosmos.frames.searchdata, cosmos.Framework.Interfaces.Root,
  cosmos.classes.ServerInterface, System.Actions;

type
  TFrmSearch = class(TFrmDefaultSearchs, ISearchLocais) //TFrmCosmosSearch
    MSGroupHeader2: TMSGroupHeader;
    FmeGridSearch1: TFmeGridSearch;
    MSGroupHeader1: TMSGroupHeader;
    Label1: TLabel;
    FmeSearchData: TFmeSearchData;
    DsrData: TDataSource;
    procedure FmeGridSearch1DBGrid1DblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FmeSearchDataSbnButtonClick(Sender: TObject);
    procedure CdsDataAfterOpen(DataSet: TDataSet);

  private
    { Private declarations }
    CdsSearchData: TClientDataset;
    procedure SelectData(Sender: TObject);

  protected
    function GetDataset: TDataset;
    function GetValue(const FieldName: string): variant;

    function Execute(CosmosSearch: TCosmosSearch): boolean;
    property Dataset: TDataset read GetDataset;    

  public
    { Public declarations }
    function GetWindowsId: string; override;

  end;

var
  FrmSearch: TFrmSearch;

implementation

{$R *.dfm}

procedure TFrmSearch.CdsDataAfterOpen(DataSet: TDataSet);
begin
  inherited;
  ICosmosApp.IRemoteCon.LoadFieldsInfo(Dataset);
end;

function TFrmSearch.Execute(CosmosSearch: TCosmosSearch): boolean;
begin
 case CosmosSearch of
  csPaises:
   begin
    Caption := TCosmosSearchsInfo.SearchPaises;
    Label1.Caption := TCosmosSearchsInfo.SearchPaises;
   end;
  csEstados:
   begin
    Caption := TCosmosSearchsInfo.SearchEstados;
    Label1.Caption := TCosmosSearchsInfo.SearchEstados;
   end;
  csCidades:
   begin
    Caption := TCosmosSearchsInfo.SearchCidades;
    Label1.Caption := TCosmosSearchsInfo.SearchCidades;
   end;
  csBairros:
   begin
    Caption := TCosmosSearchsInfo.SearchBairros;
    Label1.Caption := TCosmosSearchsInfo.SearchBairros;
   end;
 end;

 self.FmeSearchData.CosmosSearch := CosmosSearch;
 Result := ShowModal = mrOk;
end;

procedure TFrmSearch.FmeGridSearch1DBGrid1DblClick(Sender: TObject);
begin
  inherited;
  if ActiveDataset <> nil then
   begin
    if (ActiveDataset.Active) and not (ActiveDataset.IsEmpty) then
     ActSelect.Execute;
   end;
end;

procedure TFrmSearch.FmeSearchDataSbnButtonClick(Sender: TObject);
begin
  inherited;
  FmeSearchData.SbnButtonClick(Sender);

end;

procedure TFrmSearch.FormCreate(Sender: TObject);
begin
  inherited;
 FmeSearchData.CanEdit := True;
 FmeSearchData.OnSelectData := SelectData;
end;

function TFrmSearch.GetDataset: TDataset;
begin
 Result := ActiveDataset;
end;

function TFrmSearch.GetValue(const FieldName: string): variant;
begin
 if (ActiveDataset <> nil) and (ActiveDataset.Active) then
  begin
    if ActiveDataset.FindField(FieldName) <> nil then
     Result := ActiveDataset.Fields.FieldByName(FieldName).Value
    else
     Result := unassigned;
  end
 else
  Result := unassigned;
end;

function TFrmSearch.GetWindowsId: string;
begin
 Result := '{F17E6BCF-8AA9-4B1D-9811-63DF3F3B010A}';
end;

procedure TFrmSearch.SelectData(Sender: TObject);
var
AParams: TCosmosData;
begin

 try
 if FmeSearchData.CosmosData <> nil then
  begin
   if Assigned(CdsSearchData) then FreeAndNil(CdsSearchData);
   CdsSearchData := TClientDataset.Create(self);
   CdsSearchData.DisableControls;

   AParams := TCosmosData.Create(1);
   AParams.WriteValue('NOME', QuotedStr(self.FmeSearchData.ControlValue));

   case self.FmeSearchData.CosmosSearch of
    csPaises: ICosmosApp.IRemoteCon.ExecuteDQL(csPaises, AParams.Data, CdsSearchData);
    csEstados: ICosmosApp.IRemoteCon.ExecuteDQL(csEstados, AParams.Data, CdsSearchData);
    csCidades: ICosmosApp.IRemoteCon.ExecuteDQL(csCidades, AParams.Data, CdsSearchData);
    csBairros: ICosmosApp.IRemoteCon.ExecuteDQL(csBairros, AParams.Data, CdsSearchData);
   end;
  end;

 finally
  DsrData.DataSet := CdsSearchData;
  CdsSearchData.EnableControls;
  ActiveDataset := CdsSearchData;
 end;
end;

initialization
 RegisterClass(TFrmSearch);

finalization
 UnRegisterClass(TFrmSearch);

end.
