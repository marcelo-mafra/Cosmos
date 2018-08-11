unit cosmos.secretarias.view.simpatizantes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cosmos.framework.view.FrmDocked, ActnList, ImgList, cosmos.system.messages, DB,
  DBClient, cosmos.frames.gridsearch, XPStyleActnCtrls, ActnMan, ToolWin, ActnCtrls,
  cosmos.framework.datanavigators.datasets, Vcl.Tabs, Vcl.DockTabSet,
  cosmos.classes.application, cosmos.classes.ServerInterface, System.Actions,
  cosmos.classes.security, Vcl.Menus, Vcl.PlatformDefaultStyleActnCtrls,
  Vcl.ActnPopup, cosmos.framework.interfaces.dialogs, Datasnap.DSConnect,
  cosmos.framework.interfaces.dataacess, cosmos.system.formsconst;

type
  TFrmSimpatizantes = class(TFrmCosmosDocked)
    DsrSimpatizantes: TDataSource;
    ActNovo: TAction;
    ActEditar: TAction;
    ActionToolBar1: TActionToolBar;
    ActionManager1: TActionManager;
    FmeGridSearch1: TFmeGridSearch;
    TabSetAlfabetico: TDockTabSet;
    ActSimpatizantesAtivos: TAction;
    ActSimpatizantesInativos: TAction;
    ActEnderecos: TAction;
    ActMeiosContatos: TAction;
    PopupActionBar1: TPopupActionBar;
    NovoAluno1: TMenuItem;
    AlterarCadastro1: TMenuItem;
    AlterarCadastro2: TMenuItem;
    Endereos1: TMenuItem;
    N4: TMenuItem;
    Movimentao1: TMenuItem;
    Desligar2: TMenuItem;
    Religar1: TMenuItem;
    ActSearchBar: TAction;
    N1: TMenuItem;
    Religar2: TMenuItem;
    N2: TMenuItem;
    SimpatizantesAtivos1: TMenuItem;
    SimpatizantesInativos1: TMenuItem;
    ActDesligar: TAction;
    ActReligar: TAction;
    ActTransferir: TAction;
    CdsSimpatizantes: TClientDataSet;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TabSetAlfabeticoChange(Sender: TObject; NewTab: Integer;
      var AllowChange: Boolean);
    procedure ActNovoExecute(Sender: TObject);
    procedure ActEditarExecute(Sender: TObject);
    procedure ActNovoUpdate(Sender: TObject);
    procedure ActEditarUpdate(Sender: TObject);
    procedure ActSimpatizantesAtivosExecute(Sender: TObject);
    procedure PopupActionBar1Popup(Sender: TObject);
    procedure ActSearchBarExecute(Sender: TObject);
    procedure ActEnderecosExecute(Sender: TObject);
    procedure ActEnderecosUpdate(Sender: TObject);
    procedure ActMeiosContatosExecute(Sender: TObject);
    procedure ActMeiosContatosUpdate(Sender: TObject);
    procedure ActDesligarExecute(Sender: TObject);
    procedure ActDesligarUpdate(Sender: TObject);
    procedure ActReligarExecute(Sender: TObject);
    procedure ActReligarUpdate(Sender: TObject);
    procedure ActTransferirExecute(Sender: TObject);
    procedure ActTransferirUpdate(Sender: TObject);
    procedure ActSimpatizantesInativosExecute(Sender: TObject);
  private
    { Private declarations }
    FLetter2: string;
    FLetter1: string;
    FRemoteConnection: TDSProviderConnection;
    FDataNavigator: TDatasetDataNavigator;
    FSimpatizantesAtivos: boolean;
    procedure SetSimpatizantesAtivos(const value: boolean);
    procedure UpdateData(Sender: TObject);
    procedure ListarSimpatizantes;


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
    property Letter1: string read FLetter1 write FLetter1 ;
    property Letter2: string read FLetter2 write FLetter2 ;
    property SimpatizantesAtivos: boolean read FSimpatizantesAtivos write SetSimpatizantesAtivos;
  end;

var
  FrmSimpatizantes: TFrmSimpatizantes;

implementation

{$R *.dfm}

uses cosmos.secretarias.view.cadastrosimpatizantes;

{ TFrmSimpatizantes }

procedure TFrmSimpatizantes.ActEditarExecute(Sender: TObject);
var
 codcad: integer;
begin
  inherited;
  FrmCadastroSimpatizante := TFrmCadastroSimpatizante.Create(self);

  try
    codcad := CdsSimpatizantes.Fields.FieldByName('codcad').AsInteger;
    FrmCadastroSimpatizante.EditarSimpatizante(codcad);

  finally
    FreeAndNil(FrmCadastroSimpatizante);
  end;
