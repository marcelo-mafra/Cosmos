unit cosmos.tools.updater.dm;

interface

uses
  SysUtils, Classes, Windows, cosmos.core.winshell, cosmos.core.constantesmsg,
  cosmos.persistence.ini, Graphics, Dialogs, Cosmos.Framework.Interfaces.Utils,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase,
  IdFTP, IdStack, IdIntercept, IdCompressionIntercept, IdZLibCompressorBase, IdCompressorZLib,
  IdHTTP, IdGlobal, Forms, IdExceptionCore, Xml.xmldom, Xml.XMLIntf,
  Xml.Win.msxmldom, Xml.XMLDoc;

type
  ELastUpdateNotFound = Exception;

  TUpdateProtocol = (uppHTTP, uppFTP, uppNetwork);
  TUpdateInfo = (uiUpdateId, uiUpdateStatusId, uiUpdateStatus, uiUpdateDate, uiUpdateName, uiUpdateDesc,
  uiUpdateLocalFile, uiUpdateRemoteFile, uiDownloadDate, uiExecuteDate);

  TDMUpdater = class(TDataModule)
    IdFTPClient: TIdFTP;
    IdTCPClient: TIdTCPClient;
    IdHTTPClient: TIdHTTP;
    IdCompressorZLib: TIdCompressorZLib;
    IdCompressionIntercept1: TIdCompressionIntercept;
    XMLUpdatesSource: TXMLDocument;
    XMLUpdatesHistoric: TXMLDocument;
    procedure DataModuleCreate(Sender: TObject);
    procedure IdHTTPClientWorkEnd(ASender: TObject; AWorkMode: TWorkMode);
    procedure IdHTTPClientWork(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCount: Int64);
    procedure IdHTTPClientWorkBegin(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCountMax: Int64);
    procedure IdHTTPClientConnected(Sender: TObject);
  private
    { Private declarations }
    FUpdateProtocol: TUpdateProtocol;
    FUpdateConfigFile, FUpdateHistoricFile: string;
    FUpdateName, FUpdateDesc, FUpdateId, FUpdateLocalFile, FUpdateRemoteFile: string;
    FUpdatesSource, FUpdatesRootFolder: string;

    procedure LoadUpdateOptions;
    procedure DownloadFile(const SourceFile, ShortName: string);
    procedure RegisterHistoric(const UpdateId: string; Info: variant; InfoType: TUpdateInfo);
    procedure WriteMessage(const Info: string); inline;
    function GetMyLastUpdateId: string;
    function HasUpdates: boolean;
    procedure ExecuteUpdate;


  public
    { Public declarations }
    property UpdateConfigFile: string read FUpdateConfigFile;
    property UpdateHistoricFile: string read FUpdateHistoricFile;
    property UpdateProtocol: TUpdateProtocol read FUpdateProtocol write FUpdateProtocol;
    property UpdateDesc: string read FUpdateDesc write FUpdateDesc;
    property UpdateId: string read FUpdateId write FUpdateId;
    property UpdateLocalFile: string read FUpdateLocalFile write FUpdateLocalFile;
    property UpdateName: string read FUpdateName write FUpdateName;
    property UpdateRemoteFile: string read FUpdateRemoteFile write FUpdateRemoteFile;
    property UpdatesRootFolder: string read FUpdatesRootFolder;
    property UpdatesSource: string read FUpdatesSource write FUpdatesSource;
  end;

var
  DMUpdater: TDMUpdater;

implementation


{$R *.dfm}

uses cosmos.tools.updater.main;

{ TDMUpdater }



procedure TDMUpdater.DataModuleCreate(Sender: TObject);
begin
 ExecuteUpdate;
end;

procedure TDMUpdater.DownloadFile(const SourceFile, ShortName: string);
var
 AFileStream : TFileStream;
 LocalFile: string;
