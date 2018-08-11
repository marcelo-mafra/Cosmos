unit cosmos.financeiro.view.cancelarrecebimentos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  GroupHeader, Vcl.Buttons, Cosmos.Classes.Application, cosmos.business.financeiro,
  Cosmos.Framework.Interfaces.Applications;

type

  TFrmCancelarRecebimento = class(TForm)
    MSGroupHeader1: TMSGroupHeader;
    MSGroupHeader2: TMSGroupHeader;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton1: TRadioButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Bevel1: TBevel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label4: TLabel;
    LblTipoRecebimento: TLabel;
    Label6: TLabel;
    LblData: TLabel;
    Label8: TLabel;
    Lblvalor: TLabel;
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure RadioButton3Click(Sender: TObject);
  private
    { Private declarations }
    FMotivoCancelamento: TMotivoCancelamento;

  public
    { Public declarations }

    function ConfirmarCancelamento(InfoRecebimento: TCosmosData): boolean;
    property MotivoCancelamento: TMotivoCancelamento read FMotivoCancelamento;
  end;

var
  FrmCancelarRecebimento: TFrmCancelarRecebimento;

implementation

{$R *.dfm}

{ TFrmCancelarRecebimento }

function TFrmCancelarRecebimento.ConfirmarCancelamento(
  InfoRecebimento: TCosmosData): boolean;
begin
 FMotivoCancelamento := mcEquivoco; //default;
 LblTipoRecebimento.Caption := InfoRecebimento.FindValue('destiprec');
 LblData.Caption := InfoRecebimento.FindValue('datrec');
 Lblvalor.Caption := InfoRecebimento.FindValue('valrec');

 Result := ShowModal = mrOk;
end;

procedure TFrmCancelarRecebimento.RadioButton1Click(Sender: TObject);
begin
 FMotivoCancelamento := mcEquivoco;
end;

procedure TFrmCancelarRecebimento.RadioButton2Click(Sender: TObject);
begin
 FMotivoCancelamento := mcDesistencia;
end;

procedure TFrmCancelarRecebimento.RadioButton3Click(Sender: TObject);
begin
 FMotivoCancelamento := mcSystemError;
end;

end.
