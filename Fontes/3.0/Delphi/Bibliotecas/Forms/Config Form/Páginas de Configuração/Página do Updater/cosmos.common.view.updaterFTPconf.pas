unit cosmos.common.view.updaterFTPconf;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, GroupHeader,
  cosmos.framework.interfaces.root, cosmos.system.messages, XMLDoc, XMLIntf,
  cosmos.system.winshell;

type
  TFrmFTPOptions = class(TForm)
    MSGroupHeader1: TMSGroupHeader;
    EdtIPServer: TEdit;
    EdtServerPort: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    CbxIpVersion: TComboBox;
    Label3: TLabel;
    MSGroupHeader2: TMSGroupHeader;
    Label4: TLabel;
    Label5: TLabel;
    EdtUserName: TEdit;
    EdtPassword: TEdit;
    Button1: TButton;
    Button2: TButton;
    MSGroupHeader3: TMSGroupHeader;
    Label9: TLabel;
    EdtProxyUserName: TEdit;
    EdtProxyPassword: TEdit;
    Label10: TLabel;
    Label11: TLabel;
    EdtProxyHost: TEdit;
    Label12: TLabel;
    EdtProxyPort: TEdit;
    Label8: TLabel;
    EdtExternalHost: TEdit;
    MSGroupHeader4: TMSGroupHeader;
    Label6: TLabel;
    EdtConnectTimeout: TEdit;
    Label7: TLabel;
    EdtReadTimeout: TEdit;
    Label13: TLabel;
    EdtTransferTimeout: TEdit;
    Label14: TLabel;
    EdtBoundIp: TEdit;
    Label15: TLabel;
    EdtBoundPort: TEdit;
    Button3: TButton;
    procedure EdtServerPortKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    { Private declarations }
    FICosmosApp: ICosmosApplication;
    AXMLDoc: TXMLDocument;

    procedure ReadConfigurations;
    procedure WriteConfigurations;

    function OpenXMLFile(const FileName: string): TXMLDocument;


  public
    { Public declarations }
    procedure ShowConfigurations;

    property ICosmosApp: ICosmosApplication read FICosmosApp;
  end;

var
  FrmFTPOptions: TFrmFTPOptions;

implementation

{$R *.dfm}

{ TFrmFTPOptions }

procedure TFrmFTPOptions.EdtServerPortKeyPress(Sender: TObject; var Key: Char);
begin
if CharInSet(Key, ['0'..'9',#8]) then
  Abort;
end;

procedure TFrmFTPOptions.FormClose(Sender: TObject; var Action: TCloseAction);
begin
if FICosmosApp <> nil then
 FICosmosApp := nil;
end;

procedure TFrmFTPOptions.FormCreate(Sender: TObject);
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;
end;

function TFrmFTPOptions.OpenXMLFile(const FileName: string): TXMLDocument;
begin
 Result := TXMLDocument.Create(self);
 Result.Options := [doNodeAutoCreate,doNodeAutoIndent,doAttrNull,doNamespaceDecl];
 Result.NodeIndentStr := #13;

 try
  Result.FileName := FileName;
  Result.Active := True;

 except
  on E: Exception do
   begin
     Result := nil;
     ICosmosApp.MainLog.RegisterError(E.Message);
     ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, TCosmosErrorMsg.LoadServerConfigFile);
   end;
 end;
end;

procedure TFrmFTPOptions.ReadConfigurations;
var
 ANode: IXMLNode;
begin
 //Lê as configurações do servidor FTP de um arquivo.
 AXMLDoc := self.OpenXMLFile(ICosmosApp.IApplicationPaths.GetCommonConfigurationsFile);

 try
   ANode := AXMLDoc.DocumentElement;
   ANode := ANode.ChildNodes.FindNode('UpdatesInfo');
   ANode := ANode.ChildNodes.FindNode('FTP');

   if ANode <> nil then
    begin
     //Ip do servidor FTP
     EdtIPServer.Text := ANode.Attributes['Host'];
     //Porta de conexão
     EdtServerPort.Text := ANode.Attributes['Port'];
     //Timeout da conexão
     EdtConnectTimeout.Text := ANode.Attributes['ConnectTimeout'];
     //Timeout de leitura
     EdtReadTimeout.Text := ANode.Attributes['ReadTimeout'];
     CbxIpVersion.ItemIndex := ANode.Attributes['IPVersion'];
     //Bound IP
     EdtBoundIp.Text := ANode.Attributes['BoundIP'];
     //Bound port
     EdtBoundPort.Text := ANode.Attributes['BoundPort'];
     //UserName
     EdtUserName.Text := ANode.Attributes['UserName'];
     //Senha do servidor FTP
     EdtPassword.Text := ANode.Attributes['Password'];
     //Servidor Proxy
     EdtProxyHost.Text := ANode.Attributes['ProxyHost'];
     //Porta do servidor proxy
     EdtProxyPort.Text := ANode.Attributes['ProxyPort'];
     EdtProxyUserName.Text := ANode.Attributes['ProxyUserName'];
     //Senha do servidor proxy
     EdtProxyPassword.Text :=  ICosmosApp.IUtilities.DecryptString(ANode.Attributes['ProxyPassword']);
     //Timeout de transferência
     EdtTransferTimeout.Text := ANode.Attributes['TransferTimeout'];
     //IP externo
     EdtExternalHost.Text := ANode.Attributes['ExternalIp'];
    end;

 except
  on E: Exception do
   begin
    ICosmosApp.MainLog.RegisterError(E.Message);
    ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, TCosmosErrorMsg.LoadConfigurations);
   end;
 end;
