unit cosmos.common.view.updaterconf;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  GroupHeader, Vcl.ImgList, cosmos.system.messages, Vcl.Buttons,
  cosmos.framework.forms.pages, Cosmos.Framework.Interfaces.Dialogs, cosmos.system.formsconst,
  Xml.XMLDoc, Xml.XMLIntf, Vcl.ActnList, System.Actions, cosmos.classes.security;

type
  TFrmUpdaterOptions = class(TFrmCosmosPages)
    GrpUpdates: TMSGroupHeader;
    ChkAutoUpdate: TCheckBox;
    MSGroupHeader3: TMSGroupHeader;
    RdbHTTP: TRadioButton;
    RdbFTP: TRadioButton;
    RdbNetwork: TRadioButton;
    ImgSource: TImage;
    ImageSources: TImageList;
    Bevel1: TBevel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Bevel2: TBevel;
    Panel1: TPanel;
    Label2: TLabel;
    RdbConfirmAllFiles: TRadioButton;
    RdbConfirmPackage: TRadioButton;
    RdbConfirmNone: TRadioButton;
    ActionList1: TActionList;
    ActHttpOptions: TAction;
    ActFtpOptions: TAction;
    ActNetworkOptions: TAction;
    EdtUpdatesSource: TEdit;
    LblUpdatesSource: TLabel;
    Image1: TImage;
    Label1: TLabel;
    ImageList1: TImageList;
    procedure ChkAutoUpdateClick(Sender: TObject);
    procedure RdbHTTPClick(Sender: TObject);
    procedure ActFtpOptionsExecute(Sender: TObject);
    procedure ActNetworkOptionsExecute(Sender: TObject);
    procedure ActHttpOptionsExecute(Sender: TObject);
    procedure EdtUpdatesSourceChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FChanged: boolean;
    function LoadBitmap: TBitmap;

  protected
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
  FrmUpdaterOptions: TFrmUpdaterOptions;

implementation

{$R *.dfm}

uses cosmos.common.view.updaterFTPconf, cosmos.common.view.updaterothersconf;

procedure TFrmUpdaterOptions.ActFtpOptionsExecute(Sender: TObject);
begin
 FrmFTPOptions := TFrmFTPOptions.Create(self);

 try
  FrmFTPOptions.ShowConfigurations;

 finally
   if Assigned(FrmFTPOptions) then
   FreeAndNil(FrmFTPOptions);
 end;
end;

procedure TFrmUpdaterOptions.ActHttpOptionsExecute(Sender: TObject);
begin
Exit;
end;

procedure TFrmUpdaterOptions.ActNetworkOptionsExecute(Sender: TObject);
begin
Exit;
end;

procedure TFrmUpdaterOptions.ChkAutoUpdateClick(Sender: TObject);
begin
 LblUpdatesSource.Enabled := TCheckBox(sender).Checked;
 EdtUpdatesSource.Enabled := LblUpdatesSource.Enabled;
end;

procedure TFrmUpdaterOptions.EdtUpdatesSourceChange(Sender: TObject);
begin
 FChanged := True;
end;

procedure TFrmUpdaterOptions.FormCreate(Sender: TObject);
begin
  inherited;
 if (IRemoteCon <> nil) and (IRemoteCon.CurrentConnectionInfo <> nil) then
  begin
   if not (cfConfPageUpdater in IRemoteCon.CurrentConnectionInfo.AuthorizedFeatures) then
     self.DisableControls;
  end
 else
   self.DisableControls;
end;

function TFrmUpdaterOptions.GetChanged: boolean;
begin
 Result := FChanged;
end;

function TFrmUpdaterOptions.GetEnabled: boolean;
begin
 Result := True;
end;

function TFrmUpdaterOptions.GetPageInfo: TPageInfo;
begin
 Result.CodePage := 'Cosmos.Updater';
 Result.PageTitle := Caption;
 Result.PageDesc := TConfigurationPagesDesc.ConfGerais;
 Result.PageTreeRoot := TCosmosTitles.ConfGerais;
 Result.PageTreeItem := TCosmosTitles.ConfAtualizacoes;
 Result.PageIndex := 1;
 Result.PageImage := LoadBitmap;
 Result.HelpFile := Application.CurrentHelpFile;
 Result.HelpContext := self.HelpContext;
end;

function TFrmUpdaterOptions.LoadBitmap: TBitmap;
begin
 Result := TBitMap.Create;
 ImageList1.GetBitmap(0, Result);
