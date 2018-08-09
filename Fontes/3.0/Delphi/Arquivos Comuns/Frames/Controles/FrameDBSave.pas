unit FrameDBSave;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, DB, ImgList, ActnList, StdCtrls, Buttons, DBActns;

type
  TFmeDBSave = class(TFrame)
    ActionList1: TActionList;
    ImageList1: TImageList;
    DataSource1: TDataSource;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    DataSetPost1: TDataSetPost;
    DataSetCancel1: TDataSetCancel;
    ActClose: TAction;
    ActHelp: TAction;
    procedure ActCloseExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TFmeDBSave.ActCloseExecute(Sender: TObject);
begin
 Screen.ActiveForm.Close;
end;

end.
