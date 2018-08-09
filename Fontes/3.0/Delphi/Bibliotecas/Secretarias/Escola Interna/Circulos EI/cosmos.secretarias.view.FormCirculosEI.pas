unit cosmos.secretarias.view.FormCirculosEI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cosmos.framework.view.FrmDocked, ActnList, ImgList, DB, DBClient, ExtCtrls, StdCtrls,
  Cosmos.Framework.Interfaces.Root, Cosmos.Framework.Interfaces.Dialogs,
  cosmos.system.messages, ActnMan, Menus, ActnPopup, cosmos.frames.gridsearch,Tabs,
  DockTabSet, XPStyleActnCtrls, ToolWin, ActnCtrls, PlatformDefaultStyleActnCtrls,
  cosmos.classes.application, cosmos.framework.datanavigators.datasets,
  cosmos.Framework.forms.wizards, cosmos.classes.security, System.Actions,
  Datasnap.DSConnect, Cosmos.Framework.Interfaces.DataAcess,
  Cosmos.Framework.Interfaces.Applications, cosmos.system.formsconst;

type
  TFrmCirculosEI = class(TFrmCosmosDocked)
    ActNew: TAction;
    ActMembros: TAction;
    CdsCirculosEI: TClientDataSet;
    DsrCirculosEI: TDataSource;
    ActEditarCirculo: TAction;
    ActDeleteCirculo: TAction;
    PopupActionBar1: TPopupActionBar;
    NovoCrculo1: TMenuItem;
    DadosdoCrculo1: TMenuItem;
    Membros1: TMenuItem;
    DesativarCrculo1: TMenuItem;
    N1: TMenuItem;
    DockDisc: TDockTabSet;
    ActionToolBar1: TActionToolBar;
    ActionManager1: TActionManager;
    ActBarraPesquisa: TAction;
    ActFolhaPresenca: TAction;
    Documentos1: TMenuItem;
    N2: TMenuItem;
    FolhadePresena1: TMenuItem;
    FmeGridSearch1: TFmeGridSearch;
    CdsDiscipulados: TClientDataSet;
    procedure ActFolhaPresencaExecute(Sender: TObject);
    procedure ActDeleteCirculoExecute(Sender: TObject);
    procedure ActBarraPesquisaExecute(Sender: TObject);
    procedure DockDiscChange(Sender: TObject; NewTab: Integer;
      var AllowChange: Boolean);
    procedure ActEditarCirculoExecute(Sender: TObject);
    procedure ActMembrosUpdate(Sender: TObject);
    procedure ActMembrosExecute(Sender: TObject);
    procedure ActNewExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure PopupActionBar1Popup(Sender: TObject);
    procedure ActNewUpdate(Sender: TObject);
    procedure ActDeleteCirculoUpdate(Sender: TObject);
    procedure ActFolhaPresencaUpdate(Sender: TObject);
  private
    { Private declarations }
    FDiscipulado: integer;
    FDataNavigator: TDatasetDataNavigator;
    FRemoteConnection: TDSProviderConnection;

    procedure ListDiscipuladosEI;
    procedure ListarCirculos(const coddis: integer); inline;
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
  FrmCirculosEI: TFrmCirculosEI;

implementation

uses cosmos.secretarias.view.FormMembrosCirculo, cosmos.secretarias.view.FormDadosCirculo;

{$R *.dfm}

procedure TFrmCirculosEI.ActBarraPesquisaExecute(Sender: TObject);
begin
  inherited;
  FmegridSearch1.ShowSearchBar := TAction(Sender).Checked;
end;

procedure TFrmCirculosEI.ActDeleteCirculoExecute(Sender: TObject);
var
 CircleID: integer;
 ISecretarias: ICosmosSecretarias;
begin
  inherited;
  //Desativa o círculo selecionado
 if CdsCirculosEI.IsEmpty then
   Exit;

  if self.ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.CirculosEI, TCosmosConfMsg.DesativarCirculo) = mrYes then
   begin
    CircleID := CdsCirculosEI.Fields.FieldByName('codgru').AsInteger;
    ISecretarias := Application.MainForm as ICosmosSecretarias;

    try
     if ISecretarias.DesactivateCircle(CircleID) then
       IRemoteCon.ActiveDataset.Refresh;

    finally
      begin
       if Assigned(ISecretarias) then ISecretarias := nil;
      end;
    end;
   end;
