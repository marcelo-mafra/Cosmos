unit cosmos.server.tools.dmstarter;

interface

uses
  System.SysUtils, System.Classes, Cosmos.System.Types, Cosmos.System.Files,
  Cosmos.System.Messages, Cosmos.Classes.Application, Cosmos.System.Winshell,
  Cosmos.Classes.Persistence.Ini;

type
  TDMStarter = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    FHint: string;
    StartedModules: set of TCosmosModules;

  public
    { Public declarations }
    property Hint: string read FHint;
  end;

var
  DMStarter: TDMStarter;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDMStarter.DataModuleCreate(Sender: TObject);
 var
  CosmosApp: TCosmosApplication;
  AFile: TIniFilePersistence;
  AModule: TCosmosModules;
  AFileName, sModuleExecutable: string;
  I: integer;
begin
{Carrega as configurações para saber quais servidores devem ser
inicializados.}
 CosmosApp := TCosmosApplication.Create;
 AFileName := CosmosApp.GetModulePath + TCosmosFiles.CosmosRoot;
 AFile := TIniFilePersistence.Create(AFileName, True);

 try
  FHint := '';
  StartedModules := [];

  //Gestor de Secretarias.
  if AFile.ReadBoolean('GSEC', 'Started', True) then
   Include(StartedModules, cmSecretariasServer);

  //Gestor de Usuários.
  if AFile.ReadBoolean('GUSU', 'Started', True) then
   Include(StartedModules, cmUsuariosServer);

  //Gestor de Conferências.
  if AFile.ReadBoolean('GCON', 'Started', True) then
   Include(StartedModules, cmConferenciasServer);

  //Gestor Financeiro.
  if AFile.ReadBoolean('GFIN', 'Started', True) then
   Include(StartedModules, cmFinanceiroServer);

  for AModule := cmFocos to cmUsuariosServer  do
     begin
       if  AModule in StartedModules then
        begin
         case AModule of
          cmSecretariasServer: sModuleExecutable := 'secserapp.exe';
          cmFinanceiroServer: sModuleExecutable := 'finserapp.exe';
          cmConferenciasServer: sModuleExecutable := 'confserapp.exe';
          cmUsuariosServer: sModuleExecutable := 'ususerapp.exe';
         end;

         TWinShell.OpenProgram(sModuleExecutable, '');
         FHint := FHint + CosmosApp.GetFullModuleName(AModule) + #13;
        end;
     end;

 finally
  if Assigned(AFile) then FreeAndNil(AFile);
  if Assigned(CosmosApp) then  FreeAndNil(CosmosApp);
 end;
end;

end.