end;

procedure TFrmSimpatizantes.ActEditarUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := ((CdsSimpatizantes.Active) and (CdsSimpatizantes.RecordCount > 0))
  and (sfAlterarSimpatizante in ICosmosApp.IRemoteCon.CurrentConnectionInfo.SecretariasFeatures);
end;

procedure TFrmSimpatizantes.ActEnderecosExecute(Sender: TObject);
var
  AModule: HModule;
  AForm: TForm;
  IEndereco: ICosmosEnderecos;
begin
  inherited;
  if CdsSimpatizantes.IsEmpty then
   Exit;

  AForm := self.ICosmosApp.LoadDialog('cadend.bpl','TFrmCadastroEndereco',AModule);

  try
   if (AModule <> 0) and (AForm <> nil) then
    begin
      with AForm do
       begin
        if Supports(AForm, ICosmosEnderecos) then
         IEndereco := AForm as ICosmosEnderecos;
        if Assigned(IEndereco) then
         IEndereco.GetEnderecosCadastrado(CdsSimpatizantes.Fields.FieldByName('codcad').AsInteger);
        Free;
       end;
    end;

  finally
   if Assigned(IEndereco) then
    IEndereco := nil;
   UnloadPackage(AModule);
  end;

end;

procedure TFrmSimpatizantes.ActEnderecosUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := ((CdsSimpatizantes.Active) and (CdsSimpatizantes.RecordCount > 0))
   and (sfEnderecoSimpatizante in ICosmosApp.IRemoteCon.CurrentConnectionInfo.SecretariasFeatures);
end;

procedure TFrmSimpatizantes.ActDesligarExecute(Sender: TObject);
var
  AClass: TInterfacedPersistent;
  AModule: HModule;
  IMovDiscipular: IDialogMovimentacaoDiscipular;
  codcad: integer;
begin
//Desliga o simpatizante.
  inherited;
  AClass := ICosmosApp.LoadClass('movdis.bpl', 'TMovimentacaoDiscipularControler', AModule);

  try
  if (AModule <> 0) and (AClass <> nil) then
   begin
    IMovDiscipular := AClass as IDialogMovimentacaoDiscipular;
    if IMovDiscipular <> nil then
     begin
       codcad := CdsSimpatizantes.Fields.FieldByName('codcad').AsInteger;
       if IMovDiscipular.DesligarCadastrado(codcad) then
        UpdateData(self);
     end;
    end;

  finally
   if Assigned(IMovDiscipular) then IMovDiscipular := nil;
  if Assigned(AClass) then FreeAndNil(AClass);
  if AModule <> 0 then UnloadPackage(AModule);
  end;
end;

procedure TFrmSimpatizantes.ActDesligarUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := ((CdsSimpatizantes.Active) and (CdsSimpatizantes.RecordCount > 0))
   and (CdsSimpatizantes.Fields.FieldByName('indati').AsString = 'S')
   and (sfDesligarSimpatizante in ICosmosApp.IRemoteCon.CurrentConnectionInfo.SecretariasFeatures)
   and (IRemoteCon.CurrentConnectionMode <> cmRead);
end;

procedure TFrmSimpatizantes.ActReligarExecute(Sender: TObject);
var
  AClass: TInterfacedPersistent;
  AModule: HModule;
  IMovDiscipular: IDialogMovimentacaoDiscipular;
  codcad: integer;
begin
//Religa o simpatizante.
  inherited;
  AClass := ICosmosApp.LoadClass('movdis.bpl', 'TMovimentacaoDiscipularControler', AModule);

  try
  if (AModule <> 0) and (AClass <> nil) then
   begin
    IMovDiscipular := AClass as IDialogMovimentacaoDiscipular;
    if IMovDiscipular <> nil then
     begin
       codcad := CdsSimpatizantes.Fields.FieldByName('codcad').AsInteger;
       if IMovDiscipular.ReligarCadastrado(codcad) then
        self.UpdateData(self);
     end;
    end;

  finally
   if Assigned(IMovDiscipular) then IMovDiscipular := nil;
  if Assigned(AClass) then FreeAndNil(AClass);
  if AModule <> 0 then UnloadPackage(AModule);
  end;

end;

procedure TFrmSimpatizantes.ActReligarUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := ((CdsSimpatizantes.Active) and (CdsSimpatizantes.RecordCount > 0))
   and (CdsSimpatizantes.Fields.FieldByName('indati').AsString = 'N')
   and (sfReligarSimpatizante in ICosmosApp.IRemoteCon.CurrentConnectionInfo.SecretariasFeatures)
   and (IRemoteCon.CurrentConnectionMode <> cmRead);
