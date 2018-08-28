unit cosmos.framework.forms.dlgmessages;

interface

uses
 System.Classes, System.SysUtils, Vcl.Forms, Vcl.Dialogs, cosmos.system.types,
 cosmos.system.messages, cosmos.framework.interfaces.Root, cosmos.system.winshell,
 cosmos.framework.forms.sampledialog, System.variants, cosmos.classes.application,
 cosmos.system.types.cmhelpers;


type
  TDlgMessage = class(TInterfacedPersistent, IDlgMessage)

  private
    { Private declarations }
    FTaskDialogStyle: boolean;
   {$WARN SYMBOL_PLATFORM OFF}
   function DoCreateTaskDialog(const Title, Msg: string; IconType: TTaskDialogIcon): TTaskDialog;
   {$WARN SYMBOL_PLATFORM ON}


  protected
   function CreateMessage: TMessageData;
   function Execute(AMessage: TMessageData): integer; overload;
   function Execute(AMessage: TMessageData; Options: Olevariant): integer; overload;
   function Execute(const MessageData: Olevariant): integer; overload;
   function Execute(const MessageTitle, MessageText: string; DialogType: TMsgDlgType): integer; overload;
   function Execute(const MessageTitle, MessageText: string; DialogType: TMsgDlgType; Options: Olevariant): integer; overload;
   function ConfirmationMessage(const MessageTitle, MessageText: string): integer;
   function ErrorMessage(const MessageTitle, MessageText: string): integer;
   function InfoMessage(const MessageTitle, MessageText: string): integer;
   function WarningMessage(const MessageTitle, MessageText: string): integer;

   {$WARN SYMBOL_PLATFORM OFF}
   function CreateTaskDialog(AMessage: TMessageData): TTaskDialog;
   {$WARN SYMBOL_PLATFORM ON}

  public
    { Public declarations }
   constructor Create;
   destructor Destroy; override;
  end;

implementation

{ TDlgMessage }

{$WARN SYMBOL_PLATFORM OFF}
function TDlgMessage.DoCreateTaskDialog(const Title, Msg: string; IconType: TTaskDialogIcon): TTaskDialog;
var
ICosmosApp: ICosmosApplication;
begin
//Cria uma taskdialog, caso o sitema operacional seja um Windows Vista ou posterior.
 if Supports(Application.MainForm, ICosmosApplication) then
  ICosmosApp := Application.MainForm as ICosmosApplication;

 try
  if self.FTaskDialogStyle then
   begin
    Result := TTaskDialog.Create(nil);
    Result.Title := Title;
    Result.Text := Msg;
    Result.CommonButtons := [tcbOk,tcbClose];
    Result.DefaultButton := tcbOk;
    Result.Flags := [];
    Result.MainIcon := IconType;

    if ICosmosApp <> nil then
     Result.Caption := ICosmosApp.CosmosModule.ModuleName
    else
     Result.Caption := Application.Title;
   end
  else
   Result := nil;

 finally
  if ICosmosApp <> nil then ICosmosApp := nil;
 end;
end;

function TDlgMessage.ErrorMessage(const MessageTitle,
  MessageText: string): integer;
var
TaskDlg: TTaskDialog;
begin
//Exibe uma caixa de mensagem
 TaskDlg := DoCreateTaskDialog(MessageTitle, MessageText, tdiError);
 if TaskDlg <> nil then
  begin
   try
    with TaskDlg do
     begin
       CommonButtons := [tcbOk, tcbClose];
       ExpandedText := '';
       TaskDlg.Execute;
       Result := TaskDlg.ModalResult;
     end;

   finally
    if Assigned(TaskDlg) then
     FreeAndNil(TaskDlg);
   end;
  {$WARN SYMBOL_PLATFORM ON}
  end
 else
  Result := TSampleDialog.ErrorMessage(MessageText);
end;

{$WARN SYMBOL_PLATFORM OFF}
function TDlgMessage.Execute(const MessageTitle, MessageText: string;
  DialogType: TMsgDlgType; Options: Olevariant): integer;
