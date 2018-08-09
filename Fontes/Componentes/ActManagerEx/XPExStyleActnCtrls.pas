unit XPExStyleActnCtrls;

interface

uses
    XPStyleActnCtrls
  , ActnMan
  ;

type
  TXPExStyleActionBars = class(TXPStyleActionBars)
  public
    function GetControlClass(ActionBar: TCustomActionBar;
      AnItem: TActionClientItem): TCustomActionControlClass; override;
    function GetStyleName: string; override;
  end;

var
  XPExStyle: TXPExStyleActionBars;
  
implementation

uses
    ActnMenus
  , XPExActnCtrls
  ;

resourcestring
  StrNewXPStyle = 'New XP Style';

{ TXPExStyleActionBars }

function TXPExStyleActionBars.GetControlClass(ActionBar: TCustomActionBar;
  AnItem: TActionClientItem): TCustomActionControlClass;
begin
  // if the ActionBar is an TCustomActionPopupMenu (the drop down menus display
  // in the TActionMainMenuBar and TPopupActionBar are)
  if ActionBar is TCustomActionPopupMenu then
    result := TXPExStyleRichContent
  else
    // make sure the XP Style control is used if the ActionBar isn't the correct type
    result := inherited GetControlClass(ActionBar, AnItem);
end;

function TXPExStyleActionBars.GetStyleName: string;
begin
  result := StrNewXPStyle;
end;

initialization
  XPExStyle := TXPExStyleActionBars.Create;
  // uncomment this line to make this new style the default style
  // for ActionManager components dropped on to a form in future.
  //DefaultActnBarStyle := XPExStyle.GetStyleName;
  RegisterActnBarStyle(XPExStyle);
  
finalization
  UnregisterActnBarStyle(XPExStyle);
  XPExStyle.Free;

end.
