unit cosmos.classes.tools.printer;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, System.StrUtils,
  Vcl.Printers, Vcl.Graphics;

type
  TFinancialPrinter = class
    private
     FDevice: string;

    public
     constructor Create;
     destructor Destroy; override;

     procedure PrintReceipt;

     property Device: string read FDevice write FDevice;

  end;

implementation

{ TFinancialPrinter }

constructor TFinancialPrinter.Create;
begin
 inherited Create;
end;

destructor TFinancialPrinter.Destroy;
begin
 inherited Destroy;
end;

procedure TFinancialPrinter.PrintReceipt;
var
 aPrinter: TPrinter;
 Coluna, Linha: integer;
begin
  aPrinter := TPrinter.Create;

  try
   aPrinter.Orientation := poLandscape;
   //aPrinter.SetPrinter(Device, aDriver, '', );

   aPrinter.BeginDoc;
   aPrinter.Canvas.Pen.Width := 5;
   aPrinter.Canvas.Font.Name := 'Times New Roman';
   aPrinter.Canvas.Font.Size := 10;
   Coluna := 20;
   Linha := 20;

   //Impressão do título
   aPrinter.Canvas.Font.Style := aPrinter.Canvas.Font.Style + [fsBold];
   aPrinter.Canvas.TextOut(0, Linha, 'Recibo');
   aPrinter.Canvas.Font.Style := [];

   //Impressão da data do recebimento
   Linha := Linha + 5;
   aPrinter.Canvas.TextOut(0, Linha, 'Data:');

   aPrinter.EndDoc;

  finally
   aPrinter.Free;
  end;

end;

end.