var
TaskDlg: TTaskDialog;
vIconType: TTaskDialogIcon;
AButton: TTaskDialogBaseButtonItem;
I: integer;
begin
//Exibe uma caixa de mensagem
 case DialogType of
  mtInformation: vIconType := tdiInformation;
  mtError:  vIconType := tdiError;
  mtWarning:  vIconType := tdiWarning;
  mtConfirmation: vIconType := tdiShield;
  mtCustom: vIconType := tdiNone;
 end;

 TaskDlg := DoCreateTaskDialog(MessageTitle, MessageText, vIconType);
 if TaskDlg <> nil then
  begin
   try
    with TaskDlg do
     begin
       ExpandedText := '';
       Flags := [tfAllowDialogCancellation,tfUseCommandLinks];

       for I := VarArrayLowBound(Options, 1) to varArrayHighBound(Options, 1) do
        begin
         AButton := TaskDlg.Buttons.Add;
         AButton.Caption := varArrayGet(Options, [I]);
        end;

       TaskDlg.Execute;
       Result := TaskDlg.ModalResult;
     end;

   finally
    if Assigned(TaskDlg) then
     FreeAndNil(TaskDlg);
   end;
  {$WARN SYMBOL_PLATFORM ON}
  end
 else
  case DialogType of
   mtInformation: Result := TSampleDialog.InfoMessage(MessageText);
   mtError:  Result := TSampleDialog.ErrorMessage(MessageText);
   mtWarning: Result := TSampleDialog.WarningMessage(MessageText);
  end;
end;

{$WARN SYMBOL_PLATFORM OFF}
function TDlgMessage.InfoMessage(const MessageTitle,
  MessageText: string): integer;
var
TaskDlg: TTaskDialog;
begin
//Exibe uma caixa de mensagem
 TaskDlg := DoCreateTaskDialog(MessageTitle, MessageText, tdiInformation);
 if TaskDlg <> nil then
  begin
   try
    with TaskDlg do
     begin
       CommonButtons := [tcbOk, tcbClose];
       ExpandedText := '';
       TaskDlg.Execute;
       Result := TaskDlg.ModalResult;
     end;

   finally
    if Assigned(TaskDlg) then
     FreeAndNil(TaskDlg);
   end;
  {$WARN SYMBOL_PLATFORM ON}
  end
 else
  Result := TSampleDialog.InfoMessage(MessageText);
end;

{$WARN SYMBOL_PLATFORM OFF}
function TDlgMessage.WarningMessage(const MessageTitle,
  MessageText: string): integer;
var
TaskDlg: TTaskDialog;
begin
//Exibe uma caixa de mensagem
 TaskDlg := DoCreateTaskDialog(MessageTitle, MessageText, tdiWarning);
 if TaskDlg <> nil then
  begin
   try
    with TaskDlg do
     begin
       CommonButtons := [tcbOk, tcbClose];
       ExpandedText := '';
       TaskDlg.Execute;
       Result := TaskDlg.ModalResult;
     end;

   finally
    if Assigned(TaskDlg) then
     FreeAndNil(TaskDlg);
   end;
  {$WARN SYMBOL_PLATFORM ON}
  end
 else
  Result := TSampleDialog.WarningMessage(MessageText);
end;

function TDlgMessage.Execute(AMessage: TMessageData;
  Options: Olevariant): integer;
{$WARN SYMBOL_PLATFORM OFF}
var
TaskDlg: TTaskDialog;
vIconType: TTaskDialogIcon;
AButton: TTAskDialogBaseButtonItem;
I: integer;
begin
//Exibe uma caixa de mensagem para interagir com o usuário.
 if AMessage = nil then
  Result := -1;

 case AMessage.MessageType of
  mtpSucess, mtpInformation: vIconType := tdiInformation;
  mtpError:  vIconType := tdiError;
  mtpWarning:  vIconType := tdiWarning;
  mtpConfirmation:  vIconType := tdiShield;
 end;

 TaskDlg := DoCreateTaskDialog(AMessage.MessageTitle, AMessage.MessageText,
   vIconType);

 if TaskDlg <> nil then
  begin
   try
    with TaskDlg do
     begin
       ExpandedText := AMessage.XMLData;
       Flags := [tfAllowDialogCancellation,tfUseCommandLinks];

       for I := VarArrayLowBound(Options, 1) to varArrayHighBound(Options, 1) do
        begin
         AButton := TaskDlg.Buttons.Add;
         AButton.Caption := varArrayGet(Options, [I]);
        end;

       //Adiciona o botão de ajuda, se necessário.
       if AMessage.HelpContext > 0 then
        begin
         AButton := TaskDlg.Buttons.Add;
         AButton.Caption := TMessagesConst.BtHelp;
         AButton.Enabled := True;
        end;

       TaskDlg.Execute;
       Result := TaskDlg.ModalResult;
     end;

   finally
    if Assigned(TaskDlg) then
     FreeAndNil(TaskDlg);
   end;
  {$WARN SYMBOL_PLATFORM ON}
  end
 else
  case AMessage.MessageType of
   mtpSucess, mtpInformation: Result := TSampleDialog.InfoMessage(AMessage.MessageText);
   mtpError:  Result := TSampleDialog.ErrorMessage(AMessage.MessageText);
   mtpWarning: Result := TSampleDialog.WarningMessage(AMessage.MessageText);
   mtpConfirmation: Result := TSampleDialog.ConfirmMessage(AMessage.MessageText);
  end;