begin
 LocalFile := UpdatesRootFolder;
 LocalFile := LocalFile + '\' + UpdateId;
 if TShellFolders.CreateFolder(LocalFile) then
  begin
   LocalFile := LocalFile + '\' + ShortName;
   UpdateLocalFile := LocalFile;

   AFileStream := TFileStream.Create(UpdateLocalFile, fmCreate);
   WriteMessage('Iniciando a atualização do sistema...');

   try
    case UpdateProtocol of
      uppHTTP: IdHTTPClient.Get(SourceFile, AFileStream);
      uppFTP:
       begin
        IdFTPClient.Connect;
        IdFTPClient.Get(SourceFile, AFileStream);
       end;
      uppNetwork: IdTCPClient.ConnectAndGetAll;
    end;

    if Assigned(AFileStream) then
      FreeAndNil(AFileStream);

   except
    on E: EIdSocketError do
     begin
      WriteMessage('Host não encontrado. Verifique a sua connectividade com a internet.');
     if Assigned(AFileStream) then
      FreeAndNil(AFileStream);
     end;
    on E: EIdReadTimeout do
     begin
      WriteMessage('Timeout de leitura de dados esgotado!');
      if Assigned(AFileStream) then
       FreeAndNil(AFileStream);
     end;
   end;
  end
 else
  raise Exception.Create('Não foi possível criar a pasta temporária de destino dos arquivos de atualização do sistema Cosmos.');
end;

procedure TDMUpdater.ExecuteUpdate;
begin
 //Inicia o processo de busca por atualizações.
  try
   LoadUpdateOptions;

   if HasUpdates then
    DownloadFile(UpdateRemoteFile, UpdateLocalFile)
   else
    Application.Terminate;

  except
   //To-do registrar log de falha..
  end;
end;

function TDMUpdater.GetMyLastUpdateId: string;
begin
 try
  XMLUpdatesHistoric.FileName := self.UpdateHistoricFile;
  XMLUpdatesHistoric.NodeIndentStr := #13;
  XMLUpdatesHistoric.Active := True;
  Result := XMLUpdatesHistoric.DocumentElement.Attributes['LastUpdateId'];

 except
  XMLUpdatesHistoric.Active := False;
 end;
end;

function TDMUpdater.HasUpdates: boolean;
const
 sCannotFindUpdatesSourceFile = 'Não é possível verificar a existência de atualizações ' +
  'do sistema Cosmos. Verifique a sua conexão com a internet ou servidor configurado.';
 sCannotFoundLastUpdate = 'Não foi possível identificar a última atualização do Cosmos. ' +
  'Informe o administrador do Cosmos.';

var
 I: integer;
 sServerLastUpdateId, sMyLastUpdateId: string;
 ANode, AUpdateNode: IXMLNode;
 EnabledUpdate: boolean;

