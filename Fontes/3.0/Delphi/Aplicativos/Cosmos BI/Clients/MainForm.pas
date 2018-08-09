unit MainForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, SynCommons, mORMot,
  mORMotHttpClient, cosmos.bi.interfaces;

type
  TFrmMain = class(TForm)
  private
    { Private declarations }
  public
    { Public declarations }
    Model: TSQLModel;
    Client: TSQLRestClientURI;
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.fmx}

end.