end;

procedure TFrmCirculosEI.ActDeleteCirculoUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (CdsCirculosEI.Active)
    and not (CdsCirculosEI.IsEmpty)
    and (Assigned(IRemoteCon))
    and (IRemoteCon.CurrentConnectionMode = cmWrite)
    and (sfExcluirCirculoEI in IRemoteCon.CurrentConnectionInfo.SecretariasFeatures);
end;

procedure TFrmCirculosEI.ActEditarCirculoExecute(Sender: TObject);
begin
  inherited;
  if CdsCirculosEI.IsEmpty then
   Exit;
  try
    if not Assigned(FrmDadosCirculo) then
     FrmDadosCirculo := TFrmDadosCirculo.Create(self);
    FrmDadosCirculo.EditCirculo(CdsCirculosEI.Fields.FieldByName('codgru').AsInteger);

  finally
   if Assigned(FrmDadosCirculo) then
    FreeAndNil(FrmDadosCirculo);
  end;
end;

procedure TFrmCirculosEI.ActFolhaPresencaExecute(Sender: TObject);
var
  AModule: HModule;
  AForm: TForm;
  IRep: IReportCenter;
  aData: TCosmosData;
  Y, M, D: word;
begin
  //Imprime a folha de presença para o círculo selecionado
  inherited;
  aData := TCosmosData.Create(5);
  AForm := ICosmosApp.LoadDialog('repcen.bpl', 'TFrmReportCenter', AModule);

  try
   if (AModule <> 0) and (AForm <> nil) then
    begin
     with AForm do
      begin
       IRep := AForm as IReportCenter;
       if Assigned(IRep) then
        begin
         aData.WriteValue('CODGRU', CdsCirculosEI.Fields.FieldByName('codgru').Value);
         aData.WriteValue('NOMGRU', CdsCirculosEI.Fields.FieldByName('NOMGRU').Value, 1);
         aData.WriteValue('SIGDIS', CdsCirculosEI.Fields.FieldByName('SIGDIS').Value, 2);
         aData.WriteValue('NOMFOC', ICosmosApp.ActiveFocus.FocusName, 3);

         DecodeDate(IRemoteCon.ServerDateTime, Y, M, D);
         aData.WriteValue('ANO', Y, 4);

         IRep.PrintFolhaPresencaEI(aData);
        end;

       Free;
      end;
    end;

  finally
   if Assigned(IRep) then IRep := nil;
   if Assigned(aData) then FreeAndNil(aData);

   UnloadPackage(AModule);
  end;
end;

procedure TFrmCirculosEI.ActFolhaPresencaUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (CdsCirculosEI.Active) and not (CdsCirculosEI.IsEmpty);
end;

procedure TFrmCirculosEI.ActMembrosExecute(Sender: TObject);
begin
  inherited;
  if CdsCirculosEI.IsEmpty then
   Exit;  
  try
   if not Assigned(FrmMembrosCirculo) then
    FrmMembrosCirculo := TFrmMembrosCirculo.Create(self);
   FrmMembrosCirculo.ShowMembrosCirculo(CdsCirculosEI.Fields.FieldByName('codgru').AsInteger,
     CdsCirculosEI.Fields.FieldByName('nomgru').AsString);

  finally
   if Assigned(FrmMembrosCirculo) then
    FreeAndNil(FrmMembrosCirculo);
  end;
end;

procedure TFrmCirculosEI.ActMembrosUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (CdsCirculosEI.Active) and not (CdsCirculosEI.IsEmpty)
    and (Assigned(IRemoteCon)) and (IRemoteCon.CurrentConnectionMode = cmWrite)
    and (sfAlterarCirculoEI in IRemoteCon.CurrentConnectionInfo.SecretariasFeatures);
end;

procedure TFrmCirculosEI.ActNewExecute(Sender: TObject);
begin
  inherited;
  if TCosmosWizardsDialogs.ExecuteWizard('wnewcircle.bpl', 'TFrmWzNovoCirculoEI') then
   self.UpdateData(self);
end;

procedure TFrmCirculosEI.ActNewUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (Assigned(IRemoteCon))
    and (IRemoteCon.CurrentConnectionMode = cmWrite)
    and (sfNovoCirculoEI in IRemoteCon.CurrentConnectionInfo.SecretariasFeatures);
end;

procedure TFrmCirculosEI.DockDiscChange(Sender: TObject; NewTab: Integer;
  var AllowChange: Boolean);
