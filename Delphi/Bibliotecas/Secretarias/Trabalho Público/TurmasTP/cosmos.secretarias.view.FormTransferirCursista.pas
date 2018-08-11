unit cosmos.secretarias.view.FormTransferirCursista;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FormCosmosHelpDialog, ExtCtrls, StdCtrls, GroupHeader;

type
  TFrmTransferirCursista = class(TFrmCosmosHelpDialog)
    MSGroupHeader1: TMSGroupHeader;
    MSGroupHeader2: TMSGroupHeader;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmTransferirCursista: TFrmTransferirCursista;

implementation

{$R *.dfm}

end.
