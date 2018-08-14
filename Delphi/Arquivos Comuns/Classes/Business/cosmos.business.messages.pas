unit cosmos.business.messages;

interface

type

  //Alguns termos usados pelas classes dessa unidade.
  TCampoTrabalhoShort = class
    const
      Lectorium = 'LEC';
      TM  = 'TMO';
      TMB = 'TMB';
      TP  = 'TPU';
      Simpatizantes = 'SIM';
  end;

  //Nomes de tipos de locais de trabalho ou focos.
  TFocusTypesShort = class
    const
      Ra = 'Região Administrativa';
      Centro = 'Centro de Conferências';
      NucleoCentro = 'Núcleo e Centro de Conferências';
      Nucleo = 'Núcleo';
      Sala = 'Sala do Trabalho Público';
      Local = 'Local do Trabalho Público';
      Unknown = 'Desconhecido';
      SedeNacional = 'Sede Nacional';
      SedeInternacional = 'Sede Internacional';
  end;

implementation

end.
