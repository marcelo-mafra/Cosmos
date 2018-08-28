unit cosmos.data.dbobjects;

interface

uses Winapi.Windows;


 type
  //Filtros de dados aplicáveis nos datasets da camada cliente.
  TFilterData = class
   const
    CAMDIS = 'CAMDIS = %s'; //do not localize!
    CAMDIS_INDATI = 'CAMDIS = %s and INDATI = %s'; //do not localize!
    CAMDIS_INDESCINT_INDATI = 'CAMDIS = %s and INDESCINT = %s and INDATI = %s'; //do not localize!
    INDESCINT_INDATI = 'INDESCINT = %s and INDATI = %s'; //do not localize!
  end;

  //Índices de dados aplicáveis nos datasets da camada cliente.
  TIndexData = class
   const
    CAMDIS_SEQDIS = 'CAMDIS;SEQDIS'; //do not localize!

  end;


implementation

end.
