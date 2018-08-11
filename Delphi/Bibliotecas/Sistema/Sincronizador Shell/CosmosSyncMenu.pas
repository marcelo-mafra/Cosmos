unit CosmosSyncMenu;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Windows, SysUtils, ActiveX, Classes, ComObj, ShlObj;

type
  TCosmosSyncMenu = class(TComObject, IContextMenu, IShellExtInit)
  private
   FFileName: array[0..MAX_PATH] of char;
   FMenuIdx: UINT;
  protected
  //Métodos de IContextMenu
   function QueryContextMenu(Menu: HMENU; indexMenu, idCmdFirst, idCmdLast,
     uFlags: UINT): HResult; stdcall;
   function InvokeCommand(var lpici: TCMInvokeCommandInfo): HResult; stdcall;
   function GetCommandString(idCmd, uType: UINT; pwReserved: PUINT;
     pszName: LPSTR; cchMax: UINT): HResult; stdcall;

  //Métodos de IShellExtInit
   function Initialize(pidFolder: PItemIDList; lpdobj: IDataObject;
     hKeyProgID: HKEY): HResult; reintroduce; stdcall;
  end;

 TContextMenuFactory = class(TComObjectFactory)

  protected
   function GetProgID: string; override;
   procedure ApproveShellExtension(Register: boolean; const ClsID: string); virtual;

  public
   procedure UpdateRegistry(Register: boolean); override; 
 end;

const
  Class_TCosmosSyncMenu: TGUID = '{16D45F79-B2BB-433C-8CA8-E006D6A6AB99}';

implementation

uses ComServ, ShellAPI, Registry;

procedure ProcessPackage(const FileName: string; ParentWnd: HWND);
begin
 MessageBox(ParentWnd, PWideChar(FileName), 'Em teste',MB_OK);
end;

procedure RegisterFileType(ExtName:String; AppName:String) ;
var
  Reg:TRegistry;
begin
  reg := TRegistry.Create;
  try
   reg.RootKey:=HKEY_CLASSES_ROOT;
   reg.OpenKey('.' + ExtName, True) ;
   reg.WriteString('', ExtName + 'file') ;
   reg.CloseKey;
   reg.CreateKey(ExtName + 'file') ;
   reg.OpenKey(ExtName + 'file\DefaultIcon', True) ;
   reg.WriteString('', AppName + ',0') ;
   reg.CloseKey;
   reg.OpenKey(ExtName + 'file\shell\open\command', True) ;
   reg.WriteString('',AppName+' "%1"') ;
   reg.CloseKey;
  finally
   reg.Free;
   SHChangeNotify(SHCNE_ASSOCCHANGED, SHCNF_IDLIST, nil, nil);
  end
end;

procedure AssociateFileExtension;
var
Reg: TRegistry;
begin
// .cpk
 try
  Reg := TRegistry.Create;
  Reg.RootKey := HKEY_CLASSES_ROOT;
  if Reg.OpenKey('.cpk', True) then
   Reg.WriteString('','CosmosPackage');
  Reg.CloseKey;

  // Comando
  if Reg.OpenKey('CosmosPackage\shell\open\command', True) then
   Reg.WriteString('','C:\Program Files\TextCrypt\TextCrypt.exe %1');
  Reg.CloseKey;

// icon
  if Reg.OpenKey('CosmosPackage\DefaultIcon', True) then
   Reg.WriteString('','C:\Program Files\TextCrypt\TextCrypt.ico');
  Reg.CloseKey;

 finally
  if Assigned(Reg) then
   Reg.Free;
 end;
end;

{ TCosmosSyncMenu }

function TCosmosSyncMenu.InvokeCommand(
  var lpici: TCMInvokeCommandInfo): HResult;
begin
 Result := S_OK;
 try
  //Certifica-se de que não estamos sendo chamados por uma aplicação
  if HiWord(Integer(lpici.lpVerb)) <> 0 then
   begin
    Result := E_FAIL;
    Exit;
   end;

  //Executa o comando especificado por lpci.lpVerb.
  if LoWord(lpici.lpVerb) = FMenuIdx then
   ProcessPackage(FFileName, lpici.hwnd)
  else
   Result := E_INVALIDARG;

 except
  MessageBox(lpici.hwnd, 'Ocorreu um erro ao tentar abrir o pacote de ' +
   'sincronização!', 'Erro', MB_OK or MB_ICONERROR);
  Result := E_FAIL;
 end;
