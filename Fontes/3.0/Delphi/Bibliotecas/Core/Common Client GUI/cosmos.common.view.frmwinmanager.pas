unit cosmos.common.view.frmwinmanager;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ImgList,
  Vcl.Menus, Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnPopup,
  cosmos.framework.interfaces.Root;

type
 RegisteredForm = record
  Caption: string;
  Description: string;
  FormIDName: string;
  FormClass: TClass;
 end;

 PRegisteredForm = ^RegisteredForm;

  TFrmWindowsManager = class(TForm)
    PopMnWindowsManager: TPopupActionBar;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MainList: TImageList;
    LsvWindows: TListView;
    procedure FormCreate(Sender: TObject);
    procedure LsvWindowsInfoTip(Sender: TObject; Item: TListItem;
      var InfoTip: string);
    procedure LsvWindowsSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure PopMnWindowsManagerPopup(Sender: TObject);
  private
    { Private declarations }
    FICosmosApp: ICosmosApplication;

    function FindForm(const AForm: TCustomForm): boolean;
    function GetRegisteredForm: PRegisteredForm;
    procedure SelectForm(Sender: TObject);

  public
    { Public declarations }
    function RegisterForm(const AForm: TCustomForm): boolean;
    procedure UnregisterForm(const ClassName: TClass);

    property ICosmosApp: ICosmosApplication read FICosmosApp;
    property RegisteredForm: PRegisteredForm read GetRegisteredForm;
  end;

var
  FrmWindowsManager: TFrmWindowsManager;

implementation

{$R *.dfm}

{ TFrmModernMenu }

function TFrmWindowsManager.FindForm(const AForm: TCustomForm): boolean;
begin
 Result := False;
end;

procedure TFrmWindowsManager.FormCreate(Sender: TObject);
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;
 self.PopMnWindowsManager.Style := ICosmosApp.InterfaceStyle;
 self.LsvWindows.CustomHint := ICosmosApp.CustomHintObj;
end;

function TFrmWindowsManager.GetRegisteredForm: PRegisteredForm;
begin
 if self.LsvWindows.Selected <> nil then
  Result := PRegisteredForm(LsvWindows.Selected.Data)
 else
  Result := nil;
end;

procedure TFrmWindowsManager.LsvWindowsInfoTip(Sender: TObject; Item: TListItem;
  var InfoTip: string);
var
PForm: PRegisteredForm;
begin
 try
  if Item <> nil then
   begin
    PForm := Item.Data;
    InfoTip := Item.Caption + '|' + PForm.Description;
   end;

 finally
  if PForm <> nil then
   PForm := nil;
 end;
end;

procedure TFrmWindowsManager.LsvWindowsSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
 if (LsvWindows.Selected <> nil) and (LsvWindows.Selected.Data <> nil) then
  self.ICosmosApp.RestoreWindow(self.RegisteredForm.FormClass);
end;

procedure TFrmWindowsManager.PopMnWindowsManagerPopup(Sender: TObject);
var
I: integer;
Mn: TMenuItem;
begin
 with PopMnWindowsManager do
  begin
   Items.Clear;
   for I := 0 to Pred(self.LsvWindows.Items.Count) do
    begin
      Mn := TMenuItem.Create(self);
      //Mn.Tag := FrmModernMenu.BtManager.Categories.Items[I].Index;
      Mn.Caption := self.LsvWindows.Items.Item[I].Caption;
      //Mn.Checked := not FrmModernMenu.BtManager.Categories.Items[I].Collapsed;
      Mn.OnClick := SelectForm;
      Items.Add(Mn);
    end;
  end;

end;

function TFrmWindowsManager.RegisterForm(const AForm: TCustomForm): boolean;
var
AItem: TListItem;
PForm: PRegisteredForm;
IDockedForm: ICosmosDockedForm;
begin
 try
  if not FindForm(AForm) then
   begin
    New(PForm);
    PForm.Caption := AForm.Caption;
    PForm.FormClass := AForm.ClassType;

    AItem := self.LsvWindows.Items.Add;
    AItem.Caption := AForm.Caption;

    if Supports(AForm, ICosmosDockedForm) then
     begin
      IDockedForm := AForm as ICosmosDockedForm;
      PForm.Description := IDockedForm.FormDescription;
      PForm.FormIDName := IDockedForm.FormIDName;
     end;

    AItem.ImageIndex := 0;
    AItem.Data := PForm;
    AItem.OverlayIndex := AItem.ImageIndex;
    Result := True;
   end
  else
   Result := False;

 finally
  if Assigned(IDockedForm) then IDockedForm := nil;
  if Assigned(PForm) then PForm := nil;
 end;
end;

procedure TFrmWindowsManager.SelectForm(Sender: TObject);
var
I: integer;
AItem: TListItem;
begin
 for I := 0 to Pred(LsvWindows.Items.Count) do
   begin
     AItem := self.LsvWindows.Items.Item[I];
     if AItem.Caption = TMenuItem(Sender).Caption then
      begin
        self.LsvWindows.OnSelectItem(LsvWindows, AItem, True);
        Break;
      end;
   end;
end;

procedure TFrmWindowsManager.UnregisterForm(const ClassName: TClass);
var
I: integer;
AItem: TListItem;
PForm: PRegisteredForm;
begin
 for I := 0 to Pred(self.LsvWindows.Items.Count) do
  begin
   AItem := LsvWindows.Items.Item[I];
   if AItem <> nil then
    begin
     PForm := AItem.Data;
     if PForm.FormClass = ClassName then
      begin
       PForm := nil;
       AItem.Delete;
      end;
    end;
  end;
end;

end.