end;

procedure TFrmUpdaterOptions.LoadOptions;
var
 AXMLDoc: TXMLDocument;
 ANode: IXMLNode;
begin
 //Lê as opções de configuração salvas.
 AXMLDoc := self.CreateXMLDocument(ICosmosApp.IApplicationPaths.GetCommonConfigurationsFile);

 try
  ANode := AXMLDoc.DocumentElement;
  ANode := ANode.ChildNodes.FindNode('UpdatesInfo');
  ANode := ANode.ChildNodes.FindNode('Info');

  if ANode <> nil then
   begin
    ChkAutoUpdate.Checked := ANode.Attributes['AutoUpdate'];
    EdtUpdatesSource.Text :=  ANode.Attributes['UpdatesSourceFile'];

    //Lê o protocolo de atualização a ser usado
    case ANode.Attributes['Protocol'] of
     0: RdbHTTP.Checked := True;
     1: RdbFTP.Checked := True;
     2: RdbNetwork.Checked := True
     else
      RdbHTTP.Checked := True;
    end;

    //Lê a ação padrão a ser usada ao receber uma atualização.
    case ANode.Attributes['OnNewUpdate'] of
     0: RdbConfirmAllFiles.Checked := True;
     1: RdbConfirmPackage.Checked := True;
     2: RdbConfirmNone.Checked := True;
    end;

    FChanged := False; //default

    if Assigned(AXMLDoc) then
     FreeAndNil(AXMLDoc);
   end;

 except
  on E: Exception do
   begin
    ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, TCosmosErrorMsg.LoadConfigurations);

    ICosmosApp.MainLog.RegisterError(E.Message);

    if Assigned(AXMLDoc) then
     FreeAndNil(AXMLDoc);
   end;
 end;
end;

procedure TFrmUpdaterOptions.RdbHTTPClick(Sender: TObject);
begin
 ImageSources.GetIcon(TRadioButton(Sender).Tag, ImgSource.Picture.Icon);
 ImgSource.Update;
 FChanged := True;
end;

function TFrmUpdaterOptions.SaveOptions: boolean;
var
 AXMLDoc: TXMLDocument;
 ANode: IXMLNode;
begin
 {Salva as opções de configuração. Somente salva se houver um usuário autenticado
  e se o mesmo for administrador do Cosmos.}
 Result := ValidateFields;
 if not Result then
  begin
   ICosmosApp.DlgMessage.WarningMessage(TCosmosTitles.Atenttion, TCosmosWarningMsg.IncompletedFields);
   Exit;
  end;

 AXMLDoc := self.CreateXMLDocument(ICosmosApp.IApplicationPaths.GetCommonConfigurationsFile);

 try
  ANode := AXMLDoc.DocumentElement;
  ANode := ANode.ChildNodes.FindNode('UpdatesInfo');
  ANode := ANode.ChildNodes.FindNode('Info');

  if ANode <> nil then
   begin
    //Salva se a atualização será automática e outras informações correlatas.
    ANode.Attributes['AutoUpdate'] := ChkAutoUpdate.Checked;
    ANode.Attributes['UpdatesSourceFile'] := EdtUpdatesSource.Text;

    //Salva agora o protocolo de atualização a ser usado
    if RdbHTTP.Checked then
     ANode.Attributes['Protocol'] := 0
    else
     if RdbFTP.Checked then
      ANode.Attributes['Protocol'] := 1
     else
      ANode.Attributes['Protocol'] := 2;

    //Salva agora a ação padrão a ser usada ao receber uma atualização
    if RdbConfirmAllFiles.Checked then
     ANode.Attributes['OnNewUpdate'] := 0
    else
     if RdbConfirmPackage.Checked then
      ANode.Attributes['OnNewUpdate'] := 1
     else
      ANode.Attributes['OnNewUpdate'] := 2;

    AXMLDoc.SaveToFile(AXMLDoc.FileName);
    Result := True;
   end;

 finally
  if Assigned(AXMLDoc) then
    FreeAndNil(AXMLDoc);
 end;
end;

function TFrmUpdaterOptions.ValidateFields: boolean;
begin
 if ChkAutoUpdate.Checked then
  begin
   Result := HasValue(EdtUpdatesSource);
  end
 else
  Result := True;
end;

initialization
 RegisterClass(TFrmUpdaterOptions);

finalization
 UnRegisterClass(TFrmUpdaterOptions);

end.
