unit cosmos.financeiro.view.FrmContasBancarias;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cosmos.framework.view.FrmDocked, ActnList, ImgList, cosmos.system.messages,
  cosmos.frames.gridsearch, Datasnap.DSConnect, Cosmos.Framework.Interfaces.Dataacess,
  ToolWin, ActnMan, ActnCtrls, DB, DBClient, XPStyleActnCtrls, Menus, ActnPopup,
  PlatformDefaultStyleActnCtrls, cosmos.framework.datanavigators.datasets,
  System.Actions, cosmos.classes.application, Data.DBXCommon, Vcl.Grids, Vcl.DBGrids,
  cosmos.system.formsconst;

type
  TFrmContasBancarias = class(TFrmCosmosDocked)
    FmeGridSearch1: TFmeGridSearch;
    ActionToolBar1: TActionToolBar;
    ActNovaConta: TAction;
    CdsContasBancarias: TClientDataSet;
    DsrContasBancarias: TDataSource;
    ActionManager1: TActionManager;
    ActSearchBar: TAction;
    ActEditConta: TAction;
    ActDelConta: TAction;
    PopupActionBar1: TPopupActionBar;
    NovoCentrodeCusto1: TMenuItem;
    AlterarCentrodeCusto1: TMenuItem;
    ExcluirCentrodeCusto1: TMenuItem;
    ActContasAtivas: TAction;
    ActContasInativas: TAction;
    ActDesativarConta: TAction;
    ActReativarConta: TAction;
    N1: TMenuItem;
    DesativarConta1: TMenuItem;
    ReativarConta1: TMenuItem;
    procedure FmeGridSearch1DBGrid1DblClick(Sender: TObject);
    procedure ActNovaContaExecute(Sender: TObject);
    procedure ActDelContaExecute(Sender: TObject);
    procedure ActEditContaUpdate(Sender: TObject);
    procedure ActEditContaExecute(Sender: TObject);
    procedure ActSearchBarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PopupActionBar1Popup(Sender: TObject);
    procedure ActContasAtivasExecute(Sender: TObject);
    procedure ActContasAtivasUpdate(Sender: TObject);
    procedure ActContasInativasExecute(Sender: TObject);
    procedure ActContasInativasUpdate(Sender: TObject);
    procedure ActDesativarContaExecute(Sender: TObject);
    procedure ActDesativarContaUpdate(Sender: TObject);
    procedure ActReativarContaExecute(Sender: TObject);
    procedure ActReativarContaUpdate(Sender: TObject);
    procedure FmeGridSearch1DBGrid1DrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
  private
    { Private declarations }
    FAtivas: boolean;
    FRemoteConnection: TDSProviderConnection;
    FDataNavigator: TDatasetDataNavigator;
    procedure ListarContas;
    procedure SetAtivas(value: boolean);
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
    property Ativas: boolean read FAtivas write SetAtivas;
  end;

var
  FrmContasBancarias: TFrmContasBancarias;

implementation

uses cosmos.financeiro.view.FrmEditContaBancaria;

{$R *.dfm}

{ TFrmCentroCustos }

procedure TFrmContasBancarias.ActNovaContaExecute(Sender: TObject);
begin
  inherited;
  FrmEditContaBancaria := TFrmEditContaBancaria.Create(Application);

  try
   FrmEditContaBancaria.NovaContaBancaria;

  finally
   if Assigned(FrmEditContaBancaria) then
    FreeAndNil(FrmEditContaBancaria);
  end;
end;

procedure TFrmContasBancarias.ActReativarContaExecute(Sender: TObject);
var
 ACommand: TDBXCommand;
begin
  inherited;
  if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.ContasBancarias, TCosmosConfMsg.ReativarContaBancaria) = mrYes then
   begin
    ACommand := IRemoteCon.CreateCommand;

    try
     ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
     ACommand.Text := 'TDMFinanceiroMethods.ReativarContaBancaria'; //do not localize!
     ACommand.Prepare;

     ACommand.Parameters.Parameter[0].Value.SetInt32(CdsContasBancarias.Fields.FieldByName('codconban').AsInteger);
     ACommand.ExecuteUpdate;

     FreeAndNil(ACommand);
     IRemoteCon.ActiveDataset.Refresh;

    except
     on E: TDBXError do
      begin
       if assigned(ACommand) then FreeAndNil(ACommand);
       ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.ContasBancarias, E.Message);
       ICosmosApp.MainLog.RegisterError(E.Message);
      end;
    end;
   end;
