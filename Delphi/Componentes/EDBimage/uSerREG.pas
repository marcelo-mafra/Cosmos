unit uSerREG;

interface

{$R CompsSer.dcr}
{$I Definitions.inc}

procedure Register;

implementation
uses Classes , {RegisterComponent}
      TypInfo, {propiedad Dataset del QREDBimage}
      DB, {para acceder al Dataset del reporte}

      {     PictEdit, {TGraphicEditor }
     edbimage;  { mis componentes }

procedure Register;
begin
  RegisterComponents('Data Controls', [TEDBImage]);

end;


end.

