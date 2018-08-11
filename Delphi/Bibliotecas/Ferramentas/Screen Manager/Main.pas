unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ImgList, ExtCtrls, Cosmos.Framework.Interfaces.Root,
  Cosmos.Framework.Interfaces.Utils, Cosmos.Framework.Interfaces.Dialogs, ComCtrls,
  Buttons, ActnList, cosmos.core.winshell, cosmos.core.ConstantesMsg, System.Actions;

type
  TFrmWindowsList = class(TForm, ICosmosDialogWinManager)
    ImgList18: TImageList;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    LsvWindows: TListView;
    ImgList32: TImageList;
    SbnReportStyle: TSpeedButton;
    SbnIconsStyle: TSpeedButton;
    ActionList1: TActionList;
    ActActivate: TAction;
    ActCloseWin: TAction;
    procedure FormShow(Sender: TObject);
    procedure LsvWindowsDblClick(Sender: TObject);
    procedure ActActivateUpdate(Sender: TObject);
    procedure ActCloseWinExecute(Sender: TObject);
    procedure ActActivateExecute(Sender: TObject);
    procedure SbnIconsStyleClick(Sender: TObject);
    procedure SbnReportStyleClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure LoadWindowsList;

  protected
   function SelectForm: TForm;

  public
    { Public declarations }
  end;

var
  FrmWindowsList: TFrmWindowsList;

implementation

{$R *.dfm}

procedure TFrmWindowsList.ActActivateExecute(Sender: TObject);
begin
 if LsvWindows.Selected <> nil then
  ModalResult := mrOk;
end;

procedure TFrmWindowsList.ActActivateUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := LsvWindows.Selected <> nil;
end;

procedure TFrmWindowsList.ActCloseWinExecute(Sender: TObject);
var
IWinManager: ICosmosWindowsManager;
begin
 if LsvWindows.Selected <> nil then
  begin
   IWinManager := Application.MainForm as ICosmosWindowsManager;
   if IWinManager.CloseRegisteredWindow(LsvWindows.Selected.Caption) then
    begin
     LsvWindows.Selected.Delete;
     LsvWindows.Arrange(arDefault);
    end;
   end;
end;

procedure TFrmWindowsList.Button3Click(Sender: TObject);
begin
 if Self.HelpContext <> 0 then
  Application.HelpSystem.ShowContextHelp(Self.HelpContext, Application.CurrentHelpFile);
end;

procedure TFrmWindowsList.FormCreate(Sender: TObject);
begin
 //XMLFileStorage.FileName := TShellFolders.GetMyAppDataFolder + sCommonUserData + 'screens.xml';
 LoadWindowsList;
end;

procedure TFrmWindowsList.FormShow(Sender: TObject);
begin
 SbnIconsStyle.Down := LsvWindows.ViewStyle = vsIcon;
 SbnReportStyle.Down := LsvWindows.ViewStyle = vsReport;
end;

procedure TFrmWindowsList.LoadWindowsList;
var
I: integer;
Form: TCustomForm;
IWinManager: ICosmosWindowsManager;
Icon: TIcon;
Item: TListItem;
IDockedForm: ICosmosDockedForm;
begin
 IWinManager := Application.MainForm as ICosmosWindowsManager;

 for I := 0 to Pred(IWinManager.FormCount) do
  begin
   Form := IWinManager.FindFormByID(I);
   if Form <> nil then
    begin
     Item := LsvWindows.Items.Add;
     Item.Caption := Form.Caption;
     if Supports(Form, ICosmosDockedForm) then
      begin
       IDockedForm := Form as ICosmosDockedForm;
       Item.SubItems.Add(IDockedForm.FormDescription);
      end;

     Icon := IWinManager.ExtractFormIcon(Form);
     if Icon <> nil then
      begin
       Item.ImageIndex := ImgList18.AddIcon(Icon);
       ImgList32.AddIcon(Icon);
      end
     else
      Item.ImageIndex := 0;
    end;
  end;
end;

procedure TFrmWindowsList.LsvWindowsDblClick(Sender: TObject);
begin
 if LsvWindows.Selected <> nil then
  ActActivate.Execute;
end;

function TFrmWindowsList.SelectForm: TForm;
var
IWinManager: ICosmosWindowsManager;
begin
 if ShowModal = mrOk then
  begin
   IWinManager := Application.MainForm as ICosmosWindowsManager;
   Result := TForm(IWinManager.FindFormByCaption(LsvWindows.Selected.Caption));
  end
 else
  Result := nil;
end;

procedure TFrmWindowsList.SbnReportStyleClick(Sender: TObject);
begin
 LsvWindows.ViewStyle := vsReport;
end;

procedure TFrmWindowsList.SbnIconsStyleClick(Sender: TObject);
begin
 LsvWindows.ViewStyle := vsIcon;
end;

initialization
 RegisterClass(TFrmWindowsList);

finalization
 UnRegisterClass(TFrmWindowsList);

end.
