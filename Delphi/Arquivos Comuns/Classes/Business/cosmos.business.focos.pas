unit cosmos.business.focos;

interface

uses
 System.Classes, cosmos.business.messages;

type

//business core objects

  //Representa cada um dos campos de trabalho.
  TCampoTrabalho = (ctLectorium, ctTM, ctTMB, ctTP, ctEI, ctSimpatizantes,
    ctNone, ctAll);

  //Representa um conjunto de campos de trabalho.
  TCamposTrabalho = set of TCampoTrabalho;

  //Representa cada um dos tipos de um foco.
  TTipoFoco = (tfRa, tfSedeInternacional, tfSedeNacional, tfCentro, tfNucleoCentro,
    tfNucleo, tfSala, tfLocal, tfUnknown, tfTypeIndicator);

  //Representa um conjunto de tipos de focos.
  TTipoFocoSet = set of TTipoFoco;

  TCustomFocus = class
  private
    FFocusID: integer;
    FFocusName: string;

  public
   constructor Create;
   destructor Destroy; override;

   property FocusID: integer read FFocusID write FFocusID;
   property FocusName: string read FFocusName write FFocusName;
  end;


  TRegiaoAdministrativa = class(TCustomFocus)
  private
    FParent: TRegiaoAdministrativa;

   public
    constructor Create;
    destructor Destroy; override;

    property FocusID;
    property FocusName;
    property Parent: TRegiaoAdministrativa read FParent write FParent;
  end;


  TFocus = class(TCustomFocus)
  private
    FAtivo: boolean;
    FSigla: string;
    FCampos: TCamposTrabalho;
    FFocusType: TTipoFoco;
    FRegiao: TRegiaoAdministrativa;

  public
   constructor Create;
   destructor destroy; override;

   property FocusID;
   property FocusName;

   property Ativo: boolean read FAtivo write FAtivo;
   property FocusType: TTipoFoco read FFocusType write FFocusType;
   property Campos: TCamposTrabalho read FCampos write FCampos;
   property Sigla: string read FSigla write FSigla;
   property Regiao: TRegiaoAdministrativa read FRegiao write FRegiao;

  end;

  TFocusTypesInfo = class
    class function GetFocusType(const FocusType: string): TTipoFoco;
    class function FocusTypeToString(const FocusType: TTipoFoco): string;
    class function CampoTrabalhoToString(const Campo: TCampoTrabalho): string;
  end;

implementation

{ TCustomFocus }

constructor TCustomFocus.Create;
begin
  inherited Create;
end;

destructor TCustomFocus.Destroy;
begin
 inherited Destroy;
end;

{ TRegiaoAdministrativa }

constructor TRegiaoAdministrativa.Create;
begin
 inherited Create;
end;

destructor TRegiaoAdministrativa.Destroy;
begin
 if FParent <> nil then
  FParent := nil;
 inherited Destroy;
end;


{ TFocus }

constructor TFocus.Create;
begin
 inherited Create;
end;

destructor TFocus.destroy;
begin
  inherited Destroy;
end;

{ TFocusTypesInfo }

class function TFocusTypesInfo.CampoTrabalhoToString(
  const Campo: TCampoTrabalho): string;
begin
 case Campo of
  ctLectorium, ctEI: Result := TCampoTrabalhoShort.Lectorium;
  ctTM: Result := TCampoTrabalhoShort.TM;
  ctTMB: Result := TCampoTrabalhoShort.TMB;
  ctTP: Result := TCampoTrabalhoShort.TP;
  ctSimpatizantes: Result := TCampoTrabalhoShort.Simpatizantes;
  ctNone, ctAll: Result := '';
 end;
end;

class function TFocusTypesInfo.FocusTypeToString(
  const FocusType: TTipoFoco): string;
begin
 case FocusType of
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

class function TFocusTypesInfo.GetFocusType(const FocusType: string): TTipoFoco;
begin
 if FocusType = 'SDI' then Result := tfSedeInternacional else
 if FocusType = 'SDN' then Result := tfSedeNacional else
 if FocusType = 'CCO' then Result := tfCentro else
 if FocusType = 'NCC' then Result := tfNucleoCentro else
 if FocusType = 'NUC' then Result := tfNucleo else
 if FocusType = 'STP' then Result := tfSala else
 if FocusType = 'LTP' then Result := tfLocal else
 Result := tfUnknown;
end;

end.

