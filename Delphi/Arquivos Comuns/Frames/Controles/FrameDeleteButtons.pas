unit FrameDeleteButtons;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, DBActns, ActnList, ImgList, StdCtrls, Buttons,
  DB, System.Actions, System.ImageList;

type
  TFmeDBDelButtons = class(TFrame)
    BtnNew: TBitBtn;
    BtnSave: TBitBtn;
    BtnCancel: TBitBtn;
    BitBtn1: TBitBtn;
    ImageList1: TImageList;
    ActionList1: TActionList;
    DataSetInsert1: TDataSetInsert;
    DataSetPost1: TDataSetPost;
    DataSetCancel1: TDataSetCancel;
    ActClose: TAction;
    BitBtn2: TBitBtn;
    DataSetDelete1: TDataSetDelete;
    DataSource1: TDataSource;
    BitBtn3: TBitBtn;
    ActHelp: TAction;
    procedure ActHelpExecute(Sender: TObject);
    procedure ActCloseExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation


{$R *.dfm}

procedure TFmeDBDelButtons.ActCloseExecute(Sender: TObject);
begin
 Screen.ActiveForm.Close;
end;

procedure TFmeDBDelButtons.ActHelpExecute(Sender: TObject);
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
