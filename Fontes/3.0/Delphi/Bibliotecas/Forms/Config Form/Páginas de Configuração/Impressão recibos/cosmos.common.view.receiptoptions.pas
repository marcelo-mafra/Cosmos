unit cosmos.common.view.receiptoptions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Vcl.Controls, Vcl.Forms,
  Vcl.StdCtrls, Vcl.ExtCtrls, GroupHeader, Cosmos.system.messages, Vcl.Graphics,
  Cosmos.Framework.Interfaces.Dialogs, Vcl.ComCtrls, cosmos.framework.forms.pages,
  Xml.XMLDoc, Xml.XMLIntf, cosmos.system.formsconst, Vcl.Printers, Vcl.ImgList,
  Vcl.Grids, Vcl.ValEdit;


type
  TFrmReceiptOptions = class(TFrmCosmosPages)
    MSGroupHeader2: TMSGroupHeader;
    MSGroupHeader1: TMSGroupHeader;
    ImageList1: TImageList;
    Label1: TLabel;
    CbxPrinters: TComboBox;
    MSGroupHeader3: TMSGroupHeader;
    EdtAltura: TEdit;
    EdtLargura: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    GrdInfos: TValueListEditor;
    procedure CbxPrintersDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure CbxPrintersChange(Sender: TObject);
  private
    { Private declarations }
   FChanged: boolean;
   function LoadBitmap: TBitmap;
   procedure LoadInfos;

  protected
   function GetChanged: boolean; override;
   function GetEnabled: boolean; override;
   function GetPageInfo: TPageInfo; override;

   function SaveOptions: boolean; override;
   procedure LoadOptions; override;

   property Changed: boolean read GetChanged;
   property Enabled: boolean read GetEnabled;
   property PageInfo: TPageInfo read GetPageInfo;

  public
    { Public declarations }
  end;

var
  FrmReceiptOptions: TFrmReceiptOptions;

implementation

{$R *.dfm}

{ TFrmPageReceiptOptions }

procedure TFrmReceiptOptions.CbxPrintersChange(Sender: TObject);
begin
 FChanged := True;
end;

procedure TFrmReceiptOptions.CbxPrintersDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  Bitmap: TBitmap;
  Offset: Integer;
begin
  Bitmap := TBitmap.Create;

  with (Control as TCombobox).Canvas do
  begin
    FillRect(Rect);       { Clear the rectangle. }
    Offset := 2;          { Provide default offset. }
    Bitmap := TBitmap.Create;
    ImageList1.GetBitmap(1, Bitmap);

    if Bitmap <> nil then
    begin
      BrushCopy(
        Bounds(Rect.Left + Offset, Rect.Top, Bitmap.Width, Bitmap.Height),
        Bitmap,
        Bounds(0, 0, Bitmap.Width, Bitmap.Height),
        clRed);  {render bitmap}
      Offset := Bitmap.width + 6;
    end;
    TextOut(Rect.Left + Offset, Rect.Top, (Control as TCombobox).Items[Index])
  end;
end;

function TFrmReceiptOptions.GetChanged: boolean;
begin
 Result := FChanged;
end;

function TFrmReceiptOptions.GetEnabled: boolean;
begin
Result := True;
end;

function TFrmReceiptOptions.GetPageInfo: TPageInfo;
begin
 Result.CodePage := 'Cosmos.receiptprint.configuration';
 Result.PageTitle := Caption;
 Result.PageDesc := TConfigurationPagesDesc.ConfReceiptOptions;
 Result.PageTreeRoot := TCosmosTitles.ConfFinanceiro;
 Result.PageTreeItem := TCosmosTitles.ConfReceiptsOptions;
 Result.PageIndex := 1;
 Result.PageImage := LoadBitmap;
 Result.HelpFile := Application.CurrentHelpFile;
 Result.HelpContext := self.HelpContext;
end;

function TFrmReceiptOptions.LoadBitmap: TBitmap;
begin
 Result := TBitMap.Create;
 ImageList1.GetBitmap(0, Result);
end;

procedure TFrmReceiptOptions.LoadInfos;
var
 ALine: TItemProp;
 I: integer;
 sItem: string;
begin
 for I := 1 to Pred(GrdInfos.RowCount) do
   begin
    sItem :=  GrdInfos.Cells[0, I];
    ALine := GrdInfos.ItemProps[sItem];
    ALine.EditStyle := esPickList;
    ALine.PickList.Delimiter := ';'; //do not localize!
    ALine.PickList.LineBreak := '"'; //do not localize!
    ALine.PickList.DelimitedText := TCosmosMiscellaneous.ReceiptsDataList;
   end;
end;

procedure TFrmReceiptOptions.LoadOptions;
var
  AXMLDoc: TXMLDocument;
  ANode: IXMLNode;
  aPrinter: TPrinter;
begin
 aPrinter := TPrinter.Create;
 AXMLDoc := CreateXMLDocument(ICosmosApp.IApplicationPaths.GetCommonConfigurationsFile);

 try
   CbxPrinters.Items.Assign(aPrinter.Printers);

   if AXMLDoc = nil then Exit;
   ANode := AXMLDoc.DocumentElement;
   ANode := ANode.ChildNodes.FindNode('ReceiptsInfo');
   if ANode <> nil then
    begin
     ANode := ANode.ChildNodes.FindNode('Info');

     CbxPrinters.ItemIndex := CbxPrinters.Items.IndexOf(ANode.Attributes['Printer']);
     EdtAltura.Text := ANode.Attributes['PaperHeight'];
     EdtLargura.Text := ANode.Attributes['PaperWidth'];
     GrdInfos.Strings.Text :=  ANode.Attributes['ReceiptsInfo'];
    end;


  FChanged := False; //default

 finally
  LoadInfos;
  if Assigned(AXMLDoc) then FreeAndNil(AXMLDoc);
  aPrinter.Free;
 end;;
end;

function TFrmReceiptOptions.SaveOptions: boolean;
var
  AXMLDoc: TXMLDocument;
  ANode: IXMLNode;
begin
  AXMLDoc := self.CreateXMLDocument(ICosmosApp.IApplicationPaths.GetCommonConfigurationsFile);
  ANode := AXMLDoc.DocumentElement;
  ANode := ANode.ChildNodes.FindNode('ReceiptsInfo');

 try
  if ANode <> nil then
   begin
    ANode := ANode.ChildNodes.FindNode('Info');

    ANode.Attributes['Printer'] := CbxPrinters.Text;
    ANode.Attributes['PaperHeight'] := EdtAltura.Text;
    ANode.Attributes['PaperWidth'] := EdtLargura.Text;
    ANode.Attributes['ReceiptsInfo'] := GrdInfos.Strings.Text;

    AXMLDoc.SaveToFile(AXMLDoc.FileName);
    Result := True;
   end;

  if Assigned(AXMLDoc) then
   FreeAndNil(AXMLDoc);

 except
  on E: Exception do
   begin
     Result := False;
     ICosmosApp.MainLog.RegisterError(E.Message);
     ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, TCosmosErrorMsg.SaveGUIConfigurations);
   end;
 end;
end;

initialization
 RegisterClass(TFrmReceiptOptions);

finalization
 UnRegisterClass(TFrmReceiptOptions);

end.
