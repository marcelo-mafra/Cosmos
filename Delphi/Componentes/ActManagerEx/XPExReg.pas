unit XPExReg;

interface

{
  This file registers the new Actions associated with drawing
  the Context Separator and Rich Content menu items.
}

implementation

uses
    ActnList
  , XPExStyleActions
  ;
  
initialization
  RegisterActions('ActnMan Menus', [TContextSeparatorAction, TRichContentAction], nil);

end.
