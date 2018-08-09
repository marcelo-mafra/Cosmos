unit XPExActnCtrls;

interface

// Copyright 2006 Jeremy North. All Rights Reserved.
// jeremy.north@gmail.com

{$IF COMPILERVERSION > 17.0}
  {$DEFINE INLINE}
{$IFEND}

uses
    XPActnCtrls
  , Types
  , Windows
  , Graphics
  , Classes
  ;

type
  TXPExStyleRichContent = class(TXPStyleMenuItem)
  private
    FBoundsCalculated: Boolean;
    FShortCut: Word;
    FCaptionHeight: Integer;
    FCaptionText: string;
    FContentHeight: Integer;
    FContentText: string;
    FLeftMargin: Integer;
    FCaptionWidth: Integer;
    function IsSeparator: Boolean; {$IFDEF INLINE}inline;{$ENDIF}
    function SeparatorCaption: string; {$IFDEF INLINE}inline;{$ENDIF}
    function HasContent: Boolean; {$IFDEF INLINE}inline;{$ENDIF}
    function GetContent: string; {$IFDEF INLINE}inline;{$ENDIF}
    procedure UpdateShortCutBounds;
  protected
    function CaptionHeight: Integer; virtual;
    function ContentHeight: Integer; virtual;
    function ContentWidth: Integer; virtual;
    function CaptionWidth: Integer; virtual;
    procedure DrawBackground(var PaintRect: TRect); override;
    procedure DrawGlyph(const Location: TPoint); override;
    procedure DrawShadowedText(Rect: TRect; Flags: Cardinal; Text: String; TextColor: TColor; ShadowColor: TColor); override;
    procedure DrawText(var Rect: TRect; var Flags: Cardinal; Text: String); override;
    procedure DrawUnusedEdges; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure CalcBounds; override;
  end;

implementation

uses
    Controls
  , Menus
  , ActnMan
  , ActnColorMaps
  , GraphUtil
  , Math
  , SysUtils
  , ActnMenus
  , Imglist
  , ActnList
  ;

const
  // the width of the gutter
  BANNER_WIDTH = 25;
  // default width of the items with content
  // adjust as necessary
  DEFAULT_CONTENT_WIDTH = 200;

type
  // simple class to hold the colors for the various gradients
  TGradientColors = class
  private
    FContentGradientStartColor: TColor;
    FCaptionGradientEndColor: TColor;
    FContentGradientEndColor: TColor;
    FCaptionGradientStartColor: TColor;
  public
    property CaptionGradientStartColor: TColor read FCaptionGradientStartColor write FCaptionGradientStartColor;
    property CaptionGradientEndColor: TColor read FCaptionGradientEndColor write FCaptionGradientEndColor;
    property ContentGradientStartColor: TColor read FContentGradientStartColor write FContentGradientStartColor;
    property ContentGradientEndColor: TColor read FContentGradientEndColor write FContentGradientEndColor;
  end;

var
  FGradientColors: TGradientColors;

procedure InitColors;
begin
  FGradientColors := TGradientColors.Create;
  // these gradient colors are based on the XP Style color maps selected color
  FGradientColors.CaptionGradientStartColor := cXPSelectedColor;
  FGradientColors.CaptionGradientEndColor := GetHighLightColor(cXPSelectedColor);
  FGradientColors.ContentGradientStartColor := GetShadowColor(cXPSelectedColor, 10);
  FGradientColors.ContentGradientEndColor := cXPSelectedColor;
end;

{ TXPExStyleRichContent }

procedure TXPExStyleRichContent.CalcBounds;
var
  lWidth: Integer;
begin
  inherited;
  // due to the fact that the Hint property isn't set when the
  // CalcBounds method is called further checks are required.
  if (Action <> nil) or (Caption <> '') then
  begin
    // set the real width once the item heights have been calculated
    if (FContentHeight = -1) and (FCaptionHeight = -1) then
    begin
      Height := CaptionHeight + ContentHeight;
      // max width required by content and caption
      if HasContent then
        lWidth := Max(CaptionWidth + FLeftMargin, ContentWidth + FLeftMargin)
      else
        lWidth := CaptionWidth + FLeftMargin;
      // ultimate width of menu item
      Width := Max(lWidth, Width);
    end;
  end;
