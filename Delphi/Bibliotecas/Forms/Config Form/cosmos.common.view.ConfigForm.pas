unit cosmos.common.view.ConfigForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls,
  Winapi.ActiveX, Vcl.ComCtrls, Vcl.ImgList, cosmos.classes.application, cosmos.system.files,
  Winapi.CommCtrl, Cosmos.Framework.Interfaces.Root, Cosmos.Framework.Interfaces.Dialogs,
  cosmos.classes.persistence.registry, cosmos.system.types, cosmos.system.messages,
  Vcl.ExtCtrls, System.ImageList;

type

  TPageTreeIndex = record
   PageCode: string;
   PageTitle: string;
   PageDesc: string;
  end;

  PPageTreeIndex = ^TPageTreeIndex;

  TFrmConfig = class(TForm, ICosmosConfiguration)
    Button1: TButton;
    Button2: TButton;
    PageControl: TPageControl;
    Button5: TButton;
    PageList: TImageList;
    TrvIndex: TTreeView;
    PageRoot: TTabSheet;
    LblRootTitle: TLabel;
    LblRootDesc: TLabel;
    Bevel1: TBevel;
    procedure FormDestroy(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure TrvIndexChange(Sender: TObject; Node: TTreeNode);
    procedure TrvIndexChanging(Sender: TObject; Node: TTreeNode;
      var AllowChange: Boolean);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FICosmosApp: ICosmosApplication;
    FModulesHandles: TStringList;

    function FindRootNode(const Caption: string): TTreeNode;
    function FindChildNode(const Caption: string; ParentNode: TTreeNode): TTreeNode;
    function GetPageCode(APageIndex: TTreeNode): string; inline;
    procedure ActivatePage(const PageCode: string); inline;

    procedure SaveConfigurations;
    procedure LoadModules;
    function LoadPage(const ModuleName: TFileName; ModuleClass: string): ICosmosConfigurationPage;
    procedure RegisterModule(AModule: HModule);
    procedure RegisterTreeIndex(PageInfo: TPageInfo); inline;
    procedure UnloadModules;
    function GetPageInterface(ActivePage: TTabSheet): ICosmosConfigurationPage;
    procedure AddPage(Control: TWinControl; Caption: string;  index, ImageIndex: integer;
     TabEnabled: boolean = True);

  protected
   function GetPageCount: integer;

   function SelectForm: TForm;
   procedure Execute(const CodePage: string); overload;
   function Execute: boolean; overload;

   property PageCount: integer read GetPageCount;


  public
    { Public declarations }
    property ICosmosApp: ICosmosApplication read FICosmosApp;

  end;

var
  FrmConfig: TFrmConfig;

implementation


{$R *.dfm}

procedure SetNodeBoldState(Node: TTreeNode; Value: Boolean);
var
  TVItem: TTVItem;
begin
//Insere ou retira o negrito no texto do objeto TTreeNode passado.
 if not Assigned(Node) then
  Exit;
 with TVItem do
  begin
   mask := TVIF_STATE or TVIF_HANDLE;
   hItem := Node.ItemId;
   stateMask := TVIS_BOLD;
   if Value then state := TVIS_BOLD
   else
    state := 0;
   TreeView_SetItem(Node.Handle, TVItem);
  end;
end;


{ TFrmConfig }

procedure TFrmConfig.LoadModules;
var
I: integer;
IPage: ICosmosConfigurationPage;
Reg: TRegistryPersistence;
ModulesList: TStringList;
AModuleName, AClassName: string;
begin
{Carrega as páginas de configuração registradas que estão em módulos externos.}
 Reg := TRegistryPersistence.CreateReadOnly;

 try
  Reg.Open(TRegistryPaths.LocalMachineKey);

  case ICosmosApp.CosmosModule of
   cmFocos: Reg.OpenKeyReadOnly(TRegistryPaths.GFocosOptions);
   cmSecretarias: Reg.OpenKeyReadOnly(TRegistryPaths.SecretariasOptions);
   cmFinanceiro: Reg.OpenKeyReadOnly(TRegistryPaths.FinanceiroOptions);
   cmUsuarios: Reg.OpenKeyReadOnly(TRegistryPaths.UsuariosOptions);
   cmConferencias: Reg.OpenKeyReadOnly(TRegistryPaths.ConferenciasOptions);
  end;

  ModulesList := TStringList.Create;
  Reg.GetValueNames(ModulesList);

  ModulesList.Sorted := True;
//  ModulesList.Delete(0); //default value key. vem em branco sempre.

  for I := 0 to Pred(ModulesList.Count) do
    begin
     AModuleName := ModulesList.Strings[I];
     AClassName := Reg.ReadString(AModuleName);

     if (AModuleName <> '') and (AClassName <> '') then
      begin
       IPage := nil;
       IPage := self.LoadPage(AModuleName,AClassName);
       if IPage <> nil then
        try
         IPage.LoadOptions;

        except
          on E: Exception do
           begin
            ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, TCosmosErrorMsg.ReadCosmosConfigurations);
            ICosmosApp.MainLog.RegisterError(E.Message);
            Abort;
           end;
        end;
      end;
    end;
  self.TrvIndex.FullExpand;

  Reg.CloseKey;

 finally
  if Assigned(Reg) then
   FreeAndNil(Reg);
 end;