begin
{Obtém como parãmetro de execução o endereço remoto da fonte de atualizações. Este
 endereço é passado pela aplicação que chama o Cosmos Updater. Em seguida, o
 Cosmos Updater faz o seguinte:

 1) Verifica no arquivo local de histórico de atualizações o ID da última atualização.
 2) Conecta-se no endereço remoto e verifica se existem atualizações posteriores
    à última já instalada.
 3) Se positivo, faz o seguinte:
   i) Obtém o ID da atualização seguinte à última instalada.
   ii) Obtém o caminho do arquivo desta nova atualização.
   iii) Obtém o nome (somente nome, sem path) do arquivo da nova atualização.
 4) Se isto aconteceu, o retorno deste método é True.}

 UpdatesSource := ParamStr(1);
 Result := False;
 sMyLastUpdateId := self.GetMyLastUpdateId;

 try
  XMLUpdatesSource.FileName := UpdatesSource;
  XMLUpdatesSource.Active := True;

  with XMLUpdatesSource do
   begin
    ANode := DocumentElement;
    if ANode.NodeName = 'UpdatesSource' then
     sServerLastUpdateId := ANode.Attributes['LastUpdateId'];

    if sServerLastUpdateId = '' then
     Exit
    else
     begin
       ANode :=  ANode.ChildNodes.First;

       for I := 0 to Pred(ANode.ChildNodes.Count) do
         begin
          AUpdateNode := ANode.ChildNodes.Get(I);
          if (AUpdateNode <> nil) and (AUpdateNode.Attributes['UpdateId'] = sMyLastUpdateId) then
           begin
            //Pega a atualização imediatamente posterior à já instalada.
            if (I + 1) > Pred(ANode.ChildNodes.Count) then
             Continue;

            AUpdateNode := ANode.ChildNodes.Get(I + 1);
            if AUpdateNode <> nil then
             begin
              UpdateDesc := AUpdateNode.Attributes['UpdateDescription'];
              UpdateId := AUpdateNode.Attributes['UpdateId'];
              UpdateName := AUpdateNode.Attributes['UpdateName'];
              UpdateRemoteFile := AUpdateNode.Attributes['UpdateSource'];
              UpdateLocalFile := AUpdateNode.Attributes['UpdateFile'];
              EnabledUpdate := AUpdateNode.Attributes['Enabled'];
              Result := EnabledUpdate;

              if Result then
               begin
                RegisterHistoric(UpdateId, UpdateId, uiUpdateId);
                RegisterHistoric(UpdateId, '', uiUpdateDate);
                RegisterHistoric(UpdateId, UpdateName, uiUpdateName);
                RegisterHistoric(UpdateId, UpdateDesc, uiUpdateDesc);
                RegisterHistoric(UpdateId, UpdateRemoteFile, uiUpdateRemoteFile);
                RegisterHistoric(UpdateId, UpdateLocalFile, uiUpdateLocalFile);
               end;

              Break;
             end;
           end;
         end;
     end;
   end;

  XMLUpdatesSource.Active := False;

 except
  on E:ELastUpdateNotFound do
   begin
    Result := False;
    XMLUpdatesSource.Active := False;
    ShowMessage(E.Message);
    //CreateLog(E.Message, EVENTLOG_AUDIT_FAILURE);
   end
   else
    begin
     Result := False;
     XMLUpdatesSource.Active := False;
     ShowMessage(sCannotFindUpdatesSourceFile);
     //CreateLog(E.Message, EVENTLOG_AUDIT_FAILURE);
    end;
 end;
end;

procedure TDMUpdater.IdHTTPClientConnected(Sender: TObject);
begin
 case UpdateProtocol of
   uppHTTP: WriteMessage('O endereço HTTP remoto foi conectado com sucesso.');
   uppFTP: WriteMessage('O servidor FTP remoto foi conectado com sucesso.');
   uppNetwork: WriteMessage('O computador da rede foi conectado com sucesso.');
 end;

end;

procedure TDMUpdater.IdHTTPClientWork(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Int64);
begin
  FrmUpdateStatus.SetProgressPosition(AWorkCount);
  WriteMessage('Obtendo nova atualização ... ');
end;

procedure TDMUpdater.IdHTTPClientWorkBegin(ASender: TObject;
  AWorkMode: TWorkMode; AWorkCountMax: Int64);
begin
  FrmUpdateStatus.Prepare(AWorkCountMax);
  RegisterHistoric(UpdateId, 2, uiUpdateStatusId);
  RegisterHistoric(UpdateId, 'Obtendo a atualização', uiUpdateStatus);
  RegisterHistoric(UpdateId, UpdateRemoteFile, uiUpdateRemoteFile);
  RegisterHistoric(UpdateId, UpdateLocalFile, uiUpdateLocalFile);
end;

procedure TDMUpdater.IdHTTPClientWorkEnd(ASender: TObject;
  AWorkMode: TWorkMode);
begin
 FrmUpdateStatus.SetProgressPosition(FrmUpdateStatus.PBar.Max);
 WriteMessage('Download Finalizado ...');
 FrmUpdateStatus.Updating := False;
 RegisterHistoric(UpdateId, Now, uiDownloadDate);
 RegisterHistoric(UpdateId, 3, uiUpdateStatusId);
 RegisterHistoric(UpdateId, 'Download Finalizado', uiUpdateStatus);

  case UpdateProtocol of
    uppHTTP: IdHTTPClient.Disconnect;
    uppFTP: IdFTPClient.Disconnect;
    uppNetwork: IdTCPClient.Disconnect;
  end;

  FrmUpdateStatus.FinishUpdate(UpdateLocalFile, UpdateId);
