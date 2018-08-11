unit FormTransacoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cosmos.framework.view.FrmDocked, ActnList, ImgList, cosmos.system.messages,
  DB, DBClient, Menus, ActnPopup, XPStyleActnCtrls, ActnMan, ToolWin, ActnCtrls,
  PlatformDefaultStyleActnCtrls, cosmos.framework.datanavigators.datasets,
  System.Actions, cosmos.frames.gridsearch, Datasnap.DSConnect,
  Cosmos.Framework.Interfaces.Dataacess, cosmos.system.formsconst;

type
  TFrmTransacoes = class(TFrmCosmosDocked)
    FmeGridSearch1: TFmeGridSearch;
    CdsTransacoes: TClientDataSet;
    DsrTransacoes: TDataSource;
    ActNovaTransacao: TAction;
    ActEditarTransacao: TAction;
    ActParcelas: TAction;
    ActionManager1: TActionManager;
    PopupActionBar1: TPopupActionBar;
    NovaTransao1: TMenuItem;
    EditarTransao1: TMenuItem;
    Parcelas1: TMenuItem;
    ActionToolBar1: TActionToolBar;
    procedure ActParcelasExecute(Sender: TObject);
    procedure ActEditarTransacaoUpdate(Sender: TObject);
    procedure ActEditarTransacaoExecute(Sender: TObject);
    procedure ActNovaTransacaoExecute(Sender: TObject);
    procedure PopupActionBar1GetControlClass(Sender: TCustomActionBar;
      AnItem: TActionClient; var ControlClass: TCustomActionControlClass);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
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
  FrmTransacoes: TFrmTransacoes;

implementation

{$R *.dfm}

{ TFrmTransacoes }

procedure TFrmTransacoes.ActEditarTransacaoExecute(Sender: TObject);
begin
  inherited;
  //
end;

procedure TFrmTransacoes.ActEditarTransacaoUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (CdsTransacoes.Active) and not (CdsTransacoes.IsEmpty);
end;

procedure TFrmTransacoes.ActNovaTransacaoExecute(Sender: TObject);
begin
  inherited;
  //
end;

procedure TFrmTransacoes.ActParcelasExecute(Sender: TObject);
begin
  inherited;
  //
end;

procedure TFrmTransacoes.ExportData;
begin
  inherited;
 IRemoteCon.DefaultExport(CdsTransacoes);
end;

procedure TFrmTransacoes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Assigned(IRemoteCon) then
   IRemoteCon.DropConnection(FRemoteConnection);

  if Assigned(FDataNavigator) then
   FreeAndNil(FDataNavigator);
end;

procedure TFrmTransacoes.FormCreate(Sender: TObject);
begin
  inherited;
  FRemoteConnection := IRemoteCon.CreateConnection(scFinanceiro);
  CdsTransacoes.RemoteServer := FRemoteConnection;
  CdsTransacoes.Params.Items[0].AsInteger := ICosmosApp.ActiveFocus.FocusID;
  CdsTransacoes.Open;

  FDataNavigator := TDatasetDataNavigator.Create(CdsTransacoes);
  DataNavigator := FDataNavigator;
  TDatasetDataNavigator(DataNavigator).OnUpdateData := UpdateData;
end;

function TFrmTransacoes.GetFormDescription: string;
begin
 Result := TDockedFormDesc.FormTransacoes;
end;

function TFrmTransacoes.GetFormIDName: string;
begin
 Result := 'Financeiro.Transacoes';
end;

function TFrmTransacoes.GetHelpFile: string;
begin
 Result := Application.CurrentHelpFile;
end;

function TFrmTransacoes.GetHelpID: integer;
begin
 Result := Self.HelpContext;
end;

function TFrmTransacoes.GetTitle: string;
begin
 Result := Self.Caption;
end;

procedure TFrmTransacoes.Locate;
begin
  inherited;
  IRemoteCon.DefaultLocate;
end;

procedure TFrmTransacoes.PopupActionBar1GetControlClass(
  Sender: TCustomActionBar; AnItem: TActionClient;
  var ControlClass: TCustomActionControlClass);
begin
  inherited;
  if ICosmosApp.StyleControlClass <> nil then
   ControlClass := ICosmosApp.StyleControlClass;
end;

procedure TFrmTransacoes.UpdateData(Sender: TObject);
begin
 CdsTransacoes.Refresh;
end;

procedure TFrmTransacoes.UpdateVisualElements;
begin
  inherited;
 ActionManager1.Style := ICosmosApp.InterfaceStyle;
end;

initialization
 RegisterClass(TFrmTransacoes);

finalization
 UnRegisterClass(TFrmTransacoes);
end.
