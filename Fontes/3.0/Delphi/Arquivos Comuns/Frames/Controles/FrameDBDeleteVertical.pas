unit FrameDBDeleteVertical;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, DBActns, ImgList, DB, ActnList, StdCtrls, Buttons, System.Actions;

type
  TFmeDBDeleteVertical = class(TFrame)
    BtnSave: TBitBtn;
    ActionList1: TActionList;
    DataSetInsert1: TDataSetInsert;
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
    BitBtn4: TBitBtn;
    DataSetDelete1: TDataSetDelete;
    procedure ActHelpExecute(Sender: TObject);
    procedure ActCloseExecute(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }

  end;

implementation

{$R *.dfm}

procedure TFmeDBDeleteVertical.ActCloseExecute(Sender: TObject);
begin
 Screen.ActiveForm.Close;
end;

procedure TFmeDBDeleteVertical.ActHelpExecute(Sender: TObject);
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
