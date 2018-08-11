unit GroupHeader;

interface

uses
  Windows, Messages, Classes, Graphics, Controls, ExtCtrls,
  BevelTypes;

type
  TMSGroupHeaderOptions = class(TPersistent)
  private
    FBrush: TBrush;
    FHeight: Integer;
    FPen: TPen;
    FShape: TShapeType;
    FStyle: TMSBevelStyle;
    FOnChange: TNotifyEvent;
    procedure SetBrush(Value: TBrush);
    procedure SetHeight(Value: Integer);
    procedure SetPen(Value: TPen);
    procedure SetStyle(Value: TMSBevelStyle);
    procedure SetShape(Value: TShapeType);
    procedure DoChange;
  public
    constructor Create;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  published
    property Brush: TBrush read FBrush write SetBrush;
    property Height: Integer read FHeight write SetHeight default 2;
    property Pen: TPen read FPen write SetPen;
    property Shape: TShapeType read FShape write SetShape default stRectangle;
    property Style: TMSBevelStyle read FStyle write SetStyle default bsLowered;
  end;

  TMSGroupHeader = class(TCustomPanel)
  private
    FAlignment: TAlignment;
    FLayout: TMSLayout;
    FLabelOptions: TMSGroupHeaderOptions;
    FBevelOptions: TMSGroupHeaderOptions;
    FBevelSpace: Integer;
    function GetTransparent: Boolean;
    procedure SetAlignment(Value: TAlignment);
    procedure SetTransparent(Value: Boolean);
    procedure SetLayout(Value: TMSLayout);
    procedure SetBevelOptions(Value: TMSGroupHeaderOptions);
    procedure SetBevelSpace(Value: Integer);
    procedure SetLabelOptions(Value: TMSGroupHeaderOptions);
    procedure CMTextChanged(var Msg: TMessage); message CM_TEXTCHANGED;
    procedure CMFontChanged(var Msg: TMessage); message CM_FONTCHANGED;
    procedure StyleChanged(Sender: TObject);
    procedure BevelLine(C: TColor; X, Y, Width: Integer);
    procedure DoDrawText(var Rect: TRect; Flags: Longint);
    function GetLabelText: string;

  protected
    procedure Paint; override;
    
  public
    constructor Create(AOwner: TComponent); override;
    property Canvas;
  published
    property Align;
    property Alignment: TAlignment read FAlignment write SetAlignment default
      taLeftJustify;
    property Transparent: boolean read GetTransparent write SetTransparent;
    property Anchors;
    property BiDiMode;
    property Caption;
    property Color;
    property Constraints;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ParentBiDiMode;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Visible;
    property BevelOptions: TMSGroupHeaderOptions read FBevelOptions write SetBevelOptions;
    property BevelSpace: Integer read FBevelSpace write SetBevelSpace default 12;
    property LabelOptions: TMSGroupHeaderOptions read FLabelOptions write SetLabelOptions;
    property Layout: TMSLayout read FLayout write SetLayout default lTop;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Cosmos', [TMSGroupHeader]);
end;

//=== TMSGroupHeaderOptions ==================================================

constructor TMSGroupHeaderOptions.Create;
begin
  inherited Create;
  FPen := TPen.Create;
  FPen.OnChange := FOnChange;

  FBrush := TBrush.Create;
  FBrush.OnChange := FOnChange;

  FShape := stRectangle;
  FStyle := bsLowered;
  FHeight := 2;
end;

procedure TMSGroupHeaderOptions.SetBrush(Value: TBrush);
begin
  FBrush.Assign(Value);
end;

procedure TMSGroupHeaderOptions.SetHeight(Value: Integer);
begin
  if Value <> FHeight then
  begin
    FHeight := Value;
    DoChange;
  end;
end;

procedure TMSGroupHeaderOptions.SetPen(Value: TPen);
begin
  FPen.Assign(Value);
end;

procedure TMSGroupHeaderOptions.SetStyle(Value: TMSBevelStyle);
begin
  if Value <> FStyle then
  begin
    FStyle := Value;
    DoChange;
  end;
