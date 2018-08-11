unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, ActnMan, XPExStyleActnCtrls, ToolWin, ActnCtrls, ActnMenus,
  ExtActns, StdActns, StdCtrls, Menus, ActnPopup, ImgList, XPStyleActnCtrls;

type
  TfrmMain = class(TForm)
    ActionManager1: TActionManager;
    ActionMainMenuBar1: TActionMainMenuBar;
    EditCut1: TEditCut;
    EditCopy1: TEditCopy;
    EditPaste1: TEditPaste;
    EditSelectAll1: TEditSelectAll;
    EditUndo1: TEditUndo;
    EditDelete1: TEditDelete;
    FileOpen1: TFileOpen;
    FileSaveAs1: TFileSaveAs;
    mDoc: TMemo;
    FileExit1: TFileExit;
    PopupActionBar1: TPopupActionBar;
    Undo1: TMenuItem;
    Cut1: TMenuItem;
    Copy1: TMenuItem;
    Paste1: TMenuItem;
    Delete1: TMenuItem;
    SelectAll1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    ImageList1: TImageList;
    UseAdvancedMenuActn: TAction;
    Action2: TAction;
    Action3: TAction;
    Action4: TAction;
    Action6: TAction;
    Action5: TAction;
    AboutActn: TAction;
    SaveActn: TAction;
    SaveDialog1: TSaveDialog;
    procedure FileSaveAs1Accept(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SaveActnExecute(Sender: TObject);
    procedure AboutActnExecute(Sender: TObject);
    procedure Action4Execute(Sender: TObject);
    procedure Action6Execute(Sender: TObject);
    procedure Action5Execute(Sender: TObject);
    procedure ActionMainMenuBar1GetControlClass(Sender: TCustomActionBar; AnItem: TActionClient;
      var ControlClass: TCustomActionControlClass);
    procedure Action3Execute(Sender: TObject);
    procedure UseAdvancedMenuActnExecute(Sender: TObject);
    procedure PopupActionBar1GetControlClass(Sender: TCustomActionBar;
      AnItem: TActionClient; var ControlClass: TCustomActionControlClass);
  private
    FFileName: string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses
    XPExActnCtrls
  , AboutForm
  ;

{$R *.dfm}

procedure TfrmMain.UseAdvancedMenuActnExecute(Sender: TObject);
begin
  TAction(Sender).Checked := not TAction(Sender).Checked;
end;

procedure TfrmMain.AboutActnExecute(Sender: TObject);
begin
  TfrmAbout.Execute;
end;

procedure TfrmMain.Action3Execute(Sender: TObject);
begin
  // so the action is enabled
end;

procedure TfrmMain.Action4Execute(Sender: TObject);
begin
  // so the action is enabled
end;

procedure TfrmMain.Action5Execute(Sender: TObject);
begin
  // so the action is enabled
end;

procedure TfrmMain.Action6Execute(Sender: TObject);
begin
  // so the action is enabled
end;

procedure TfrmMain.ActionMainMenuBar1GetControlClass(Sender: TCustomActionBar; AnItem: TActionClient;
  var ControlClass: TCustomActionControlClass);
begin
  // only use the new style if the UseAdvancedMenu action is checked
  if UseAdvancedMenuActn.Checked then
  begin
    if not (Sender is TActionMainMenuBar) then
      ControlClass := TXPExStyleRichContent;
  end;
end;

procedure TfrmMain.FileSaveAs1Accept(Sender: TObject);
begin
  FFileName := FileSaveAs1.Dialog.FileName;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  FFileName := '';
end;

procedure TfrmMain.PopupActionBar1GetControlClass(Sender: TCustomActionBar;
  AnItem: TActionClient; var ControlClass: TCustomActionControlClass);
begin
  // only use the new style if the UseAdvancedMenu action is checked
  if UseAdvancedMenuActn.Checked then
    ControlClass := TXPExStyleRichContent;
end;

procedure TfrmMain.SaveActnExecute(Sender: TObject);
begin
  if FFileName = '' then
    FileSaveAs1.Execute
  else
    mDoc.Lines.SaveToFile(FFileName);
end;

end.