end;

procedure TFrmSimpatizantes.ActTransferirExecute(Sender: TObject);
var
  AClass: TInterfacedPersistent;
  AModule: HModule;
  IMovDiscipular: IDialogMovimentacaoDiscipular;
  codcad: integer;
begin
//Transfere o simpatizante para outro foco
  inherited;
  AClass := ICosmosApp.LoadClass('movdis.bpl', 'TMovimentacaoDiscipularControler', AModule);

  try
  if (AModule <> 0) and (AClass <> nil) then
   begin
    IMovDiscipular := AClass as IDialogMovimentacaoDiscipular;
    if IMovDiscipular <> nil then
     begin
       codcad := CdsSimpatizantes.Fields.FieldByName('codcad').AsInteger;
       if IMovDiscipular.TransferirCadastrado(codcad) then
        self.UpdateData(self);
     end;
    end;

  finally
   if Assigned(IMovDiscipular) then IMovDiscipular := nil;
  if Assigned(AClass) then FreeAndNil(AClass);
  if AModule <> 0 then UnloadPackage(AModule);
  end;
end;

procedure TFrmSimpatizantes.ActTransferirUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := ((CdsSimpatizantes.Active) and (CdsSimpatizantes.RecordCount > 0))
   and (CdsSimpatizantes.Fields.FieldByName('indati').AsString = 'S')
   and (sfTransferirSimpatizante in ICosmosApp.IRemoteCon.CurrentConnectionInfo.SecretariasFeatures)
   and (IRemoteCon.CurrentConnectionMode <> cmRead);
end;

procedure TFrmSimpatizantes.ActMeiosContatosExecute(Sender: TObject);
var
  AModule: HModule;
  AForm: TForm;
  IContatos: ICosmosMeiosContatos;
begin
  inherited;
  if CdsSimpatizantes.IsEmpty then
   Exit;

   AForm := self.ICosmosApp.LoadDialog('meicont.bpl', 'TFrmMeiosContatos', AModule);

   try
    if (AModule <> 0) and (AForm <> nil) then
     begin
      with AForm do
       begin
        if Supports(AForm, ICosmosMeiosContatos) then
         IContatos := AForm as ICosmosMeiosContatos;
        if Assigned(IContatos) then
         IContatos.ShowMeiosContatosPesquisador(CdsSimpatizantes.Fields.FieldByName('codcad').AsInteger);
        Free;
       end;
     end;

  finally
   if Assigned(IContatos) then IContatos := nil;
   UnloadPackage(AModule);
  end;

end;

procedure TFrmSimpatizantes.ActMeiosContatosUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := ((CdsSimpatizantes.Active) and (CdsSimpatizantes.RecordCount > 0))
   and (sfMeiosContatosSimpatizante in ICosmosApp.IRemoteCon.CurrentConnectionInfo.SecretariasFeatures);
end;

procedure TFrmSimpatizantes.ActSearchBarExecute(Sender: TObject);
begin
  inherited;
  FmeGridSearch1.ShowSearchBar := TAction(Sender).Checked;
end;

procedure TFrmSimpatizantes.ActNovoExecute(Sender: TObject);
begin
  inherited;
  FrmCadastroSimpatizante := TFrmCadastroSimpatizante.Create(self);

  try
    FrmCadastroSimpatizante.NovoSimpatizante;

  finally
    FreeAndNil(FrmCadastroSimpatizante);
  end;
end;

procedure TFrmSimpatizantes.ActNovoUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (IRemoteCon.CurrentConnectionMode <> cmRead)
  and (sfCadastrarSimpatizante in ICosmosApp.IRemoteCon.CurrentConnectionInfo.SecretariasFeatures);
end;

procedure TFrmSimpatizantes.ActSimpatizantesAtivosExecute(Sender: TObject);
begin
  inherited;
  SimpatizantesAtivos := True;
end;

procedure TFrmSimpatizantes.ActSimpatizantesInativosExecute(Sender: TObject);
begin
  inherited;
  SimpatizantesAtivos := False;
end;

procedure TFrmSimpatizantes.ExportData;
begin
  inherited;
 IRemoteCon.DefaultExport(CdsSimpatizantes);
end;

procedure TFrmSimpatizantes.FormActivate(Sender: TObject);
begin
  inherited;
  IRemoteCon.ActiveDataset := CdsSimpatizantes;
end;