end;

procedure TDMUpdater.LoadUpdateOptions;
var
  Reg: TIniFilePersistence;
begin
{Lê as opções de conexão com o computador remoto para obtenção de informações
iniciais sobre a existência de atualizaçõe.}
 FUpdateConfigFile := TShellFolders.GetCommonAppDataFolder;
 FUpdateConfigFile := UpdateConfigFile + sCommonUserData + 'CosmosConfigurations.ini';

 Reg := TIniFilePersistence.Create(UpdateConfigFile, True);

 try
  with Reg do
   begin
    FUpdatesRootFolder := ReadString('Update/Info', 'UpdatesRootFolder', '');
    FUpdateHistoricFile := ReadString('Update/Info', 'UpdatesHistoricFile', '');
    UpdatesSource := ReadString('Update/Info', 'UpdatesSourceFile', '');

    case ReadInteger('Update/Info', 'Protocol', 0) of
     0: UpdateProtocol := uppHTTP;
     1: UpdateProtocol := uppFTP;
     2: UpdateProtocol := uppNetwork;
    end;

   // WebUpdate.LogFileName := ReadString('LogFile');
    //WebUpdate.Logging := ReadBoolean('HasUpdateLog');
    case UpdateProtocol of
      uppHTTP: ;
      uppFTP:
       begin
        IdFTPClient.Host := ReadString('Update/FTP', 'Host', '');

        if ReadInteger('Update/FTP', 'Port', -1) >= 0 then
          IdFTPClient.Port := ReadInteger('Update/FTP', 'Port', -1);

        if ReadInteger('Update/FTP', 'ConnectTimeout', -1) >= 0 then
          IdFTPClient.ConnectTimeout :=  ReadInteger('Update/FTP', 'ConnectTimeout', -1);

        if ReadInteger('Update/FTP', 'ReadTimeout', -1) >= 0 then
          IdFTPClient.ReadTimeout := ReadInteger('Update/FTP', 'ReadTimeout', -1);

        if ReadInteger('Update/FTP', 'IPVersion', 0) = 0 then
         IdFTPClient.IPVersion := id_IPv4
        else
         IdFTPClient.IPVersion := id_IPv6;

         IdFTPClient.BoundIP := ReadString('Update/FTP', 'BoundIP', '');

         if ReadInteger('Update/FTP', 'BoundPort', -1) >= 0 then
           IdFTPClient.BoundPort := ReadInteger('Update/FTP', 'BoundPort', -1);

         IdFTPClient.Username := ReadString('Update/FTP', 'UserName', '');
         IdFTPClient.Password := ReadHash('Update/FTP', 'Password', '');
         IdFTPClient.ProxySettings.Host := ReadString('Update/FTP', 'ProxyHost', '');

         if ReadInteger('Update/FTP', 'ProxyPort', -1) >= 0 then
           IdFTPClient.ProxySettings.Port := ReadInteger('Update/FTP', 'ProxyPort', -1);

         IdFTPClient.ProxySettings.UserName := ReadString('Update/FTP', 'ProxyUserName', '');
         IdFTPClient.ProxySettings.Password := ReadHash('Update/FTP', 'ProxyPassword', '');

         if ReadInteger('Update/FTP', 'TransferTimeout', -1) >= 0 then
          IdFTPClient.TransferTimeout := ReadInteger('Update/FTP', 'TransferTimeout', -1);

         IdFTPClient.ExternalIP := ReadString('Update/FTP', 'ExternalIp', '');
       end;
      uppNetwork:
       begin
        IdTCPClient.Host := ReadString('Update/Network', 'Host', '');

        if ReadInteger('Update/Network', 'Port', -1) >= 0 then
          IdTCPClient.Port := ReadInteger('Update/Network', 'Port', -1);

        if ReadInteger('Update/Network', 'ConnectTimeout', -1) >= 0 then
         IdTCPClient.ConnectTimeout := ReadInteger('Update/Network', 'ConnectTimeout', -1);

        if ReadInteger('Update/Network', 'ReadTimeout', -1) >= 0 then
         IdTCPClient.ReadTimeout := ReadInteger('Update/Network', 'ReadTimeout', -1);

        if ReadInteger('Update/Network', 'IPVersion', 0) = 0 then
         IdTCPClient.IPVersion := id_IPv4
        else
         IdTCPClient.IPVersion := id_IPv6;

         IdTCPClient.BoundIP := ReadString('Update/Network', 'BoundIP', '');

         if ReadInteger('Update/Network', 'BoundPort', -1) >= 0 then
          IdTCPClient.BoundPort := ReadInteger('Update/Network', 'BoundPort', -1);
       end;
    end;
   end;

 finally
  if Assigned(Reg) then
   FreeAndNil(Reg);
 end;
