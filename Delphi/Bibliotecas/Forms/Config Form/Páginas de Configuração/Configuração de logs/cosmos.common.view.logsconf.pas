unit cosmos.common.view.logsconf;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cosmos.system.messages,
  Cosmos.Framework.Interfaces.Dialogs, Xml.XMLDoc, Xml.XMLIntf, Vcl.ComCtrls,
  Vcl.ExtCtrls, GroupHeader, Vcl.StdCtrls, cosmos.framework.forms.pages,
  cosmos.classes.security, Vcl.Samples.Spin, Vcl.ImgList, cosmos.system.winshell,
  ValueComboBox, cosmos.system.formsconst;


type
  TFrmLogsConf = class(TFrmCosmosPages)
    GhConexoes: TMSGroupHeader;
    Image1: TImage;
    Label2: TLabel;
    MSGroupHeader1: TMSGroupHeader;
    ChkConnectionsSucess: TCheckBox;
    ChkConnectionsFailure: TCheckBox;
    ChkClosedConnections: TCheckBox;
    EdtFilesPath: TButtonedEdit;
    Label1: TLabel;
    Label3: TLabel;
    Bevel1: TBevel;
    Label4: TLabel;
    Label5: TLabel;
    ChkAuthenticationSucess: TCheckBox;
    ChkAuthenticationFailure: TCheckBox;
    Label6: TLabel;
    ChkMethodsCallSucess: TCheckBox;
    ChkMethodsCallFailure: TCheckBox;
    ChkApplicationlFailure: TCheckBox;
    ImageList1: TImageList;
    Bevel2: TBevel;
    Image2: TImage;
    LblHelp: TLabel;
    CBXMaxFileSize: TValueComboBox;
    procedure ChkConnectionsSucessClick(Sender: TObject);
    procedure EdtFilesPathRightButtonClick(Sender: TObject);
    procedure ChkConnectionsSucessMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure EdtFilesPathChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
   FChanged: boolean;

  protected
   procedure DisableControls; reintroduce;
   function GetChanged: boolean; override;
   function GetEnabled: boolean; override;
   function GetPageInfo: TPageInfo; override;

   function SaveOptions: boolean; override;
   procedure LoadOptions; override;

   function ValidateFields: boolean; override;

   property Changed: boolean read GetChanged;
   property Enabled: boolean read GetEnabled;
   property PageInfo: TPageInfo read GetPageInfo;

  public
    { Public declarations }
  end;

var
  FrmLogsConf: TFrmLogsConf;

implementation

{$R *.dfm}

{ TFrmLogsConf }

procedure TFrmLogsConf.ChkConnectionsSucessMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
 LblHelp.Caption := TControl(Sender).Hint;
end;

procedure TFrmLogsConf.DisableControls;
begin
 self.MSGroupHeader1.Enabled := False;
end;

procedure TFrmLogsConf.ChkConnectionsSucessClick(Sender: TObject);
begin
 FChanged := True;
end;

procedure TFrmLogsConf.EdtFilesPathChange(Sender: TObject);
begin
 self.FChanged := True;
end;

procedure TFrmLogsConf.EdtFilesPathRightButtonClick(Sender: TObject);
var
 sFolder: string;
begin
 sFolder := TShellDialogs.BrowseForFolders(Application.Handle, TCosmosGUIElements.SelectFolder);
 if sFolder.Trim <> '' then
  EdtFilesPath.Text := sFolder;
end;

procedure TFrmLogsConf.FormCreate(Sender: TObject);
begin
 if (IRemoteCon <> nil) and (IRemoteCon.CurrentConnectionInfo <> nil) then
  begin
   if not (cfConfPageLogs in IRemoteCon.CurrentConnectionInfo.AuthorizedFeatures) then
     self.DisableControls;
  end
 else
   self.DisableControls;
end;

function TFrmLogsConf.GetChanged: boolean;
begin
 Result := FChanged;
end;

function TFrmLogsConf.GetEnabled: boolean;
begin
Result := True;
end;

function TFrmLogsConf.GetPageInfo: TPageInfo;
begin
 Result.CodePage := 'Cosmos.logs.configuration';
 Result.PageTitle := Caption;
 Result.PageDesc := TConfigurationPagesDesc.ConfSistema;
 Result.PageTreeRoot := TCosmosTitles.ConfGerais;
 Result.PageTreeItem := TCosmosTitles.LogsCosmos;
 Result.PageIndex := 1;
 Result.PageImage := nil;
 Result.HelpFile := Application.CurrentHelpFile;
 Result.HelpContext := self.HelpContext;
end;

procedure TFrmLogsConf.LoadOptions;
var
 AXMLDoc: TXMLDocument;
 ANode: IXMLNode;
 sCosmosModule: string;
