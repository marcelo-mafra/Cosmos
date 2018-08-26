unit cosmos.common.view.configservers;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls,  Vcl.ImgList,
  Vcl.ActnList, Vcl.StdCtrls, Vcl.ExtCtrls, GroupHeader, cosmos.system.types,
  Cosmos.system.messages, cosmos.framework.forms.pages,  cosmos.classes.application,
  Cosmos.Framework.Interfaces.Root, Cosmos.Framework.Interfaces.Dialogs,
  cosmos.core.client.connection, Xml.xmldom, Xml.XMLIntf, Xml.Win.msxmldom,
  Xml.XMLDoc, System.Actions, cosmos.classes.security, cosmos.system.winshell,
  cosmos.system.formsconst, cosmos.system.nettypes, System.ImageList;

type
  PConnection = ^TConnectionRec;

  TConnectionRec = record
   ConnectionID: TGUID;
   ConnectionName: string;
   BufferKBSize: integer;
   Protocolo: TConnectionProtocol;
   NotifyMode: TNotifyMode;
   CommunicationTimeout: integer;
   ConnectTimeout: integer;
   Enabled: boolean;
   Agent: string;
   ServerHost: string;
   ServerPort: integer;
   ProxyHost: string;
   ProxyPort: string;
   ProxyUserName: string;
   ProxyPassword: string;
   ProxyByPass: string;
   DatasnapContext: string;
  end;

  TFrmServidores = class(TFrmCosmosPages)
    ImageList1: TImageList;
    MSGroupHeader1: TMSGroupHeader;
    Image2: TImage;
    Button4: TButton;
    Button3: TButton;
    LsvServers: TListView;
    Button6: TButton;
    MSGroupHeader3: TMSGroupHeader;
    ChkShowLogin: TCheckBox;
    ChkLoadBalance: TCheckBox;
    ActionList1: TActionList;
    ActInsert: TAction;
    ActDelete: TAction;
    ActEdit: TAction;
    ImageList2: TImageList;
    CheckBox1: TCheckBox;
    procedure ActEditExecute(Sender: TObject);
    procedure ActDeleteUpdate(Sender: TObject);
    procedure ActDeleteExecute(Sender: TObject);
    procedure ActInsertExecute(Sender: TObject);
    procedure LsvServersDblClick(Sender: TObject);
    procedure EdtTimeoutKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure LsvServersDeletion(Sender: TObject; Item: TListItem);
    procedure ActInsertUpdate(Sender: TObject);
    procedure ChkShowLoginClick(Sender: TObject);
  private
    { Private declarations }
    FChanged: boolean;
    procedure SaveConnectionInfo(var AConInfo: PConnection);
    procedure ListConnection(var Item: TListItem; Connection: TClientConnectionInfo);
    procedure PointerToObject(ACon: PConnection; var AConInfo: TClientConnectionInfo);
    function OpenXMLDocument: TXMLDocument;
    function LoadBitmap: TBitmap;


  protected
   function GetChanged: boolean; override;
   function GetEnabled: boolean; override;
   function GetPageInfo: TPageInfo; override;

   function SaveOptions: boolean; override;
   procedure LoadOptions; override;

   property Changed: boolean read GetChanged;
   property Enabled: boolean read GetEnabled;
   property PageInfo: TPageInfo read GetPageInfo;  

  public
    { Public declarations }
  end;

var
  FrmServidores: TFrmServidores;

implementation

uses cosmos.common.view.dlgaddserver;

{$R *.dfm}

procedure TFrmServidores.ActDeleteExecute(Sender: TObject);
var
Server: string;
begin
 Server := LsvServers.ItemFocused.Caption;
 if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.ServerConection, Format(TCosmosConfMsg.DelServer, [Server])) = mrYes then
  begin
   LsvServers.ItemFocused.Delete;
   FChanged := True;
  end;
end;

procedure TFrmServidores.ActDeleteUpdate(Sender: TObject);
begin
 TAction(sender).Enabled := (LsvServers.Selected <> nil) and not (IRemoteCon.Connected);
end;

