unit cosmos.common.view.menuconf;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Cosmos.system.messages, Cosmos.Framework.Interfaces.Dialogs,
  ComCtrls, ExtCtrls, GroupHeader, StdCtrls, cosmos.framework.forms.pages,
  Vcl.CategoryButtons, Xml.XMLDoc, Xml.XMLIntf, cosmos.system.formsconst;


type
  TFrmPageMenuLateral = class(TFrmCosmosPages)
    MSGroupHeader2: TMSGroupHeader;
    ChkReorder: TCheckBox;
    ChkBoldText: TCheckBox;
    ChkPlusSignal: TCheckBox;
    ChkCategoryBorder: TCheckBox;
    MSGroupHeader1: TMSGroupHeader;
    BtManager: TCategoryButtons;
    Label2: TLabel;
    ChkVerticalCategory: TCheckBox;
    ChkNoImages: TCheckBox;
    procedure ChkReorderClick(Sender: TObject);
    procedure ChkBoldTextClick(Sender: TObject);
    procedure ChkPlusSignalClick(Sender: TObject);
    procedure ChkCategoryBorderClick(Sender: TObject);
    procedure ChkVerticalCategoryClick(Sender: TObject);
    procedure ChkNoImagesClick(Sender: TObject);
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
  FrmPageMenuLateral: TFrmPageMenuLateral;

implementation

{$R *.dfm}

{ TFrmPageMenuLateral }

procedure TFrmPageMenuLateral.ChkBoldTextClick(Sender: TObject);
begin
  inherited;
 if ChkBoldText.Checked then
   BtManager.ButtonOptions := BtManager.ButtonOptions + [boBoldCaptions]
 else
   BtManager.ButtonOptions := BtManager.ButtonOptions - [boBoldCaptions];

 FChanged := True;
end;

procedure TFrmPageMenuLateral.ChkCategoryBorderClick(Sender: TObject);
begin
  inherited;
 if ChkCategoryBorder.Checked then
   BtManager.ButtonOptions := BtManager.ButtonOptions + [boCaptionOnlyBorder]
 else
   BtManager.ButtonOptions := BtManager.ButtonOptions - [boCaptionOnlyBorder];

 FChanged := True;
end;

procedure TFrmPageMenuLateral.ChkNoImagesClick(Sender: TObject);
begin
  inherited;
 FChanged := True;
end;

procedure TFrmPageMenuLateral.ChkPlusSignalClick(Sender: TObject);
begin
  inherited;
 if ChkPlusSignal.Checked then
   BtManager.ButtonOptions := BtManager.ButtonOptions + [boUsePlusMinus]
 else
   BtManager.ButtonOptions := BtManager.ButtonOptions - [boUsePlusMinus];

 FChanged := True;
end;

procedure TFrmPageMenuLateral.ChkReorderClick(Sender: TObject);
begin
 if ChkReorder.Checked then
   BtManager.ButtonOptions := BtManager.ButtonOptions + [boAllowReorder]
 else
   BtManager.ButtonOptions := BtManager.ButtonOptions - [boAllowReorder];

 FChanged := True;
end;

procedure TFrmPageMenuLateral.ChkVerticalCategoryClick(Sender: TObject);
begin
  inherited;
 if ChkVerticalCategory.Checked then
   BtManager.ButtonOptions := BtManager.ButtonOptions + [boVerticalCategoryCaptions]
 else
   BtManager.ButtonOptions := BtManager.ButtonOptions - [boVerticalCategoryCaptions];

 FChanged := True;
end;

function TFrmPageMenuLateral.GetChanged: boolean;
begin
 Result := FChanged;
end;

function TFrmPageMenuLateral.GetEnabled: boolean;
begin
Result := True;
end;

function TFrmPageMenuLateral.GetPageInfo: TPageInfo;
begin
 Result.CodePage := 'Cosmos.MenuLateral.configuration';
 Result.PageTitle := Caption;
 Result.PageDesc := TConfigurationPagesDesc.ConfSistema;
 Result.PageTreeRoot := TCosmosTitles.ConfGUI;
 Result.PageTreeItem := TCosmosTitles.ConfMenuLateral;
 Result.PageIndex := 1;
 Result.PageImage := nil;
 Result.HelpFile := Application.CurrentHelpFile;
 Result.HelpContext := self.HelpContext;