end;

procedure TFrmFTPOptions.ShowConfigurations;
begin
 ReadConfigurations;

 if self.ShowModal = mrOk then
  self.WriteConfigurations;
end;

procedure TFrmFTPOptions.WriteConfigurations;
var
 ANode: IXMLNode;
begin
 //Salva as configurações do servidor FTP em um arquivo.

 try
   ANode := AXMLDoc.DocumentElement;
   ANode := ANode.ChildNodes.FindNode('UpdatesInfo');
   ANode := ANode.ChildNodes.FindNode('FTP');

   if ANode <> nil then
    begin
     //Ip do servidor FTP
     ANode.Attributes['Host'] := EdtIPServer.Text;
     //Porta de conexão
     ANode.Attributes['Port'] := EdtServerPort.Text;
     //Timeout da conexão
     ANode.Attributes['ConnectTimeout'] := EdtConnectTimeout.Text;
     //Timeout de leitura
     ANode.Attributes['ReadTimeout'] := EdtReadTimeout.Text;
     ANode.Attributes['IPVersion'] := CbxIpVersion.ItemIndex;
     //Bound IP
     ANode.Attributes['BoundIP'] := EdtBoundIp.Text;
     //Bound port
     ANode.Attributes['BoundPort'] := EdtBoundPort.Text;
     //UserName
     ANode.Attributes['UserName'] := EdtUserName.Text;
     //Senha do servidor FTP
     ANode.Attributes['Password'] := EdtPassword.Text;
     //Servidor Proxy
     ANode.Attributes['ProxyHost'] := EdtProxyHost.Text;
     //Porta do servidor proxy
     ANode.Attributes['ProxyPort'] := EdtProxyPort.Text;
     ANode.Attributes['ProxyUserName'] := EdtProxyUserName.Text;
     //Senha do servidor proxy
     ANode.Attributes['ProxyPassword'] := ICosmosApp.IUtilities.EncriptString(EdtProxyPassword.Text);
     //Timeout de transferência
     ANode.Attributes['TransferTimeout'] := EdtTransferTimeout.Text;
     //IP externo
     ANode.Attributes['ExternalIp'] := EdtExternalHost.Text;

     AXMLDoc.SaveToFile(AXMLDoc.FileName);
    end;

 finally
   if Assigned(AXMLDoc) then
   FreeAndNil(AXMLDoc);
 end;
end;


end.