end;

function TFrmConfig.LoadPage(const ModuleName: TFileName;
  ModuleClass: string): ICosmosConfigurationPage;
var
  AModule: HModule;
  AClass: TPersistentClass;
  AForm: TCustomForm;
  AImageIndex: integer;
begin
{Carrega um módulo externo e retorna a interface para manipulação da página
 de opções.}
  Result := nil;

 try
  AModule := LoadPackage(ModuleName);

  if AModule <> 0 then
   begin
    AClass := GetClass(ModuleClass);
    if AClass = nil then
     raise exception.Create(TCosmosErrorMsg.UnregisteredClass);

    if AClass <> nil then
     AForm := TComponentClass(AClass).Create(Application) as TCustomForm;

     if Supports(AForm, ICosmosConfigurationPage) then
      begin
       Result := AForm as ICosmosConfigurationPage;

       if Result.PageInfo.PageImage = nil then
        AImageIndex := -1
       else
        AImageIndex := PageList.Add(Result.PageInfo.PageImage, nil);

       self.RegisterTreeIndex(Result.PageInfo);
       self.AddPage(AForm, Result.PageInfo.CodePage, Result.PageInfo.PageIndex, AImageIndex, Result.Enabled);
       self.RegisterModule(AModule);
      end;
   end;

 except
  raise;
 end;
end;

procedure TFrmConfig.RegisterModule(AModule: HModule);
begin
//Tipo HModule é um LongWord.
 FModulesHandles.Append(IntToStr(AModule));
end;

procedure TFrmConfig.RegisterTreeIndex(PageInfo: TPageInfo);
var
 PTreeIndex: PPageTreeIndex;
 ARootNode, AItemNode: TTreeNode;
 AIndex: integer;
begin
 {Registra as informações sobre a página de configuração na árvore que serve
  de índice para a navegação.}

 //Primeiro, insere o nó raíz.
 New(PTreeIndex);
 PTreeIndex.PageCode := 'Cosmos.PageRoot'; //do not localize!
 PTreeIndex.PageTitle := PageInfo.PageTitle;
 PTreeIndex.PageDesc := PageInfo.PageDesc;

 ARootNode := FindRootNode(PageInfo.PageTreeRoot);
 if ARootNode = nil then
  begin
   ARootNode := TrvIndex.Items.AddObject(nil, PageInfo.PageTreeRoot, PTreeIndex);
   ARootNode.ImageIndex := 0;
   ARootNode.SelectedIndex := ARootNode.ImageIndex;
  end;

 //Agora, insere o nó que aponta para uma página de configuração.
 New(PTreeIndex);
 PTreeIndex.PageCode := PageInfo.CodePage;
 AItemNode := TrvIndex.Items.AddChildObject(ARootNode, PageInfo.PageTreeItem, PTreeIndex);

 if PageInfo.PageImage = nil then
  AIndex := -1
 else
  AIndex := PageList.Add(PageInfo.PageImage, nil);

 AItemNode.ImageIndex := AIndex;
 AItemNode.SelectedIndex := AItemNode.ImageIndex;