procedure TFrmServidores.ActEditExecute(Sender: TObject);
var
AConInfo: TClientConnectionInfo;
ACon: PConnection;
AItem: TListItem;
begin
 FrmAddServer := TFrmAddServer.Create(self);
 AConInfo := TClientConnectionInfo.Create;

 try
  ACon := self.LsvServers.Selected.Data;
  PointerToObject(ACon, AConInfo);

  if FrmAddServer.EditConnection(AConInfo) then
   begin
    AItem := self.LsvServers.Selected;
    self.ListConnection(AItem, AConInfo);
    FChanged := True;
   end;

 finally
  if Assigned(AConInfo) then FreeAndNil(AConInfo);
  if Assigned(FrmAddServer) then FreeAndNil(FrmAddServer);
 end;
end;

procedure TFrmServidores.ActInsertExecute(Sender: TObject);
var
AConInfo: TClientConnectionInfo;
Item: TListItem;
begin
 FrmAddServer := TFrmAddServer.Create(self);

 try
  AConInfo := FrmAddServer.AddConnection;
  if AConInfo <> nil then
    begin
     Item := LsvServers.FindCaption(0, AConInfo.ConnectionName, False,True,True);
     ListConnection(Item, AConInfo);
     FChanged := True;
    end;

 finally
  if Assigned(FrmAddServer) then
   FreeAndNil(FrmAddServer);
 end;
end;

procedure TFrmServidores.ActInsertUpdate(Sender: TObject);
begin
 TAction(sender).Enabled := not (IRemoteCon.Connected);
end;

procedure TFrmServidores.ChkShowLoginClick(Sender: TObject);
begin
  FChanged := True;
end;

