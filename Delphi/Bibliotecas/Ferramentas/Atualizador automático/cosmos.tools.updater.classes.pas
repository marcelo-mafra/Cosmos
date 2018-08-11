unit cosmos.tools.updater.classes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Classes, System.SysUtils, Vcl.Forms,
  cosmos.framework.interfaces.root, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdHTTP, IdWinsock2, IdGlobal, cosmos.classes.persistence.ini, XMLDoc,
  cosmos.system.messages,  ActiveX, XMLIntf, XMLDom, System.DateUtils,
  IdSSLOpenSSL;

type

  TDownloadStatus = (dsUnknown, dsInProgress, dsTerminated, dsError);
  TNotifyPositionEvent = procedure(MaxPos, Position: integer; Status: TDownloadStatus) of object;
  TNotifyStatusEvent = procedure(UpdateId: string; Status: TDownloadStatus) of object;

  TCosmosUpdateInfo = class
   private
      FUpdatesHistoricFile, FRemoteSource,  FUpdateId, FSourceFile, FUpdateFolder, FUpdateFile: string;
      FPublishedDate: TDateTime;
      FApplied, FHasUpdate: boolean;
      FUpdateStatus: TDownloadStatus;
      AXMLDoc: TXMLDocument;
      FOnStatusEvent: TNotifyStatusEvent;

      procedure OnDownloadProgress(MaxPos, Position: integer; Status: TDownloadStatus);

   public
      constructor Create;
      destructor Destroy; override;
      procedure CheckUpdates;
      procedure DownloadUpdate;

      property UpdateId: string read FUpdateId;
      property SourceFile: string read FSourceFile;
      property PublishedDate: TDateTime read FPublishedDate;
      property UpdateFile: string read FUpdateFile;
      property Applied: boolean read FApplied;

      property HasUpdate: boolean read FHasUpdate default false;
      property RemoteSource: string read FRemoteSource write FRemoteSource;
      property UpdateFolder: string read FUpdateFolder write FUpdateFolder;
      property UpdatesHistoricFile: string read FUpdatesHistoricFile write FUpdatesHistoricFile;
      property UpdateStatus: TDownloadStatus read FUpdateStatus;

      property OnStatusEvent: TNotifyStatusEvent read FOnStatusEvent write FOnStatusEvent;
  end;


  TCosmosUpdate = class(TThread)
   private
      FSourceFile, FDestFile, FUpdateFolder: string;
      FWorkCount, FMaxPosition: Int64;
      FStatus: TDownloadStatus;
      FIdHTTP: TIdHTTP;
      FLHandler: TIdSSLIOHandlerSocketOpenSSL;
      FOnNotifyPositionEvent: TNotifyPositionEvent;

      procedure NotifyPosition(ASender: TObject; AWorkMode: TWorkMode;
        AWorkCount: Int64);
      procedure WorkBegin(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);
      procedure WorkEnd(ASender: TObject; AWorkMode: TWorkMode);
      procedure UpdateMainThread;

   protected
      procedure Execute; override;

   public
      constructor Create;
      destructor Destroy; override;

      property SourceFile: string read FSourceFile write FSourceFile;
      property DestFile: string read FDestFile write FDestFile;
      property Status: TDownloadStatus read FStatus default dsUnknown;
      property UpdateFolder: string read FUpdateFolder write FUpdateFolder;
      property OnNotifyPosition: TNotifyPositionEvent read FOnNotifyPositionEvent write FOnNotifyPositionEvent;

  end;


implementation

{ TCosmosUpdate }

constructor TCosmosUpdate.Create;
begin
  inherited Create;
  FIdHTTP := TIdHTTP.Create(nil);
  FLHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  FIdHTTP.IOHandler := FLHandler;

  FIdHTTP.OnWorkBegin := WorkBegin;
  FIdHTTP.OnWorkEnd := WorkEnd;
  FIdHTTP.OnWork :=  NotifyPosition;
end;

destructor TCosmosUpdate.Destroy;
begin
  if Assigned(FIdHTTP) then
   begin
    FIdHTTP.OnWorkBegin := nil;
    FIdHTTP.OnWorkEnd := nil;
    FIdHTTP.OnWork :=  nil;
    FIdHTTP.Disconnect;
    FreeAndNil(FLHandler);
    FreeAndNil(FIdHTTP);
    OnNotifyPosition := nil;
   end;

  inherited;
end;

procedure TCosmosUpdate.Execute;
var
 aStream: TMemoryStream;
 AFileName: string;
begin
  inherited;
  if Terminated then Exit;

  if not FIdHTTP.Connected then
   begin
    AFileName := UpdateFolder + self.DestFile;
    aStream := TMemoryStream.Create;
   end;

  try
   FIdHTTP.ConnectTimeout := 0;
   FIdHTTP.Get(self.SourceFile, aStream);

   if aStream.Size > 0 then
    aStream.SaveToFile(aFileName);

  finally
   aStream.Free;
  end;
end;

procedure TCosmosUpdate.NotifyPosition(ASender: TObject;
  AWorkMode: TWorkMode; AWorkCount: Int64);
begin
 FWorkCount := AWorkCount;
 FStatus := dsInProgress;
 Synchronize(UpdateMainThread);
end;

procedure TCosmosUpdate.UpdateMainThread;
begin
 if Assigned(OnNotifyPosition) then
  OnNotifyPosition(FMaxPosition, FWorkCount, Status);
end;

procedure TCosmosUpdate.WorkBegin(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCountMax: Int64);
begin
 FWorkCount := 0;
 FMaxPosition := AWorkCountMax;
 FStatus := dsInProgress;
 self.Synchronize(UpdateMainThread);
