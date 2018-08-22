unit cosmos.tools.view.logsreader;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Controls, Vcl.ComCtrls, Vcl.Forms, System.IniFiles,
  Vcl.StdCtrls, Vcl.ImgList, Vcl.PlatformDefaultStyleActnCtrls, System.Actions,
  Vcl.ActnList, Vcl.ActnMan, Vcl.ActnCtrls, Vcl.ToolWin, Vcl.ExtCtrls,
  Vcl.Buttons, cosmos.system.winshell, cosmos.tools.view.logs.interfaces,
  cosmos.classes.application, Vcl.Menus, Xml.xmldom, Xml.XMLIntf,
  Xml.Win.msxmldom, Xml.XMLDoc, cosmos.classes.logs, cosmos.system.messages,
  Cosmos.Framework.Interfaces.Root, cosmos.framework.forms.dlgmessages,
  cosmos.system.types, System.ImageList, cosmos.tools.controller.logsint,
  cosmos.tools.controller.logs;

type
  TExecutionMode = (emClient, emServer);

  TFrmLogsReaderMainForm = class(TForm, ICosmosLogsInterface)
    LsvLogsData: TListView;
    StatusBar: TStatusBar;
    ActionManager1: TActionManager;
    ImageList1: TImageList;
    ActListPrepare: TAction;
    ActListError: TAction;
    ActListAuthenticate: TAction;
    ActionToolBar1: TActionToolBar;
    ActOpenFile: TAction;
    ActClose: TAction;
    ActListTrace: TAction;
    ActListInfo: TAction;
    ActPrior: TAction;
    ActNext: TAction;
    Splitter1: TSplitter;
    ActShowFiles: TAction;
    ActDetailForm: TAction;
    ActDeleteFiles: TAction;
    PopupMenu1: TPopupMenu;
    ExcluirArquivos1: TMenuItem;
    AtualizarLista1: TMenuItem;
    N1: TMenuItem;
    PopupMenu2: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    Erros1: TMenuItem;
    Informao1: TMenuItem;
    Prepare1: TMenuItem;
    race1: TMenuItem;
    ActListConnections: TAction;
    ActListRemoteCalls: TAction;
    ActListWarnings: TAction;
    ActListUnknown: TAction;
    Conexes1: TMenuItem;
    ChamadasRemotas1: TMenuItem;
    Avisos1: TMenuItem;
    Desconhecidos1: TMenuItem;
    Panel1: TPanel;
    LstFiles: TListBox;
    CBXCosmosApp: TComboBox;
    ActUpdate: TAction;
    procedure LsvLogsDataSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure ActOpenFileExecute(Sender: TObject);
    procedure ActListAuthenticateExecute(Sender: TObject);
    procedure ActListErrorExecute(Sender: TObject);
    procedure ActListPrepareExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ActCloseExecute(Sender: TObject);
    procedure ActListTraceExecute(Sender: TObject);
    procedure ActListInfoExecute(Sender: TObject);
    procedure ActPriorExecute(Sender: TObject);
    procedure ActPriorUpdate(Sender: TObject);
    procedure ActNextExecute(Sender: TObject);
    procedure ActNextUpdate(Sender: TObject);
    procedure LstFilesClick(Sender: TObject);
    procedure ActShowFilesExecute(Sender: TObject);
    procedure ActDetailFormExecute(Sender: TObject);
    procedure ActDetailFormUpdate(Sender: TObject);
    procedure ActDeleteFilesExecute(Sender: TObject);
    procedure ActDeleteFilesUpdate(Sender: TObject);
    procedure ActListConnectionsExecute(Sender: TObject);
    procedure ActListRemoteCallsExecute(Sender: TObject);
    procedure ActListWarningsExecute(Sender: TObject);
    procedure ActListUnknownExecute(Sender: TObject);
    procedure CBXCosmosAppChange(Sender: TObject);
    procedure ActUpdateExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);


  private
    { Private declarations }
    FCurrentFile: string;
    FCurrentModule: TCosmosModules;
    FExecutionMode: TExecutionMode;
    FInstallPath: string;
    FLogsFilesPath: string;
    FLogEvents: TLogEvents;
    FCurrentPos: integer;
    IController: IControllerCosmosLogs;

    procedure SetCurrentModule(Value: TCosmosModules);
    procedure SetCurrentFile(value: string);
    procedure LoadFiles;
    function LoadLogData: TCosmosData;
    procedure ReadLogFile(const FileName: string);
    procedure ResumeData;

    procedure ListLogsFiles(const Path: string);
    function GetFileNameStart: string;


  protected
    //function PriorLog: TCosmosData;
    function PriorLog: IControllerLogInfo;
    //function NextLog: TCosmosData;
    function NextLog: IControllerLogInfo;


  public
    { Public declarations }
    property CurrentFile: string read FCurrentFile write SetCurrentFile;
    property CurrentModule: TCosmosModules read FCurrentModule write SetCurrentModule;
    property InstallPath: string read FInstallPath;
    property LogEvents: TLogEvents read FLogEvents write FLogEvents;
    property ExecutionMode: TExecutionMode read FExecutionMode write FExecutionMode;
  end;