end;

function TCosmosSyncMenu.GetCommandString(idCmd, uType: UINT;
  pwReserved: PUINT; pszName: LPSTR; cchMax: UINT): HResult;
begin
 Result := S_OK;
 try
  {Certifica-se de que o índice do menu está correto e de que o shell esteja
   solicitando string de ajuda.}
  if (idCmd = FMenuIdx) and ((uType and GCS_HELPTEXT) <> 0) then
   //retorna a string de ajuda para o item de menu
   StrLCopy(pszName, 'Processa este pacote de sincronização de dados do Cosmos.', cchMax)
  else
   Result := E_INVALIDARG;

 except
   Result := E_UNEXPECTED;
 end;
end;

function TCosmosSyncMenu.QueryContextMenu(Menu: HMENU; indexMenu, idCmdFirst,
  idCmdLast, uFlags: UINT): HResult;
begin
 FMenuIdx := indexMenu;
 //Adiciona um item de menu ao menu de contexto
 InsertMenu(Menu, FMenuIdx, MF_STRING or MF_BYPOSITION, idCmdFirst,
  'Processar pacote de dados...');
 //Retorna o índice di último índice inserido + 1
  Result := FMenuIdx + 1; 
end;

function TCosmosSyncMenu.Initialize(pidFolder: PItemIDList;
  lpdobj: IDataObject; hKeyProgID: HKEY): HResult;
var
 Medium: TStgMedium;
 FE: TFormatEtc;
begin
 try
  //Aborta a chamada se lpdobj for nil
  if lpdobj = nil then
   begin
    Result := E_FAIL;
    Exit;
   end;

   with FE do
    begin
     cfFormat := CF_HDROP;
     ptd := nil;
     dwAspect := DVASPECT_CONTENT;
     lindex := -1;
     tymed := TYMED_HGLOBAL;
    end;
  //produz os dados referenciados pelo ponteiro IDataObject para um meio de
  //armazenamento HGLOBAL no formato CF_HDROP.
  Result := lpdobj.GetData(FE,Medium);
  if Failed(Result) then
   exit;
  try
   //Se apenas um arquivo for selecionado, recupera o nome do arquivo e o
   //armazena em szFile. Caso contrário, aborta a chamada.
   if DragQueryFile(Medium.hGlobal, $FFFFFFFF, nil, 0) = 1 then
    begin
     DragQueryFile(Medium.hGlobal, 0, FFileName, SizeOf(FFileName));
     Result := NOERROR;
    end
   else
    Result := E_FAIL;
  finally
   ReleaseStgMedium(Medium);
  end;

 except
  Result := E_UNEXPECTED;
 end;
end;

{ TContextMenuFactory }

function TContextMenuFactory.GetProgID: string;
begin
//ProgID não é necessária para a extensão do Shell de menu de contexto.
 Result := '';
end;

procedure TContextMenuFactory.UpdateRegistry(Register: boolean);
var
 ClsID: string;
begin
 ClsID := GUIDToString(ClassID);
 inherited UpdateRegistry(Register);
 ApproveShellExtension(Register, ClsID);
 if Register then
  begin
   //Registra a extensão de arquivo .cpk
   CreateRegKey('.cpk','','PacotesCosmos');
   //Registra esta dll como um manipulador de menu de contexto para estes arquivos
   CreateRegKey('PacotesCosmos\shellex\ContextMenuHandlers\' + ClassName, '', ClsID);
  end
 else
  begin
   DeleteRegKey('.cpk');
   DeleteRegKey('PacotesCosmos\shellex\ContextMenuHandlers\' + ClassName);
  end;
end;

procedure TContextMenuFactory.ApproveShellExtension(Register: boolean;
  const ClsID: string);
const
 sApprovedKey = 'SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Approved';
begin
 with TREgistry.Create do
  begin
   try
    RootKey := HKEY_LOCAL_MACHINE;
    if not OpenKey(SApprovedKey, True) then
     exit;
    if Register then
     WriteString(ClsID, Description)
    else
     DeleteValue(ClsID);

   finally
    Free;
   end;
  end;
end;


initialization
  TComObjectFactory.Create(ComServer, TCosmosSyncMenu, Class_TCosmosSyncMenu,
    'TCosmosSyncMenu', 'Processa pacotes de sincronização de dados do Cosmos', ciMultiInstance, tmApartment);
end.