end;

procedure TFrmContasBancarias.ActReativarContaUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (CdsContasBancarias.Active) and not (CdsContasBancarias.IsEmpty)
    and not (Ativas)
    and (CdsContasBancarias.Fields.FieldByName('codfoc').AsInteger = ICosmosApp.ActiveFocus.FocusID);
end;

procedure TFrmContasBancarias.ActContasAtivasExecute(Sender: TObject);
begin
  inherited;
  Ativas := True;
end;

procedure TFrmContasBancarias.ActContasAtivasUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Checked := Ativas;
end;

procedure TFrmContasBancarias.ActContasInativasExecute(Sender: TObject);
begin
  inherited;
  Ativas := False;
end;

procedure TFrmContasBancarias.ActContasInativasUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Checked := not Ativas;
end;

procedure TFrmContasBancarias.ActDelContaExecute(Sender: TObject);
var
 ACommand: TDBXCommand;
begin
  inherited;
  if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.ContasBancarias, TCosmosConfMsg.DelContaBancaria) = mrYes then
   begin
    ACommand := IRemoteCon.CreateCommand;

    try
     ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
     ACommand.Text := 'TDMFinanceiroMethods.DeleteContaBancaria'; //do not localize!
     ACommand.Prepare;

     ACommand.Parameters.Parameter[0].Value.SetInt32(CdsContasBancarias.Fields.FieldByName('codconban').AsInteger);
     ACommand.ExecuteUpdate;

     FreeAndNil(ACommand);
     IRemoteCon.ActiveDataset.Refresh;

    except
     on E: TDBXError do
      begin
       if assigned(ACommand) then FreeAndNil(ACommand);
       ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.ContasBancarias, E.Message);
       ICosmosApp.MainLog.RegisterError(E.Message);
      end;
    end;
   end;
end;

procedure TFrmContasBancarias.ActDesativarContaExecute(Sender: TObject);
var
 ACommand: TDBXCommand;
begin
  inherited;
  if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.ContasBancarias, TCosmosConfMsg.DesativarContaBancaria) = mrYes then
   begin
    ACommand := IRemoteCon.CreateCommand;

    try
     ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
     ACommand.Text := 'TDMFinanceiroMethods.DesativarContaBancaria'; //do not localize!
     ACommand.Prepare;

     ACommand.Parameters.Parameter[0].Value.SetInt32(CdsContasBancarias.Fields.FieldByName('codconban').AsInteger);
     ACommand.ExecuteUpdate;

     FreeAndNil(ACommand);
     IRemoteCon.ActiveDataset.Refresh;

    except
     on E: TDBXError do
      begin
       if assigned(ACommand) then FreeAndNil(ACommand);
       ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.ContasBancarias, E.Message);
       ICosmosApp.MainLog.RegisterError(E.Message);
      end;
    end;
   end;
end;

procedure TFrmContasBancarias.ActDesativarContaUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (CdsContasBancarias.Active) and not (CdsContasBancarias.IsEmpty)
    and (Ativas)
    and (CdsContasBancarias.Fields.FieldByName('codfoc').AsInteger = ICosmosApp.ActiveFocus.FocusID);;
end;

procedure TFrmContasBancarias.ActEditContaExecute(Sender: TObject);
begin
  inherited;
  if (CdsContasBancarias.Fields.FieldByName('codfoc').AsInteger <> ICosmosApp.ActiveFocus.FocusID) then
   Exit;

  FrmEditContaBancaria := TFrmEditContaBancaria.Create(Application);

  try
   FrmEditContaBancaria.EditarContaBancaria(CdsContasBancarias.FieldValues['codconban']);

  finally
   if Assigned(FrmEditContaBancaria) then
    FreeAndNil(FrmEditContaBancaria);
  end;
end;

procedure TFrmContasBancarias.ActEditContaUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (CdsContasBancarias.Active) and not (CdsContasBancarias.IsEmpty)
   and (CdsContasBancarias.Fields.FieldByName('codfoc').AsInteger = ICosmosApp.ActiveFocus.FocusID);
end;

procedure TFrmContasBancarias.ActSearchBarExecute(Sender: TObject);
begin
  inherited;
  FmeGridSearch1.ShowSearchBar := TAction(Sender).Checked;
