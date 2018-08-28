unit cosmos.data.dbobjects.sequences;

interface

type
///<summary>Nomes de sequences do banco de dados.</summary>
 TSequencesNames =  class
    const
      GEN_ACTIVE_RANGE = 'ACTIVE_RANGE';
      GEN_SYNC_STATUS = 'SYNC_STATUS';
      GEN_FOCOS = 'GEN_FOCOS_ID';
      GEN_REGIOES = 'GEN_REGIOES_ID';
      GEN_CADASTRADOS = 'GEN_CADASTRADOS_ID';
      GEN_PAISES = 'GEN_PAISES_ID';
      GEN_ESTADOS = 'GEN_ESTADOS_ID';
      GEN_CIDADES = 'GEN_CIDADES_ID';
      GEN_BAIRROS = 'GEN_BAIRROS_ID';
      GEN_LOGRADOUROS = 'GEN_LOGRADOUROS_ID';
      GEN_ENDERECOS = 'GEN_ENDERECOS_ID';
      GEN_MEIOS_CONTATOS = 'GEN_MEIOS_CONTATOS_ID';
      GEN_FAMILIARES = 'GEN_FAMILIARES_ID';
      GEN_INFO_MED = 'GEN_INFO_MED_ID';
      GEN_FUNCOES_CADASTRADO = 'GEN_FUNCOES_CADASTRADO_ID';
      GEN_CARGOS = 'GEN_CARGOS_ID';
      GEN_TIPOS_CONTATOS = 'GEN_TIPOS_CONTATOS_ID';
      GEN_MENTORES_REGIOES = 'GEN_MENTORES_REGIOES_ID';
      GEN_ORGAOS_GESTORES = 'GEN_ORGAOS_GESTORES_ID';
      sGESTOES = 'GEN_GESTOES_ID';
      GEN_DIRECOES = 'GEN_DIRECOES_ID';
      GEN_USUARIOS = 'GEN_USUARIOS_ID';
      GEN_GESTOES = 'GEN_GESTOES_ID';
      GEN_GRUPOS_USUARIOS = 'GEN_GRUPOS_USUARIOS_ID';
      GEN_PROFISSOES = 'GEN_PROFISSOES_ID';
      GEN_ENFERMIDADES = 'GEN_ENFERMIDADES_ID';
      GEN_LIVROS_EI = 'GEN_LIVROS_EI_ID';
      GEN_LICOES_EI = 'GEN_LICOES_EI_ID';
      GEN_ALOCUCOES = 'GEN_ALOCUCOES_ID';
      GEN_ALOJAMENTOS = 'GEN_ALOJAMENTOS_ID';
      GEN_KEYWORDS = 'GEN_KEYWORDS_ID';
      GEN_TURMASTP = 'GEN_TURMAS_TP_ID';
      GEN_MEMBROS_TURMAS = 'GEN_MEMBROS_TURMAS_TP_ID';
      GEN_GRUPOS_EI = 'GEN_GRUPOS_EI_ID';
      GEN_APTIDOES = 'GEN_APTIDOES_ID';
      GEN_DISPENSAS = 'GEN_DISPENSAS_ID';
      GEN_DBVERSION = 'GEN_DBVERSION';
      GEN_HISTORICOS = 'GEN_HISTORICOS_ID';
      GEN_DETALHES_HISTORICO = 'GEN_DETALHE_HISTORICO_ID';
      GEN_ATIVIDADES = 'GEN_ATIVIDADES_ID';
      GEN_ATIVIDADES_DISCIPULADOS = 'GEN_ATIVIDADES_DISCIPULADOS_ID';
      GEN_ATIVIDADES_FOCOS = 'GEN_ATIVIDADES_FOCOS_ID';
      GEN_ATRIBUTOS = 'GEN_ATRIBUTOS_ID';
      GEN_ESCALAS_ATIVIDADES =  'GEN_ESCALAS_ATIVIDADES_ID';
      GEN_TIPOS_ATIVIDADES = 'GEN_TIPOS_ATIVIDADES_ID';
      GEN_MEMBROS_GRUPOS_EI = 'GEN_MEMBROS_GRUPOS_EI_ID';
      GEN_FREQUENCIAS = 'GEN_FREQUENCIAS_ID';
      GEN_INSCRICOES = 'GEN_INSCRICOES_ID';
      GEN_AREAS_APTIDOES = 'GEN_AREAS_APTIDOES_ID';
      GEN_CONTAS = 'GEN_CONTAS_ID';
      GEN_RECEBIMENTOS = 'GEN_RECEBIMENTOS_ID';
      GEN_PAGAMENTOS = 'GEN_PAGAMENTOS_ID';
      GEN_TURMAS_INSTALACOES = 'GEN_TURMAS_INSTALACOES_ID';
      GEN_MEMBROS_TURMAS_INSTALACOES = 'GEN_MEMBROS_TURMAS_INSTALACOES_ID';
      GEN_FUNCOES = 'GEN_FUNCOES_ID';
      GEN_PARTICIPANTES = 'GEN_PARTICIPANTES_ID';
      GEN_ATRIBUTOS_LEITOS = 'GEN_ATRIBUTOS_LEITOS_ID';
      GEN_CONFERENCIAS_FOCOS = 'GEN_CONFERENCIAS_FOCOS_ID';
      GEN_CONFERENCIAS_DISC = 'GEN_CONFERENCIAS_DISC_ID';
      GEN_RELATORIOS_EXTERNOS = 'GEN_RELATORIOS_EXTERNOS_ID';
      GEN_PERFIS = 'GEN_PERFIS_ID';
      GEN_PRIVILEGIOS = 'GEN_PRIVILEGIOS_ID';
      GEN_CENTROS_CUSTOS = 'GEN_CENTRO_CUSTOS_ID';
      GEN_CONTAS_BANCARIAS = 'GEN_CONTAS_BANCARIAS_ID';
      GEN_TIPOS_RECEBIMENTOS = 'GEN_TIPOS_RECEBIMENTOS_ID';
      GEN_ATRIBUTOS_CADASTRADOS = 'GEN_ATRIBUTOS_CADASTRADOS_ID';
      GEN_AREAS = 'GEN_AREAS_ID';
      GEN_TAREFAS_STAFF = 'GEN_TAREFAS_STAFF_ID';
      GEN_QUARTOS = 'GEN_QUARTOS_ID';
      GEN_LEITOS = 'GEN_LEITOS_ID';
      GEN_FLAGS_INSCRICOES = 'GEN_FLAGS_INSCRICOES_ID';
      GEN_ITENS_INSCRICAO = 'GEN_ITENS_INSCRICAO_ID';
      GEN_STAFF = 'GEN_STAFF_ID';
      GEN_NOTAS_INSCRITO = 'GEN_NOTAS_INSCRITO_ID';
      GEN_CAIXAS = 'GEN_CAIXAS_ID';
 end;

