unit cosmos.secretarias.view.FormAlocucoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cosmos.framework.view.FrmDocked, ActnList, ImgList, DB, DBClient, Grids, DBGrids,
  Menus, ActnPopup, Cosmos.Framework.Interfaces.Dialogs, cosmos.frames.gridsearch,
  ActnMan, cosmos.classes.application, cosmos.system.messages, cosmos.classes.security,
  PlatformDefaultStyleActnCtrls, cosmos.framework.datanavigators.datasets,
  cosmos.Framework.forms.wizards, System.Actions, Datasnap.DSConnect,
  Cosmos.Framework.Interfaces.DataAcess, cosmos.system.formsconst;


type
  TFrmAlocucoes = class(TFrmCosmosDocked)
    CdsAlocucoes: TClientDataSet;
    DsrAlocucoes: TDataSource;
    ActNewAloc: TAction;
    ActSearch: TAction;
    ActEditAloc: TAction;
    ActionList2: TActionList;
    ActAlocucoesRecentes: TAction;
    PopupActionBar1: TPopupActionBar;
    ActAssuntos: TAction;
    ActNovasAlocucoes: TAction;
    ActAlocucoesIneditas: TAction;
    NovaAlocuo1: TMenuItem;
    AlterarAlocuo1: TMenuItem;
    Assuntos1: TMenuItem;
    Pesquisas1: TMenuItem;
    Pesquisar2: TMenuItem;
    AlocuesRecentes1: TMenuItem;
    AlocuesInditas2: TMenuItem;
    NovasAlocues2: TMenuItem;
    N2: TMenuItem;
    N1: TMenuItem;
    FmeGridSearch1: TFmeGridSearch;
    procedure ActAlocucoesIneditasExecute(Sender: TObject);
    procedure ActAssuntosExecute(Sender: TObject);
    procedure ActAlocucoesRecentesExecute(Sender: TObject);
    procedure ActSearchExecute(Sender: TObject);
    procedure ActEditAlocUpdate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ActEditAlocExecute(Sender: TObject);
    procedure ActNewAlocExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PopupActionBar1Popup(Sender: TObject);
    procedure ActNewAlocUpdate(Sender: TObject);
    procedure ActSearchUpdate(Sender: TObject);
  private
    { Private declarations }
    ARemoteConnection: TDSProviderConnection;
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
  FrmAlocucoes: TFrmAlocucoes;

implementation

uses cosmos.secretarias.view.FormEditarAlocucoes, cosmos.secretarias.view.FormSearchAlocucoes,
 cosmos.secretarias.view.FormEditarAssuntos;

{$R *.dfm}

procedure TFrmAlocucoes.ActAssuntosExecute(Sender: TObject);
begin
  inherited;
  if not CdsAlocucoes.IsEmpty then
   begin
    try
     if not Assigned(FrmEditAssuntos) then
      FrmEditAssuntos := TFrmEditAssuntos.Create(self);

     FrmEditAssuntos.EditarAssuntos(CdsAlocucoes.Fields.FieldByName('codalo').AsInteger);

    finally
     if Assigned(FrmEditAssuntos) then
     FreeAndNil(FrmEditAssuntos);
    end;
   end;
end;

procedure TFrmAlocucoes.ActEditAlocExecute(Sender: TObject);
begin
  inherited;
  if not CdsAlocucoes.IsEmpty then
   begin
    try
     if not Assigned(FrmEditarAlocucoes) then
      FrmEditarAlocucoes := TFrmEditarAlocucoes.Create(self);
     FrmEditarAlocucoes.EditarAlocucao(CdsAlocucoes.Fields.FieldByName('codalo').AsInteger);

    finally
     if Assigned(FrmEditarAlocucoes) then
     FreeAndNil(FrmEditarAlocucoes);
    end;
   end;
end;

procedure TFrmAlocucoes.ActEditAlocUpdate(Sender: TObject);
begin
  inherited;
 TAction(Sender).Enabled := (CdsAlocucoes.Active) and not (CdsAlocucoes.IsEmpty);
end;

