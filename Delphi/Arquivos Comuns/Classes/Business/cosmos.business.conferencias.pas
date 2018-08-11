unit cosmos.business.conferencias;

interface

uses

 System.Classes;

type

//Conferences core objects

  TConferencia = class
  private
    FConferenceName, FFocoPromotor, FCampoPromotor: string;
    FConferenceID: integer;
    FConferenceStart, FConferenceEnd: TDateTime;

  public
   constructor Create;
   destructor Destroy; override;

   property ConferenceID: integer read FConferenceID write FConferenceID;
   property ConferenceName: string read FConferenceName write FConferenceName;
   property FocoPromotor: string read FFocoPromotor write FFocoPromotor;
   property CampoPromotor: string read FCampoPromotor write FCampoPromotor;
   property ConferenceStart: TDateTime read FConferenceStart write FConferenceStart;
   property ConferenceEnd: TDateTime read FConferenceEnd write FConferenceEnd;
  end;


implementation

{ TConferencia }

constructor TConferencia.Create;
begin
  inherited Create;
end;

destructor TConferencia.Destroy;
begin
 inherited Destroy;
end;


end.