procedure TFrmServidores.EdtTimeoutKeyPress(Sender: TObject; var Key: Char);
begin
if not CharInSet(Key, ['0'..'9',#8]) then
  Abort;
end;

procedure TFrmServidores.FormCreate(Sender: TObject);
begin
  inherited;
  FChanged := False;
end;

function TFrmServidores.GetChanged: boolean;
begin
 Result := FChanged;
end;

function TFrmServidores.GetEnabled: boolean;
begin
Result := True;
end;

function TFrmServidores.GetPageInfo: TPageInfo;
begin
 Result.CodePage := 'Cosmos.Servers'; //do not localize!
 Result.PageTitle := Caption;
 Result.PageDesc := TConfigurationPagesDesc.ConfConexoes;
 Result.PageTreeRoot := TCosmosTitles.ConfConexoes;
 Result.PageTreeItem := TCosmosTitles.ConfServidores;
 Result.PageIndex := 1;
 Result.PageImage := LoadBitmap;
 Result.HelpFile := Application.CurrentHelpFile;
 Result.HelpContext := self.HelpContext;
end;

function TFrmServidores.LoadBitmap: TBitmap;
begin
 Result := TBitMap.Create;
 ImageList1.GetBitmap(0, Result);
end;

procedure TFrmServidores.LoadOptions;
var
 I: integer;
 sCosmosModule: string;
 Item: TListItem;
 AXMLDoc: TXMLDocument;
 ANode, AChildNode: IXMLNode;
 PCon: PConnection;

begin
 {Carrega as opções de configuração desta página de configurações. As configurações
 são lidas do arquivo "Connections.xml".}
 AXMLDoc := OpenXMLDocument;

 try
  ANode := AXMLDoc.DocumentElement;
  ANode := ANode.ChildNodes.FindNode('CosmosServers');
  ChkLoadBalance.Checked :=  ANode.Attributes['LoadBalanced'];
  ChkShowLogin.Checked := ANode.Attributes['ShowLogin'];

  ANode := ANode.ChildNodes.FindNode('ServersInfo');

  sCosmosModule := ICosmosApp.CosmosModuleShortName;

  for I := 0 to Pred(ANode.ChildNodes.Count) do
   begin
    AChildNode := ANode.ChildNodes.Get(I);

    if (AChildNode <> nil) and (AChildNode.Attributes['CosmosApp'] = sCosmosModule) then
     begin
      New(PCon);
      PCon.ConnectionID := StringToGUID(AChildNode.Attributes['ConnectionID']);
      PCon.ConnectionName := AChildNode.Attributes['ConnectionName'];
      PCon.BufferKBSize :=  AChildNode.Attributes['BufferKBSize'];
      PCon.Enabled := AChildNode.Attributes['Enabled'];
      PCon.Protocolo := TConnectionProtocol(AChildNode.Attributes['CommunicationProtocol']);
      PCon.NotifyMode := TNotifyMode(AChildNode.Attributes['NotifyMode']);
      PCon.ConnectTimeout := AChildNode.Attributes['ConnectTimeout'];
      PCon.CommunicationTimeout := AChildNode.Attributes['CommunicationTimeout'];

      if AChildNode.Attributes['Agent'] <> null then
        PCon.Agent := AChildNode.Attributes['Agent'];

      PCon.ServerHost := AChildNode.Attributes['Host'];
      PCon.ServerPort := AChildNode.Attributes['Port'];
      PCon.ProxyHost := AChildNode.Attributes['ProxyHost'];
      PCon.ProxyPort := AChildNode.Attributes['ProxyPort'];

      if Trim(AChildNode.Attributes['ProxyUsername']) <> '' then
       PCon.ProxyUserName := ICosmosApp.IUtilities.DecryptString(AChildNode.Attributes['ProxyUsername'])
      else
       PCon.ProxyUserName := AChildNode.Attributes['ProxyUsername'];

      if Trim(AChildNode.Attributes['ProxyPassword']) <> '' then
       PCon.ProxyPassword :=  ICosmosApp.IUtilities.DecryptString(AChildNode.Attributes['ProxyPassword'])
      else
       PCon.ProxyPassword := AChildNode.Attributes['ProxyPassword'];

      if AChildNode.Attributes['ProxyByPass'] <> null then
        PCon.ProxyByPass := AChildNode.Attributes['ProxyByPass'];

      if AChildNode.Attributes['DatasnapContext'] <> null then
        PCon.DatasnapContext := AChildNode.Attributes['DatasnapContext'];

      Item := LsvServers.Items.Add;
      Item.Caption := PCon.ConnectionName;
      Item.SubItems.Add(PCon.Protocolo.AsString);
      Item.Data := PCon;
      if PCon.Enabled then
       Item.ImageIndex := 0
      else
       Item.ImageIndex := 1;

      Item.OverlayIndex := Item.ImageIndex;
     end;
   end;

   FChanged := False; //default

  if Assigned(AXMLDoc) then
    FreeAndNil(AXMLDoc);

 except
  on E: Exception do
   begin
    ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, TCosmosErrorMsg.LoadServerConfigFile);
    ICosmosApp.MainLog.RegisterError(E.Message);

    if Assigned(AXMLDoc) then
     FreeAndNil(AXMLDoc);
   end;
 end;
end;

procedure TFrmServidores.LsvServersDblClick(Sender: TObject);
begin
 if LsvServers.Selected <> nil then
  ActEdit.Execute;
end;

procedure TFrmServidores.LsvServersDeletion(Sender: TObject; Item: TListItem);
begin
 FChanged := True;
end;

function TFrmServidores.OpenXMLDocument: TXMLDocument;
begin
 Result := TXMLDocument.Create(self);
 Result.Options := [doNodeAutoCreate,doNodeAutoIndent,doAttrNull,doNamespaceDecl];
 Result.NodeIndentStr := #13;

 try
  Result.FileName := ICosmosApp.IApplicationPaths.GetUserConfigurationsFile;
  Result.Active := True;

 except
  on E: Exception do
   begin
     ICosmosApp.MainLog.RegisterError(E.Message);
     ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, TCosmosErrorMsg.LoadServerConfigFile);
   end;
 end;
end;

procedure TFrmServidores.PointerToObject(ACon: PConnection; var AConInfo: TClientConnectionInfo);
begin
  AConInfo.ConnectionName := ACon.ConnectionName;
  AConInfo.ConnectionID := ACon.ConnectionID;
  AConInfo.Protocolo := ACon.Protocolo;
  AConInfo.NotifyMode := ACon.NotifyMode;
  AConInfo.Enabled := ACon.Enabled;
  AConInfo.ConnectionTimeout := ACon.ConnectTimeout;
  AConInfo.CommunicationTimeout := ACon.CommunicationTimeout;

  AConInfo.Agent := ACon.Agent;
  AConInfo.ServerHost := ACon.ServerHost;
  AConInfo.ServerPort := ACon.ServerPort;
  AConInfo.ProxyHost := ACon.ProxyHost;
  AConInfo.ProxyPort := ACon.ProxyPort;
  AConInfo.ProxyUsername := ACon.ProxyUserName;
  AConInfo.ProxyPassword := ACon.ProxyPassword;
  AConInfo.ProxyByPass := ACon.ProxyByPass;
  AConInfo.BufferKBSize := ACon.BufferKBSize;
  AConInfo.DatasnapContext := ACon.DatasnapContext;