end;

procedure TFrmContasBancarias.ExportData;
begin
  inherited;
 IRemoteCon.DefaultExport(CdsContasBancarias);
end;

procedure TFrmContasBancarias.FmeGridSearch1DBGrid1DblClick(Sender: TObject);
begin
  inherited;
  if ActEditConta.Enabled then
   ActEditConta.Execute;
end;

procedure TFrmContasBancarias.FmeGridSearch1DBGrid1DrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  //Destaca com cores as atividades do foco corrente.
  FmeGridSearch1.DBGrid1.Canvas.FillRect(Rect);

  //Deixa o fundo da fonte e grade transparentes. Sem isso, a fonte fica distorcida.
  if  gdSelected in State then
   begin
    FmeGridSearch1.DBGrid1.Canvas.Font.Color  := clHighlightText;
    FmeGridSearch1.DBGrid1.Canvas.Brush.Color := clHighlight;
   end;

    if CdsContasBancarias.FieldByName('codfoc').AsInteger = ICosmosApp.ActiveFocus.FocusID then
     FmeGridSearch1.DBGrid1.Canvas.Font.Color := clWindowText//cor "ativa" de texto.
    else
     FmeGridSearch1.DBGrid1.Canvas.Font.Color := clGrayText; //Cor de background de texto


  FmeGridSearch1.DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TFrmContasBancarias.FormActivate(Sender: TObject);
begin
  inherited;
  IRemoteCon.ActiveDataset := CdsContasBancarias;
end;

procedure TFrmContasBancarias.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Assigned(IRemoteCon) then
   IRemoteCon.DropConnection(FRemoteConnection);

  if Assigned(FDataNavigator) then
   FreeAndNil(FDataNavigator);
end;

procedure TFrmContasBancarias.FormCreate(Sender: TObject);
begin
  inherited;
  FRemoteConnection := IRemoteCon.CreateConnection(scFinanceiro);
  CdsContasBancarias.RemoteServer := FRemoteConnection;
  FmeGridSearch1.SearchFields := 'numcon';

  FDataNavigator := TDatasetDataNavigator.Create(CdsContasBancarias);
  DataNavigator := FDataNavigator;
  TDatasetDataNavigator(DataNavigator).OnUpdateData := UpdateData;

  FAtivas := True;
  ListarContas;
end;

function TFrmContasBancarias.GetFormDescription: string;
begin
Result := TDockedFormDesc.FormCentroCustos;
end;

function TFrmContasBancarias.GetFormIDName: string;
begin
Result := 'Financeiro.ContasBancarias';
end;

function TFrmContasBancarias.GetHelpFile: string;
begin
 Result := Self.HelpFile;
end;

function TFrmContasBancarias.GetHelpID: integer;
begin
 Result := HelpContext;
end;

function TFrmContasBancarias.GetTitle: string;
begin
 Result := Caption;
end;

procedure TFrmContasBancarias.ListarContas;
begin
 CdsContasBancarias.DisableControls;

 try
  if CdsContasBancarias.Active then
    CdsContasBancarias.Close;

  CdsContasBancarias.Params.Items[0].Value := TDataConverter.ToBoleanString(Ativas);
  CdsContasBancarias.Open;

 finally
  CdsContasBancarias.EnableControls;
 end;
end;

procedure TFrmContasBancarias.Locate;
begin
  inherited;
  IRemoteCon.DefaultLocate;
end;

procedure TFrmContasBancarias.PopupActionBar1Popup(Sender: TObject);
begin
  inherited;
  TPopupActionBar(Sender).Style := ICosmosApp.InterfaceStyle;
end;

procedure TFrmContasBancarias.SetAtivas(value: boolean);
begin
 if Value <> FAtivas then
  begin
   FAtivas := Value;
   ListarContas;
  end;
end;

procedure TFrmContasBancarias.UpdateData(Sender: TObject);
begin
  inherited;
  CdsContasBancarias.Refresh;
end;

procedure TFrmContasBancarias.UpdateVisualElements;
begin
  inherited;
 ActionManager1.Style := ICosmosApp.InterfaceStyle;
end;

initialization
 RegisterClass(TFrmContasBancarias);

finalization
 UnRegisterClass(TFrmContasBancarias);

end.
