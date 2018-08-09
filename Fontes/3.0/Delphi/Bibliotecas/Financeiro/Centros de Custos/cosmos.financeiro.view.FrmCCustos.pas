unit cosmos.financeiro.view.FrmCCustos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cosmos.framework.view.FrmDocked, ActnList, ImgList, cosmos.system.messages,
  cosmos.frames.gridsearch, Datasnap.DSConnect, Cosmos.Framework.Interfaces.Dataacess,
  ToolWin, ActnMan, ActnCtrls, DB, DBClient, XPStyleActnCtrls, Menus, ActnPopup,
  PlatformDefaultStyleActnCtrls, cosmos.framework.datanavigators.datasets,
  System.Actions, cosmos.system.formsconst;

type
  TFrmCentroCustos = class(TFrmCosmosDocked)
    FmeGridSearch1: TFmeGridSearch;
    ActionToolBar1: TActionToolBar;
    ActCentroCusto: TAction;
    CdsCentrosCusto: TClientDataSet;
    DsrCentrosCusto: TDataSource;
    ActionManager1: TActionManager;
    ActSearchBar: TAction;
    ActEditCentroCusto: TAction;
    ActDelCentroCusto: TAction;
    PopupActionBar1: TPopupActionBar;
    NovoCentrodeCusto1: TMenuItem;
    AlterarCentrodeCusto1: TMenuItem;
    ExcluirCentrodeCusto1: TMenuItem;
    procedure FmeGridSearch1DBGrid1DblClick(Sender: TObject);
    procedure ActCentroCustoExecute(Sender: TObject);
    procedure ActDelCentroCustoExecute(Sender: TObject);
    procedure ActEditCentroCustoUpdate(Sender: TObject);
    procedure ActEditCentroCustoExecute(Sender: TObject);
    procedure ActSearchBarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PopupActionBar1Popup(Sender: TObject);
  private
    { Private declarations }
    FRemoteConnection: TDSProviderConnection;
    FDataNavigator: TDatasetDataNavigator;
    procedure UpdateData(Sender: TObject);


  protected
    function GetFormDescription: string; override;
    function GetFormIDName: string; override;
    function GetHelpFile: string; override;
    function GetHelpID: integer; override;
    function GetTitle: string; override;
    procedure Locate; override;
    procedure ExportData; override;
    procedure UpdateVisualElements; override;


    property FormDescription: string read GetFormDescription;
    property HelpFile: string read GetHelpFile;
    property HelpID: integer read GetHelpID;
    property FormIDName: string read GetFormIDName;
    property Title: string read GetTitle;    

  public
    { Public declarations }
  end;

var
  FrmCentroCustos: TFrmCentroCustos;

implementation

uses cosmos.financeiro.view.FrmEditCentroCusto;

{$R *.dfm}

{ TFrmCentroCustos }

procedure TFrmCentroCustos.ActCentroCustoExecute(Sender: TObject);
begin
  inherited;
  FrmEditCentroCusto := TFrmEditCentroCusto.Create(Application);

  try
   FrmEditCentroCusto.NovoCentro;

  finally
   if Assigned(FrmEditCentroCusto) then
    FreeAndNil(FrmEditCentroCusto);
  end;
end;

procedure TFrmCentroCustos.ActDelCentroCustoExecute(Sender: TObject);
begin
  inherited;
//
end;

procedure TFrmCentroCustos.ActEditCentroCustoExecute(Sender: TObject);
begin
  inherited;
  FrmEditCentroCusto := TFrmEditCentroCusto.Create(Application);

  try
   FrmEditCentroCusto.EditarCentro(CdsCentrosCusto.Fields.FieldByName('codcen').Value);

  finally
   if Assigned(FrmEditCentroCusto) then
    FreeAndNil(FrmEditCentroCusto);
  end;
end;

procedure TFrmCentroCustos.ActEditCentroCustoUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (CdsCentrosCusto.Active) and not (CdsCentrosCusto.IsEmpty);
end;

procedure TFrmCentroCustos.ActSearchBarExecute(Sender: TObject);
begin
  inherited;
  FmeGridSearch1.ShowSearchBar := TAction(Sender).Checked;
end;

procedure TFrmCentroCustos.ExportData;
begin
  inherited;
 IRemoteCon.DefaultExport(CdsCentrosCusto);
end;

procedure TFrmCentroCustos.FmeGridSearch1DBGrid1DblClick(Sender: TObject);
begin
  inherited;
  if ActEditCentroCusto.Enabled then
   ActEditCentroCusto.Execute;
end;

procedure TFrmCentroCustos.FormActivate(Sender: TObject);
begin
  inherited;
  IRemoteCon.ActiveDataset := CdsCentrosCusto;
end;

procedure TFrmCentroCustos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Assigned(IRemoteCon) then
   IRemoteCon.DropConnection(FRemoteConnection);

  if Assigned(FDataNavigator) then
   FreeAndNil(FDataNavigator);
end;

procedure TFrmCentroCustos.FormCreate(Sender: TObject);
begin
  inherited;
  FRemoteConnection := IRemoteCon.CreateConnection(scFinanceiro);
  CdsCentrosCusto.RemoteServer := FRemoteConnection;
  FmeGridSearch1.SearchFields := 'nomcen';

  FDataNavigator := TDatasetDataNavigator.Create(CdsCentrosCusto);
  DataNavigator := FDataNavigator;
  TDatasetDataNavigator(DataNavigator).OnUpdateData := UpdateData;

  CdsCentrosCusto.Open;
end;

function TFrmCentroCustos.GetFormDescription: string;
begin
Result := TDockedFormDesc.FormCentroCustos;
end;

function TFrmCentroCustos.GetFormIDName: string;
begin
Result := 'Financeiro.CentroCustos';
end;

function TFrmCentroCustos.GetHelpFile: string;
begin
 Result := Self.HelpFile;
end;

function TFrmCentroCustos.GetHelpID: integer;
begin
 Result := HelpContext;
end;

function TFrmCentroCustos.GetTitle: string;
begin
 Result := Caption;
end;

procedure TFrmCentroCustos.Locate;
begin
  inherited;
  IRemoteCon.DefaultLocate;
end;

procedure TFrmCentroCustos.PopupActionBar1Popup(Sender: TObject);
begin
  inherited;
  TPopupActionBar(Sender).Style := ICosmosApp.InterfaceStyle;
end;

procedure TFrmCentroCustos.UpdateData(Sender: TObject);
begin
  inherited;
  CdsCentrosCusto.Refresh;
end;

procedure TFrmCentroCustos.UpdateVisualElements;
begin
  inherited;
 ActionManager1.Style := ICosmosApp.InterfaceStyle;
end;

initialization
 RegisterClass(TFrmCentroCustos);

finalization
 UnRegisterClass(TFrmCentroCustos);

end.