end;

procedure TMSGroupHeaderOptions.SetShape(Value: TShapeType);
begin
  if Value <> FShape then
  begin
    FShape := Value;
    DoChange;
  end;
end;

procedure TMSGroupHeaderOptions.DoChange;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

//=== TGroupHeader =========================================================

constructor TMSGroupHeader.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable];
  Font.Name := 'Tahoma';
  Width := 200;
  Height := 17;

  FBevelOptions := TMSGroupHeaderOptions.Create;
  FBevelOptions.OnChange := StyleChanged;
  FBevelSpace := 12;
  FLabelOptions := TMSGroupHeaderOptions.Create;
  FLabelOptions.OnChange := StyleChanged;
end;

function TMSGroupHeader.GetLabelText: string;
begin
  Result := Caption;
end;

procedure TMSGroupHeader.DoDrawText(var Rect: TRect; Flags: Longint);
var
  Text: string;
begin
  Text := GetLabelText;
  Flags := Flags or DT_NOPREFIX;
  Flags := DrawTextBiDiModeFlags(Flags);
  Canvas.Font := Font;
  if not Enabled then
  begin
    OffsetRect(Rect, 1, 1);
    Canvas.Font.Color := clBtnHighlight;
    DrawText(Canvas.Handle, PChar(Text), Length(Text), Rect, Flags);
    OffsetRect(Rect, -1, -1);
    Canvas.Font.Color := clBtnShadow;
    DrawText(Canvas.Handle, PChar(Text), Length(Text), Rect, Flags);
  end
  else
    DrawText(Canvas.Handle, PChar(Text), Length(Text), Rect, Flags);
end;

procedure TMSGroupHeader.Paint;
const
  Alignments: array [TAlignment] of Word = (DT_LEFT, DT_RIGHT, DT_CENTER);
  WordWraps: array [Boolean] of Word = (0, DT_WORDBREAK);
var
  Rect, CalcRect: TRect;
  DrawStyle: Longint;
  // Bevel padrão
  Color1, Color2: TColor;
  lbHeight, lbWidth: Integer;
  LX1, LX2, LX3, LX4, LY: Integer;
  // Shape padrão
  X, Y, W, H, S: Integer;
