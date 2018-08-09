unit cosmos.business.secretariats;

interface

uses
 System.Classes;

 type
   {Modo de geração de novas matrículas: sempre a partir do último número ou
    aproveitando intervalos vagos.}
   TNewMatriculaMode = (mmFromLastNumber, mmEmptyIntervals);

 TSecretariasOptions = class
   private
    FNewMatriculaMode: TNewMatriculaMode;

   public
    constructor Create;
    destructor Destroy;

    property NewMatriculaMode: TNewMatriculaMode read FNewMatriculaMode write FNewMatriculaMode default mmFromLastNumber;
 end;

implementation

{ TSecretariasOptions }

constructor TSecretariasOptions.Create;
begin
 inherited Create;
end;

destructor TSecretariasOptions.Destroy;
begin
 inherited Destroy;
end;

end.
