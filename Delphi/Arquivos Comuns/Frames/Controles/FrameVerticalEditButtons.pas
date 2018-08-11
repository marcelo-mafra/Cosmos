unit FrameVerticalEditButtons;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, ImgList, DBActns, ActnList, StdCtrls, Buttons, DB;

type
  TFmeVerticalEditButtons = class(TFrame)
    BtnSave: TBitBtn;
    BtnCancel: TBitBtn;
    ActionList1: TActionList;
    DataSetPost1: TDataSetPost;
    DataSetCancel1: TDataSetCancel;
    BitBtn1: TBitBtn;
    ActClose: TAction;
    ImageList1: TImageList;
    DataSource1: TDataSource;
    ActHelp: TAction;
    BitBtn2: TBitBtn;
    procedure ActCloseExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TFmeVerticalEditButtons.ActCloseExecute(Sender: TObject);
begin
 Screen.ActiveForm.Close;
end;

end.
