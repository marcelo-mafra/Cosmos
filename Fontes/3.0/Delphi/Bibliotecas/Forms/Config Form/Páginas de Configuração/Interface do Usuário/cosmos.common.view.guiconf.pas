unit cosmos.common.view.guiconf;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cosmos.system.messages,
  Cosmos.Framework.Interfaces.Dialogs, Xml.XMLDoc, Xml.XMLIntf, Vcl.ComCtrls,
  Vcl.ExtCtrls, GroupHeader, Vcl.StdCtrls, cosmos.framework.forms.pages,
  Vcl.Buttons, cosmos.classes.application, Vcl.ImgList, cosmos.system.types,
  Vcl.Tabs, cosmos.system.formsconst;


type
  TFrmPageGUI = class(TFrmCosmosPages)
    MSGroupHeader1: TMSGroupHeader;
    RdbNormalHint: TRadioButton;
    RdbRichHint: TRadioButton;
    RdbBalloonHint: TRadioButton;
    BalloonHint: TBalloonHint;
    BtnSample: TSpeedButton;
    Label1: TLabel;
    ImageList1: TImageList;
    MSGroupHeader2: TMSGroupHeader;
    ChkWinManager: TCheckBox;
    MSGroupHeader3: TMSGroupHeader;
    RdbPlatformStyle: TRadioButton;
    RdbXPStyle: TRadioButton;
    RdbModernStyle: TRadioButton;
    RdbRibbonLunaStyle: TRadioButton;
    RdbRibbonObsidianStyle: TRadioButton;
    RdbRibbonSilverStyle: TRadioButton;
    ChkShowStatusBar: TCheckBox;
    RdbNone: TRadioButton;
    MSGroupHeader4: TMSGroupHeader;
    RdbTabModern: TRadioButton;
    RdbTabModernSoft: TRadioButton;
    RdbTabTraditional: TRadioButton;
    RdbTabSoft: TRadioButton;
    Label2: TLabel;
    ChkFullScreen: TCheckBox;
    procedure RdbNormalHintClick(Sender: TObject);
    procedure RdbRichHintClick(Sender: TObject);
    procedure RdbBalloonHintClick(Sender: TObject);
    procedure RdbNoneClick(Sender: TObject);
    procedure ChkWinManagerClick(Sender: TObject);
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
  FrmPageGUI: TFrmPageGUI;

implementation

{$R *.dfm}

{ TFrmLogsConf }

procedure TFrmPageGUI.ChkWinManagerClick(Sender: TObject);
begin
 FChanged := True;
end;

function TFrmPageGUI.GetChanged: boolean;
begin
 Result := FChanged;
end;

function TFrmPageGUI.GetEnabled: boolean;
begin
Result := True;
end;

function TFrmPageGUI.GetPageInfo: TPageInfo;
begin
 Result.CodePage := 'Cosmos.GUI.configuration';
 Result.PageTitle := Caption;
 Result.PageDesc := TConfigurationPagesDesc.ConfSistema;
 Result.PageTreeRoot := TCosmosTitles.ConfGUI;
 Result.PageTreeItem := TCosmosTitles.ConfElements;
 Result.PageIndex := 1;
 Result.PageImage := nil;
 Result.HelpFile := Application.CurrentHelpFile;
 Result.HelpContext := self.HelpContext;
end;

procedure TFrmPageGUI.LoadOptions;
var
  AXMLDoc: TXMLDocument;
  ANode: IXMLNode;
  ARadio: TRadioButton;
  StyleName: string;
begin
 AXMLDoc := CreateXMLDocument(ICosmosApp.IApplicationPaths.GetUserConfigurationsFile);
 if AXMLDoc = nil then
  Exit;

 try
   ANode := AXMLDoc.DocumentElement;
   ANode := ANode.ChildNodes.FindNode('CosmosVisual');
   ANode := ANode.ChildNodes.FindNode(ICosmosApp.CosmosModuleShortName);
   ANode := ANode.ChildNodes.FindNode('Visual');

   case ANode.Attributes['CustomHint'] of //do not localize!
    0: ARadio :=  self.RdbNormalHint;
    1: ARadio :=  self.RdbRichHint;
    2: ARadio :=  self.RdbBalloonHint;
    3: ARadio := self.RdbNone;
    else
     ARadio := self.RdbNormalHint;
   end;

  if (ARadio <> nil) and Assigned(ARadio.OnClick) then
   begin
    ARadio.Checked := True;
    ARadio.OnClick(ARadio);
   end;

  //Lê a opção de estilos de menus
  StyleName := ANode.Attributes['Style'];

  RdbPlatformStyle.Checked := StyleName = 'Platform Default';
  RdbXPStyle.Checked := StyleName = 'XP Style';
  RdbModernStyle.Checked := StyleName = 'New XP Style';
  RdbRibbonLunaStyle.Checked := StyleName = 'Ribbon - Luna';
  RdbRibbonObsidianStyle.Checked := StyleName = 'Ribbon - Obsidian';
  RdbRibbonSilverStyle.Checked := StyleName = 'Ribbon - Silver';

  ChkWinManager.Checked := ANode.Attributes['ShowWindowsManager'];

  //Estilos das abas. Numeração conforme tipo enumerado TTabSetTabStyle.
   case ANode.Attributes['TabsStyle'] of //do not localize!
    0: RdbTabTraditional.Checked := True;
    2: RdbTabSoft.Checked := True;
    3: RdbTabModern.Checked := True;
    4: RdbTabModernSoft.Checked := True;
    else
     RdbTabModernSoft.Checked := True;
   end;

  ChkFullScreen.Checked := ANode.Attributes['FullScreen'];

  FChanged := False; //default

 finally
  if Assigned(ARadio) then
   ARadio := nil;

  if Assigned(AXMLDoc) then
   FreeAndNil(AXMLDoc);
 end;