procedure TFrmSimpatizantes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 if Assigned(FRemoteConnection) then
  ICosmosApp.IRemoteCon.DropConnection(FRemoteConnection);

  if Assigned(FDataNavigator) then FreeAndNil(FDataNavigator);

  inherited;

  Action := caFree;
  FrmSimpatizantes := nil;
end;

procedure TFrmSimpatizantes.FormCreate(Sender: TObject);
begin
  inherited;
  FSimpatizantesAtivos := True; //default
  FmeGridSearch1.ShowSearchBar := True;
  FmeGridSearch1.SearchFields := 'nomcad';
  Letter1 := 'A';
  Letter2 := 'B';

  FRemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scPesquisadores);
  CdsSimpatizantes.RemoteServer := FRemoteConnection;

  FDataNavigator := TDatasetDataNavigator.Create(CdsSimpatizantes);
  DataNavigator := FDataNavigator;
  TDatasetDataNavigator(DataNavigator).OnUpdateData := UpdateData;

  ListarSimpatizantes;
end;

function TFrmSimpatizantes.GetFormDescription: string;
begin
 Result := TDockedFormDesc.FormSimpatizantes;
end;

function TFrmSimpatizantes.GetFormIDName: string;
begin
Result := 'Secretarias.Simpatizantes';
end;

function TFrmSimpatizantes.GetHelpFile: string;
begin
Result := HelpFile;
end;

function TFrmSimpatizantes.GetHelpID: integer;
begin
Result := HelpContext;
end;

function TFrmSimpatizantes.GetTitle: string;
begin
Result := Caption;
end;

procedure TFrmSimpatizantes.ListarSimpatizantes;
{var
AParams: TSQLParams;
ASearch: TCosmosSearch;}
begin
// Lista os simpatizantes cadastrados.
  {AParams := TSQLParams.Create(5);
  AParams.AppendData(QuotedStr(self.Letter1));
  AParams.AppendData(QuotedStr(self.Letter2), 1);
  AParams.AppendData(ICosmosApp.ActiveFocus.FocusID, 2);
  AParams.AppendData(ActSimpatizantesAtivos.Checked, 3);
  ASearch := csListaSimpatizantes; }

 try
    CdsSimpatizantes.DisableControls;
    CdsSimpatizantes.Params.ParamByName('param1').Value := self.Letter1;
    CdsSimpatizantes.Params.ParamByName('param2').Value := self.Letter2;
    CdsSimpatizantes.Params.ParamByName('param3').Value := ICosmosApp.ActiveFocus.FocusID;
    CdsSimpatizantes.Params.ParamByName('param4').Value := TDataConverter.ToBoleanString(SimpatizantesAtivos);
    CdsSimpatizantes.Params.ParamByName('param5').Value := 'SIM';
  //IRemoteCon.ExecuteDQL(ASearch, AParams.Params, CdsSimpatizantes);

   if CdsSimpatizantes.Active then CdsSimpatizantes.Close;
   CdsSimpatizantes.Open;

 finally
  CdsSimpatizantes.EnableControls;
  //if Assigned(AParams) then FreeAndNil(AParams);
 end;
end;

procedure TFrmSimpatizantes.Locate;
begin
  inherited;
  IRemoteCon.DefaultLocate;
end;

procedure TFrmSimpatizantes.PopupActionBar1Popup(Sender: TObject);
begin
  inherited;
  TPopupActionBar(Sender).Style := ICosmosApp.InterfaceStyle;
end;

procedure TFrmSimpatizantes.SetSimpatizantesAtivos(const value: boolean);
begin
 if Value <> FSimpatizantesAtivos then
  begin
   FSimpatizantesAtivos := Value;
   ListarSimpatizantes;
  end;
end;

procedure TFrmSimpatizantes.TabSetAlfabeticoChange(Sender: TObject;
  NewTab: Integer; var AllowChange: Boolean);
var
AString: string;
begin
  inherited;
  AString := TabSetAlfabetico.Tabs.Strings[NewTab];
  Letter1 := Copy(AString, 1, 1);
  Letter2 := Copy(AString, 2, 1);
  ListarSimpatizantes;
end;

procedure TFrmSimpatizantes.UpdateData(Sender: TObject);
begin
  inherited;
  ListarSimpatizantes;
end;

procedure TFrmSimpatizantes.UpdateVisualElements;
begin
  inherited;
 ActionManager1.Style := ICosmosApp.InterfaceStyle;
 TabsetAlfabetico.Style := ICosmosApp.Components.TabsStyle;
end;

initialization
 RegisterClass(TFrmSimpatizantes);

finalization
 UnRegisterClass(TFrmSimpatizantes);

end.
