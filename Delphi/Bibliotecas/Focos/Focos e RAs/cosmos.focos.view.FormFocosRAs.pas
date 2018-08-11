unit cosmos.focos.view.FormFocosRAs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cosmos.framework.view.FrmDocked, ActnList, ImgList, cosmos.system.messages,
  cosmos.frames.FrameFocos, Menus, ExtCtrls, GroupHeader, ComCtrls, StdCtrls, GraphicHeader,
  cosmos.framework.datanavigators.treeview, PlatformDefaultStyleActnCtrls,
  ActnMan, ToolWin, ActnCtrls, cosmos.framework.interfaces.Root,
  cosmos.business.focos, System.Actions, System.Rtti, System.Bindings.Outputs,
  Vcl.Bind.Editors, Data.Bind.EngExt, Vcl.Bind.DBEngExt, Data.Bind.Components,
  Data.Bind.DBScope, Data.DB, Datasnap.DBClient, cosmos.system.formsconst,
  cosmos.framework.interfaces.DataAcess, cosmos.classes.ServerInterface,
  Vcl.ActnPopup;

type
  TFrmFocosRAs = class(TFrmCosmosDocked)
    MainPage: TPageControl;
    TabSheet5: TTabSheet;
    TabSheet3: TTabSheet;
    MSGraphicHeader1: TMSGraphicHeader;
    MSGraphicHeader3: TMSGraphicHeader;
    Label1: TLabel;
    LblRaSup: TLabel;
    Panel1: TPanel;
    LblRaName: TLabel;
    Image1: TImage;
    LsvMentores: TListView;
    TabSheet4: TTabSheet;
    MSGraphicHeader2: TMSGraphicHeader;
    Label2: TLabel;
    LblTipoFoco: TLabel;
    LblSiglaFoco: TLabel;
    Label5: TLabel;
    Panel2: TPanel;
    LblFocusName: TLabel;
    Image2: TImage;
    MSGroupHeader1: TMSGroupHeader;
    LsvEnderecosFocos: TListView;
    ActionToolBar1: TActionToolBar;
    ActionManager1: TActionManager;
    Splitter1: TSplitter;
    FmeFocos1: TFmeFocos;
    CdsMentoresRA: TClientDataSet;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkFillControlToField1: TLinkFillControlToField;
    PopupFocos: TPopupActionBar;
    Endereos1: TMenuItem;
    EditarFoco1: TMenuItem;
    MeiosdeContato1: TMenuItem;
    N1: TMenuItem;
    PopupRas: TPopupActionBar;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    ExcluirRA1: TMenuItem;
    NovoFoco1: TMenuItem;
    procedure Action1Execute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FmeFocos1ActEnderecosFocoExecute(Sender: TObject);
    procedure PopupFocosPopup(Sender: TObject);
    procedure FmeFocos1ActEditFocusExecute(Sender: TObject);
  private
    { Private declarations }
    FDataNavigator: TTreeviewDataNavigator;
    procedure UpdateData(Sender: TObject);
    procedure OnSelectFocus(Sender: TObject);

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
  end;

var
  FrmFocosRAs: TFrmFocosRAs;

implementation

{$R *.dfm}

{ TFrmFocosRAs }

procedure TFrmFocosRAs.Action1Execute(Sender: TObject);
begin
  inherited;
  caption := Caption;
end;

procedure TFrmFocosRAs.ExportData;
var
 ADataset: TClientDataset;
begin
  inherited;
  {Exporta uma listagem de focos e regiões administrativas retornadas na pesquisa.}
  ADataset := TClientDataset.Create(self);

  try
   ICosmosApp.IRemoteCon.ExecuteDQL(csFocosRas, null, ADataset);

   if (ADataset.Active) and not (ADataset.IsEmpty) then
     ICosmosApp.IRemoteCon.DefaultExport(ADataset);

  finally
   if Assigned(ADataset) then FreeAndNil(ADataset);
  end;
end;

procedure TFrmFocosRAs.FmeFocos1ActEditFocusExecute(Sender: TObject);
begin
  inherited;
  FmeFocos1.ActEditFocusExecute(Sender);

end;

procedure TFrmFocosRAs.FmeFocos1ActEnderecosFocoExecute(Sender: TObject);
begin
  inherited;
  FmeFocos1.ActEnderecosFocoExecute(Sender);
end;

procedure TFrmFocosRAs.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Assigned(FDataNavigator) then
   FreeAndNil(FDataNavigator);

  self.FmeFocos1.OnSelectFocus := nil;

  Action := caFree;
  FrmFocosRAs := nil;
end;

procedure TFrmFocosRAs.FormCreate(Sender: TObject);
var
 I: integer;
begin
  inherited;
  FDataNavigator := TTreeviewDataNavigator.Create(self.FmeFocos1.TreeFocos);
  self.DataNavigator := FDataNavigator;
  TTreeviewDataNavigator(DataNavigator).OnUpdateData := UpdateData;
  ICosmosApp.AddCategory(Self.Caption, self.FmeFocos1.ActionFrame);

  for I := 0 to Pred(MainPage.PageCount) do
    MainPage.Pages[I].TabVisible := False;

  MainPage.ActivePageIndex := 0; //default

  self.FmeFocos1.ListType := tlNoneFocus;
  self.FmeFocos1.ListType := tlRA;
  self.FmeFocos1.ListFocosRa := True;
  self.FmeFocos1.ActRAsStyle.Checked := True;
  self.FmeFocos1.OnSelectFocus := self.OnSelectFocus;
  self.FmeFocos1.ToolBar1.Visible := False;

  CdsMentoresRA.RemoteServer :=  ICosmosApp.IRemoteCon.CreateConnection(scFocos);