end;

procedure TXPExStyleRichContent.UpdateShortCutBounds;
var
  lShortCutRect: TRect;
begin
  if (FBoundsCalculated) and (FShortCut = ActionClient.ShortCut) then
    exit;
  if ActionClient.ShortCut <> 0 then
  begin
    lShortCutRect := Rect(0,0,0,0);
    Windows.DrawText(Canvas.Handle, PChar(ActionClient.ShortCutText), -1, lShortCutRect, DT_CALCRECT);
    // Left offset is determined when the item is painted to make it right justified
    lShortCutRect.Top := TextBounds.Top;
    lShortCutRect.Bottom := TextBounds.Bottom;
    ShortCutBounds := lShortCutRect;
    FBoundsCalculated := True;
    FShortCut := ActionClient.ShortCut;
  end;
end;

function TXPExStyleRichContent.CaptionHeight: Integer;
var
  lBoldFont: Boolean;
begin
  if (FCaptionHeight > -1) and SameText(Caption, FCaptionText) then
    result := FCaptionHeight
  else
  begin
    result := 0;
    if Canvas.HandleAllocated then
    begin
      // is this a true separator
      if (Caption = '-') then
        result := 3
      else
      begin
        lBoldFont := HasContent;
        if lBoldFont then
        begin
          Canvas.Font.Style := [fsBold];
          UpdateShortCutBounds;
        end;
        result := Canvas.TextHeight(Caption);
        Canvas.Font.Style := [];
        // we have to set the font to bold here otherwise the shortcut dimensions are wrong
        if not HasContent then
          inc(result, 3);
        result := Max(22, result); // the item should be at least 19 pixels high
      end;
      FCaptionHeight := result;
      FCaptionText := Caption;
    end;
  end;
end;

function TXPExStyleRichContent.CaptionWidth: Integer;
begin
  // only set the caption width once the Caption Height is known
  if FCaptionHeight = -1 then
  begin
    result := -1;
    exit;
  end;
  if (FCaptionWidth <> -1) and SameText(FCaptionText, Caption) then
    result := FCaptionWidth
  else
  begin
    if HasContent then
      Canvas.Font.Style := [fsBold];
    result := Canvas.TextWidth(Caption);
    // if there is a shortcut need to increase width accordingly
    if ActionClient.ShortCut <> 0 then
      inc(result, ShortCutBounds.Right - ShortCutBounds.Left + 21 + 4);
    Canvas.Font.Style := [];
    FCaptionWidth := result;
  end;
end;

function TXPExStyleRichContent.ContentHeight: Integer;
var
  lContent: string;
  lRect: TRect;
begin
  if (FContentHeight > -1) and SameText(GetContent, FContentText) then
    result := FContentHeight
  else
  begin
    result := 0;
    if Canvas.HandleAllocated then
    begin
      lContent := GetContent;
      if HasContent then
      begin
        lRect := Types.Rect(0, 0, ContentWidth, 0);
        Windows.DrawText(Canvas.Handle, PChar(lContent), Length(lContent), lRect, DT_LEFT or DT_NOCLIP or DT_CALCRECT or DT_WORDBREAK);
        result := lRect.Bottom - lRect.Top;
        inc(result, 3);
      end
      else
        result := 0;
      FContentHeight := result;
      FContentText := lContent;
    end;
  end;
end;

function TXPExStyleRichContent.ContentWidth: Integer;
begin
  result := Max(DEFAULT_CONTENT_WIDTH + 4, CaptionWidth);
end;

constructor TXPExStyleRichContent.Create(AOwner: TComponent);
begin
  inherited;
  FCaptionHeight := -1;
  FCaptionText := '';
  FCaptionWidth := -1;
  FContentHeight := -1;
  FContentText := '';
  FBoundsCalculated := False;
  FShortCut := 0;
  FLeftMargin := BANNER_WIDTH + 6;
end;