var
Disc: string;
coddis: integer;
begin
  inherited;
  Disc := DockDisc.Tabs.Strings[NewTab];
  if CdsDiscipulados.Locate('sigdis', Disc, []) then
   begin
    coddis := CdsDiscipulados.Fields.FieldByName('coddis').AsInteger;
    ListarCirculos(coddis);
   end;
end;

procedure TFrmCirculosEI.ExportData;
begin
  inherited;
 IRemoteCon.DefaultExport(CdsCirculosEI);
end;

procedure TFrmCirculosEI.FormActivate(Sender: TObject);
begin
  inherited;
  IRemoteCon.ActiveDataset := CdsCirculosEI;
end;

procedure TFrmCirculosEI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 CdsCirculosEI.RemoteServer := nil;

 if (Assigned(IRemoteCon)) and (Assigned(FRemoteConnection)) then
   IRemoteCon.DropConnection(FRemoteConnection);

 inherited;

 if Assigned(FDataNavigator) then
  FreeAndNil(FDataNavigator);

 Action := caFree;
 FrmCirculosEI := nil;
end;

procedure TFrmCirculosEI.FormCreate(Sender: TObject);
var
AllowChange: boolean;
begin
  inherited;
  FRemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scEscolaInterna);

  CdsCirculosEI.RemoteServer := FRemoteConnection;

  FDataNavigator := TDatasetDataNavigator.Create(CdsCirculosEI);
  DataNavigator := FDataNavigator;
  TDatasetDataNavigator(DataNavigator).OnUpdateData := UpdateData;

  ListDiscipuladosEI;
  AllowChange := True;
  DockDIsc.OnChange(DockDisc,0,AllowChange);
  FmeGridSearch1.SearchFields := 'nomgru';
end;

function TFrmCirculosEI.GetFormDescription: string;
begin
 Result := TDockedFormDesc.FormCirculosEI;
end;

function TFrmCirculosEI.GetFormIDName: string;
begin
Result := 'Secretarias.CirculosEI';
end;

function TFrmCirculosEI.GetHelpFile: string;
begin
 Result := HelpFile;
end;

function TFrmCirculosEI.GetHelpID: integer;
begin

end;

function TFrmCirculosEI.GetTitle: string;
begin
 Result := 'Círculos da Escola Interna';
end;

procedure TFrmCirculosEI.ListarCirculos(const coddis: integer);
begin
 self.FDiscipulado := coddis;

 try
  with CdsCirculosEI do
   begin
    DisableControls;
    if Active then Close;

    Params.Items[0].AsInteger := ICosmosApp.ActiveFocus.FocusID;
    Params.Items[1].AsInteger := coddis;
    Open;
   end;

 finally
  CdsCirculosEI.EnableControls;
 end;
end;

procedure TFrmCirculosEI.ListDiscipuladosEI;
var
 sFilter: string;
begin
  CdsDiscipulados := IRemoteCon.OpenBufferedData(TCosmosFiles.BufDiscipulados);

  sFilter := 'indescint = %s and indati = %s';
  sFilter := sFilter.Format(sFilter, [TDataConverter.ToBoleanString(True, True),
     TDataConverter.ToBoleanString(True, True)]);

  CdsDiscipulados.Filter := sFilter;
  CdsDiscipulados.Filtered := True;

  DockDisc.Tabs.Clear;

  while not CdsDiscipulados.EOF do
   begin
    DockDisc.Tabs.Add(CdsDiscipulados.Fields.FieldByName('sigdis').AsString);
    CdsDiscipulados.Next;
   end;
end;

procedure TFrmCirculosEI.Locate;
begin
  IRemoteCon.DefaultLocate;
end;

procedure TFrmCirculosEI.PopupActionBar1Popup(Sender: TObject);
begin
  inherited;
  TPopupActionBar(Sender).Style := ICosmosApp.InterfaceStyle;
end;

procedure TFrmCirculosEI.UpdateData(Sender: TObject);
begin
  inherited;
  self.ListarCirculos(FDiscipulado);
end;

procedure TFrmCirculosEI.UpdateVisualElements;
begin
  inherited;
 ActionManager1.Style := ICosmosApp.InterfaceStyle;
end;

initialization
 RegisterClass(TFrmCirculosEI);

finalization
 UnRegisterClass(TFrmCirculosEI);

end.