end;

procedure TFrmServidores.ListConnection(var Item: TListItem; Connection: TClientConnectionInfo);
var
  PCon: PConnection;
begin
  New(PCon);
  if Item = nil then //Novo item...
   begin
    Item := LsvServers.Items.Add;
    Item.SubItems.Add(Connection.Protocolo.AsString);
   end
  else   //Atualização de item existente...
   begin
    Item.SubItems.Strings[0] := Connection.Protocolo.AsString;
    FChanged := True;
   end;

  Item.Caption := Connection.ConnectionName;
  PCon.BufferKBSize := Connection.BufferKBSize;
  PCon.ConnectionID := Connection.ConnectionID;
  PCon.ConnectionName := Connection.ConnectionName;
  PCon.Enabled := Connection.Enabled;
  PCon.Protocolo := Connection.Protocolo;
  PCon.NotifyMode := Connection.NotifyMode;
  PCon.ConnectTimeout := Connection.ConnectionTimeout;
  PCon.CommunicationTimeout := Connection.CommunicationTimeout;

  PCon.Agent := Connection.Agent;
  PCon.ServerHost := Connection.ServerHost;
  PCon.ServerPort := Connection.ServerPort;
  PCon.ProxyHost :=  Connection.ProxyHost;
  PCon.ProxyPort := Connection.ProxyPort;
  PCon.ProxyUserName := Connection.ProxyUsername;
  PCon.ProxyPassword := Connection.ProxyPassword;
  PCon.ProxyByPass := Connection.ProxyByPass;
  PCon.DatasnapContext := Connection.DatasnapContext;

  Item.Data := PCon;

  if PCon.Enabled then
   Item.ImageIndex := 0
  else
   Item.ImageIndex := 1;

  Item.OverlayIndex := Item.ImageIndex;
end;

procedure TFrmServidores.SaveConnectionInfo(var AConInfo: PConnection);
var
 ANode, ACurrentNode: IXMLNode;
 AXMLDoc: TXMLDocument;
begin
 {Salva as configurações de conexão do usuário. O salvamento é feito em arquivo
 XML.}
 AXMLDoc := self.OpenXMLDocument;

 try
  if (AConInfo <> nil) and (AXMLDoc.Active) then
   begin
    ANode := AXMLDoc.DocumentElement;

    ANode := ANode.ChildNodes.FindNode('CosmosServers');
    ANode := ANode.ChildNodes.FindNode('ServersInfo');

    ACurrentNode := ANode.AddChild('Server');
    ACurrentNode.Attributes['ConnectionID'] := AConInfo.ConnectionID.ToString;
    ACurrentNode.Attributes['ConnectionName'] := AConInfo.ConnectionName;
    ACurrentNode.Attributes['CommunicationProtocol'] := Ord(AConInfo.Protocolo);
    ACurrentNode.Attributes['NotifyMode'] := Ord(AConInfo.NotifyMode);
    ACurrentNode.Attributes['CommunicationTimeout'] := AConInfo.CommunicationTimeout;
    ACurrentNode.Attributes['ConnectTimeout'] := AConInfo.ConnectTimeout;

    ACurrentNode.Attributes['Agent'] := AConInfo.Agent;
    ACurrentNode.Attributes['Host'] := AConInfo.ServerHost;
    ACurrentNode.Attributes['Port'] := AConInfo.ServerPort;
    ACurrentNode.Attributes['ProxyHost'] := AConInfo.ProxyHost;
    ACurrentNode.Attributes['ProxyPort'] := AConInfo.ProxyPort;
    ACurrentNode.Attributes['ProxyByPass'] := AConInfo.ProxyByPass;

    if AConInfo.ProxyUserName.Trim <> '' then
     ACurrentNode.Attributes['ProxyUsername'] := ICosmosApp.IUtilities.EncriptString(AConInfo.ProxyUserName)
    else
     ACurrentNode.Attributes['ProxyUsername'] := AConInfo.ProxyUserName;

    if AConInfo.ProxyPassword.Trim <> '' then
     ACurrentNode.Attributes['ProxyPassword'] := ICosmosApp.IUtilities.EncriptString(AConInfo.ProxyPassword)
    else
     ACurrentNode.Attributes['ProxyPassword'] := AConInfo.ProxyPassword;

    ACurrentNode.Attributes['BufferKBSize'] := AConInfo.BufferKBSize;
    ACurrentNode.Attributes['DatasnapContext'] := AConInfo.DatasnapContext;

    case ICosmosApp.CosmosModule of
     cmFocos: ACurrentNode.Attributes['CosmosApp'] := TCosmosAppName.CosmosFocosId;
     cmSecretarias: ACurrentNode.Attributes['CosmosApp'] := TCosmosAppName.CosmosSecretariasId;
     cmFinanceiro: ACurrentNode.Attributes['CosmosApp'] := TCosmosAppName.CosmosFinanceiroId;
     cmConferencias: ACurrentNode.Attributes['CosmosApp'] := TCosmosAppName.CosmosConferenciasId;
     cmUsuarios: ACurrentNode.Attributes['CosmosApp'] := TCosmosAppName.CosmosUsuariosId;
    end;

    ACurrentNode.Attributes['Enabled'] := AConInfo.Enabled;
    AXMLDoc.SaveToFile(AXMLDoc.FileName);
   end;

   if Assigned(AXMLDoc) then
    FreeAndNil(AXMLDoc);

  except
   on E: Exception do
    begin
     ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, TCosmosErrorMsg.SaveServerConfigFile);
     ICosmosApp.MainLog.RegisterError(E.Message);

     if Assigned(AXMLDoc) then
      FreeAndNil(AXMLDoc);
    end;
  end;