end;

procedure TCosmosUpdate.WorkEnd(ASender: TObject; AWorkMode: TWorkMode);
begin
 FStatus := dsTerminated;
 self.Synchronize(UpdateMainThread);
 Terminate;
end;

{TCosmosUpdateInfo}

{Esta classe é responsável por localizar em um endereço remoto o arquivo de
 configurações de atualizações para verificar se existe alguma atualização nova.
 Caso exista, a classe retornará os dados da atualização para download e execução,
 que está a cargo de outra classe.}

constructor TCosmosUpdateInfo.Create;
begin
 inherited Create;

  {Cria o XMLDoc com Application no Owner. Se não for assim dará errada a leitura do arquivo.
   Ref: http://docwiki.embarcadero.com/Libraries/XE3/en/Xml.XMLDoc.TXMLDocument}
  AXMLDoc := TXMLDocument.Create(Application);
  AXMLDoc.Options := [doNodeAutoCreate,doNodeAutoIndent,doAttrNull,doAutoPrefix,doNamespaceDecl];
  AXMLDoc.ParseOptions := [];
end;

destructor TCosmosUpdateInfo.Destroy;
begin
  inherited;
  if Assigned(AXMLDoc) then
   begin
    AXMLDoc.Active := False;
    FreeAndNil(AXMLDoc);
   end;
end;

procedure TCosmosUpdateInfo.DownloadUpdate;
var
 aUpdateObj: TCosmosUpdate;
begin
 aUpdateObj := TCosmosUpdate.Create;

 aUpdateObj.OnNotifyPosition := OnDownloadProgress;
 aUpdateObj.DestFile := self.UpdateFile;
 aUpdateObj.SourceFile := self.SourceFile;
 aUpdateObj.UpdateFolder := self.UpdateFolder;
 aUpdateObj.FreeOnTerminate := True;
 aUpdateObj.Priority := tpNormal;
end;

procedure TCosmosUpdateInfo.OnDownloadProgress(MaxPos, Position: integer;
  Status: TDownloadStatus);
var
 ICosmosApp: ICosmosApplication;
begin
 ICosmosApp := Application.MainForm as ICosmosApplication;
 FUpdateStatus := Status;

 try
  case Status of
    dsUnknown: Exit;
    dsInProgress:
     begin
       if ICosmosApp.Components.ProgressBar.Visible = False then
        begin
         //if Assigned(FOnStatusEvent) then FOnStatusEvent(UpdateId, dsInProgress);
         ICosmosApp.Components.ProgressBar.Position := 0;
         ICosmosApp.Components.ProgressBar.Visible := True;
        end;

       ICosmosApp.Components.ProgressBar.MaxPosition := MaxPos;
       ICosmosApp.Components.ProgressBar.Position := Position;
     end;
    dsTerminated:
     begin
       ICosmosApp.Components.ProgressBar.MaxPosition := MaxPos;
       ICosmosApp.Components.ProgressBar.Position := Position;
       ICosmosApp.Components.ProgressBar.Visible := False;
       ICosmosApp.Components.ProgressBar.Position := 0;
       //if Assigned(FOnStatusEvent) then FOnStatusEvent(UpdateId, dsTerminated);
     end;
    dsError:
     begin
       ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.UpdateSystem, TCosmosErrorMsg.UpdateDownload);
       ICosmosApp.Components.ProgressBar.Visible := False;
       ICosmosApp.Components.ProgressBar.Position := 0;
       //if Assigned(FOnStatusEvent) then FOnStatusEvent(UpdateId, dsError);
     end;
  end;

 finally
  if ICosmosApp <> nil then
   ICosmosApp := nil;
 end;
end;

procedure TCosmosUpdateInfo.CheckUpdates;
var
 sCurrentUpdateId: string;
 I: integer;
 ANode, AUpdateNode: IXMLNode;
begin
  inherited;
   //Na fonte remota de info sobre updates, recupera o número do update mais recente.
   if RemoteSource <> '' then
    begin
     AXMLDoc.FileName := RemoteSource;
     AXMLDoc.Active := True;

     if AXMLDoc.Active then
      begin
       ANode := AXMLDoc.ChildNodes.FindNode('UpdatesSource');
       sCurrentUpdateId := ANode.Attributes['CurrentUpdate'];

       for I := 0 to Pred(ANode.ChildNodes.Count) do
        begin
         AUpdateNode := ANode.ChildNodes.Nodes[I];
         AUpdateNode := AUpdateNode.ChildNodes.Nodes['UpdateInfo'];

         if AUpdateNode.Attributes['Enabled'] = True then
          begin
           if sCurrentUpdateId = AUpdateNode.Attributes['UpdateId'] then
            begin
             FUpdateId := sCurrentUpdateId;
             FPublishedDate :=  StrToDateTime(AUpdateNode.Attributes['PublishedDate']);
             FSourceFile := AUpdateNode.Attributes['SourceFile'];
             FUpdateFile := AUpdateNode.Attributes['UpdateFile'];
            end;
          end;
        end;
      end;

  try
     //No arquivo de histórico de atualizações, verifica se o update já foi aplicado...
     if (UpdateId <> '') and (UpdatesHistoricFile <> '') then
      begin
       AXMLDoc.Active := False;
       AXMLDoc.FileName := UpdatesHistoricFile;
       AXMLDoc.Active := True;

       if AXMLDoc.Active then
        begin
         ANode := AXMLDoc.ChildNodes.FindNode('UpdatesHistoric');
         FHasUpdate := UpdateId <> ANode.Attributes['LastUpdateId'];
         AXMLDoc.Active := False;
        end;
      end;

  except
    raise;
  end;
 end;
end;



end.
