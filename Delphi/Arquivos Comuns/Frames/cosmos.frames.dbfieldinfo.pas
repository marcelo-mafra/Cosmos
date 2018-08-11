unit cosmos.frames.dbfieldinfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, Buttons, StdCtrls, Mask, DBCtrls;

type
  TFmeDBFieldInfo = class(TFrame)
    DBEdit1: TDBEdit;
    SpeedButton1: TSpeedButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
