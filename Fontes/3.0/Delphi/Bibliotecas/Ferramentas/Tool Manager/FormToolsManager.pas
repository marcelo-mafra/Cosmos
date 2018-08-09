unit FormToolsManager;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TaskBarForm, Cosmos.Framework.Interfaces.Dialogs, ComCtrls, ImgList,
  ToolWin, ActnMan, ActnCtrls, XPStyleActnCtrls, ActnList, cosmos.framework.forms.mydialogs,
  cosmos.core.winshell, ShellAPI;

type
  TToolsManager = class
    private
      FList: TStringList;
      FFileName: string;
      function GetToolCount: integer;
      procedure SetFileName(const Value: string);

    public
      constructor Create;
      destructor Destroy; override;
      procedure AddTool(const ToolName, Command: string);
      function DeleteTool(const ToolName: string): boolean;
      procedure LoadFromFile(const FileName: string);
      procedure SaveToFile(const FileName: string); overload;
      procedure SaveToFile; overload;
      function GetToolString(const Index: integer): string;
      function GetCommand(const ToolName: string): string;

      property FileName: string read FFileName write SetFileName;
      property ToolCount: integer read GetToolCount;

  end;


  TFrmToolsManager = class(TFrmTaskBar, ICosmosToolsManager)
    ImageList1: TImageList;
    LsvTools: TListView;
    StatusBar1: TStatusBar;
    ActionManager1: TActionManager;
    ActionToolBar1: TActionToolBar;
    ActClose: TAction;
    ActExecute: TAction;
    ActNew: TAction;
    ActDel: TAction;
    ImgIcons: TImageList;
    ActHelp: TAction;
    procedure ActHelpExecute(Sender: TObject);
    procedure ActExecuteExecute(Sender: TObject);
    procedure ActNewExecute(Sender: TObject);
    procedure ActDelUpdate(Sender: TObject);
    procedure ActDelExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ActCloseExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FToolManager: TToolsManager;
    procedure LoadTools;
    function GetIcon(const FileName: string): TIcon;

  protected
   procedure OpenManager(const FileName: string);
   procedure Execute(const FileName: string);  

  public
    { Public declarations }
  end;

var
  FrmToolsManager: TFrmToolsManager;

implementation

uses FormEditTool;

{$R *.dfm}

{ TFrmToolsManager }

procedure TFrmToolsManager.ActDelExecute(Sender: TObject);
const
 sQuestion = 'Deseja apagar o registro da ferramenta selecionada?';
begin
  inherited;
  if TMyDialogs.ConfirmMessage(sQuestion) = mrNo then
   exit;
  
  if FToolManager.DeleteTool(LsvTools.Selected.Caption) then
   begin
    FToolManager.SaveToFile;
    LsvTools.Selected.Delete;
   end;
end;

procedure TFrmToolsManager.ActDelUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := LsvTools.Selected <> nil;
end;

procedure TFrmToolsManager.ActExecuteExecute(Sender: TObject);
var
Command: string;
begin
  inherited;
  Command := FToolManager.GetCommand(LsvTools.Selected.Caption);
  TWinShell.OpenProgram(Command, '');
end;

procedure TFrmToolsManager.ActHelpExecute(Sender: TObject);
begin
  inherited;
 if Self.HelpContext <> 0 then
  Application.HelpSystem.ShowContextHelp(Self.HelpContext, Application.CurrentHelpFile);
end;