var
  FrmLogsReaderMainForm: TFrmLogsReaderMainForm;

implementation

{$R *.dfm}

uses cosmos.tools.view.logsdetailform;

{ TFrmLogsReaderMainForm }

procedure TFrmLogsReaderMainForm.ActCloseExecute(Sender: TObject);
begin
 Close;
end;

procedure TFrmLogsReaderMainForm.ActDeleteFilesExecute(Sender: TObject);
var
 I: integer;
 AFileName: string;
 AMessageDlg: TDlgMessage;
 AMessage: IDlgMessage;
begin
//Exclui os arquivos selecionados na lista.
 AMessageDlg := TDlgMessage.Create;

 try
  AMessage := AMessageDlg as IDlgMessage;
  if AMessage.ConfirmationMessage(TCosmosTitles.LogsCosmos , TCosmosConfMsg.DeleteLogFiles) = mrNo then
   Abort;

 finally
   AMessage := nil;
   AMessageDlg.Free;
 end;

 try
  for I := 0 to Pred(LstFiles.Count) do
   begin
     if LstFiles.Selected[I] then
      begin
       AFileName := FLogsFilesPath + LstFiles.Items.Strings[I];
       DeleteFile(AFileName);
      end;
    end;

 finally
   LoadFiles;
 end;

end;

procedure TFrmLogsReaderMainForm.ActDeleteFilesUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := LstFiles.SelCount > 0;
end;

procedure TFrmLogsReaderMainForm.ActDetailFormExecute(Sender: TObject);
begin
 FrmLogsDetail := TFrmLogsDetail.Create(self);

 try
  FrmLogsDetail.ShowLog(IController.Current);

 finally
  FrmLogsDetail.Free
 end;
end;

procedure TFrmLogsReaderMainForm.ActDetailFormUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := (LsvLogsData.Selected <> nil);
end;

procedure TFrmLogsReaderMainForm.ActListAuthenticateExecute(Sender: TObject);
begin
 if TAction(Sender).Checked then
  LogEvents := LogEvents + [leOnAuthenticateSucess, leOnAuthenticateFail]
 else
  LogEvents := LogEvents - [leOnAuthenticateSucess, leOnAuthenticateFail];

 if CurrentFile <> '' then
  ReadLogFile(CurrentFile);
end;

procedure TFrmLogsReaderMainForm.ActListConnectionsExecute(Sender: TObject);
begin
 if TAction(Sender).Checked then
  LogEvents := LogEvents + [leOnConnect, leOnConnectError, leOnConnectClose]
 else
  LogEvents := LogEvents - [leOnConnect, leOnConnectError, leOnConnectClose];

 if CurrentFile <> '' then
  ReadLogFile(CurrentFile);
end;

procedure TFrmLogsReaderMainForm.ActListErrorExecute(Sender: TObject);
begin
 if TAction(Sender).Checked then
  LogEvents := LogEvents + [leOnError]
 else
  LogEvents := LogEvents - [leOnError];

 if CurrentFile <> '' then
  ReadLogFile(CurrentFile);
end;

procedure TFrmLogsReaderMainForm.ActListInfoExecute(Sender: TObject);
begin
 if TAction(Sender).Checked then
  LogEvents := LogEvents + [leOnInformation]
 else
  LogEvents := LogEvents - [leOnInformation];

 if CurrentFile <> '' then
  ReadLogFile(CurrentFile);
end;

procedure TFrmLogsReaderMainForm.ActListPrepareExecute(Sender: TObject);
begin
 if TAction(Sender).Checked then
  LogEvents := LogEvents + [leOnPrepare]
 else
  LogEvents := LogEvents - [leOnPrepare];

 if CurrentFile <> '' then
  ReadLogFile(CurrentFile);
end;

procedure TFrmLogsReaderMainForm.ActListRemoteCallsExecute(Sender: TObject);
begin
 if TAction(Sender).Checked then
  LogEvents := LogEvents + [leOnMethodCall, leOnMethodCallError]
 else
  LogEvents := LogEvents - [leOnMethodCall, leOnMethodCallError];

 if CurrentFile <> '' then
  ReadLogFile(CurrentFile);
