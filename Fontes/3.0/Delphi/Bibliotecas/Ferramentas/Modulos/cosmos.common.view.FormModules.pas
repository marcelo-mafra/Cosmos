unit cosmos.common.view.FormModules;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ImgList, Vcl.ComCtrls,
  Vcl.StdCtrls, Cosmos.system.messages, cosmos.classes.persistence.xml, Vcl.Menus,
  Vcl.ActnPopup, Vcl.ActnList, Vcl.ActnMan, cosmos.framework.interfaces.root,
  cosmos.system.winshell, Vcl.PlatformDefaultStyleActnCtrls, System.Actions,
  System.UITypes, cosmos.system.formsconst;

type
  TFileDesc = (fdExecutable, fdLibrary, fdPackage, fdUnknown);
  ELoadDLLError = Exception;
  TGetCustomVersionInfo = function (AppPath, AKey: PChar): PChar; stdcall;
  TGetVersionInfo = function (AppPath: PChar): PChar; stdcall;
  THasVersionInfo =  function (FileName: PChar): boolean; stdcall;

  TFrmModules = class(TForm)
    LsvModules: TListView;
    ImageList1: TImageList;
    StatusBar: TStatusBar;
    PopupActionBar1: TPopupActionBar;
    ActionList1: TActionList;
    ActSave: TAction;
    Salvar1: TMenuItem;
    procedure ActSaveExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure PopupActionBar1Popup(Sender: TObject);
  private
    { Private declarations }
    LibHandle: THandle;
    FICosmosApp: ICosmosApplication;

    procedure FileSearch(const PathName: string; const Extensions: string);
    function GetFileType(FileName: TFileName): TFileDesc;
    procedure AddItem(const FileName: string; FileType: TFileDesc); inline;
    procedure SaveToFile(const FileName: TFileName);
    
  public
    { Public declarations }
    property ICosmosApp: ICosmosApplication read FICosmosApp;
  end;

var
  FrmModules: TFrmModules;

implementation

{$R *.dfm}

{ TFrmModules }

procedure TFrmModules.ActSaveExecute(Sender: TObject);
var
SaveDialog: TSaveDialog;
begin
 SaveDialog := TSaveDialog.Create(self);

 try
  SaveDialog.Filter := TCosmosFiles.XmlFilter;
  SaveDialog.DefaultExt := '.xml';
  SaveDialog.InitialDir := TShellFolders.GetMyDocumentsDir;
  if SaveDialog.Execute then
   self.SaveToFile(SaveDialog.FileName);

 finally
  if Assigned(SaveDialog) then
   FreeAndNil(SaveDialog);
 end;
end;

procedure TFrmModules.AddItem(const FileName: string; FileType: TFileDesc);
var
Item: TListItem;
List: TStringList;
HasVersionInfo: THasVersionInfo;
GetVersionInfo: TGetVersionInfo;
begin
 Item := LsvModules.Items.Add;
 Item.Caption := FileName;
 case FileType of
   fdExecutable:
     begin
      Item.SubItems.Add(TVersionInfo.EXE);
      Item.ImageIndex := 0;
     end;
   fdLibrary:
     begin
      Item.SubItems.Add(TVersionInfo.DLL);
      Item.ImageIndex := 1;
     end;
   fdPackage:
     begin
      Item.SubItems.Add(TVersionInfo.BPL);
      Item.ImageIndex := 2;
     end;
   fdUnknown:
     begin
      Item.SubItems.Add(TVersionInfo.Unknown);
      Item.ImageIndex := 3;
     end;
 end;

 //Obtém informações sobre a versão do arquivo.
  @HasVersionInfo := GetProcAddress(LibHandle, 'HasVersionInfo');//do not localize
 try
  if not (@HasVersionInfo = nil) then
   begin
    if HasVersionInfo(PChar(FileName)) = True then
     begin
      if not Assigned(List) then
       List := TStringList.Create;

      @GetVersionInfo := GetProcAddress(LibHandle, 'GetVersionInfo');//do not localize
      List.CommaText := GetVersionInfo(Pchar(FileName));
      Item.SubItems.Add(List.Values[TVersionInfo.Descricao]);
      Item.SubItems.Add(List.Values[TVersionInfo.FileVersion]);
     end;
   end;
  //else
   //RaiseLastOSError;

 except
   //Não existe informação sobre a versão do arquivo...
   Item.SubItems.Add('');
   Item.SubItems.Add(TCosmosMiscellaneous.UnknowVersionFile);
 end;
