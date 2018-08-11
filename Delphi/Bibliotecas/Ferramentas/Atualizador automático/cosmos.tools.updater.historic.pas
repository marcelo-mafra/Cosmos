unit cosmos.tools.updater.historic;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cosmos.framework.view.FrmDocked, Vcl.ActnList,
  Vcl.ImgList, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.StdCtrls, Xml.xmldom,
  Xml.XMLIntf, Xml.Win.msxmldom, Xml.XMLDoc, cosmos.system.messages,
  cosmos.classes.persistence.ini, cosmos.system.winshell, cosmos.system.formsconst,
  cosmos.classes.application, cosmos.framework.datanavigators.listview,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, IdWinsock2, IdGlobal,
  Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnMan, System.Actions, Vcl.ToolWin,
  Vcl.ActnCtrls, cosmos.tools.updater.classes;

type
  PUpdateInfo = ^TUpdateInfo;

  TUpdateInfo = record
   UpdateId: string;
   UpdateStatusId: integer;
   UpdateStatus: string;
   UpdateDate: variant;
   UpdateName: string;
   UpdateDescription: string;
   UpdateSource: string;
   UpdateFile: string;
   DownloadDate: variant;
   ExecuteDate: variant;
  end;


  TFrmUpdatesHistoric = class(TFrmCosmosDocked)
    LsvHistoric: TListView;
    XMLUpdatesHistoric: TXMLDocument;
    Panel1: TPanel;
    Image1: TImage;
    LblTitle: TLabel;
    Bevel2: TBevel;
    LblDesc: TLabel;
    ActionManager1: TActionManager;
    ActionToolBar1: TActionToolBar;
    ActVerifyUpdates: TAction;
    Action2: TAction;
    procedure FormCreate(Sender: TObject);
    procedure LsvHistoricSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure ActVerifyUpdatesExecute(Sender: TObject);
  private
    { Private declarations }
    FDataNavigator: TListviewDataNavigator;
    FUpdateHistoricFile, FUpdateSourceFile: string;

    function CreateXMLDocument: TXMLDocument;
    procedure SetUpdatesHistoricFileName;
    procedure LoadUpdatesHistoric;
    procedure UpdateData(Sender: TObject);
    procedure RegisterUpdateStatus(UpdateId: string; Status: TDownloadStatus);

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
    property UpdateHistoricFile: string read FUpdateHistoricFile;
    property UpdateSourceFile: string read FUpdateSourceFile;
  end;

var
  FrmUpdatesHistoric: TFrmUpdatesHistoric;

implementation

{$R *.dfm}

{ TFrmUpdatesHistoric }

procedure TFrmUpdatesHistoric.ActVerifyUpdatesExecute(Sender: TObject);
var
 aUpdateInfoObj: TCosmosUpdateInfo;
begin
  inherited;
  aUpdateInfoObj := TCosmosUpdateInfo.Create;

  try
   aUpdateInfoObj.UpdatesHistoricFile := self.UpdateHistoricFile;
   aUpdateInfoObj.RemoteSource := self.UpdateSourceFile;
   aUpdateInfoObj.UpdateFolder := ICosmosApp.IApplicationPaths.ReadUpdatesFolder;
   aUpdateInfoObj.CheckUpdates;

   if aUpdateInfoObj.HasUpdate then
     aUpdateInfoObj.DownloadUpdate;

  finally
   if Assigned(aUpdateInfoObj) then
    begin
     FreeAndNil(aUpdateInfoObj);
    end;
  end;
end;

function TFrmUpdatesHistoric.CreateXMLDocument: TXMLDocument;
begin
  Result := TXMLDocument.Create(Application);
  Result.Options := [doNodeAutoCreate,doNodeAutoIndent,doAttrNull,doAutoPrefix,doNamespaceDecl];
  Result.ParseOptions := [];
end;

procedure TFrmUpdatesHistoric.ExportData;
begin
  inherited;

end;

procedure TFrmUpdatesHistoric.FormActivate(Sender: TObject);
begin
  inherited;
  IRemoteCon.ActiveDataset := nil;
  IRemoteCon.ActiveDataNavigator := self.DataNavigator;