end;

procedure TFrmLogsReaderMainForm.ActListTraceExecute(Sender: TObject);
begin
 if TAction(Sender).Checked then
  LogEvents := LogEvents + [leOnTrace]
 else
  LogEvents := LogEvents - [leOnTrace];

 if CurrentFile <> '' then
  ReadLogFile(CurrentFile);
end;

procedure TFrmLogsReaderMainForm.ActListUnknownExecute(Sender: TObject);
begin
 if TAction(Sender).Checked then
  LogEvents := LogEvents + [leUnknown]
 else
  LogEvents := LogEvents - [leUnknown];

 if CurrentFile <> '' then
  ReadLogFile(CurrentFile);
end;

procedure TFrmLogsReaderMainForm.ActNextExecute(Sender: TObject);
var
 I: integer;
 AItem: TListItem;
begin
 I := LsvLogsData.Selected.Index;
 AItem := LsvLogsData.Items.Item[I + 1];
 LsvLogsData.Selected := AItem;
end;

procedure TFrmLogsReaderMainForm.ActNextUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := (LsvLogsData.Selected <> nil)
    and (LsvLogsData.Selected.Index < LsvLogsData.Items.Count - 1);
end;

procedure TFrmLogsReaderMainForm.ActOpenFileExecute(Sender: TObject);
begin
 LoadFiles;
end;

procedure TFrmLogsReaderMainForm.ActPriorExecute(Sender: TObject);
var
 I: integer;
 AItem: TListItem;
begin
 I := LsvLogsData.Selected.Index;
 AItem := LsvLogsData.Items.Item[I - 1];
 LsvLogsData.Selected := AItem;
end;

procedure TFrmLogsReaderMainForm.ActPriorUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := (LsvLogsData.Selected <> nil)
    and (LsvLogsData.Selected.Index <> 0);
end;

procedure TFrmLogsReaderMainForm.ActShowFilesExecute(Sender: TObject);
begin
 LstFiles.Visible := TAction(sender).Checked;
end;

procedure TFrmLogsReaderMainForm.ActUpdateExecute(Sender: TObject);
begin
 ReadLogFile(CurrentFile);
end;

procedure TFrmLogsReaderMainForm.CBXCosmosAppChange(Sender: TObject);
begin
 case CBXCosmosApp.ItemIndex of
  0: CurrentModule := cmSecretarias;
  1: CurrentModule := cmConferencias;
  2: CurrentModule := cmFinanceiro;
  3: CurrentModule := cmUsuarios;
  4: CurrentModule := cmFocos;
 end;
end;

procedure TFrmLogsReaderMainForm.ActListWarningsExecute(Sender: TObject);
begin
 if TAction(Sender).Checked then
  LogEvents := LogEvents + [leOnWarning]
 else
  LogEvents := LogEvents - [leOnWarning];

 if CurrentFile <> '' then
  ReadLogFile(CurrentFile);
end;

procedure TFrmLogsReaderMainForm.FormCreate(Sender: TObject);
 var
  Buffer: array[0..260] of Char;
begin
 LogEvents := [leOnAuthenticateSucess, leOnAuthenticateFail, leOnError, leOnInformation,
    leOnPrepare, leOnMethodCall, leOnMethodCallError]; //padrão.

{Carrega as configurações de registro de logs do servidor em execução.}

//Recupera a pasta onde se encontra a aplicação ou módulo.
 GetModuleFileName(0, Buffer, SizeOf(Buffer));
 FInstallPath := Buffer;
 FInstallPath := ExtractFilePath(FInstallPath);

 {Define quais logs serão lidos. Caso o arquivo CosmosRoot.ini esteja presente,
  isso indica que está-se rodando em uma instalação do servidor. Do contrário,
  estamos em uma instalação cliente.}
 if FileExists(InstallPath + 'CosmosRoot.ini') then
  ExecutionMode := emServer
 else
  ExecutionMode := emClient;

 CurrentModule := cmSecretarias;
end;

procedure TFrmLogsReaderMainForm.FormDestroy(Sender: TObject);
begin
 IController := nil;
end;

function TFrmLogsReaderMainForm.GetFileNameStart: string;
begin
 case CurrentModule of
   cmFocos, cmFocosServer: Result := TCosmosAppName.CosmosFocosShort;
   cmSecretarias, cmSecretariasServer: Result := TCosmosAppName.CosmosSecretariasShort;
   cmFinanceiro, cmFinanceiroServer: Result := TCosmosAppName.CosmosFinanceiroShort;
   cmConferencias, cmConferenciasServer: Result := TCosmosAppName.CosmosConferenciasShort;
   cmUsuarios, cmUsuariosServer: Result := TCosmosAppName.CosmosUsuariosShort;
 end;
