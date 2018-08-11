unit FrameEditButtonsHoriz;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, ImgList, DBActns, ActnList, StdCtrls, Buttons, DB;

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

end.
