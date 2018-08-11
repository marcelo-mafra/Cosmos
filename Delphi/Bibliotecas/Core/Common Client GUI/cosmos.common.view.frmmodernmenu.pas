unit cosmos.common.view.frmmodernmenu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.CategoryButtons,
  Vcl.Menus, Vcl.ActnPopup, Vcl.ImgList, Vcl.ComCtrls, Vcl.ActnList,
  Vcl.PlatformDefaultStyleActnCtrls, Xml.XMLDoc, Xml.XMLIntf,
  cosmos.system.winshell;

type
  TFrmModernMenu = class(TForm)
    PopMnCategoryButtons: TPopupActionBar;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MainList: TImageList;
    BtManager: TCategoryButtons;
    procedure BtManagerGetHint(Sender: TObject; const Button: TButtonItem;
      const Category: TButtonCategory; var HintStr: string;
      var Handled: Boolean);
    procedure PopMnCategoryButtonsPopup(Sender: TObject);
  private
    { Private declarations }
    procedure SelectCategory(Sender: TObject);
    procedure CreateItems(Category: TButtonCategory; Action: TBasicAction);

  public
    { Public declarations }
    procedure AddCategory(Caption: string; Actions: TActionList);
    procedure LoadOptions(const FileName, Module: string);
  end;

var
  FrmModernMenu: TFrmModernMenu;

implementation

{$R *.dfm}

{ TFrmModernMenu }

procedure TFrmModernMenu.AddCategory(Caption: string; Actions: TActionList);
var
I: integer;
ACategory: TButtonCategory;
ACategories: TButtonCategories;
begin
 I := BtManager.Categories.IndexOf(Caption);
 if I < 0 then
  begin
   if (Actions <> nil) and (Actions.ActionCount > 0) then
    begin
     ACategories :=  TButtonCategories.Create(BtManager);
     ACategory := ACategories.Add;

     ACategory.Caption := Caption;

     for I := 0 to Pred(Actions.ActionCount) do
       CreateItems(ACategory, Actions.Actions[I]);

     ACategory.Collapsed := False;
     ACategory.Color := BtManager.Color;
     ACategory.Collapsed := False;

     BtManager.Categories.AddItem(ACategory, 0);
    end;
  end
 else
  begin
   ACategory := FrmModernMenu.BtManager.Categories.Items[I];
   ACategory.Collapsed := False;
   ACategory.ScrollIntoView;
  end;
end;

procedure TFrmModernMenu.BtManagerGetHint(Sender: TObject;
  const Button: TButtonItem; const Category: TButtonCategory;
  var HintStr: string; var Handled: Boolean);
begin
 HintStr := GetLongHint(HintStr);
 Handled := True;
end;


procedure TFrmModernMenu.CreateItems(Category: TButtonCategory;
  Action: TBasicAction);
var
Bi: TButtonItem;
begin
//Insere o botão e o liga ao action desde que o seu tag seja diferente de 100.
//Convensionou-se que actions com tag = 100 não serão listados.
 if (Action <> nil) and (Action.Tag <> 100) then
  begin
   Bi := Category.Items.Add;
   Bi.ImageIndex := 1; //TAction(Action).ImageIndex;
   Bi.ImageIndex := 1; //-1;
   Bi.Action := Action;

   {if (TAction(Action).Images <> nil) and (TAction(Action).ImageIndex >= 0) then
    begin
     Bi.ImageIndex := MainList.AddImage(TAction(Action).Images, TAction(Action).ImageIndex);
    end;}
  end;
end;

procedure TFrmModernMenu.LoadOptions(const FileName, Module: string);
var
 AXMLDoc: TXMLDocument;
 ANode: IXMLNode;
begin
  AXMLDoc := TXMLDocument.Create(self);

   try
    AXMLDoc.Options := [doNodeAutoCreate, doNodeAutoIndent, doAttrNull, doNamespaceDecl];
    AXMLDoc.NodeIndentStr := ''#13'';

    AXMLDoc.FileName := FileName;
    if TWinShell.IsWinXP then
     begin
      AXMLDoc.Encoding := 'utf-8';
      AXMLDoc.Version := '1.0';
     end;

    AXMLDoc.Active := True;
    ANode := AXMLDoc.DocumentElement;
    ANode := ANode.ChildNodes.FindNode('CosmosVisual');
    ANode := ANode.ChildNodes.FindNode(Module);
    ANode := ANode.ChildNodes.FindNode('LateralMenu');

    with BtManager do
     begin
      ButtonOptions := [boFullSize, boShowCaptions]; //default

      if ANode.Attributes['AllowReorder'] then
        ButtonOptions := ButtonOptions + [boAllowReorder];
      if ANode.Attributes['BoldCaptions'] then
        ButtonOptions := ButtonOptions + [boBoldCaptions];
      if ANode.Attributes['VerticalCategories'] then
        ButtonOptions := ButtonOptions + [boVerticalCategoryCaptions];
      if ANode.Attributes['DefaultPlusSignal'] then
        ButtonOptions := ButtonOptions + [boUsePlusMinus];
      if ANode.Attributes['CategoryBorder'] then
        ButtonOptions := ButtonOptions + [boCaptionOnlyBorder];
      if ANode.Attributes['NoIcons'] then
       Images := nil
      else
       Images := MainList;
     end;

   finally
    if Assigned(AXMLDoc) then
     FreeAndNil(AXMLDoc);
   end;
end;

procedure TFrmModernMenu.PopMnCategoryButtonsPopup(Sender: TObject);
var
I: integer;
Mn: TMenuItem;
begin
 with PopMnCategoryButtons do
  begin
   Items.Clear;
   for I := 0 to Pred(FrmModernMenu.BtManager.Categories.Count) do
    begin
      Mn := TMenuItem.Create(self);
      Mn.Tag := FrmModernMenu.BtManager.Categories.Items[I].Index;
      Mn.Caption := FrmModernMenu.BtManager.Categories.Items[I].Caption;
      Mn.Checked := not FrmModernMenu.BtManager.Categories.Items[I].Collapsed;
      Mn.OnClick := SelectCategory;
      Items.Add(Mn);
    end;
  end;
end;

procedure TFrmModernMenu.SelectCategory(Sender: TObject);
var
I: integer;
Cat: TButtonCategory;
begin
 if Sender is TMenuItem then
  begin
   for I := 0 to Pred(FrmModernMenu.BtManager.Categories.Count) do
     begin
      Cat := FrmModernMenu.BtManager.Categories.Items[I];
      if Cat.Index = TMenuItem(Sender).Tag then
       begin
        Cat.Collapsed := TMenuItem(Sender).Checked;
        Cat.ScrollIntoView;
        break;
       end;
     end;
  end;
end;

end.