end;

procedure TFrmLogsReaderMainForm.ListLogsFiles(const Path: string);
var
 AList, ACurrentModule: TStringList;
 sFileNameStart, sFileName: string;
 I: integer;
begin
{Carrega as configurações de registro de logs do servidor em execução.}
 AList := TStringList.Create;
 ACurrentModule := TStringList.Create;

 try
  if Path <> '' then
   begin
    LstFiles.Items.BeginUpdate;
    LstFiles.Items.Clear;
    TShellFiles.FilesOfFolder(Path, 'log', AList);

    sFileNameStart := self.GetFileNameStart;

    for I := 0 to Pred(AList.Count) do
      begin
        sFileName := AList.Strings[I];
        if sFileName.Contains(sFileNameStart) then
         ACurrentModule.Append(AList.Strings[I]);
      end;

    LstFiles.Items.Assign(ACurrentModule);
    LstFiles.Items.EndUpdate;

    if LstFiles.Items.Count > 0 then
     begin
      LstFiles.Selected[0] := True;
      LstFiles.OnClick(LstFiles);
     end;
   end;

  AList.Free;
  ACurrentModule.Free;

 except
  on E: Exception do
   begin
    raise;
   end;
 end;

end;

procedure TFrmLogsReaderMainForm.LoadFiles;
var
  AFile: TIniFile;
  AXMLFile: TXMLDocument;
  ANode: IXMLNode;
  AFileName: string;
begin
{Carrega as configurações de registro de logs do servidor em execução.}
 case ExecutionMode of
   emClient: //ler os logs do cliente.
     begin
      AFileName := InstallPath + 'CosmosFolders.ini';
      AFile := TIniFile.Create(AFileName);
      AFileName := AFile.ReadString('CurrentPaths', 'CommonAppDataPath', '');
      AFileName := AFileName + 'ConfigurationsAll.xml';

      AXMLFile := TXMLDocument.Create(self);

      try
       AXMLFile.FileName := AFileName;
       AXMLFile.Options := [doNodeAutoCreate, doNodeAutoIndent, doAttrNull, doNamespaceDecl];
       AXMLFile.NodeIndentStr := ''#13'';
       AXMLFile.Active := True;

       ANode := AXMLFile.DocumentElement;
       ANode := ANode.ChildNodes.FindNode('LogsInfo');
       ANode := ANode.ChildNodes.FindNode('LogsFile');
       ANode := ANode.ChildNodes.FindNode('Info');

       FLogsFilesPath := ANode.Attributes['LogsFilesPath'];

      except
       on E: Exception do
        begin
         if Assigned(AFile) then FreeAndNil(AFile);
         if Assigned(AXMLFile) then FreeAndNil(AXMLFile);
        end;
      end;
     end;
   emServer: //ler os logs do servidor.
     begin
      AFileName := InstallPath + 'CosmosRoot.ini';
      AFile := TIniFile.Create(AFileName);

      try
       //Recupera no arquivo de configurações do servidor onde estão os arquivos de logs.
       FLogsFilesPath := AFile.ReadString('LOGS', 'ServerLogsPath', '');
       if FLogsFilesPath = '' then
        raise Exception.Create('Error Message');

       if Assigned(AFile) then FreeAndNil(AFile);

      except
       on E: Exception do
        begin
         if Assigned(AFile) then FreeAndNil(AFile);
        end;
      end;
     end;
 end;

 if Assigned(AFile) then FreeAndNil(AFile);
 if Assigned(AXMLFile) then FreeAndNil(AXMLFile);
 ListLogsFiles(FLogsFilesPath);
end;


function TFrmLogsReaderMainForm.LoadLogData: TCosmosData;
var
 AItem: TListItem;
begin
 if LsvLogsData.Selected <> nil then
  begin
   Result := TCosmosData.Create(20);
   AItem := LsvLogsData.Selected;
   Result.WriteValue('LOGDATE', AItem.Caption);
   Result.WriteValue('LOGGEN', AItem.SubItems.Strings[0], 1);
   Result.WriteValue('LOGTYPE', AItem.SubItems.Strings[1], 2);
   Result.WriteValue('LOGINFO', AItem.SubItems.Strings[2], 3);
   Result.WriteValue('LOGCONTEXT', AItem.SubItems.Strings[3], 4);
  end
  else
   Result := nil;