begin
 //Carrega as configurações de geração de logs.

 //Desabilita os controles caso o usuário não seja um administrador.
 if ICosmosApp.IRemoteCon.CurrentUser = nil then self.DisableControls
 else
  if ICosmosApp.IRemoteCon.CurrentUser.Administrator = False then
   self.DisableControls;

 //Desabilita os controles caso o usuário não tenha permissão a essa página de configuração.
 if IRemoteCon.CurrentConnectionInfo <> nil then
  begin
   if not (cfConfPageLogs in IRemoteCon.CurrentConnectionInfo.AuthorizedFeatures) then
    self.DisableControls;
  end;

 AXMLDoc := CreateXMLDocument(ICosmosApp.IApplicationPaths.GetCommonConfigurationsFile, False);

 if AXMLDoc = nil then
  Exit;

 try
   AXMLDoc.Active := True;
   ANode := AXMLDoc.DocumentElement;
   ANode := ANode.ChildNodes.FindNode('LogsInfo');
   ANode := ANode.ChildNodes.FindNode('LogsFile');
   ANode := ANode.ChildNodes.FindNode('Info');

   //Pasta dos arquivos e tamanho dos mesmos.
   if not TWinShell.IsWinXP then
    EdtFilesPath.Text := ANode.Attributes['LogsFilesPath'];

    CBXMaxFileSize.ItemIndex := CBXMaxFileSize.Values.IndexOf(ANode.Attributes['MaxFileSize']);
    if CBXMaxFileSize.ItemIndex < 0 then
     CBXMaxFileSize.ItemIndex := 1; //default

   ANode := ANode.ParentNode.ParentNode;//Retorna dois níveis acima.

   sCosmosModule := ICosmosApp.CosmosModuleShortName;
   ANode := ANode.ChildNodes.FindNode(sCosmosModule);

   if (ANode <> nil) then
    begin
      ANode := ANode.ChildNodes.FindNode('Info');
      //Logs de conexão
      ChkConnectionsSucess.Checked := ANode.Attributes['ActivateOnConnectSucessLogs'];
      ChkConnectionsFailure.Checked := ANode.Attributes['ActivateOnConnectErrorLogs'];
      ChkClosedConnections.Checked :=  ANode.Attributes['ActivateOnConnectCloseLogs'];

      //Logs de autenticação
      ChkAuthenticationSucess.Checked := ANode.Attributes['ActivateOnAuthenticateSucessLogs'];
      ChkAuthenticationFailure.Checked := ANode.Attributes['ActivateOnAuthenticateFailLogs'];

      //Logs de sistema
      ChkMethodsCallSucess.Checked := ANode.Attributes['ActivateOnMethodsCallSucessLogs'];
      ChkMethodsCallFailure.Checked := ANode.Attributes['ActivateOnMethodsCallFailLogs'];
      ChkApplicationlFailure.Checked := ANode.Attributes['ActivateOnApplicationFailLogs'];
    end;

  FChanged := False; //default


 finally
   if Assigned(AXMLDoc) then
    FreeAndNil(AXMLDoc);
 end;
end;

function TFrmLogsConf.SaveOptions: boolean;
var
 AXMLDoc: TXMLDocument;
 ANode: IXMLNode;
 sCosmosModule: string;
begin
 //Somente salva as configurações se o usuário for um administrador.
 Result := ValidateFields;
 if not Result then
  begin
   ICosmosApp.DlgMessage.WarningMessage(TCosmosTitles.Atenttion, TCosmosWarningMsg.IncompletedFields);
   Exit;
  end;

 AXMLDoc := self.CreateXMLDocument(ICosmosApp.IApplicationPaths.GetCommonConfigurationsFile, False);

 if AXMLDoc = nil then
  Exit;

 try
   if TWinShell.IsWinXP then
    begin
     AXMLDoc.Encoding := 'utf-8';
     AXMLDoc.Version := '1.0';
    end;

   AXMLDoc.Active := True;
   ANode := AXMLDoc.DocumentElement;
   ANode := ANode.ChildNodes.FindNode('LogsInfo');
   ANode := ANode.ChildNodes.FindNode('LogsFile');
   ANode := ANode.ChildNodes.FindNode('Info');

   //Pasta dos arquivos e tamanho dos mesmos.
   ANode.Attributes['LogsFilesPath'] := EdtFilesPath.Text;
   ANode.Attributes['MaxFileSize'] := CBXMaxFileSize.GetValue;

   ANode := ANode.ParentNode.ParentNode;//Retorna dois níveis acima.
   sCosmosModule := ICosmosApp.CosmosModuleShortName;
   ANode := ANode.ChildNodes.FindNode(sCosmosModule);

   if (ANode <> nil) then
    begin
      ANode := ANode.ChildNodes.FindNode('Info');
      //Logs de conexão
      ANode.Attributes['ActivateOnConnectSucessLogs'] := ChkConnectionsSucess.Checked;
      ANode.Attributes['ActivateOnConnectErrorLogs'] := ChkConnectionsFailure.Checked;
      ANode.Attributes['ActivateOnConnectCloseLogs'] := ChkClosedConnections.Checked;

      //Logs de autenticação
      ANode.Attributes['ActivateOnAuthenticateSucessLogs'] := ChkAuthenticationSucess.Checked;
      ANode.Attributes['ActivateOnAuthenticateFailLogs'] := ChkAuthenticationFailure.Checked;

      //Logs de sistema
      ANode.Attributes['ActivateOnMethodsCallSucessLogs'] := ChkMethodsCallSucess.Checked;
      ANode.Attributes['ActivateOnMethodsCallFailLogs'] := ChkMethodsCallFailure.Checked;
      ANode.Attributes['ActivateOnApplicationFailLogs'] := ChkApplicationlFailure.Checked;
    end;

   AXMLDoc.SaveToFile(AXMLDoc.FileName);

 finally
   if Assigned(AXMLDoc) then
    FreeAndNil(AXMLDoc);
 end;
end;

function TFrmLogsConf.ValidateFields: boolean;
begin
 Result := HasValue(EdtFilesPath) and HasValue(CBXMaxFileSize);
end;

initialization
 RegisterClass(TFrmLogsConf);

finalization
 UnRegisterClass(TFrmLogsConf);

end.