begin
  // "Draw" o texto
  Color1 := 0;
  Color2 := 0;
  with Canvas do
  begin
    if not Transparent then
    begin
      Brush.Color := Self.Color;
      Brush.Style := bsSolid;
      FillRect(ClientRect);
    end;
    Brush.Style := bsClear;
    Rect := ClientRect;
    DrawStyle := DT_EXPANDTABS or WordWraps[False] or Alignments[FAlignment];
    // Calcula o layout vertical
    if FLayout <> lTop then
    begin
      CalcRect := Rect;
      DoDrawText(CalcRect, DrawStyle or DT_CALCRECT);
      if FLayout = lBottom then
        OffsetRect(Rect, 0, Height - CalcRect.Bottom)
      else
        OffsetRect(Rect, 0, (Height - CalcRect.Bottom) div 2);
    end;
    DoDrawText(Rect, DrawStyle);
  end;

  // Calcula posições...

  lbHeight := Canvas.TextHeight(GetLabelText);
  lbWidth := Canvas.TextWidth(GetLabelText);

  LX1 := 0;
  LX2 := 0;
  LX3 := 0;
  LX4 := 0;
  case FAlignment of
    taLeftJustify:
      begin
        LX1 := lbWidth + FBevelSpace;
        LX2 := Width - lbWidth - FBevelSpace;
      end;
    taCenter:
      begin
        LX1 := 0;
        LX2 := (Width div 2) - (lbWidth div 2);
        LX3 := (Width div 2) + (lbWidth div 2);
        LX4 := Width;
      end;
    taRightJustify:
      begin
        LX1 := 0;
        LX2 := Width - lbWidth - FBevelSpace;
      end;
  end;

  LY := 0;
  case FLayout of
    lTop:
      LY := lbHeight div 2;
    lCenter:
      LY := Height div 2;
    lBottom:
      LY := Height - (lbHeight div 2);
  end;

  // Desenha o bevel
  if BevelOptions.Style <> bsShape then
  begin
    with Canvas do
    begin
      case BevelOptions.Style of
        bsLowered:
          begin
            Color1 := clBtnShadow;
            Color2 := clBtnHighlight;
          end;
        bsRaised:
          begin
            Color1 := clBtnHighlight;
            Color2 := clBtnShadow;
          end;
      end;

      if csDesigning in ComponentState then
      begin
        Pen.Style := psSolid;
        Pen.Mode := pmCopy;
        Pen.Color := clBlack;
        Brush.Style := bsSolid;
      end;

      Pen.Width := 1;

      // Desenha a linha

      BevelLine(Color1, LX1, LY, LX2);
      BevelLine(Color2, LX1, LY + 1, LX2);
      if FAlignment = taCenter then
      begin
        BevelLine(Color1, LX3, LY, LX4);
        BevelLine(Color2, LX3, LY + 1, LX4);
      end;
    end;
  end
  else
    with Canvas do
    begin
      Pen := BevelOptions.Pen;
      Brush := BevelOptions.Brush;
      X := LX1 + (Pen.Width div 2);
      Y := LY - (BevelOptions.Height div 2) + (Pen.Width div 2);
      W := LX2 - Pen.Width + 1;
      H := BevelOptions.Height - Pen.Width + 1;
      if Pen.Width = 0 then
      begin
        Dec(W);
        Dec(H);
      end;
      if W < H then
        S := W
      else
        S := H;
      if BevelOptions.Shape in [stSquare, stRoundSquare, stCircle] then
      begin
        Inc(X, (W - S) div 2);
        Inc(Y, (H - S) div 2);
        W := S;
        H := S;
      end;
      case BevelOptions.Shape of
        stRectangle, stSquare:
          Rectangle(X, Y, X + W, Y + H);
        stRoundRect, stRoundSquare:
          RoundRect(X, Y, X + W, Y + H, S div 4, S div 4);
        stCircle, stEllipse:
          Ellipse(X, Y, X + W, Y + H);
      end;
    end;
end;

procedure TMSGroupHeader.SetAlignment(Value: TAlignment);
begin
  if FAlignment <> Value then
  begin
    FAlignment := Value;
    Invalidate;
  end;
end;

function TMSGroupHeader.GetTransparent: Boolean;
begin
  Result := not (csOpaque in ControlStyle);
end;

procedure TMSGroupHeader.SetTransparent(Value: Boolean);
begin
  if Transparent <> Value then
  begin
    if Value then
      ControlStyle := ControlStyle - [csOpaque, csParentBackground]//  Result := csParentBackground in ControlStyle;
    else
      ControlStyle := ControlStyle + [csOpaque, csParentBackground];
    Invalidate;
  end;
end;

procedure TMSGroupHeader.SetLayout(Value: TMSLayout);
begin
  if FLayout <> Value then
  begin
    FLayout := Value;
    Invalidate;
  end;
end;

procedure TMSGroupHeader.CMTextChanged(var Msg: TMessage);
begin
  inherited;
  Invalidate;
end;

procedure TMSGroupHeader.CMFontChanged(var Msg: TMessage);
begin
  inherited;
  Invalidate;
end;

procedure TMSGroupHeader.SetBevelSpace(Value: Integer);
begin
  if Value <> FBevelSpace then
  begin
    FBevelSpace := Value;
    Invalidate;
  end;
end;

procedure TMSGroupHeader.StyleChanged(Sender: TObject);
begin
  Invalidate;
end;

procedure TMSGroupHeader.BevelLine(C: TColor; X, Y, Width: Integer);
begin
  with Canvas do
  begin
    Pen.Color := C;
    MoveTo(X, Y);
    LineTo(X + Width, Y);
  end;
end;

procedure TMSGroupHeader.SetBevelOptions(Value: TMSGroupHeaderOptions);
begin
  //
end;

procedure TMSGroupHeader.SetLabelOptions(Value: TMSGroupHeaderOptions);
begin
  //
end;
end.