end;

{$WARN SYMBOL_PLATFORM ON}

function TDlgMessage.Execute(AMessage: TMessageData): integer;
{$WARN SYMBOL_PLATFORM OFF}
var
TaskDlg: TTaskDialog;
vIconType: TTaskDialogIcon;
AButton: TTAskDialogBaseButtonItem;
begin
//Exibe uma caixa de mensagem para interagir com o usuário.
 if AMessage = nil then
  Result := -1;

 case AMessage.MessageType of
  mtpSucess, mtpInformation: vIconType := tdiInformation;
  mtpError:  vIconType := tdiError;
  mtpWarning:  vIconType := tdiWarning;
  mtpConfirmation:  vIconType := tdiShield;
 end;

 TaskDlg := DoCreateTaskDialog(AMessage.MessageTitle, AMessage.MessageText,
   vIconType);

 if TaskDlg <> nil then
  begin
   try
    with TaskDlg do
     begin
       ExpandedText := AMessage.XMLData;

       //Adiciona o botão de ajuda, se necessário.
       if AMessage.HelpContext > 0 then
        begin
         AButton := TaskDlg.Buttons.Add;
         AButton.Caption := TMessagesConst.BtHelp;
         AButton.Enabled := True;
        end;

       TaskDlg.Execute;
       Result := TaskDlg.ModalResult;
     end;

   finally
    if Assigned(TaskDlg) then
     FreeAndNil(TaskDlg);
   end;
  {$WARN SYMBOL_PLATFORM ON}
  end
 else
  case AMessage.MessageType of
   mtpSucess, mtpInformation: Result := TSampleDialog.InfoMessage(AMessage.MessageText);
   mtpError:  Result := TSampleDialog.ErrorMessage(AMessage.MessageText);
   mtpWarning: Result := TSampleDialog.WarningMessage(AMessage.MessageText);
   mtpConfirmation: Result := TSampleDialog.ConfirmMessage(AMessage.MessageText);
  end;
end;

{$WARN SYMBOL_PLATFORM OFF}
function TDlgMessage.ConfirmationMessage(const MessageTitle,
  MessageText: string): integer;
var
TaskDlg: TTaskDialog;
begin
//Exibe uma caixa de mensagem
 TaskDlg := DoCreateTaskDialog(MessageTitle, MessageText, tdiInformation);
 if TaskDlg <> nil then
  begin
   try
    with TaskDlg do
     begin
       CommonButtons := [tcbYes, tcbNo];
       ExpandedText := '';
       TaskDlg.Execute;
       Result := TaskDlg.ModalResult;
     end;

   finally
    if Assigned(TaskDlg) then
     FreeAndNil(TaskDlg);
   end;
  {$WARN SYMBOL_PLATFORM ON}
  end
 else
  Result := TSampleDialog.ConfirmMessage(MessageText);
end;

constructor TDlgMessage.Create;
begin
 inherited Create;
 FTaskDialogStyle := TWinShell.IsWinVista;
end;

destructor TDlgMessage.Destroy;
begin
 inherited Destroy;
end;

function TDlgMessage.CreateMessage: TMessageData;
begin
 Result := TMessageData.Create;
end;