end;

function TFrmServidores.SaveOptions: boolean;
var
 I: integer;
 AConInfo: PConnection;
 AXMLDoc: TXMLDocument;
 ANode: IXMLNode;
 Updated: boolean;
begin
 {Este método protegido salva os dados da página de configuração. São salvos os
 dados de conexão das aplicações Cosmos em um arquivo XML.}
 Updated := False;
 AXMLDoc := self.OpenXMLDocument;

 try
  if AXMLDoc.Active then
   begin
    ANode := AXMLDoc.DocumentElement;
    ANode := ANode.ChildNodes.FindNode('CosmosServers');
    ANode.Attributes['LoadBalanced'] := ChkLoadBalance.Checked;
    ANode.Attributes['ShowLogin'] := ChkShowLogin.Checked;

    ANode := ANode.ChildNodes.FindNode('ServersInfo');

    {Primeiro exclui todas as conexões usadas pelo módulo corrente do Cosmos.
    Esta exclusão é feita por um loop while que tem o contador resetado sempre
    que uma conexão é excluída, uma vez que a exclusão afeta o contador em
    um loop for, por exemplo. }
    I := 0;

    while I <= Pred(ANode.ChildNodes.Count) do
     begin
       if ANode.ChildNodes[I].Attributes['CosmosApp'] = ICosmosApp.CosmosModuleShortName then
        begin
         //Outputdebugstring(PWideChar(ANode.ChildNodes[I].XML));
         ANode.ChildNodes.Delete(I);
         Updated := True;

         I := 0; //reset do contador.
         Continue;
        end;

        Inc(I); //Incrementa o contador.
     end;

     //Salva as informações das conexões configuradas, após as exclusões.
    if Updated then
     begin
      AXMLDoc.SaveToFile(AXMLDoc.FileName);
      Result := True;
     end;

    if Assigned(AXMLDoc) then
     FreeAndNil(AXMLDoc);

    //Agora insere novamente todas as configurações de conexões.
    for I := 0 to Pred(LsvServers.Items.Count) do
     begin
      AConInfo := LsvServers.Items.Item[I].Data;
      if AConInfo <> nil then
       self.SaveConnectionInfo(AConInfo);
     end;
   end;

 except
  on E: Exception do
   begin
    Result := False;
    ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, TCosmosErrorMsg.SaveServerConfigFile);
    ICosmosApp.MainLog.RegisterError(E.Message);

    if Assigned(AXMLDoc) then
     FreeAndNil(AXMLDoc);
   end;
 end;
end;


initialization
 RegisterClass(TFrmServidores);

finalization
 UnRegisterClass(TFrmServidores);

end.
