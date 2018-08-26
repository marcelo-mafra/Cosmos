unit cosmos.business.focos.helpers;

interface

uses
 cosmos.business.focos, cosmos.business.messages;

type
 TTipoFocoHelper = record helper for TTipoFoco
  strict private
    function GetAsString: string;

  public
    property AsString: string read GetAsString;
 end;


 TCampoTrabalhoHelper = record helper for TCampoTrabalho
   strict private
     function GetShortName: string;

   public
     property ShortName: string read GetShortName;
 end;

implementation

{ TTipoFocoHelper }

function TTipoFocoHelper.GetAsString: string;
begin
 case self of
  tfRa: Result := TFocusTypesShort.Ra;
  tfCentro: Result := TFocusTypesShort.Centro;
  tfNucleoCentro: Result := TFocusTypesShort.NucleoCentro;
  tfNucleo: Result := TFocusTypesShort.Nucleo;
  tfSala: Result := TFocusTypesShort.Sala;
  tfLocal: Result := TFocusTypesShort.Local;
  tfUnknown: Result := TFocusTypesShort.Unknown;
  tfSedeNacional: Result := TFocusTypesShort.SedeNacional;
  tfSedeInternacional: Result := TFocusTypesShort.SedeInternacional;
 end;
end;

{ TCampoTrabalhoHelper }

function TCampoTrabalhoHelper.GetShortName: string;
begin
 case self of
  ctLectorium, ctEI: Result := TCampoTrabalhoShort.Lectorium;
  ctTM: Result := TCampoTrabalhoShort.TM;
  ctTMB: Result := TCampoTrabalhoShort.TMB;
  ctTP: Result := TCampoTrabalhoShort.TP;
  ctSimpatizantes: Result := TCampoTrabalhoShort.Simpatizantes;
  ctNone, ctAll: Result := '';
 end;
end;

end.
