unit Cosmos.Framework.Interfaces.Applications;

interface

 uses cosmos.classes.application, Cosmos.Framework.Interfaces.Root, cosmos.business.focos,
  cosmos.business.secretariats, cosmos.business.financeiro, Data.DBXCommon;

 type
  ICosmosFocos = interface(ICosmosInterfaces)
    ['{1D54580F-58A1-4E9D-82D9-D47D0C7A05DE}']

    //Regiões administrativas.
    function ChangeRegion(FocusID, NewRegion: Integer): boolean;
    function DeleteRegion(const RegionId: integer): boolean;
    function NewRegion(const NewRegion: string; ParentId: variant): variant;
    function RenameRa(const RegionId: integer; RegionName: string): boolean;
    function MoveRegion(RegionID, NewRegion: Integer): boolean;

    //Focos.
    function ChangeFocusParent(FocusID, NewParentId: Integer): boolean;
    function ChangeFocusStatus(FocusId: Integer; Status: boolean): boolean;
    function CreateFocus(DadosFoco, DadosEndereco, DadosGestao, DadosMeiosContatos: OleVariant): boolean;
    function DeleteFocus(codfoc: Integer): boolean;
    function DesactiveFocus(TargetFocus, TransferFocus: Integer; Desactivate: boolean): string;
  end;


  ICosmosSecretarias = interface(ICosmosInterfaces)
   ['{AB58AC17-4B4C-408C-8CF6-9D3E9A397A44}']

    function GetSecretariasOptions: TSecretariasOptions;

    //Escola Interna
    function DesactivateCircle(const CircleID: integer): boolean;
    function CreateCircle(CircleData, Members: Olevariant): boolean;

    //Movimentação do histórico discipular
    procedure BaptizePeople(const TaggedData: string);
    function DesactivatePeople(const TaggedData: string): boolean;
    function InvalidateEvent(const codhis: integer; Discipulado: string): boolean;
    function  LoadPreviousGrades(const coddis: integer; TM, TPU, SIM, Atual: boolean): TDBXReader;
    function NovaMatricula(const CampoTrabalho: TCampoTrabalho): string;
    function ReactivatePeople(const TaggedData: string): boolean;
    procedure RegisterMarriage(const TaggedData: string);
    function RetrogradatePeople(const TaggedData: string): boolean;
    procedure SendLetter(const TaggedData: string);
    function TransferPeople(const TaggedData: string): boolean;
    procedure UpdateAllYoungPupils(const codfoc: integer);

    //Trabalho Público
    function CloseTeam(const TeamID: integer): boolean;
    function CreatePublicTeam(const FocusID: integer; Team: Olevariant): boolean;
    procedure DeleteTeam(const TeamID: integer);
    function GetPublicTeamId(const FocusId: integer): string;
    function ReactivateTeam(const TeamID: integer): boolean;

    property SecretariasOptions: TSecretariasOptions read GetSecretariasOptions;
  end;

  ICosmosFinanceiro = interface(ICosmosInterfaces)
   ['{AEC15BA7-4B6C-4755-80B2-077EF7631CA4}']

    function GetCaixaAberto: boolean;
    function GetCurrentCaixa: TCaixa;

    procedure CadastrarDispensas(const codcad: integer; nomcad: string);
    function CancelarRecebimento(Info: TCosmosData): boolean;
    function CancelarPagamento(Info: TCosmosData): boolean;
    function FecharCaixa(const codcai: integer; UserLogin: string): boolean;
    procedure ImprimirRecibo(const RecebimentoId: integer);
    procedure SummarizeCaixa(const codcai: integer; Close: boolean);

    property CaixaAberto: boolean read GetCaixaAberto;
    property CurrentCaixa: TCaixa read GetCurrentCaixa;
  end;

implementation

end.