end;

procedure TFrmUpdatesHistoric.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if Assigned(FDataNavigator) then
   FreeAndNil(FDataNavigator);
end;

procedure TFrmUpdatesHistoric.FormCreate(Sender: TObject);
begin
  inherited;
  self.XMLUpdatesHistoric.NodeIndentStr :=  #13;

  FDataNavigator := TListViewDataNavigator.Create(self.LsvHistoric);
  DataNavigator := FDataNavigator;
  TListViewDataNavigator(DataNavigator).OnUpdateData := self.UpdateData;

  self.SetUpdatesHistoricFileName;
  self.LoadUpdatesHistoric;
end;

function TFrmUpdatesHistoric.GetFormDescription: string;
begin
 Result := TDockedFormDesc.FormUpdatesHistoric;
end;

function TFrmUpdatesHistoric.GetFormIDName: string;
begin
 Result := 'Cosmos.Updates.Historic';
end;

function TFrmUpdatesHistoric.GetHelpFile: string;
begin
 Result := HelpFile;
end;

function TFrmUpdatesHistoric.GetHelpID: integer;
begin
 Result := self.HelpID;
end;

function TFrmUpdatesHistoric.GetTitle: string;
begin
 Result := Caption;
end;

procedure TFrmUpdatesHistoric.LoadUpdatesHistoric;
var
 I: integer;
 UpdatesNodes, AUpdateNode: IXMLNode;
 AItem: TListItem;
 AUpdateInfo: PUpdateInfo;
begin
{Registra no histórico de atualizações informações sobre a atualização corrente.}
 XMLUpdatesHistoric.FileName := self.UpdateHistoricFile;
 XMLUpdatesHistoric.Active := True;

 if XMLUpdatesHistoric.Active then
  begin
   UpdatesNodes := XMLUpdatesHistoric.DocumentElement;
   UpdatesNodes := UpdatesNodes.ChildNodes.First;

   LsvHistoric.Items.Clear;

   for I := 0 to Pred(UpdatesNodes.ChildNodes.Count) do
    begin
     AUpdateNode := UpdatesNodes.ChildNodes.Get(I);
     if (AUpdateNode <> nil) then
      begin
       if AUpdateNode.Attributes['UpdateId'] <> null then
        begin
         New(AUpdateInfo);
         AUpdateInfo.UpdateId := AUpdateNode.Attributes['UpdateId'];
         AUpdateInfo.UpdateStatusId := AUpdateNode.Attributes['UpdateStatusId'];
         AUpdateInfo.UpdateStatus := AUpdateNode.Attributes['UpdateStatus'];

         if Trim(AUpdateNode.Attributes['UpdateDate']) <> '' then
           AUpdateInfo.UpdateDate := TDataConverter.ToDateTime(AUpdateNode.Attributes['UpdateDate']);

         if Trim(AUpdateNode.Attributes['DownloadDate']) <> '' then
           AUpdateInfo.DownloadDate := TDataConverter.ToDateTime(AUpdateNode.Attributes['DownloadDate']);

         if Trim(AUpdateNode.Attributes['ExecuteDate']) <> '' then
           AUpdateInfo.ExecuteDate := TDataConverter.ToDateTime(AUpdateNode.Attributes['ExecuteDate']);

         AUpdateInfo.UpdateName := AUpdateNode.Attributes['UpdateName'];
         AUpdateInfo.UpdateDescription := AUpdateNode.Attributes['UpdateDescription'];
         AUpdateInfo.UpdateSource := AUpdateNode.Attributes['UpdateSource'];
         AUpdateInfo.UpdateFile := AUpdateNode.Attributes['UpdateFile'];

         AItem := LsvHistoric.Items.Add;
         AItem.Data := AUpdateInfo;

         AItem.Caption := AUpdateNode.Attributes['UpdateId'];
         AItem.SubItems.Append(AUpdateNode.Attributes['UpdateStatus']);
         AItem.SubItems.Append(AUpdateNode.Attributes['UpdateDate']);
         AItem.SubItems.Append(AUpdateNode.Attributes['DownloadDate']);
         AItem.SubItems.Append(AUpdateNode.Attributes['ExecuteDate']);
         AItem.SubItems.Append(AUpdateNode.Attributes['UpdateName']);
         AItem.SubItems.Append(AUpdateNode.Attributes['UpdateDescription']);
         AItem.SubItems.Append(AUpdateNode.Attributes['UpdateStatusId']);

         case AUpdateInfo.UpdateStatusId of
          1: AItem.ImageIndex := 0;
          2: AItem.ImageIndex := 1;
          3: AItem.ImageIndex := 2;
          4: AItem.ImageIndex := 3;
         end;
        end;
      end;
    end;
  end;
