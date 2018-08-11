unit cosmos.framework.view.FrmDefWizard;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Wizard, Vcl.ImgList, Vcl.ActnList,
  Vcl.Imaging.jpeg, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Cosmos.Framework.Interfaces.Root, Cosmos.Framework.Interfaces.DataAcess,
  Cosmos.Framework.Interfaces.Dialogs, cosmos.classes.application,
  cosmos.system.messages, Vcl.Imaging.pngimage, System.Actions, System.ImageList;


type
  TFrmCosmosWizard = class(TForm, ICosmosWizard)
    Panel2: TPanel;
    PcWizard: TPageControl;
    TabSheet1: TTabSheet;
    BtnPrior: TBitBtn;
    BtnNext: TBitBtn;
    BtnCancel: TBitBtn;
    Panel1: TPanel;
    Bevel6: TBevel;
    Label12: TLabel;
    Image1: TImage;
    ActionList1: TActionList;
    ActAterior: TAction;
    ActProximo: TAction;
    ImageList1: TImageList;
    LblHelp: TLabel;
    WzCosmos: TWizard;
    Image2: TImage;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Label1: TLabel;
    LblTitle: TLabel;
    BtnHelp: TBitBtn;
    ActHelp: TAction;
    procedure FormDestroy(Sender: TObject);
    procedure ActHelpUpdate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ActHelpExecute(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure ActAteriorExecute(Sender: TObject);
    procedure ActProximoExecute(Sender: TObject);
    procedure ActAteriorUpdate(Sender: TObject);
    procedure ActProximoUpdate(Sender: TObject);
  private
    { Private declarations }
    FICosmosApp: ICosmosApplication;
    FIRemoteCon: ICosmosRemoteConnection;
  protected
   function Execute: boolean; overload; virtual; abstract;
   function Execute(Data: TCosmosData): boolean; overload; virtual; abstract;

  public
    { Public declarations }
    property ICosmosApp: ICosmosApplication read FICosmosApp;
    property IRemoteCon: ICosmosRemoteConnection read FIRemoteCon;

   function GetWizardName: string;
   property WizardName: string read GetWizardName;

  end;

var
  FrmCosmosWizard: TFrmCosmosWizard;

implementation

{$R *.dfm}

procedure TFrmCosmosWizard.ActAteriorExecute(Sender: TObject);
begin
 WzCosmos.PriorPage;
end;

procedure TFrmCosmosWizard.ActProximoExecute(Sender: TObject);
begin
 if not WzCosmos.FinalPage then
  WzCosmos.NextPage
 else
  if Assigned(WzCosmos.OnFinishWizard) then
    WzCosmos.FinishWizard;
end;

procedure TFrmCosmosWizard.ActAteriorUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := not WzCosmos.StartPage;
end;

procedure TFrmCosmosWizard.ActHelpExecute(Sender: TObject);
begin
 if Self.HelpContext <> 0 then
  Application.HelpSystem.ShowContextHelp(Self.HelpContext, Application.CurrentHelpFile);
end;

procedure TFrmCosmosWizard.ActHelpUpdate(Sender: TObject);
begin
TAction(Sender).Visible := Self.HelpContext <> 0;
end;

procedure TFrmCosmosWizard.ActProximoUpdate(Sender: TObject);
begin
 case WzCosmos.CurrentPage.Index of
  0: Taction(Sender).Enabled := True;    //Página 1
 end;

 if WzCosmos.FinalPage then
  begin
   TAction(Sender).Caption := TWizardsConst.Finish;
   BtnNext.ModalResult := mrOK;
  end
 else
  begin
   BtnNext.ModalResult := mrNone;
   TAction(Sender).Caption := TWizardsConst.NextPage;
  end;
end;


procedure TFrmCosmosWizard.FormCreate(Sender: TObject);
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;
 FIRemoteCon := Application.MainForm as ICosmosRemoteConnection;
 self.CustomHint := ICosmosApp.CustomHintObj;
end;

procedure TFrmCosmosWizard.FormDestroy(Sender: TObject);
begin
 if Assigned(FICosmosApp) then
  FICosmosApp := nil;
 if Assigned(FIRemoteCon) then
  FIRemoteCon := nil;
end;

procedure TFrmCosmosWizard.FormShow(Sender: TObject);
begin
 Caption := WzCosmos.Title;
end;

function TFrmCosmosWizard.GetWizardName: string;
begin
 Result := WzCosmos.Title;
end;

procedure TFrmCosmosWizard.BtnCancelClick(Sender: TObject);
begin
 Close;
end;

end.