end;

procedure TFrmPageGUI.RdbNoneClick(Sender: TObject);
begin
 BtnSample.CustomHint := nil;
 BtnSample.CustomHint := self.BalloonHint;
 BtnSample.ShowHint := False;
 self.ShowHint := False;
 FChanged := True;
end;

procedure TFrmPageGUI.RdbNormalHintClick(Sender: TObject);
begin
 BtnSample.CustomHint := nil;
 BtnSample.ShowHint := True;
 self.ShowHint := True;
 FChanged := True;
end;

procedure TFrmPageGUI.RdbRichHintClick(Sender: TObject);
begin
 self.BalloonHint.Style := bhsStandard;
 BtnSample.CustomHint := self.BalloonHint;
 BtnSample.ShowHint := True;
 self.ShowHint := True;
 FChanged := True;
end;

procedure TFrmPageGUI.RdbBalloonHintClick(Sender: TObject);
begin
 self.BalloonHint.Style := bhsBalloon;
 BtnSample.CustomHint := self.BalloonHint;
 BtnSample.ShowHint := True;
 self.ShowHint := True;
 FChanged := True;
end;

function TFrmPageGUI.SaveOptions: boolean;
var
  AXMLDoc: TXMLDocument;
  ANode: IXMLNode;
begin
  AXMLDoc := self.CreateXMLDocument(ICosmosApp.IApplicationPaths.GetUserConfigurationsFile);
  ANode := AXMLDoc.DocumentElement;
  ANode := ANode.ChildNodes.FindNode('CosmosVisual');
  ANode := ANode.ChildNodes.FindNode(ICosmosApp.CosmosModuleShortName);
  ANode := ANode.ChildNodes.FindNode('Visual');

 try
  if self.RdbNormalHint.Checked then
   ANode.Attributes['CustomHint'] := 0 //do not localize!
  else
  if self.RdbRichHint.Checked then
   ANode.Attributes['CustomHint'] := 1 //do not localize!
  else
  if self.RdbBalloonHint.Checked then
   ANode.Attributes['CustomHint'] := 2 //do not localize!
  else
   ANode.Attributes['CustomHint'] := 3; //do not localize!

  if RdbPlatformStyle.Checked then ANode.Attributes['Style'] := 'Platform Default'
  else
  if RdbXPStyle.Checked then ANode.Attributes['Style'] := 'XP Style'
  else
  if RdbModernStyle.Checked then ANode.Attributes['Style'] := 'New XP Style'
  else
  if RdbRibbonLunaStyle.Checked then ANode.Attributes['Style'] := 'Ribbon - Luna'
  else
  if RdbRibbonObsidianStyle.Checked then ANode.Attributes['Style'] := 'Ribbon - Obsidian'
  else
   ANode.Attributes['Style'] := 'Ribbon - Silver'; //Age como um default

  ANode.Attributes['ShowWindowsManager'] := self.ChkWinManager.Checked;

 //Configurações de estilo de tabs, conforme tipo enumerado TTabSetTabStyle.
  if RdbTabTraditional.Checked then
   ANode.Attributes['TabsStyle'] := 0 //do not localize!
  else
  if RdbTabSoft.Checked then
   ANode.Attributes['TabsStyle'] := 2 //do not localize!
  else
  if RdbTabModern.Checked then
   ANode.Attributes['TabsStyle'] := 3 //do not localize!
  else
  if RdbTabModernSoft.Checked then
   ANode.Attributes['TabsStyle'] := 4 //do not localize!
  else
   ANode.Attributes['TabsStyle'] := 4; //do not localize!


  ANode.Attributes['FullScreen'] := ChkFullScreen.Checked;

  AXMLDoc.SaveToFile(AXMLDoc.FileName);
  Result := True;

  ICosmosApp.Components.TabsStyle := TTabSetTabStyle(ANode.Attributes['TabsStyle']);

  if Assigned(AXMLDoc) then
   FreeAndNil(AXMLDoc);


 except
  on E: Exception do
   begin
     Result := False;
     ICosmosApp.MainLog.RegisterError(E.Message);
     ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, TCosmosErrorMsg.SaveGUIConfigurations);
   end;
 end;
end;

initialization
 RegisterClass(TFrmPageGUI);

finalization
 UnRegisterClass(TFrmPageGUI);

end.
