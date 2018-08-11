unit cosmos.common.view.messagesconf;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Cosmos.system.messages, Cosmos.Framework.Interfaces.Dialogs,
  XMLDoc, XMLIntf, GroupHeader, StdCtrls, cosmos.system.formsconst,
  cosmos.framework.forms.pages, Vcl.ExtCtrls;


type
  TFrmMessagesConf = class(TFrmCosmosPages)
    GhAutenticacoes: TMSGroupHeader;
    ChkOpenMyMessage: TCheckBox;
    ChkNotify: TCheckBox;
    ChkNotifyOnStart: TCheckBox;

  private
    { Private declarations }
   FChanged: boolean;

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
  FrmMessagesConf: TFrmMessagesConf;

implementation

{$R *.dfm}

{ TFrmLogsConf }


function TFrmMessagesConf.GetChanged: boolean;
begin
 Result := FChanged;
end;

function TFrmMessagesConf.GetEnabled: boolean;
begin
Result := True;
end;

function TFrmMessagesConf.GetPageInfo: TPageInfo;
begin
 Result.CodePage := 'Cosmos.messages.configuration';
 Result.PageTitle := Caption;
 Result.PageDesc := TConfigurationPagesDesc.ConfMessages;
 Result.PageTreeRoot := TCosmosTitles.Messages;
 Result.PageTreeItem := TCosmosTitles.ConfMessages;
 Result.PageIndex := 1;
 Result.PageImage := nil;
 Result.HelpFile := Application.CurrentHelpFile;
 Result.HelpContext := self.HelpContext;
end;

procedure TFrmMessagesConf.LoadOptions;
var
 AXMLDoc: TXMLDocument;
 ANode, AModuleNode: IXMLNode;
 sCosmosModule: string;
begin
 //Salva as configurações da ferramenta de mensagens.
 AXMLDoc := CreateXMLDocument(ICosmosApp.IApplicationPaths.GetUserConfigurationsFile);

 try
  if Assigned(AXMLDoc) then
   begin
     ANode := AXMLDoc.DocumentElement;
     ANode := ANode.ChildNodes.FindNode('CosmosVisual');

    //Busca o nó do módulo corrente do Cosmos.
    sCosmosModule := ICosmosApp.CosmosModuleShortName;
    AModuleNode := ANode.ChildNodes.First;

    while (AModuleNode <> nil) and (UpperCase(AModuleNode.NodeName) <> UpperCase(sCosmosModule)) do
     begin
      AModuleNode := AModuleNode.NextSibling;
     end;

    ANode := AModuleNode.ChildNodes.FindNode('Messages');
    ChkOpenMyMessage.Checked := ANode.Attributes['OpenMyMessageTool'];
    ChkNotify.Checked := ANode.Attributes['NotifyOnNewMessages'];
    ChkNotifyOnStart.Checked := ANode.Attributes['NotifyOnStartUp'];

    FChanged := False; //default
    if Assigned(AXMLDoc) then FreeAndNil(AXMLDoc);
   end;

 except
   on E: Exception do
    begin
     if Assigned(AXMLDoc) then FreeAndNil(AXMLDoc);
    end;
 end;
end;

function TFrmMessagesConf.SaveOptions: boolean;
var
 AXMLDoc: TXMLDocument;
 ANode, AChildNode: IXMLNode;
 sCosmosModule: string;
begin
 //Somente salva as configurações se o usuário for um administrador.
 AXMLDoc := CreateXMLDocument(ICosmosApp.IApplicationPaths.GetUserConfigurationsFile);

 try
  ANode := ANode.ChildNodes.FindNode('CosmosVisual');

  sCosmosModule := ICosmosApp.CosmosModuleShortName;

  AChildNode := ANode.ChildNodes.First;

  while (AChildNode <> nil) and (UpperCase(AChildNode.NodeName) <> UpperCase(sCosmosModule)) do
   begin
     AChildNode := AChildNode.NextSibling;
   end;

  AChildNode := AChildNode.ChildNodes.FindNode('Messages');
  ANode.Attributes['OpenMyMessageTool'] := ChkOpenMyMessage.Checked;
  ANode.Attributes['NotifyOnNewMessages'] := ChkNotify.Checked;
  ANode.Attributes['NotifyOnStartUp'] := ChkNotifyOnStart.Checked;

  AXMLDoc.SaveToFile(AXMLDoc.FileName);
  Result := True;

 finally
   if Assigned(AXMLDoc) then
    FreeAndNil(AXMLDoc);
 end;
end;


initialization
 RegisterClass(TFrmMessagesConf);

finalization
 UnRegisterClass(TFrmMessagesConf);

end.
