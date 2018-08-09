unit cosmos.secretarias.view.FormLicoesEI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, cosmos.frames.FrameLivrosLicoesEI, Cosmos.Framework.Interfaces.DataAcess,
  Cosmos.Framework.Interfaces.Dialogs, StdCtrls, ActnList, System.Actions;

type
  TFrmLicoesEI = class(TForm, ICosmosLocateLessosEI)
    FmeEIBooks1: TFmeEIBooks;
    Panel1: TPanel;
    Button1: TButton;
    ActionList1: TActionList;
    ActOK: TAction;
    Button2: TButton;
    Button3: TButton;
    Panel2: TPanel;
    Image1: TImage;
    Label1: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    procedure Button3Click(Sender: TObject);
    procedure ActOKUpdate(Sender: TObject);
    procedure ActOKExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  protected
    function GetSelectedID: integer;
    function GetSelectedText: string;  
    function GetLessonEI: boolean;
    property SelectedID: integer read GetSelectedID;
    property SelectedText: string read GetSelectedText;

  public
    { Public declarations }
  end;

var
  FrmLicoesEI: TFrmLicoesEI;

implementation

{$R *.dfm}

procedure TFrmLicoesEI.ActOKExecute(Sender: TObject);
begin
ModalResult := mrOk;
end;

procedure TFrmLicoesEI.ActOKUpdate(Sender: TObject);
begin
TAction(Sender).Enabled := FmeEIBooks1.SelectedType = otLicao;
end;

procedure TFrmLicoesEI.Button3Click(Sender: TObject);
begin
 if Self.HelpContext <> 0 then
  Application.HelpSystem.ShowContextHelp(Self.HelpContext, Application.CurrentHelpFile);
end;

procedure TFrmLicoesEI.FormCreate(Sender: TObject);
var
IRemoteCon: ICosmosRemoteConnection;
begin
 IRemoteCon := Application.MainForm as ICosmosRemoteConnection;

 FmeEIBooks1.HideMenu := True;
 FmeEIBooks1.ListLessons := True;
end;

function TFrmLicoesEI.GetLessonEI: boolean;
begin
 FmeEIBooks1.ListarDiscipuladosEI;
 Result := ShowModal = mrOK;
end;

function TFrmLicoesEI.GetSelectedID: integer;
begin
 Result := FmeEIBooks1.SelectedID;
end;

function TFrmLicoesEI.GetSelectedText: string;
begin
 Result := FmeEIBooks1.SelectedText;
end;

initialization
 RegisterClass(TFrmLicoesEI);

finalization
 UnRegisterClass(TFrmLicoesEI);

end.
