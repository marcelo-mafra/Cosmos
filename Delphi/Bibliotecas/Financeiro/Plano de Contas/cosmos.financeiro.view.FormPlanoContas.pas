unit cosmos.financeiro.view.FormPlanoContas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cosmos.framework.view.FrmDocked, ActnList, ImgList, cosmos.system.messages,
  cosmos.framework.datanavigators.treeview, System.Actions, Vcl.ActnMan, Vcl.ActnPopup,
  Vcl.PlatformDefaultStyleActnCtrls, cosmos.frames.PlanoContas, Vcl.Menus,
  cosmos.system.formsconst;

type
  TFrmPlanoContas = class(TFrmCosmosDocked)
    ActNovaConta: TAction;
    FmePlanoContas1: TFmePlanoContas;
    ActAlterarConta: TAction;
    ActDelConta: TAction;
    ActionManager1: TActionManager;
    procedure ActDelContaExecute(Sender: TObject);
    procedure ActAlterarContaExecute(Sender: TObject);
    procedure ActNovaContaExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FmePlanoContas1PopupActionBar1Popup(Sender: TObject);
  private
    { Private declarations }
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
  end;

var
  FrmPlanoContas: TFrmPlanoContas;

implementation

{$R *.dfm}

{ TFrmPlanoContas }

procedure TFrmPlanoContas.ActAlterarContaExecute(Sender: TObject);
begin
  inherited;
    FmePlanoContas1.EditarConta;
end;

procedure TFrmPlanoContas.ActDelContaExecute(Sender: TObject);
begin
  inherited;
  FmePlanoContas1.ExcluiConta;
end;

procedure TFrmPlanoContas.ActNovaContaExecute(Sender: TObject);
begin
  inherited;
  FmePlanoContas1.NovaConta;
end;

procedure TFrmPlanoContas.ExportData;
begin
  inherited;
//  IRemoteCon.DefaultExport();
end;

procedure TFrmPlanoContas.FmePlanoContas1PopupActionBar1Popup(Sender: TObject);
begin
  inherited;
  TPopupActionBar(Sender).Style := ICosmosApp.InterfaceStyle;
end;

procedure TFrmPlanoContas.FormCreate(Sender: TObject);
begin
  inherited;
  FmePlanoContas1.CanEdit := True;
  FmePlanoContas1.ListarContas;

  FDataNavigator := TTreeviewDataNavigator.Create(FmePLanoContas1.TrvContas);
  DataNavigator := FDataNavigator;
  TTreeviewDataNavigator(DataNavigator).OnUpdateData := UpdateData;
end;

function TFrmPlanoContas.GetFormDescription: string;
begin
 Result := TDockedFormDesc.FormPlanoContas;
end;

function TFrmPlanoContas.GetFormIDName: string;
begin
 Result := 'financeiro.plano de contas';
end;

function TFrmPlanoContas.GetHelpFile: string;
begin
 Result := HelpFile;
end;

function TFrmPlanoContas.GetHelpID: integer;
begin
 Result := HelpContext;
end;

function TFrmPlanoContas.GetTitle: string;
begin
 Result := Caption;
end;

procedure TFrmPlanoContas.Locate;
begin
  inherited;
  IRemoteCon.DefaultLocate;
end;


procedure TFrmPlanoContas.UpdateData(Sender: TObject);
begin
 self.FmePlanoContas1.ListarContas;
end;

procedure TFrmPlanoContas.UpdateVisualElements;
begin
  inherited;
 ActionManager1.Style := ICosmosApp.InterfaceStyle;
end;

initialization
 RegisterClass(TFrmPlanoContas);

finalization
 UnRegisterClass(TFrmPlanoContas);

end.
