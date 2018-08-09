unit cosmos.financeiro.view.caixaresult;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, GroupHeader,
  Data.DBXCommon, cosmos.classes.application;

type
  TFrmFechamentoCaixa = class(TForm)
    MSGroupHeader1: TMSGroupHeader;
    MSGroupHeader2: TMSGroupHeader;
    MSGroupHeader3: TMSGroupHeader;
    ChkShowMummary: TCheckBox;
    Bevel1: TBevel;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    LblTotaisRecebidos: TLabel;
    LblValoresRecebidos: TLabel;
    LblTotaisPagos: TLabel;
    LblValoresPagos: TLabel;
    Label5: TLabel;
    LblNumcaixa: TLabel;
    Label7: TLabel;
    LblResponsavel: TLabel;
  private
    { Private declarations }
    function GetShowOption: boolean;

  public
    { Public declarations }
    procedure ShowSummary(Data: TCosmosData);

    property ShowOption: boolean read GetShowOption;
  end;

var
  FrmFechamentoCaixa: TFrmFechamentoCaixa;

implementation

{$R *.dfm}

{ TFrmFechamentoCaixa }

function TFrmFechamentoCaixa.GetShowOption: boolean;
begin
 Result := ChkShowMummary.Checked;
end;

procedure TFrmFechamentoCaixa.ShowSummary(Data: TCosmosData);
begin
  if Data <> nil then
   begin
     LblNumcaixa.Caption := Data.FindValue('numcai');
     LblResponsavel.Caption := Data.FindValue('nomcad');
     LblTotaisRecebidos.Caption := Data.FindValue('numrec');
     LblValoresRecebidos.Caption := TDataConverter.ToFormatedCurrency(Data.FindValue('totrec'));
     LblTotaisPagos.Caption := Data.FindValue('numpag');
     LblValoresPagos.Caption := TDataConverter.ToFormatedCurrency(Data.FindValue('totpag'));
   end;

  ShowModal;
end;

end.