procedure TXPExStyleRichContent.DrawBackground(var PaintRect: TRect);
var
  lRect: TRect;
begin
  if IsSeparator then
  begin
    Canvas.Brush.Color := GetShadowColor(Menu.ColorMap.Color, -10);
    Canvas.FillRect(PaintRect);
    Canvas.Pen.Color := GetShadowColor(Menu.ColorMap.Color);
    Canvas.Brush.Style := bsClear;
    // draw border
    //Canvas.Rectangle(PaintRect);
    // draw a single line
    Canvas.MoveTo(PaintRect.Left, PaintRect.Bottom - 1);
    Canvas.LineTo(PaintRect.Right, PaintRect.Bottom - 1);
  end
  else if (not Selected) or (not Enabled) or (Caption = '-') then
    inherited
  else
  begin
    // caption gradient
    lRect := PaintRect;
    lRect.Bottom := lRect.Top + CaptionHeight;
    GradientFillCanvas(Canvas, FGradientColors.CaptionGradientStartColor, FGradientColors.CaptionGradientEndColor, lRect, gdVertical);
    // content gradient
    lRect.Top := lRect.Bottom;
    lRect.Bottom := PaintRect.Bottom;
    GradientFillCanvas(Canvas, FGradientColors.ContentGradientStartColor, FGradientColors.ContentGradientEndColor, lRect, gdVertical);
    // draw the selection frame
    Canvas.Brush.Style := bsClear;
    Canvas.Pen.Color := Menu.ColorMap.BtnFrameColor;
    Canvas.Rectangle(PaintRect);
  end;
end;


// The DrawGlyph method only has a minor change in it from the code in the XPActnCtrls unit
// Instead of:
//        FrameRect := Rect(Location.X - 1, 1, Location.X + 20, Self.Height - 1);
// The code is:
//        FrameRect := Rect(Location.X - 1, 1, Location.X + 20, CaptionHeight - 1);
//
{$REGION 'DrawGlyph Method'}
procedure TXPExStyleRichContent.DrawGlyph(const Location: TPoint);
var
  OldColor, OldBrushColor: TColor;
  NewLocation: TPoint;
  FrameRect: TRect;
  SelBmp: TBitmap;
  ImageList: TCustomImageList;
begin
  if not IsSeparator then
  begin
    if (Assigned(ActionClient) and not ActionClient.HasGlyph) and
       ((Action is TCustomAction) and TCustomAction(Action).Checked) then
    begin
      if IsChecked then
      begin
        FrameRect := Rect(Location.X - 1, 1, Location.X + 20, CaptionHeight - 1);
        Canvas.Brush.Color := Menu.ColorMap.SelectedColor;
        Canvas.FillRect(FrameRect);
        Canvas.Pen.Color := Menu.ColorMap.BtnFrameColor;
        Canvas.Rectangle(FrameRect);
      end;
      Canvas.Pen.Color := Menu.ColorMap.FontColor;
      with Location do
        DrawCheck(Canvas, Point(X + 6, Y + 3), 2)
    end
    else
    begin
      if IsChecked then
      begin
        FrameRect := Rect(Location.X - 1, 1, Location.X + 20, CaptionHeight - 1);
        Canvas.Brush.Color := Menu.ColorMap.SelectedColor;
        Canvas.Pen.Color := Menu.ColorMap.BtnFrameColor;
        Canvas.Rectangle(FrameRect);
      end;
      OldColor := Canvas.Brush.Color;
      if (Selected and Enabled) or (Selected and not MouseSelected) then
        Canvas.Brush.Color := Menu.ColorMap.SelectedColor
      else
        Canvas.Brush.Color := Menu.ColorMap.ShadowColor;
      NewLocation := Location;

      if (Selected and Enabled and ActionClient.HasGlyph) then
      begin
        OldBrushColor := Canvas.Brush.Color;
        SelBmp := TBitmap.Create;
        try
          if Assigned(ActionClient.Action) and Assigned(ActionClient.Action.ActionList) then
            ImageList := ActionClient.Items.ActionManager.Images
          else
            ImageList := ActionClient.OwningCollection.ActionManager.Images;
          if Assigned(ImageList) then
          begin
            Canvas.Brush.Color := GetShadowColor(Menu.ColorMap.SelectedColor);
            SelBmp.Width := ImageList.Width;
            SelBmp.Height := ImageList.Width;
            ImageList.Draw(SelBmp.Canvas, 0, 0, ActionClient.ImageIndex, dsNormal, itMask);
            DrawState(Canvas.Handle, Canvas.Brush.Handle, nil, SelBmp.Handle, 0,
              NewLocation.X + 3, NewLocation.Y + 2, 0, 0, DST_BITMAP or DSS_MONO);
          end;
        finally
          SelBmp.Free;
          Canvas.Brush.Color := OldBrushColor;
        end;
  
        Inc(NewLocation.X, 1);
        inherited DrawGlyph(NewLocation);
      end
      else begin
        Inc(NewLocation.X, 2);
        Inc(NewLocation.Y, 1);
        inherited DrawGlyph(NewLocation);
      end;
      Canvas.Brush.Color := OldColor;
    end;
  end;