end;

procedure TFrmPageMenuLateral.LoadOptions;
var
  AXMLDoc: TXMLDocument;
  ANode: IXMLNode;
begin
 AXMLDoc := CreateXMLDocument(ICosmosApp.IApplicationPaths.GetUserConfigurationsFile);
 if AXMLDoc = nil then
  Exit;

 try
   ANode := AXMLDoc.DocumentElement;
   ANode := ANode.ChildNodes.FindNode('CosmosVisual');
   ANode := ANode.ChildNodes.FindNode(ICosmosApp.CosmosModuleShortName);
   ANode := ANode.ChildNodes.FindNode('LateralMenu');

  //Lê a opção de estilos de menus
  ChkReorder.Checked := ANode.Attributes['AllowReorder'];
  ChkBoldText.Checked := ANode.Attributes['BoldCaptions'];
  ChkVerticalCategory.Checked := ANode.Attributes['VerticalCategories'];
  ChkPlusSignal.Checked := ANode.Attributes['DefaultPlusSignal'];
  ChkCategoryBorder.Checked := ANode.Attributes['CategoryBorder'];
  ChkNoImages.Checked := ANode.Attributes['NoIcons'];

  if ChkReorder.Checked then
   BtManager.ButtonOptions := BtManager.ButtonOptions + [boAllowReorder]
  else
   BtManager.ButtonOptions := BtManager.ButtonOptions - [boAllowReorder];

  if ChkBoldText.Checked then
   BtManager.ButtonOptions := BtManager.ButtonOptions + [boBoldCaptions]
  else
   BtManager.ButtonOptions := BtManager.ButtonOptions - [boBoldCaptions];

  if ChkVerticalCategory.Checked then
   BtManager.ButtonOptions := BtManager.ButtonOptions + [boVerticalCategoryCaptions]
  else
   BtManager.ButtonOptions := BtManager.ButtonOptions - [boVerticalCategoryCaptions];

  if ChkPlusSignal.Checked then
   BtManager.ButtonOptions := BtManager.ButtonOptions + [boUsePlusMinus]
  else
   BtManager.ButtonOptions := BtManager.ButtonOptions - [boUsePlusMinus];

  if ChkCategoryBorder.Checked then
   BtManager.ButtonOptions := BtManager.ButtonOptions + [boCaptionOnlyBorder]
  else
   BtManager.ButtonOptions := BtManager.ButtonOptions - [boCaptionOnlyBorder];


  FChanged := False; //default

 finally
  if Assigned(AXMLDoc) then
   FreeAndNil(AXMLDoc);
 end;;
end;

function TFrmPageMenuLateral.SaveOptions: boolean;
var
  AXMLDoc: TXMLDocument;
  ANode: IXMLNode;
begin
  AXMLDoc := self.CreateXMLDocument(ICosmosApp.IApplicationPaths.GetUserConfigurationsFile);
  ANode := AXMLDoc.DocumentElement;
  ANode := ANode.ChildNodes.FindNode('CosmosVisual');
  ANode := ANode.ChildNodes.FindNode(ICosmosApp.CosmosModuleShortName);
  ANode := ANode.ChildNodes.FindNode('LateralMenu');

 try
  ANode.Attributes['AllowReorder'] := ChkReorder.Checked;
  ANode.Attributes['BoldCaptions'] := ChkBoldText.Checked;
  ANode.Attributes['VerticalCategories'] := ChkVerticalCategory.Checked;
  ANode.Attributes['DefaultPlusSignal'] := ChkPlusSignal.Checked;
  ANode.Attributes['CategoryBorder'] := ChkCategoryBorder.Checked;
  ANode.Attributes['NoIcons'] := ChkNoImages.Checked;

  AXMLDoc.SaveToFile(AXMLDoc.FileName);
  Result := True;

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
 RegisterClass(TFrmPageMenuLateral);

finalization
 UnRegisterClass(TFrmPageMenuLateral);

end.