end;

procedure TFrmConfig.SaveConfigurations;
var
 I: integer;
 IPage: ICosmosConfigurationPage;
 ANode: TTreeNode;
begin
  for I := 0 to Pred(PageControl.PageCount) do
    begin
      IPage := self.GetPageInterface(PageControl.Pages[I]);
      if IPage <> nil then
       begin
        if IPage.Changed then
         if not IPage.SaveOptions then
          begin
           ANode := self.FindRootNode(IPage.PageInfo.PageTreeRoot);
           if ANode <> nil then
             ANode := self.FindChildNode(IPage.PageInfo.PageTreeItem, ANode);

           if ANode <> nil then
            begin
             TrvIndex.Select(ANode);
             TrvIndex.OnChange(TrvIndex, ANode);
            end;

           Abort;
          end;
       end;
    end;
end;

function TFrmConfig.SelectForm: TForm;
begin
 Result := FrmConfig;
 ShowModal;
end;

procedure TFrmConfig.TrvIndexChange(Sender: TObject; Node: TTreeNode);
var
 APageCode: string;
 PPageIndex: PPageTreeIndex;
begin
 if Node <> nil then
  SetNodeBoldState(Node,True);

 APageCode := GetPageCode(TrvIndex.Selected);
 if APageCode = 'Cosmos.PageRoot' then //do not localize!
  begin
   PPageIndex := TrvIndex.Selected.Data;
   self.LblRootTitle.Caption := TrvIndex.Selected.Text;
   self.LblRootDesc.Caption := PPageIndex.PageDesc;
  end;

 ActivatePage(APageCode);
end;

procedure TFrmConfig.TrvIndexChanging(Sender: TObject; Node: TTreeNode;
  var AllowChange: Boolean);
begin
  //Retira o negrito do nó
  SetNodeBoldState(Node.TreeView.Selected,False);
end;

procedure TFrmConfig.UnloadModules;
var
I: integer;
begin
{Primeiro, destrói as páginas criadas no controle PageControl. Se isto não for
 feito, ocorrerá erro do tipo "Acess violation". Para fazer isso sem erro, deve-se
 tornar o "tab" de cada página visível.}

 for I := 0 to Pred(PageControl.PageCount) do
  PageControl.Pages[I].TabVisible := True;

 while PageControl.PageCount > 0 do
  PageControl.ActivePage.Free;


//Agora, descarrega da memória cada uma das dll's.
 for I := 0 to Pred(FModulesHandles.Count) do
   UnloadPackage(StrToInt(FModulesHandles.Strings[I]));

//Por fim, destrói a lista de dll's carregadas (as páginas).
 if Assigned(FModulesHandles) then
  FModulesHandles.Free;
end;

procedure TFrmConfig.Button1Click(Sender: TObject);
begin
 SaveConfigurations;
 self.ModalResult := mrOK;
end;

procedure TFrmConfig.Button5Click(Sender: TObject);
begin
 if Self.HelpContext <> 0 then
  Application.HelpSystem.ShowContextHelp(Self.HelpContext, Application.CurrentHelpFile);
end;

function TFrmConfig.Execute: boolean;
begin
 TrvIndex.Select(TrvIndex.TopItem);
 Result := ShowModal = mrOK;
end;