end;

procedure TFrmUpdatesHistoric.Locate;
begin
  inherited;
  IRemoteCon.DefaultLocate;
end;

procedure TFrmUpdatesHistoric.LsvHistoricSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  inherited;
  if Item <> nil then
   begin
     self.LblTitle.Caption := Item.SubItems.Strings[4];
     self.LblDesc.Caption := Item.SubItems.Strings[5];
   end;
end;

procedure TFrmUpdatesHistoric.RegisterUpdateStatus(UpdateId: string;
  Status: TDownloadStatus);
var
 I: integer;
 ADoc: TXMLDocument;
 ANode, AUpdateNode: IXMLNode;
begin
 if (UpdateId <> '') and (Status <> dsunknown) then
  begin
   ADoc := CreateXMLDocument;
   ADoc.FileName := self.UpdateHistoricFile;
   ADoc.Active := True;

   if ADoc.Active then
    begin
     ANode := ADoc.ChildNodes.FindNode('UpdatesHistoric');
     ANode := ANode.ChildNodes.FindNode('CmUpdates');


     for I := 0 to Pred(ANode.ChildNodes.Count) do
       begin
         AUpdateNode := ANode.ChildNodes.Get(I);
         if (AUpdateNode <> nil) and (AUpdateNode.Attributes['UpdateId'] = UpdateId) then
          begin
           AUpdateNode.Attributes['UpdateStatusId'] := Ord(Status);
           ADoc.SaveToFile(ADoc.FileName);
           Abort;
          end
         else
          if I = Pred(ANode.ChildNodes.Count) then
          begin
           AUpdateNode := ANode.AddChild('UpdateInfo', I + 1);
           AUpdateNode.Attributes['UpdateId'] := UpdateId;
           AUpdateNode.Attributes['UpdateStatusId'] := Ord(Status);

           ADoc.SaveToFile(ADoc.FileName);
           Abort;
          end

       end;
    end;
  end;

end;

procedure TFrmUpdatesHistoric.SetUpdatesHistoricFileName;
var
 AXMLDoc: TXMLDocument;
 ANode: IXMLNode;
begin
{Lê as informações iniciais sobre os arquivos de histórico e fonte de atualizaçõe.}

 AXMLDoc := TXMLDocument.Create(self);

 try
  AXMLDoc.Options := [doNodeAutoCreate,doNodeAutoIndent,doAttrNull,doNamespaceDecl];
  AXMLDoc.NodeIndentStr := #13;
  AXMLDoc.FileName := ICosmosApp.IApplicationPaths.GetCommonConfigurationsFile;
  AXMLDoc.Active := True;

  ANode := AXMLDoc.DocumentElement;
  ANode := ANode.ChildNodes.FindNode('UpdatesInfo');
  ANode := ANode.ChildNodes.FindNode('Info');

  FUpdateHistoricFile := ANode.Attributes['UpdatesHistoricFile'];
  FUpdateSourceFile := ANode.Attributes['UpdatesSourceFile'];

 finally
  if Assigned(AXMLDoc) then
   FreeAndNil(AXMLDoc);
 end;
end;

procedure TFrmUpdatesHistoric.UpdateData(Sender: TObject);
begin
 self.LoadUpdatesHistoric;
end;


procedure TFrmUpdatesHistoric.UpdateVisualElements;
begin
  inherited;
 ActionManager1.Style := ICosmosApp.InterfaceStyle;
end;

initialization
 RegisterClass(TFrmUpdatesHistoric);

finalization
 UnRegisterClass(TFrmUpdatesHistoric);

end.