//Não altere a ordem destes tipos enumerados!
 TSequences = (sqCadastrados, sqFocos, sqRegioes, sqPaises, sqEstados,
   sqCidades, sqBairros, sqLogradouros, sqCargos, sqTiposMeiosContatos,
   sqMentorRA, sqOrgaosGestores, sqGestoes, sqDirecoes, sqAreasStaff);


 TSequencesHelper = record helper for TSequences
  private
   function GetSequenceName: string;
  public
   property SequenceName: string read GetSequenceName;
 end;

implementation

{ TSequencesHelper }

function TSequencesHelper.GetSequenceName: string;
begin
{Retorna o nome da sequence que um objeto do tipo TSequences representa.}
 case self of
   sqCadastrados: Result := TSequencesNames.GEN_CADASTRADOS;
   sqFocos: Result := TSequencesNames.GEN_FOCOS;
   sqRegioes: Result := TSequencesNames.GEN_REGIOES;
   sqPaises: Result := TSequencesNames.GEN_PAISES;
   sqEstados: Result := TSequencesNames.GEN_ESTADOS;
   sqCidades: Result := TSequencesNames.GEN_CIDADES;
   sqBairros: Result := TSequencesNames.GEN_BAIRROS;
   sqLogradouros: Result := TSequencesNames.GEN_LOGRADOUROS;
   sqCargos: Result := TSequencesNames.GEN_CARGOS;
   sqTiposMeiosContatos: Result := TSequencesNames.GEN_TIPOS_CONTATOS;
   sqMentorRA: Result := TSequencesNames.GEN_MENTORES_REGIOES;
   sqOrgaosGestores: Result := TSequencesNames.GEN_ORGAOS_GESTORES;
   sqGestoes: Result :=  TSequencesNames.GEN_GESTOES;
   sqDirecoes: Result := TSequencesNames.GEN_DIRECOES;
   sqAreasStaff: Result := TSequencesNames.GEN_AREAS;
 end;
end;

end.
