unit FrameDBEditVertical;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, Buttons, DBActns, ActnList, DB, ImgList, System.Actions;

type
  TFmeDBEditVertical = class(TFrame)
    ImageList1: TImageList;
    DataSource1: TDataSource;
    ActionList1: TActionList;
    DataSetPost1: TDataSetPost;
    DataSetCancel1: TDataSetCancel;
    ActClose: TAction;
    ActHelp: TAction;
    BitBtn2: TBitBtn;
    BitBtn1: TBitBtn;
    BtnCancel: TBitBtn;
    BtnSave: TBitBtn;
    procedure ActHelpExecute(Sender: TObject);
    procedure ActCloseExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TFmeDBEditVertical.ActCloseExecute(Sender: TObject);
begin
 Screen.ActiveForm.Close;
end;

procedure TFmeDBEditVertical.ActHelpExecute(Sender: TObject);
var
AForm: TForm;
begin
 AForm := Screen.ActiveForm;

 if AForm <> nil then
  begin
   if AForm.HelpContext <> 0 then
    Application.HelpSystem.ShowContextHelp(AForm.HelpContext, Application.CurrentHelpFile);
  end;
end;

end.