end;

procedure TFrmLogsReaderMainForm.LstFilesClick(Sender: TObject);
var
 AFile: string;
begin
 if LstFiles.ItemIndex >= 0 then
  begin
   AFile := FLogsFilesPath + LstFiles.Items.Strings[LstFiles.ItemIndex];
   CurrentFile := AFile;
  end;
end;

procedure TFrmLogsReaderMainForm.LsvLogsDataSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  FCurrentPos := Item.SubItems.Values['ID'].ToInteger;
  ResumeData;
end;

function TFrmLogsReaderMainForm.NextLog: IControllerLogInfo;
begin
 Result := IController.Next;
end;

procedure TFrmLogsReaderMainForm.ReadLogFile(const FileName: string);
 var
  AItem: TListItem;
begin
  IController := TControllerCosmosLogs.New(FileName);

  try
   screen.Cursor := crHourGlass;
   LsvLogsData.Items.BeginUpdate;
   LsvLogsData.Items.Clear;


   while not IController.EOF do
    begin
      if not (IController.Current.LogType in self.LogEvents) then
       begin
         IController.Next;
         Continue;
       end;

      AItem := LsvLogsData.Items.Add;
      AItem.Caption := DateTimeToStr(IController.Current.Data);

      //Pega a app Cosmos geradora do log.
      AItem.SubItems.Append(IController.Current.Source);

      case IController.Current.LogType of
        leOnInformation:
         begin
          AItem.ImageIndex := 0;
          AItem.SubItems.Append(TCosmosLogs.InfoLogType);
         end;
        leOnError:
         begin
          AItem.ImageIndex := 3;
          AItem.SubItems.Append(TCosmosLogs.ErrorLogType);
         end;
        leOnPrepare:
         begin
          AItem.ImageIndex := 2;
          AItem.SubItems.Append(TCosmosLogs.PrepareLogType);
         end;
        leOnTrace:
         begin
          AItem.ImageIndex := 4;
          AItem.SubItems.Append(TCosmosLogs.TraceLogType);
         end;
        leOnAuthenticateSucess, leOnAuthenticateFail:
         begin
          AItem.ImageIndex := 1;
          AItem.SubItems.Append(TCosmosLogs.AuthLogType);
         end;
        leOnAuthorize:
         begin
          AItem.ImageIndex := 1;
          AItem.SubItems.Append(TCosmosLogs.AutLogType);
         end;
        leOnConnect, leOnConnectError, leOnConnectClose:
         begin
          AItem.ImageIndex := 5;
          AItem.SubItems.Append(TCosmosLogs.ConLogType);
         end;
        leOnMethodCall, leOnMethodCallError:
         begin
          AItem.ImageIndex := 6;
          AItem.SubItems.Append(TCosmosLogs.RemoteCallLogType);
         end;
        leUnknown:
         begin
          AItem.ImageIndex := 7;
          AItem.SubItems.Append(TCosmosLogs.UnknownLogType);
         end;
      end;
      //Pega a mensagem do log.
      AItem.SubItems.Append(IController.Current.Info);
      //Pega a mensagem de contexto de execução do log.
      AItem.SubItems.Append(IController.Current.Context);
      AItem.SubItems.Append(IController.Current.Index.ToString);

      IController.Next;
    end;

  finally
   screen.Cursor := crDefault;
   LsvLogsData.Items.EndUpdate;
   StatusBar.Panels.Items[1].Text := CurrentFile;
   ResumeData;
  end;
end;

procedure TFrmLogsReaderMainForm.ResumeData;
var
 sInfo: string;
begin
 if LsvLogsData.Items.Count > 0 then
  begin
   sInfo := 'Linha %d de %d';

   if LsvLogsData.Selected = nil then
     sInfo := sInfo.Format(sInfo, [1, LsvLogsData.Items.Count])
   else
     sInfo := sInfo.Format(sInfo, [LsvLogsData.Selected.Index + 1, LsvLogsData.Items.Count]);

   StatusBar.Panels.Items[0].Text := sInfo;
  end;
end;

procedure TFrmLogsReaderMainForm.SetCurrentFile(value: string);
begin
 FCurrentFile := Value;
 ReadLogFile(FCurrentFile);
end;

procedure TFrmLogsReaderMainForm.SetCurrentModule(Value: TCosmosModules);
begin
 if FCurrentModule <> Value then
  begin
    FCurrentModule := Value;
    LoadFiles;
  end;
end;

function TFrmLogsReaderMainForm.PriorLog: IControllerLogInfo;
begin
 Result := IController.Prior;
end;

end.
