unit cosmos.frames.usuariocad;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, Mask, DB, DBCtrls, Buttons;

type
  TFmeUsuarioCadastrador = class(TFrame)
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    SpeedButton1: TSpeedButton;
    procedure DBEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses  Cosmos.system.messages, cosmos.common.view.userinfo;

{$R *.dfm}

procedure TFmeUsuarioCadastrador.DBEdit1KeyPress(Sender: TObject;
  var Key: Char);
begin
 if key = #13 then
  self.SpeedButton1.Click;
end;

procedure TFmeUsuarioCadastrador.SpeedButton1Click(Sender: TObject);
var
 Dataset: TDataset;
 AUserLogin: string;
begin
 Dataset := DBEdit1.DataSource.DataSet;
 if (Dataset <> nil) and not (Dataset.Fields.FieldByName(DBedit1.DataField).IsNull) then
  begin
   FrmUserInfo := TFrmUserInfo.Create(Application);
   AUserLogin := DBEdit1.Field.AsString;

   try
    FrmUserInfo.ShowUserInfo(AUserLogin);

   finally
    FreeAndNil(FrmUserInfo);
   end;
  end;
end;


end.
