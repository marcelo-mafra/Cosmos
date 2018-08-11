unit FrameDBInsertVertical;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, DBActns, ImgList, DB, ActnList, StdCtrls, Buttons, System.Actions,
  System.ImageList;

type
  TFmeDBInsertVertical = class(TFrame)
    BtnSave: TBitBtn;
    ActionList1: TActionList;
    DataSetPost1: TDataSetPost;
    DataSetCancel1: TDataSetCancel;
    ActClose: TAction;
    ActHelp: TAction;
    DataSource1: TDataSource;
    ImageList1: TImageList;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BtnCancel: TBitBtn;
    BitBtn3: TBitBtn;
    DataSetInsert1: TDataSetInsert;
    procedure ActHelpExecute(Sender: TObject);
    procedure ActCloseExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TFmeDBInsertVertical.ActCloseExecute(Sender: TObject);
begin
 Screen.ActiveForm.Close;
end;

procedure TFmeDBInsertVertical.ActHelpExecute(Sender: TObject);
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