end;
{$ENDREGION}

procedure TXPExStyleRichContent.DrawShadowedText(Rect: TRect; Flags: Cardinal; Text: String; TextColor,
  ShadowColor: TColor);
begin
  // just called DrawText but make sure the Font Color is correct
  Canvas.Font.Color := TextColor;
  DrawText(Rect, Flags, Text);
end;

procedure TXPExStyleRichContent.DrawText(var Rect: TRect; var Flags: Cardinal; Text: String);
var
  lContent: string;
  lRect: TRect;
  lTempFont: TFont;
  lBoldFont: Boolean;
begin
  lTempFont := TFont.Create;
  try
    lContent := GetContent;
    lBoldFont := HasContent;
    lTempFont.Assign(Canvas.Font);
    if lBoldFont then
    begin
      Canvas.Font.Style := [fsBold];
      Rect.Left := Rect.Left - 1;
    end;
    if IsSeparator then
    begin
      Canvas.Font.Color := Menu.ColorMap.FontColor;
      Canvas.Font.Style := [fsBold];
      Rect.Left := 4;
      inherited DrawText(Rect, Flags, SeparatorCaption);
    end
    else
    begin
      inherited DrawText(Rect, Flags, Caption);
      // with a bolded font the left position of the content text needs to be shifted
      if lBoldFont then
        Rect.Left := Rect.Left + 1;
    end;
    Canvas.Font.Assign(lTempFont);
    if Length(lContent) > 0 then
    begin
      //lRect := ClientRect;
      lRect := Types.Rect(Rect.Left, CaptionHeight, Rect.Left + ContentWidth, CaptionHeight + ContentHeight);
      Windows.DrawText(Canvas.Handle, PChar(lContent), Length(lContent), lRect, DT_LEFT or DT_NOCLIP or DT_WORDBREAK);
    end;
  finally
    lTempFont.Free;
  end;
end;

procedure TXPExStyleRichContent.DrawUnusedEdges;
begin
  if not IsSeparator then
    inherited;
end;

// GetContent returns the Hint value from the associated action
// if there is one. This is because when CalcBounds is called
// the Hint value of the associated action has not been transferred
// to the Hint property of the TActionClientItem
function TXPExStyleRichContent.GetContent: string;
begin
  if HasContent then
    result := GetLongHint(TCustomAction(Action).Hint)
  else
   result := '';
end;

function TXPExStyleRichContent.HasContent: Boolean;
begin
  result := (Action <> nil);
  if result then
    result := Length(TCustomAction(Action).Hint) > 0;
end;

function TXPExStyleRichContent.IsSeparator: Boolean;
begin
  result := POS('- ', Caption) = 1;
end;

function TXPExStyleRichContent.SeparatorCaption: string;
begin
  if IsSeparator then
    result := StripHotKey(Copy(Caption, 3, Length(Caption)))
  else
    result := Caption;
end;

initialization
  InitColors;

finalization
  FGradientColors.Free;

end.
