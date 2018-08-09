unit cosmos.conferencias.view.FormAreasStaff;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cosmos.framework.view.FrmDocked, ActnList, ImgList, PlatformDefaultStyleActnCtrls,
  ActnMan, ToolWin, ActnCtrls, cosmos.system.messages, ComCtrls,
  cosmos.framework.datanavigators.treeview, cosmos.classes.application,
  cosmos.classes.ServerInterface, Menus, ActnPopup, ExtCtrls, cosmos.frames.areasstaff,
  System.Actions, cosmos.system.formsconst;

type
  TFrmAreasStaff = class(TFrmCosmosDocked)
    ActionToolBar1: TActionToolBar;
    ActionManager1: TActionManager;
    FmeAreasStaff: TFmeAreasStaff;
    PopupActionBar1: TPopupActionBar;
    Novarea1: TMenuItem;
    NovoSubrea1: TMenuItem;
    Excluirrea1: TMenuItem;
    N1: TMenuItem;
    NovaTarefa1: TMenuItem;
    AlterarTarefa1: TMenuItem;
    ExcluirTarefa1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure PopupActionBar1Popup(Sender: TObject);
  private
    { Private declarations }
    FCurrentFocusID: integer;
    FDataNavigator: TTreeviewDataNavigator;

    procedure UpdateData(Sender: TObject);

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
    property CurrentFocusID: integer read FCurrentFocusID write FCurrentFocusID;
  end;

var
  FrmAreasStaff: TFrmAreasStaff;

implementation


{$R *.dfm}

procedure TFrmAreasStaff.ExportData;
begin
  inherited;

end;

procedure TFrmAreasStaff.FormActivate(Sender: TObject);
begin
  inherited;
  IRemoteCon.ActiveDataNavigator := self.DataNavigator;
end;

procedure TFrmAreasStaff.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Assigned(FDataNavigator) then
   FreeAndNil(FDataNavigator);

  Action := caFree;
  FrmAreasStaff := nil;
end;

procedure TFrmAreasStaff.FormCreate(Sender: TObject);
begin
  inherited;
  FCurrentFocusID := ICosmosApp.ActiveFocus.FocusID;

  FDataNavigator := TTreeviewDataNavigator.Create(FmeAreasStaff.TrvAreas);
  self.DataNavigator := FDataNavigator;
  TTreeviewDataNavigator(DataNavigator).OnUpdateData := self.UpdateData;

  FmeAreasStaff.Listagem := [ltAreas, ltTarefas];
  FmeAreasStaff.ListarAreas(nil);
end;

function TFrmAreasStaff.GetFormDescription: string;
begin
 Result := TDockedFormDesc.FormAreasStaff;
end;

function TFrmAreasStaff.GetFormIDName: string;
begin
 Result := 'Cosmos.Conferencias.AreasStaff';
end;

function TFrmAreasStaff.GetHelpFile: string;
begin
 Result := self.HelpFile;
end;

function TFrmAreasStaff.GetHelpID: integer;
begin

end;

function TFrmAreasStaff.GetTitle: string;
begin
 Result := Caption;
end;

procedure TFrmAreasStaff.Locate;
begin
  inherited;
  IRemoteCon.DefaultLocate;
end;

procedure TFrmAreasStaff.PopupActionBar1Popup(Sender: TObject);
begin
  inherited;
  TPopupActionBar(Sender).Style := ICosmosApp.InterfaceStyle;
end;

procedure TFrmAreasStaff.UpdateData(Sender: TObject);
begin
 {Caso o foco ativo mude, este método é chamado. Então, deve-se construir a
  árvore por completo. DO contrário, somente será atualizado os nós debaixo
  do selecionado.}
 if CurrentFocusID = ICosmosApp.ActiveFocus.FocusID then
  FmeAreasStaff.TreeData.OnDblClick(FmeAreasStaff.TreeData)
 else
  begin
   CurrentFocusID := ICosmosApp.ActiveFocus.FocusID;
   FmeAreasStaff.ListarAreas(nil);
  end;
end;

procedure TFrmAreasStaff.UpdateVisualElements;
begin
  inherited;
  ActionManager1.Style := ICosmosApp.InterfaceStyle;
end;

initialization
 RegisterClass(TFrmAreasStaff);

finalization
 UnRegisterClass(TFrmAreasStaff);

end.
