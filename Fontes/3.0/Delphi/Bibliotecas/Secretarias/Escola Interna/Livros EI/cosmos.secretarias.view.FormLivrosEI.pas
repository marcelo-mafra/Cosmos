
unit cosmos.secretarias.view.FormLivrosEI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cosmos.framework.view.FrmDocked, ActnList, ImgList, ExtCtrls, cosmos.system.messages,
  Menus, cosmos.frames.FrameLivrosLicoesEI, System.Actions, Vcl.ToolWin,
  Vcl.ActnMan, Vcl.ActnCtrls, Vcl.PlatformDefaultStyleActnCtrls,
  cosmos.system.formsconst;

type
  TFrmLivrosEI = class(TFrmCosmosDocked)
    ActionManager1: TActionManager;
    ActionToolBar1: TActionToolBar;
    FmeEIBooks1: TFmeEIBooks;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FmeEIBooks1PopUpMenuPopup(Sender: TObject);
    procedure FmeEIBooks1ActEditLessonExecute(Sender: TObject);
  private
    { Private declarations }

  protected
    function GetFormDescription: string; override;
    function GetFormIDName: string; override;
    function GetHelpFile: string; override;
    function GetHelpID: integer; override;
    function GetTitle: string; override;
    procedure Locate; override;
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
  FrmLivrosEI: TFrmLivrosEI;

implementation

{$R *.dfm}

{ TFrmLivrosEI }

procedure TFrmLivrosEI.FmeEIBooks1ActEditLessonExecute(Sender: TObject);
begin
  inherited;
  FmeEIBooks1.ActEditLessonExecute(Sender);

end;

procedure TFrmLivrosEI.FmeEIBooks1PopUpMenuPopup(Sender: TObject);
begin
  inherited;
  FmeEIBooks1.PopUpMenuPopup(Sender);

end;

procedure TFrmLivrosEI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 inherited;
 Action := caFree;
 FrmLivrosEI := nil;
end;

procedure TFrmLivrosEI.FormCreate(Sender: TObject);
begin
  inherited;
  FmeEIBooks1.ListarDiscipuladosEI;
  FmeEIBooks1.ListLessons := True;
end;

function TFrmLivrosEI.GetFormDescription: string;
begin
 Result := TDockedFormDesc.FormLivrosLicoesEI;
end;

function TFrmLivrosEI.GetFormIDName: string;
begin
 Result := 'Secretarias.LivrosEI';
end;

function TFrmLivrosEI.GetHelpFile: string;
begin

end;

function TFrmLivrosEI.GetHelpID: integer;
begin

end;

function TFrmLivrosEI.GetTitle: string;
begin
 Result := 'Material da E.I.';
end;

procedure TFrmLivrosEI.Locate;
begin
  inherited;
 ICosmosApp.IRemoteCon.DefaultLocate;
end;

procedure TFrmLivrosEI.UpdateVisualElements;
begin
  inherited;
 ActionManager1.Style := ICosmosApp.InterfaceStyle;
end;

initialization
 RegisterClass(TFrmLivrosEI);

finalization
 UnRegisterClass(TFrmLivrosEI);
end.
