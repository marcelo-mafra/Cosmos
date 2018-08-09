unit FrameEditButtons;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, ImgList, DBActns, ActnList, StdCtrls, Buttons, DB, System.Actions;

type
  TFmeEditButtons = class(TFrame)
    BtnNew: TBitBtn;
    BtnSave: TBitBtn;
    BtnCancel: TBitBtn;
    ActionList1: TActionList;
    DataSetInsert1: TDataSetInsert;
    DataSetPost1: TDataSetPost;
    DataSetCancel1: TDataSetCancel;
    BitBtn1: TBitBtn;
    ActClose: TAction;
    ImageList1: TImageList;
    DataSource1: TDataSource;
    ActHelp: TAction;
    BitBtn2: TBitBtn;
    procedure ActHelpExecute(Sender: TObject);
    procedure ActCloseExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TFmeEditButtons.ActCloseExecute(Sender: TObject);
begin
 Screen.ActiveForm.Close;
end;

procedure TFmeEditButtons.ActHelpExecute(Sender: TObject);
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
