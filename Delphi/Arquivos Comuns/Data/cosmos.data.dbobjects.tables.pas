unit cosmos.data.dbobjects.tables;

interface

uses
 cosmos.system.files,cosmos.data.dbobjects.objnames;

type
  TCosmosTables = (ctAptidoes, ctCargos, ctEnfermidades, ctFuncoes, ctMeiosContatos,
   ctProfissoes, ctTiposRecebimentos, ctFlagsInscricao, ctFocos, ctPerfis,
   ctDiscipulados, ctTiposEventos, ctRelatoriosExternos);

  TCosmosTablesHelper = record helper for TCosmosTables
    private
     function GetTableBufferFile: string;
     function GetTableId: string;
     function GetTableName: string;

    public
     property TableBufferFile: string read GetTableBufferFile;
     property TableId: string read GetTableId;
     property TableName: string read GetTableName;
  end;

implementation

{ TCosmosTablesHelper }

function TCosmosTablesHelper.GetTableBufferFile: string;
begin
{Retorna o nome do arquivo de uma tebela buferizada do Cosmos.}
 case self of
   ctAptidoes: Result := TCosmosFiles.BufAptidoes; //do not localize!
   ctCargos: Result := TCosmosFiles.BufCargos; //do not localize!
   ctEnfermidades: Result := TCosmosFiles.BufEnfermidades; //do not localize!
   ctFuncoes: Result := TCosmosFiles.BufFuncoes; //do not localize!
   ctProfissoes: Result := TCosmosFiles.BufProfissoes; //do not localize!
   ctFocos: Result := TCosmosFiles.BufFocos; //do not localize!
   ctPerfis: Result := TCosmosFiles.BufPerfis; //do not localize!
   ctDiscipulados: Result := TCosmosFiles.BufDiscipulados; //do not localize!
   ctTiposEventos: Result := TCosmosFiles.BufTiposEventos; //do not localize!
   ctRelatoriosExternos: Result := TCosmosFiles.BufExternalReports; //do not localize!
 end;
end;

function TCosmosTablesHelper.GetTableId: string;
begin
{Retorna o identificador de uma tebela buferizada do Cosmos.}
 case self of
   ctAptidoes: Result := 'APT'; //do not localize!
   ctCargos: Result := 'CAR'; //do not localize!
   ctEnfermidades: Result := 'ENF'; //do not localize!
   ctFuncoes: Result := 'FUN'; //do not localize!
   ctProfissoes: Result := 'PRO'; //do not localize!
   ctFocos: Result := 'FOC'; //do not localize!
   ctPerfis: Result := 'PER'; //do not localize!
   ctDiscipulados: Result := 'DIS'; //do not localize!
   ctTiposEventos: Result := 'EVE'; //do not localize!
   ctRelatoriosExternos: Result := 'REL'; //do not localize!
 end;
end;

function TCosmosTablesHelper.GetTableName: string;
begin
{Retorna o nome de algumas tabelas mapeadas.}
 case self of
   ctAptidoes: Result := TTablesNames.TAB_APTIDOES;
   ctCargos: Result := TTablesNames.TAB_CARGOS;
   ctEnfermidades: Result:= TTablesNames.TAB_ENFERMIDADES;
   ctFuncoes: Result := TTablesNames.TAB_FUNCOES;
   ctMeiosContatos: Result := TTablesNames.TAB_MEIOSCONTATOS;
   ctProfissoes: Result := TTablesNames.TAB_PROFISSOES;
   ctTiposRecebimentos: Result := TTablesNames.TAB_TIPOS_RECEBIMENTOS;
   ctFlagsInscricao: Result := TTablesNames.TAB_FLAGS_INSCRICOES;
   ctFocos: Result := TTablesNames.TAB_FOCOS;
   ctPerfis: Result := TTablesNames.TAB_PERFIS;
   ctDiscipulados: Result := TTablesNames.TAB_DISCIPULADOS;
   ctTiposEventos: Result := TTablesNames.TAB_TIPOS_EVENTOS;
   ctRelatoriosExternos: Result := TTablesNames.TAB_RELATORIOS_EXTERNOS;
 end;
end;

end.