{$WARN SYMBOL_PLATFORM OFF}
function TDlgMessage.CreateTaskDialog(AMessage: TMessageData): TTaskDialog;
var
TaskDlg: TTaskDialog;
vIconType: TTaskDialogIcon;
AButton: TTAskDialogBaseButtonItem;
begin
{Exibe uma caixa de mensagem no estilo TaskDialog. Este método somente deve
 ser usado quando se quer usar os recursos avançados de um TaskDialogs e se
 sabe que o O.S. é um WinVista ou posterior.}
 if AMessage = nil then
  begin
   Result := nil;
   Exit;
  end;

 case AMessage.MessageType of
  mtpSucess, mtpInformation: vIconType := tdiInformation;
  mtpError:  vIconType := tdiError;
  mtpWarning:  vIconType := tdiWarning;
  mtpConfirmation:  vIconType := tdiShield;
 end;

 Result := DoCreateTaskDialog(AMessage.MessageTitle, AMessage.MessageText,
   vIconType);

 if Result <> nil then
  begin
   with Result do
    begin
     Caption := AMessage.CosmosModule.ModuleName;
     ExpandedText := AMessage.XMLData;

     //Adiciona o botão de ajuda, se necessário.
     if AMessage.HelpContext > 0 then
      begin
       AButton := TaskDlg.Buttons.Add;
       AButton.Caption := TMessagesConst.BtHelp;
       AButton.Enabled := True;
      end;
    end;
  {$WARN SYMBOL_PLATFORM ON}
  end;
end;

function TDlgMessage.Execute(const MessageTitle, MessageText: string; DialogType: TMsgDlgType): integer;
var
{$WARN SYMBOL_PLATFORM OFF}
TaskDlg: TTaskDialog;
vIconType: TTaskDialogIcon;
begin
//Exibe uma caixa de mensagem
 case DialogType of
  mtInformation: vIconType := tdiInformation;
  mtError:  vIconType := tdiError;
  mtWarning:  vIconType := tdiWarning;
  mtConfirmation: vIconType := tdiShield;
  mtCustom: vIconType := tdiNone;
 end;

 TaskDlg := DoCreateTaskDialog(MessageTitle, MessageText, vIconType);
 if TaskDlg <> nil then
  begin
   try
    with TaskDlg do
     begin
       ExpandedText := '';
       TaskDlg.Execute;
       Result := TaskDlg.ModalResult;
     end;

   finally
    if Assigned(TaskDlg) then
     FreeAndNil(TaskDlg);
   end;
  {$WARN SYMBOL_PLATFORM ON}
  end
 else
  case DialogType of
   mtInformation: Result := TSampleDialog.InfoMessage(MessageText);
   mtError:  Result := TSampleDialog.ErrorMessage(MessageText);
   mtWarning: Result := TSampleDialog.WarningMessage(MessageText);
  end;
end;

function TDlgMessage.Execute(const MessageData: Olevariant): integer;
{$WARN SYMBOL_PLATFORM OFF}
var
TaskDlg: TTaskDialog;
vIconType: TTaskDialogIcon;
begin
//Exibe uma caixa de mensagem
 case TMessageType(MessageData[1]) of
  mtpSucess, mtpInformation: vIconType := tdiInformation;
  mtpError:  vIconType := tdiError;
  mtpWarning:  vIconType := tdiWarning;
  mtpConfirmation:  vIconType := tdiShield;
  else
   vIconType := tdiInformation;
 end;

 TaskDlg := DoCreateTaskDialog(MessageData[5], MessageData[2], vIconType);
 if TaskDlg <> nil then
  begin
   try
    with TaskDlg do
     begin
       ExpandedText := MessageData[6];
       TaskDlg.Execute;
       Result := TaskDlg.ModalResult;
     end;

   finally
    if Assigned(TaskDlg) then
     FreeAndNil(TaskDlg);
   end;
  {$WARN SYMBOL_PLATFORM ON}
  end
 else
  case TMessageType(MessageData[1]) of
   mtpSucess, mtpInformation: Result := TSampleDialog.InfoMessage(MessageData[2]);
   mtpError:  Result := TSampleDialog.ErrorMessage(MessageData[2]);
   mtpWarning: Result := TSampleDialog.WarningMessage(MessageData[2]);
   mtpConfirmation: Result := TSampleDialog.ConfirmMessage(MessageData[2])
  end;
end;


initialization
 RegisterClass(TDlgMessage);

finalization
 UnRegisterClass(TDlgMessage);

end.