procedure TFrmToolsManager.ActCloseExecute(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmToolsManager.ActNewExecute(Sender: TObject);
var
ITem: TListItem;
begin
  inherited;
  try
   FrmEditTool := TFrmEditTool.Create(self);
   if FrmEditTool.ShowModal = mrOk then
    begin
     FToolManager.AddTool(FrmEditTool.EdtFerramenta.Text, FrmEditTool.EdtFile.Text);
     FToolManager.SaveToFile;
     Item := LsvTools.Items.Add;
     Item.Caption := FrmEditTool.EdtFerramenta.Text;
     Item.SubItems.Add(FrmEditTool.EdtFile.Text);
    end;

  finally
   if Assigned(FrmEditTool) then
    FreeAndNil(FrmEditTool);
  end;
end;

procedure TFrmToolsManager.Execute(const FileName: string);
begin
 Caption := FileName;
end;

procedure TFrmToolsManager.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
  FrmToolsManager := nil;
end;

procedure TFrmToolsManager.FormCreate(Sender: TObject);
begin
  inherited;
  FToolManager := TToolsManager.Create;
end;

function TFrmToolsManager.GetIcon(const FileName: string): TIcon;
var
  icon: TIcon;
  NumberOfIcons: Integer;
begin
  icon := TIcon.Create;
  try
    // Get the number of Icons
    NumberOfIcons := ExtractIcon(Handle, PChar(FileName), UINT(-1));
    if NumberOfIcons > 0 then
     begin
      Icon.Handle := ExtractIcon(Handle, PChar(FileName), 1);
      Result := Icon;
     end
    else
     Result := nil;

  finally
    icon.Free;
  end;

end;

procedure TFrmToolsManager.LoadTools;
var
I: integer;
s: string;
Item: TListItem;
Icon: TIcon;
begin
 Icon := TIcon.Create;
 for I := 0  to Pred(FToolManager.GetToolCount) do
  begin
   s := FToolManager.GetToolString(I);
   if s <> '' then
    begin
     Item := LsvTools.Items.Add;
     Item.Caption := Copy(s, 1, Pos('=', s) - 1);
     Item.SubItems.Add(Copy(s, Pos('=',s) + 1, Length(s)));
     Icon := GetIcon(Item.SubItems.Strings[0]);
     if Icon <> nil then
      begin
       ImgIcons.AddIcon(Icon);
       Item.ImageIndex := ImgIcons.Count - 1;
      end;
    end;
  end;  
end;

procedure TFrmToolsManager.OpenManager(const FileName: string);
begin
 FToolManager.FileName := FileName;

 if FileExists(FileName) then
  begin
   FToolManager.LoadFromFile(FileName);
   LoadTools;
  end
 else
  FToolManager.SaveToFile(FileName);

 Show;
end;



{ TToolsManager }

procedure TToolsManager.AddTool(const ToolName, Command: string);
begin
 FList.Append(ToolName + '=' + Command);
end;

constructor TToolsManager.Create;
begin
 inherited Create;
 FList := TStringList.Create;
end;

function TToolsManager.DeleteTool(const ToolName: string): boolean;
var
Position: integer;
begin
 Result := False;
 Position := FList.IndexOfName(ToolName);
 if Position >= 0 then
  begin
   FList.Delete(Position);
   Result := True;
  end;
end;

destructor TToolsManager.Destroy;
begin
 FList.Free;
 inherited Destroy;
end;

function TToolsManager.GetCommand(const ToolName: string): string;
begin
 Result := FList.Values[ToolName];
end;

function TToolsManager.GetToolCount: integer;
begin
 Result := FList.Count;
end;

function TToolsManager.GetToolString(const Index: integer): string;
begin
 Result := FList.Strings[Index];
end;

procedure TToolsManager.LoadFromFile(const FileName: string);
begin
 FList.LoadFromFile(FileName);
end;

procedure TToolsManager.SaveToFile(const FileName: string);
begin
 FList.SaveToFile(FileName);
end;

procedure TToolsManager.SaveToFile;
begin
 if FFileName <> '' then
  begin
    FList.SaveToFile(FFileName);
  end;
end;

procedure TToolsManager.SetFileName(const Value: string);
begin
 FFileName := Value;

end;

initialization
 RegisterClass(TFrmToolsManager);

finalization
 UnRegisterClass(TFrmToolsManager);

end.