end;

procedure TDMUpdater.RegisterHistoric(const UpdateId: string; Info: variant;
  InfoType: TUpdateInfo);
var
 I: integer;
 UpdatesNodes, AUpdateNode: IXMLNode;
begin
{Registra no histórico de atualizações informações sobre a atualização corrente.}
 if not XMLUpdatesHistoric.Active then
  begin
    XMLUpdatesHistoric.FileName := self.UpdateHistoricFile;
    XMLUpdatesHistoric.Active;
  end;

 UpdatesNodes := XMLUpdatesHistoric.DocumentElement;
 UpdatesNodes := UpdatesNodes.ChildNodes.First;

 for I := 0 to Pred(UpdatesNodes.ChildNodes.Count) do
  begin
   AUpdateNode := UpdatesNodes.ChildNodes.Get(I);
   if (AUpdateNode <> nil) and (AUpdateNode.Attributes['UpdateId'] = UpdateId) then
    Break;
  end;

 if (AUpdateNode <> nil) and (AUpdateNode.Attributes['UpdateId'] = UpdateId) then //Update node.
  begin
    case InfoType of
      uiUpdateId: AUpdateNode.Attributes['UpdateId'] := UpdateId;
      uiUpdateStatusId: AUpdateNode.Attributes['UpdateStatusId'] := Info;
      uiUpdateStatus: AUpdateNode.Attributes['UpdateStatus'] := Info;
      uiUpdateDate: AUpdateNode.Attributes['UpdateDate'] := Info;
      uiUpdateName: AUpdateNode.Attributes['UpdateName'] := Info;
      uiUpdateDesc: AUpdateNode.Attributes['UpdateDescription'] := Info;
      uiUpdateRemoteFile: AUpdateNode.Attributes['UpdateSource'] := Info;
      uiUpdateLocalFile: AUpdateNode.Attributes['UpdateFile'] := Info;
      uiDownloadDate: AUpdateNode.Attributes['DownloadDate'] := Info;
      uiExecuteDate: AUpdateNode.Attributes['ExecuteDate'] := Info;
    end;

    XMLUpdatesHistoric.SaveToFile(self.UpdateHistoricFile);
  end
  else
   begin //Create node.
    AUpdateNode := UpdatesNodes.AddChild('UpdateInfo');

    if InfoType = uiUpdateId then
     begin
      AUpdateNode.Attributes['UpdateId'] := UpdateId;
      AUpdateNode.Attributes['UpdateStatusId'] := 1;
      AUpdateNode.Attributes['UpdateStatus'] := 'Registrado';
      AUpdateNode.Attributes['UpdateDate'] := '';
      AUpdateNode.Attributes['Updatename'] := '';
      AUpdateNode.Attributes['UpdateDescription'] := '';
      AUpdateNode.Attributes['UpdateSource'] := '';
      AUpdateNode.Attributes['UpdateFile'] := '';
      AUpdateNode.Attributes['DownloadDate'] := '';
      AUpdateNode.Attributes['ExecuteDate'] := '';
     end;

    XMLUpdatesHistoric.SaveToFile(self.UpdateHistoricFile);
   end;


end;

procedure TDMUpdater.WriteMessage(const Info: string);
begin
 if Assigned(FrmUpdateStatus) then
   FrmUpdateStatus.WriteMessage(Info);
end;

end.
