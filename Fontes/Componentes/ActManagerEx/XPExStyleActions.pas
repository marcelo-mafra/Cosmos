unit XPExStyleActions;

interface

uses
    ActnList
  , Classes
  , Graphics
  ;

type
  TCaptionAlignment = (caLeft, caCenter, caRight, caBannerLeft);

  TContextSeparatorAction = class(TAction)
  private
    FBoldFont: Boolean;
    FAlignment: TCaptionAlignment;
    FBorderWidth: Integer;
    procedure SetAlignment(const Value: TCaptionAlignment);
  public
    constructor Create(AOwner: TComponent); override;
  published
    property BoldFont: Boolean read FBoldFont write FBoldFont default True;
    property Alignment: TCaptionAlignment read FAlignment write SetAlignment default caBannerLeft;
    property BorderWidth: Integer read FBorderWidth write FBorderWidth default 4;
  end;

  TGlyphAlign = (gaTop, gaCenter, gaBottom);

  TRichContentAction = class(TAction)
  private
    FBoldFont: Boolean;
    FContent: TStrings;
    FContentFont: TFont;
    FGlyphAlign: TGlyphAlign;
    FWidth: Integer;
    function get_Content: TStrings;
    procedure set_Content(const Value: TStrings);
    function get_ContentFont: TFont;
    procedure set_ContentFont(const Value: TFont);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property BoldFont: Boolean read FBoldFont write FBoldFont default True;
    property Content: TStrings read get_Content write set_Content;
    property ContentFont: TFont read get_ContentFont write set_ContentFont;
    property GlyphAlign: TGlyphAlign read FGlyphAlign write FGlyphAlign default gaTop;
	  property Width: Integer read FWidth write FWidth default 150;
  end;

implementation

{ TContextSeparatorAction }

constructor TContextSeparatorAction.Create(AOwner: TComponent);
begin
  inherited;
  FBoldFont := True;
  FAlignment := caBannerLeft;
  FBorderWidth := 4;
end;

procedure TContextSeparatorAction.SetAlignment(const Value: TCaptionAlignment);
begin
  FAlignment := Value;
  // reset BorderWidth to the default when alignment is set
  FBorderWidth := 4;
end;

{ TRichContentAction }

constructor TRichContentAction.Create(AOwner: TComponent);
begin
  inherited;
  FContent := TStringList.Create;
  FContentFont := TFont.Create;
  FGlyphAlign := gaTop;
  FWidth := 150;
  FBoldFont := True;
end;

destructor TRichContentAction.Destroy;
begin
  FContent.Free;
  FContentFont.Free;
  inherited;
end;

function TRichContentAction.get_Content: TStrings;
begin
  result := FContent;
end;

function TRichContentAction.get_ContentFont: TFont;
begin
  result := FContentFont;
end;

procedure TRichContentAction.set_Content(const Value: TStrings);
begin
  FContent.Assign(Value);
end;

procedure TRichContentAction.set_ContentFont(const Value: TFont);
begin
  FContentFont.Assign(Value);
end;

end.


//var
//  lCnt: Integer;
//  lItem: TActionClientItem;
//begin
//  lCnt := 0;
//  lItem := PopupActionBar1.PopupMenu.FindFirstVisibleItem;
//  while lItem <> nil do
//  begin
//    // if this item is a separator make the item a Context Separator if the item
//    // has a hint associated with it
//    if (lItem.Caption = '-') and (PopupActionBar1.Items[lCnt].Caption = '-') then
//      lItem.Caption := trim('- ' + PopupActionBar1.Items[lCnt].Hint);
//    lItem := THackActionBar(PopupActionBar1.PopupMenu).FindNextVisibleItem(lItem);
//    inc(lCnt);
//  end;