procedure TFrmAlocucoes.ActAlocucoesIneditasExecute(Sender: TObject);
var
AReturn: TServerReturn;
begin
  inherited;
{  AReturn := TServerReturn.Create;

  try
   AReturn.ReadServerReturn(IRemoteCon.ConnectionBroker.AppServer.SearchAlocucoes(2,null, False, False, False, False));
   if AReturn.MessageType = mtpSucess then
    CdsAlocucoes.Data := AReturn.ServerData
   else
    ICosmosApp.DlgMessage.Execute(AReturn);

  finally
   if Assigned(AReturn) then
    AReturn.Free;
  end;}
end;

procedure TFrmAlocucoes.ActAlocucoesRecentesExecute(Sender: TObject);
var
AReturn: TServerReturn;
begin
  inherited;
 { AReturn := TServerReturn.Create;

  try
   AReturn.ReadServerReturn(IRemoteCon.ConnectionBroker.AppServer.SearchAlocucoes(1,null, False, False, False, False));
   if AReturn.MessageType = mtpSucess then
    CdsAlocucoes.Data := AReturn.ServerData
   else
    ICosmosApp.DlgMessage.Execute(AReturn);

  finally
   if Assigned(AReturn) then
    AReturn.Free;
  end; }
end;

procedure TFrmAlocucoes.ActNewAlocExecute(Sender: TObject);
begin
  TCosmosWizardsDialogs.ExecuteWizard('waloc.bpl','TFrmWzNovaAlocucao');
end;

procedure TFrmAlocucoes.ActNewAlocUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := False;
end;

procedure TFrmAlocucoes.ActSearchExecute(Sender: TObject);
begin
  inherited;
 try
  if not Assigned(FrmSearchAlocucoes) then
   FrmSearchAlocucoes := TFrmSearchAlocucoes.Create(self);
  FrmSearchAlocucoes.ExecuteSearch(CdsAlocucoes);
//  FrmSearchAlocucoes.ShowModal;

 finally
  if Assigned(FrmSearchAlocucoes) then
   FreeAndNil(FrmSearchAlocucoes);
 end;
end;

procedure TFrmAlocucoes.ActSearchUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := False;
end;

procedure TFrmAlocucoes.ExportData;
begin
  inherited;
 IRemoteCon.DefaultExport(CdsAlocucoes);
end;

procedure TFrmAlocucoes.FormActivate(Sender: TObject);
begin
  inherited;
  IRemoteCon.ActiveDataset := CdsAlocucoes;
end;

procedure TFrmAlocucoes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if Assigned(IRemoteCon) and Assigned(ARemoteConnection) then
  ICosmosApp.IRemoteCon.DropConnection(ARemoteConnection);

  if Assigned(FDataNavigator) then
   FreeAndNil(FDataNavigator);

  inherited;

  Action := caFree;
  FrmAlocucoes := nil;
end;

procedure TFrmAlocucoes.FormCreate(Sender: TObject);
begin
  inherited;
  ARemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scAtividades);
  CdsAlocucoes.RemoteServer := ARemoteConnection;

  FDataNavigator := TDatasetDataNavigator.Create(CdsAlocucoes);
  DataNavigator := FDataNavigator;
  TDatasetDataNavigator(DataNavigator).OnUpdateData := UpdateData;

 CdsAlocucoes.Open;
end;

function TFrmAlocucoes.GetFormDescription: string;
begin
 Result := TDockedFormDesc.FormAlocucoes;
end;

function TFrmAlocucoes.GetFormIDName: string;
begin
 Result := 'Secretarias.Alocucoes';
end;

function TFrmAlocucoes.GetHelpFile: string;
begin
 Result := HelpFile;
end;

function TFrmAlocucoes.GetHelpID: integer;
begin

end;

function TFrmAlocucoes.GetTitle: string;
begin
 Result := 'Alocuções';
end;

procedure TFrmAlocucoes.Locate;
begin
 inherited;
 IRemoteCon.DefaultLocate;
end;

procedure TFrmAlocucoes.PopupActionBar1Popup(Sender: TObject);
begin
  inherited;
  TPopupActionBar(Sender).Style := ICosmosApp.InterfaceStyle;
end;

procedure TFrmAlocucoes.UpdateData(Sender: TObject);
begin
  inherited;
  CdsAlocucoes.Refresh;
end;

procedure TFrmAlocucoes.UpdateVisualElements;
begin
  inherited;
 //Implementar quando houverem controes sujeitos a style de ActionsManager.
end;

initialization
 RegisterClass(TFrmAlocucoes);

finalization
 UnRegisterClass(TFrmAlocucoes);

end.
