unit cosmos.conferencias.view.FormClassificadores;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cosmos.framework.view.FrmDocked, ActnList, ImgList, DB, DBClient, cosmos.frames.gridsearch,
  ToolWin, ActnMan, ActnCtrls, PlatformDefaultStyleActnCtrls, Menus, ActnPopup,
  cosmos.classes.application, cosmos.system.messages, cosmos.framework.datanavigators.datasets,
  System.Actions, Data.DBXCommon, Datasnap.DSConnect, cosmos.classes.security,
  cosmos.framework.interfaces.dataacess, cosmos.system.formsconst;

type
  TFrmClassificadores = class(TFrmCosmosDocked)
    CdsClassificadores: TClientDataSet;
    ActionManager1: TActionManager;
    ActionToolBar1: TActionToolBar;
    FmeGridSearch1: TFmeGridSearch;
    ActNovoClassificador: TAction;
    ActEditarClassificador: TAction;
    ActDelClassificador: TAction;
    DsrClassificadores: TDataSource;
    PopupActionBar1: TPopupActionBar;
    NovoClassificador1: TMenuItem;
    AlterarClassificador1: TMenuItem;
    ExcluirClassificador1: TMenuItem;
    ActLocate: TAction;
    procedure FormCreate(Sender: TObject);
    procedure ActNovoClassificadorExecute(Sender: TObject);
    procedure ActEditarClassificadorExecute(Sender: TObject);
    procedure ActEditarClassificadorUpdate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ActDelClassificadorExecute(Sender: TObject);
    procedure PopupActionBar1Popup(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ActLocateExecute(Sender: TObject);
    procedure ActLocateUpdate(Sender: TObject);
    procedure ActNovoClassificadorUpdate(Sender: TObject);
    procedure ActDelClassificadorUpdate(Sender: TObject);
  private
    { Private declarations }
    FDataNavigator: TDatasetDataNavigator;
    FRemoteConnection: TDSProviderConnection;
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
  FrmClassificadores: TFrmClassificadores;

implementation

uses cosmos.conferencias.view.FormEditarClassificadores;

{$R *.dfm}

procedure TFrmClassificadores.ActDelClassificadorExecute(Sender: TObject);
var
codatr: integer;
ACommand: TDBXCommand;
begin
  inherited;
  if not self.CdsClassificadores.Active then
   Exit;

  if self.CdsClassificadores.IsEmpty then
   Exit;

  ACommand := IRemoteCon.CreateCommand;
  codatr := self.CdsClassificadores.FieldValues['codatr'];

  try
   ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
   ACommand.Text := 'TDMCosmosApplicationServer.DeleteAttribute'; //do not localize!
   ACommand.Prepare;

   ACommand.Parameters[0].Value.SetInt32(codatr);
   ACommand.ExecuteUpdate;

   ICosmosApp.MainLog.RegisterRemoteCallSucess(Format(TCosmosLogs.ExecutedRemoteCommand, [ACommand.Text]), ICosmosApp.IRemoteCon.ConnectionParamsInfo);

   case ACommand.Parameters[1].Value.GetInt32 of
    0: self.CdsClassificadores.Refresh;
    1: ICosmosApp.DlgMessage.InfoMessage(TCosmosTitles.Classificadores, TCosmosInfoMsg.CantDeleteClassificador);
   end;

   ACommand.Free;

 except
  on E: Exception do
   begin
    ICosmosApp.MainLog.RegisterRemoteCallFailure(Format(TCosmosLogs.ExecutedRemoteCommandFail, [ACommand.Text]), ICosmosApp.IRemoteCon.ConnectionParamsInfo);
    if Assigned(ACommand) then FreeAndNil(ACommand);
   end;
 end;
end;

procedure TFrmClassificadores.ActDelClassificadorUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (Assigned(IRemoteCon)) and (IRemoteCon.Connected)
   and (CdsClassificadores.Active) and not (CdsClassificadores.IsEmpty)
   and (nfExcluirClassificador in IRemoteCon.CurrentConnectionInfo.ConferenciasFeatures)
   and (ICosmosApp.IRemoteCon.CurrentConnectionMode = cmWrite);
end;

procedure TFrmClassificadores.ActEditarClassificadorExecute(Sender: TObject);
var
codatr: integer;
begin
  inherited;
  if not self.CdsClassificadores.Active then
   Exit;

  if self.CdsClassificadores.IsEmpty then
   Exit;

  codatr := self.CdsClassificadores.Fields.FieldByName('codatr').AsInteger;

  if not Assigned(FrmEditarClassificadores) then
   FrmEditarClassificadores := TFrmEditarClassificadores.Create(self);

  try
   FrmEditarClassificadores.EditarClassificador(codatr);

  finally
   if Assigned(FrmEditarClassificadores) then
    FreeAndNil(FrmEditarClassificadores);
  end;
end;

procedure TFrmClassificadores.ActEditarClassificadorUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (Assigned(IRemoteCon)) and (IRemoteCon.Connected)
   and (CdsClassificadores.Active) and not (CdsClassificadores.IsEmpty)
   and (nfAlterarClassificador in IRemoteCon.CurrentConnectionInfo.ConferenciasFeatures)
   and (ICosmosApp.IRemoteCon.CurrentConnectionMode = cmWrite);
end;

procedure TFrmClassificadores.ActLocateExecute(Sender: TObject);
begin
  inherited;
  self.Locate;
end;

procedure TFrmClassificadores.ActLocateUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (CdsClassificadores.Active) and not (CdsClassificadores.IsEmpty);
end;

procedure TFrmClassificadores.ActNovoClassificadorExecute(Sender: TObject);
begin
  inherited;
  if not Assigned(FrmEditarClassificadores) then
   FrmEditarClassificadores := TFrmEditarClassificadores.Create(self);

  try
   FrmEditarClassificadores.NovoClassificador;

  finally
   if Assigned(FrmEditarClassificadores) then
    FreeAndNil(FrmEditarClassificadores);
  end;
end;

procedure TFrmClassificadores.ActNovoClassificadorUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (Assigned(IRemoteCon)) and (IRemoteCon.Connected)
   and (CdsClassificadores.Active)
   and (nfNovoClassificador in IRemoteCon.CurrentConnectionInfo.ConferenciasFeatures)
   and (ICosmosApp.IRemoteCon.CurrentConnectionMode = cmWrite);
end;

procedure TFrmClassificadores.ExportData;
begin
  inherited;
  IRemoteCon.DefaultExport(CdsClassificadores);
end;

procedure TFrmClassificadores.FormActivate(Sender: TObject);
begin
  inherited;
  IRemoteCon.ActiveDataset := CdsClassificadores;
end;

procedure TFrmClassificadores.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if CdsClassificadores.Active then CdsClassificadores.Close;
  CdsClassificadores.RemoteServer := nil;

 if Assigned(FRemoteConnection) then
  ICosmosApp.IRemoteCon.DropConnection(FRemoteConnection);

  inherited;

  if Assigned(FDataNavigator) then FreeAndNil(FDataNavigator);
end;

procedure TFrmClassificadores.FormCreate(Sender: TObject);
begin
  inherited;
  FRemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scConferencias);
  CdsClassificadores.RemoteServer := FRemoteConnection;

  FDataNavigator := TDatasetDataNavigator.Create(self.CdsClassificadores);
  DataNavigator := FDataNavigator;
  TDatasetDataNavigator(DataNavigator).OnUpdateData := UpdateData;

  CdsClassificadores.Open;

  self.ActionManager1.Style := ICosmosApp.InterfaceStyle;
  self.FmeGridSearch1.SearchFields := 'SIGATR';
end;

function TFrmClassificadores.GetFormDescription: string;
begin
 Result := TDockedFormDesc.FormClassificadores;
end;

function TFrmClassificadores.GetFormIDName: string;
begin
 Result := 'Conferencias.Classificadores';
end;

function TFrmClassificadores.GetHelpFile: string;
begin
 Result := HelpFile;
end;

function TFrmClassificadores.GetHelpID: integer;
begin

end;

function TFrmClassificadores.GetTitle: string;
begin
 Result := self.Caption;
end;

procedure TFrmClassificadores.Locate;
begin
  inherited;
  IRemoteCon.DefaultLocate;
end;

procedure TFrmClassificadores.PopupActionBar1Popup(Sender: TObject);
begin
  inherited;
 TPopupActionBar(Sender).Style := ICosmosApp.InterfaceStyle;
end;

procedure TFrmClassificadores.UpdateData(Sender: TObject);
begin
  inherited;
  self.CdsClassificadores.Refresh;
end;

procedure TFrmClassificadores.UpdateVisualElements;
begin
  inherited;
  ActionManager1.Style := ICosmosApp.InterfaceStyle;
end;

initialization
 RegisterClass(TFrmClassificadores);

finalization
 UnRegisterClass(TFrmClassificadores);

end.
