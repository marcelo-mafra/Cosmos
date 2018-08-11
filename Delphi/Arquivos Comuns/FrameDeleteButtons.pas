unit FrameDeleteButtons;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, DBActns, ActnList, ImgList, StdCtrls, Buttons,
  DB;

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

end.