end;

function TFrmFocosRAs.GetFormDescription: string;
begin
 Result := TDockedFormDesc.FormFocos;
end;

function TFrmFocosRAs.GetFormIDName: string;
begin
 Result := 'GestorFocos.Focos';
end;

function TFrmFocosRAs.GetHelpFile: string;
begin
 Result := Self.HelpFile;
end;

function TFrmFocosRAs.GetHelpID: integer;
begin
 Result := HelpContext;
end;

function TFrmFocosRAs.GetTitle: string;
begin
 Result := Caption;
end;

procedure TFrmFocosRAs.Locate;
begin
  inherited;
  IRemoteCon.DefaultLocate;
end;

procedure TFrmFocosRAs.OnSelectFocus(Sender: TObject);
begin
{Implementa o evento de mudança de foco na árvore de de focos e regiões
 administrativas, presentes no frame.}
 if CdsMentoresRA.Active then CdsMentoresRA.Close;


 case self.FmeFocos1.SelectedType of
   tfRa:
    begin
     self.LblRaName.Caption := FmeFocos1.GetSelectedFocusData.nomfoc;
     if FmeFocos1.SelectedNode.Parent <> nil then
      LblRASup.Caption :=  FmeFocos1.GetFocusData(FmeFocos1.SelectedNode.Parent).nomfoc
     else
      LblRASup.Caption := '-';

     CdsMentoresRA.Params.Items[0].AsInteger := self.FmeFocos1.GetSelectedFocusData.codfoc;
     CdsMentoresRA.Open;
     MainPage.ActivePageIndex := 1
    end;
   tfSedeNacional:
    begin
     self.LblFocusName.Caption := self.FmeFocos1.GetSelectedFocusData.nomfoc;
     self.LblTipoFoco.Caption := TFocusTypesInfo.FocusTypeToString(tfSedeNacional);
     self.LblSiglaFoco.Caption := self.FmeFocos1.GetSelectedFocusData.sigfoc;
     MainPage.ActivePageIndex := 2
    end;
   tfSedeInternacional:
    begin
     self.LblFocusName.Caption := self.FmeFocos1.GetSelectedFocusData.nomfoc;
     self.LblTipoFoco.Caption := TFocusTypesInfo.FocusTypeToString(tfSedeInternacional);
     self.LblSiglaFoco.Caption := self.FmeFocos1.GetSelectedFocusData.sigfoc;
     MainPage.ActivePageIndex := 2
    end;
   tfCentro:
    begin
     self.LblFocusName.Caption := self.FmeFocos1.GetSelectedFocusData.nomfoc;
     self.LblTipoFoco.Caption := TFocusTypesInfo.FocusTypeToString(tfCentro);
     self.LblSiglaFoco.Caption := self.FmeFocos1.GetSelectedFocusData.sigfoc;
     MainPage.ActivePageIndex := 2
    end;
   tfNucleo:
    begin
     self.LblFocusName.Caption := self.FmeFocos1.GetSelectedFocusData.nomfoc;
     self.LblTipoFoco.Caption := TFocusTypesInfo.FocusTypeToString(tfNucleo);
     self.LblSiglaFoco.Caption := self.FmeFocos1.GetSelectedFocusData.sigfoc;
     MainPage.ActivePageIndex := 2
    end;
   tfSala:
    begin
     self.LblFocusName.Caption := self.FmeFocos1.GetSelectedFocusData.nomfoc;
     self.LblTipoFoco.Caption := TFocusTypesInfo.FocusTypeToString(tfSala);
     self.LblSiglaFoco.Caption := self.FmeFocos1.GetSelectedFocusData.sigfoc;
     MainPage.ActivePageIndex := 2
    end;
   tfNucleoCentro:
    begin
     self.LblFocusName.Caption := self.FmeFocos1.GetSelectedFocusData.nomfoc;
     self.LblTipoFoco.Caption := TFocusTypesInfo.FocusTypeToString(tfNucleoCentro);
     self.LblSiglaFoco.Caption := self.FmeFocos1.GetSelectedFocusData.sigfoc;
     MainPage.ActivePageIndex := 2
    end;
   tfLocal:
    begin
     self.LblFocusName.Caption := self.FmeFocos1.GetSelectedFocusData.nomfoc;
     self.LblTipoFoco.Caption := TFocusTypesInfo.FocusTypeToString(tfLocal);
     self.LblSiglaFoco.Caption := self.FmeFocos1.GetSelectedFocusData.sigfoc;
     MainPage.ActivePageIndex := 2
    end;

 end;
end;

procedure TFrmFocosRAs.PopupFocosPopup(Sender: TObject);
begin
  inherited;
  TPopupActionBar(Sender).Style := ICosmosApp.InterfaceStyle;
end;

procedure TFrmFocosRAs.UpdateData(Sender: TObject);
begin
 case self.FmeFocos1.ListType of
  tlRa : self.FmeFocos1.ListType := tlRa;
  tlSequencial: self.FmeFocos1.ListType := tlSequencial;
  tlTitularFocus: self.FmeFocos1.ListType := tlTitularFocus;
  tlTipologic: self.FmeFocos1.ListType := tlTipologic;
  tlNoneFocus: exit;
 end;
end;

procedure TFrmFocosRAs.UpdateVisualElements;
begin
  inherited;
 ActionManager1.Style := ICosmosApp.InterfaceStyle;
end;

initialization
 RegisterClass(TFrmFocosRAs);

finalization
 UnRegisterClass(TFrmFocosRAs);

end.
