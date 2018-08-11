unit ASAddIn;

interface

{ Bonus package mentioned in the BDN Article Extending Action Manager Styles 

  Copyright 2006, Jeremy North. All Rights Reserved.                         }

procedure Register;

implementation

uses
    ActnMan
  , Windows
  , Classes
  , Controls
  , ToolsAPI
  , Dialogs
  , ActnMenus
  , XPExActnCtrls
  , SysUtils
  , ExtCtrls
  ;

type
  TActionStyleAddIn = class
  private
    FOldGetControlClass: TGetControlClassEvent;
    FMenuBar: TActionMainMenuBar;
    procedure GetControlClassHandler(Sender: TCustomActionBar; AnItem: TActionClient; var ControlClass: TCustomActionControlClass);
  public
    constructor Create;
    destructor Destroy; override;
  end;

var
  FActionStyleAddIn: TActionStyleAddIn;

procedure Register;
begin
  FActionStyleAddIn := TActionStyleAddIn.Create;
end;

{ TActionStyleAddIn }

constructor TActionStyleAddIn.Create;
var
  lHwnd: THandle;
  lCtrl: TWinControl;
  lCtrlBar: TWinControl;
  i, j: Integer;
begin
  lHwnd := FindWindow('TAppBuilder', nil);
  if lHwnd <> 0 then
  begin
    lCtrl := FindControl(lHwnd);
    if lCtrl <> nil then
    begin
      FMenuBar := nil;
//      ShowMessage('ControlCount: ' + IntToStr(lCtrl.ControlCount));
      for i := 0 to lCtrl.ControlCount - 1 do
      begin
        if lCtrl.Controls[i] is TControlBar then
        begin
          lCtrlBar := TWinControl(lCtrl.Controls[i]);
          for j := 0 to lCtrlBar.ControlCount - 1 do
          begin
//            ShowMessage(lCtrlBar.Controls[j].ClassName);
            if lCtrlBar.Controls[j] is TActionMainMenuBar then
            begin
              FMenuBar := lCtrlBar.Controls[j] as TActionMainMenuBar;
              break;
            end;
          end;
        end;
        if FMenuBar <> nil then
          break;
      end;
      if FMenuBar <> nil then
      begin
        FOldGetControlClass := FMenuBar.OnGetControlClass;
        FMenuBar.OnGetControlClass := GetControlClassHandler;
//        ShowMessage('Installed');
      end
      else
        ShowMessage('MenuBar not found');
    end;
  end
  else
    ShowMessage('Main Form not found');
end;

destructor TActionStyleAddIn.Destroy;
begin
  if FMenuBar <> nil then
    FMenuBar.OnGetControlClass := FOldGetControlClass;
  inherited;
end;

procedure TActionStyleAddIn.GetControlClassHandler(Sender: TCustomActionBar; AnItem: TActionClient;
  var ControlClass: TCustomActionControlClass);
begin
  if not (Sender is TActionMainMenuBar) then
    ControlClass := TXPExStyleRichContent;
end;

initialization
  FActionStyleAddIn := nil;

finalization
  if FActionStyleAddIn <> nil then
    FActionStyleAddIn.Free;

end.