procedure TFrmConfig.Execute(const CodePage: string);
var
Tab: TTabSheet;
I: integer;
IPage: ICosmosConfigurationPage;
begin

 for I := 0 to Pred(PageControl.PageCount) do
   begin
    Tab := PageControl.Pages[I];
    IPage := self.GetPageInterface(Tab);

    if IPage.PageInfo.CodePage = CodePage then
     begin
       PageControl.ActivePage := Tab;
       Break;
     end;
   end;

 if (IPage = nil) or (IPage.PageInfo.CodePage <> CodePage) then
  ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, TCosmosErrorMsg.OptionsPageNotFound);

 IPage := nil;
 ShowModal;
end;

procedure TFrmConfig.ActivatePage(const PageCode: string);
var
Tab: TTabSheet;
I: integer;
begin

 for I := 0 to Pred(PageControl.PageCount) do
   begin
    Tab := PageControl.Pages[I];
    if Tab.Caption = PageCode then
     begin
       PageControl.ActivePage := Tab;
       Break;
     end;
   end;
end;

procedure TFrmConfig.AddPage(Control: TWinControl; Caption: string;
  index: integer; ImageIndex: integer; TabEnabled: boolean);
var
Tab: TTabsheet;
begin
 Tab := TTabsheet.Create(self);
 Tab.PageControl := PageControl;
 Tab.Caption := Caption;
 Tab.Enabled := TabEnabled;
 Tab.TabVisible := False;

 Tab.ImageIndex := ImageIndex;

 if Control <> nil then
  begin
   Control.Parent := Tab;
   Control.Align := alClient;
   Control.Visible := True;
  end;

 if Control is TCustomForm then
  begin
   TCustomForm(Control).BorderStyle := bsNone;
  end;
end;

function TFrmConfig.FindChildNode(const Caption: string;
  ParentNode: TTreeNode): TTreeNode;
begin
//Busca um a partir de seu pai.
 Result := ParentNode.getFirstChild;

 while Result <> nil do
  begin
   if Result.Text = Caption then
    Break;
   Result := Result.GetNext;
  end;
end;

function TFrmConfig.FindRootNode(const Caption: string): TTreeNode;
begin
//Busca um nó-raíz a partir de seu texto.
 Result := TrvIndex.TopItem;

 while Result <> nil do
  begin
   if Result.Text = Caption then
    Break;

   Result := Result.getNextSibling;
  end;
end;

procedure TFrmConfig.FormCreate(Sender: TObject);
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;
 self.CustomHint := ICosmosApp.CustomHintObj;

 FModulesHandles := TStringList.Create;

 PageControl.Pages[0].TabVisible := False; //Oculta o tab do primeiro TabSheet.
 self.LoadModules;
end;

procedure TFrmConfig.FormDestroy(Sender: TObject);
begin
 self.UnloadModules;
end;

procedure TFrmConfig.FormShow(Sender: TObject);
begin
 TrvIndex.AlphaSort();
end;

function TFrmConfig.GetPageCode(APageIndex: TTreeNode): string;
var
ANodeData: PPageTreeIndex;
begin
//Recupera o código da página no nó selecionado na treeview.
 if TrvIndex.Selected <> nil then
  begin
    ANodeData := TrvIndex.Selected.Data;
    Result := ANodeData.PageCode;
  end;
end;

function TFrmConfig.GetPageCount: integer;
begin
 Result := PageControl.PageCount;
end;

function TFrmConfig.GetPageInterface(
  ActivePage: TTabSheet): ICosmosConfigurationPage;
var
I: integer;
AForm: TCustomForm;
begin
 Result := nil;

 if ActivePage <> nil then
  begin
   for I := 0 to Pred(ActivePage.ControlCount) do
    begin
      if ActivePage.Controls[I] is TCustomForm then
       begin
        AForm := TCustomForm(ActivePage.Controls[I]);
        if Supports(AForm, ICosmosConfigurationPage) then
         begin
           Result := AForm as ICosmosConfigurationPage;
           Break;
         end;
       end
    end;
  end;
end;

initialization
 RegisterClass(TFrmConfig);

finalization
 UnRegisterClass(TFrmConfig);

end.
