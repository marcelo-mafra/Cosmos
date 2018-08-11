unit cosmos.conferencias.reports;

interface

uses
  SysUtils, Classes, frxClass, frxDBSet;

type
  TDMConfReports = class(TDataModule)
    frxDBCrachas: TfrxDBDataset;
    frxDBProgramacao: TfrxDBDataset;
    frxDBListaInscritos: TfrxDBDataset;
    frxDBFichaInscricao: TfrxDBDataset;
    frxDBCrachaInscrito: TfrxDBDataset;
    frxDBAreasStaaff: TfrxDBDataset;
    frxDBTarefasCracha: TfrxDBDataset;
    frxDBAlojamentos: TfrxDBDataset;
    frxDBLeitos: TfrxDBDataset;
    frxDBInformacoesInscritos: TfrxDBDataset;
    frxDBStaffs: TfrxDBDataset;
    frxDBQuartosAlojamento: TfrxDBDataset;
    frxDBFolhasQuartos: TfrxDBDataset;
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  DMConfReports: TDMConfReports;

implementation

{$R *.dfm}

uses cosmos.conferencias.reports.data;

{ TDMCentralConferencias }



end.