end;

procedure TFrmModules.FileSearch(const PathName, Extensions: string);
const
  FileMask = '*.*';
var
  Rec: TSearchRec;
  Path: string;
begin
{Pesquisa os arquivos existentes na pasta de instalação do sistema. Lista estes
 arquivos no controle em tela.}
  Path := IncludeTrailingBackslash(PathName);
  if FindFirst(Path + FileMask, faAnyFile - faDirectory, Rec) = 0 then
    try
      repeat
        if AnsiPos(ExtractFileExt(Rec.Name), Extensions) > 0 then
         begin
          case GetFileType(Rec.Name) of
           fdExecutable : AddItem(Rec.Name, fdExecutable);
           fdLibrary : AddItem(Rec.Name, fdLibrary);
           fdPackage : AddItem(Rec.Name, fdPackage);
          end;
         end;

      until FindNext(Rec) <> 0;
    finally
      System.SysUtils.FindClose(Rec);
    end;

  if FindFirst(Path + '*.*', faDirectory, Rec) = 0 then
    try
      repeat
        if ((Rec.Attr and faDirectory) <> 0) and (Rec.Name <> '.') and
          (Rec.Name <> '..') then
          FileSearch(Path + Rec.Name, Extensions);
      until FindNext(Rec) <> 0;
    finally
      FindClose(Rec);
    end;
end;

procedure TFrmModules.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if LibHandle <> 0 then
  FreeLibrary(LibHandle);
end;

procedure TFrmModules.FormCreate(Sender: TObject);
begin
 self.FICosmosApp := Application.MainForm as ICosmosApplication;
 LibHandle := LoadLibrary('VINFO.DLL');

 FileSearch(ICosmosApp.IApplicationPaths.ReadInstallationPath, '.dll;.bpl;.exe');
end;

function TFrmModules.GetFileType(FileName: TFileName): TFileDesc;
var
Ext: string;
begin
//Retorna o tipo do arquivo.
 Ext := ExtractFileExt(FileName);
 if  Ext = '.exe' then
  Result := fdExecutable
 else
 if  Ext = '.bpl' then
  Result := fdPackage
 else
 if  Ext = '.dll' then
  Result := fdLibrary
 else
  Result := fdUnknown;
end;

procedure TFrmModules.PopupActionBar1Popup(Sender: TObject);
begin
 TPopupActionBar(Sender).Style := ICosmosApp.InterfaceStyle;
end;

procedure TFrmModules.SaveToFile(const FileName: TFileName);
var
I: integer;
Item: TListItem;
AFile: TXMLPersistence;
begin
//Salva as informações sobre os arquivos em um arquivo...
 try
  AFile := TXMLPersistence.Create(FileName, 'Arquivos');

  for I := 0 to self.LsvModules.Items.Count - 1 do
   begin
     Item := self.LsvModules.Items.Item[I];
     AFile.WriteString(Item.Caption, 'Tipo', Item.SubItems.Strings[0]);
     AFile.WriteString(Item.Caption, 'Descrição', Item.SubItems.Strings[1]);
     AFile.WriteString(Item.Caption, 'Versão', Item.SubItems.Strings[2]);
   end;

 AFile.Save;  

 finally
  if Assigned(AFile) then
   FreeAndNil(AFile);
 end;
end;

initialization
 RegisterClass(TFrmModules);

finalization
 UnregisterClass(TFrmModules);

end.
