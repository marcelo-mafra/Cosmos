unit cosmos.classes.controler.exporter;

interface

uses
 System.Classes, System.SysUtils, cosmos.system.types, cosmos.system.messages,
 cosmos.classes.application, cosmos.framework.interfaces.root, Vcl.Controls, Vcl.Forms,
 cosmos.framework.interfaces.dialogs, cosmos.framework.interfaces.DataAcess,
 cosmos.business.focos, Data.DB, Cosmos.System.Winshell;


type
  TDlgExporterControler = class(TInterfacedPersistent, IExporterDialogs)

   private
    FExportFormat: TExportFormat;
    FFileName: string;
    FOpenFile: boolean;
    procedure DoExportData(Dataset: TDataset);


   protected
    function GetFileName: string;
    function GetExportFormat: TExportFormat;
    function GetOpenFile: boolean;

    procedure ExecuteDefault(Dataset: TDataset);
    procedure ExportarAgendaAtividades;
    procedure ExportarAlunos;
    procedure ExportarJovensTM;
    procedure ExportarPesquisadores;
    procedure ExportarInscritos(ConferenceId: integer);

    property FileName: string read GetFileName;
    property ExportFormat: TExportFormat read GetExportFormat;
    property OpenFile: boolean read GetOpenFile;

   public
    { Public declarations }
    constructor Create;
    destructor Destroy; override;
  end;

implementation



uses cosmos.common.view.dlgexporter, cosmos.secretarias.view.expcadastrados,
 cosmos.conferencias.view.expinscritos, cosmos.secretarias.view.expagenda;

{ TDlgExporterControler }

constructor TDlgExporterControler.Create;
begin
 inherited Create;
 FOpenFile := True; //default
end;

destructor TDlgExporterControler.Destroy;
begin
 inherited Destroy;
end;

procedure TDlgExporterControler.DoExportData(Dataset: TDataset);
var
  AModule: HModule;
  ADataModule: TDataModule;
  ICosmosApp: ICosmosApplication;
  IExporter: ICosmosExporter;
begin
//Exporta os dados do dataset ativo para um arquivo externo.
 if Assigned(Dataset) and (Dataset.Active) then
  begin
   ICosmosApp := Application.MainForm as ICosmosApplication;

   try
     if not Dataset.IsEmpty then
      begin
       ADataModule := ICosmosApp.LoadDataModule('exporter.bpl', 'TDMExporter', AModule);
       if ADataModule <> nil then
        begin
         IExporter := ADataModule as ICosmosExporter;

         case ExportFormat of
           efMSWord: IExporter.ExportToMSWord(Dataset, FileName);
           efMSExcel: IExporter.ExportToMSExcel(Dataset, FileName);
           efXML: IExporter.ExportToXML(Dataset, FileName);
           efHTML:IExporter.ExportToHTML(Dataset, FileName);
           efText: IExporter.ExportToTXT(Dataset, FileName);
           efOpenOffice: IExporter.ExportToOpenOffice(Dataset, FileName);
           efCSV: IExporter.ExportToCSV(Dataset, FileName);
         end;

         if OpenFile then
           TWinShell.OpenFile(FileName);

         ADataModule.Free;
        end;
      end
     else
      ICosmosApp.DlgMessage.InfoMessage(TCosmosTitles.ExportData, TCosmosInfoMsg.ExportEmpty);

   finally
     if Assigned(ICosmosApp) then ICosmosApp := nil;
     if Assigned(IExporter) then IExporter := nil;
     if AModule <> 0 then UnloadPackage(AModule);
   end;
  end;
end;

procedure TDlgExporterControler.ExecuteDefault(Dataset: TDataset);
begin
 FrmExportar := TFrmExportar.Create(nil);

 try
  if FrmExportar.ShowModal = mrOk then
   begin
    FExportFormat := FrmExportar.ExportFormat;
    FFileName := FrmExportar.EdtFileName.Text;
    FOpenFile := FrmExportar.ChkOpenFile.Checked;

    DoExportData(Dataset);
   end;

 finally
  if Assigned(FrmExportar) then FreeAndNil(FrmExportar);
 end;
end;

procedure TDlgExporterControler.ExportarAgendaAtividades;
var
 aDataset: TDataset;
begin
 FrmExportarAgenda := TFrmExportarAgenda.Create(nil);

 try
  aDataset := FrmExportarAgenda.DoExportarAgenda;

  if (aDataset <> nil) then
   begin
    FExportFormat := FrmExportarAgenda.ExportFormat;
    FFileName := FrmExportarAgenda.EdtFileName.Text;
    FOpenFile := FrmExportarAgenda.ChkOpenFile.Checked;

    DoExportData(aDataset);
   end;

 finally
  if Assigned(FrmExportarAgenda) then FreeAndNil(FrmExportarAgenda);
 end;
end;

procedure TDlgExporterControler.ExportarAlunos;
var
 aDataset: TDataset;
begin
 FrmExportarCadastrados := TFrmExportarCadastrados.Create(nil);

 try
  aDataset := FrmExportarCadastrados.DoExportarAlunos;

  if (aDataset <> nil) then
   begin
    FExportFormat := FrmExportarCadastrados.ExportFormat;
    FFileName := FrmExportarCadastrados.EdtFileName.Text;
    FOpenFile := FrmExportarCadastrados.ChkOpenFile.Checked;

    DoExportData(aDataset);
   end;

 finally
  if Assigned(FrmExportarCadastrados) then FreeAndNil(FrmExportarCadastrados);
 end;
end;

procedure TDlgExporterControler.ExportarInscritos(ConferenceId: integer);
var
 aDataset: TDataset;
begin
 FrmExportarInscritos := TFrmExportarInscritos.Create(nil);

 try
  aDataset := FrmExportarInscritos.DoExportarInscritos(ConferenceId);

  if (aDataset <> nil) then
   begin
    FExportFormat := FrmExportarInscritos.ExportFormat;
    FFileName := FrmExportarInscritos.EdtFileName.Text;
    FOpenFile := FrmExportarInscritos.ChkOpenFile.Checked;

    DoExportData(aDataset);
   end;

 finally
  if Assigned(FrmExportarInscritos) then
   FreeAndNil(FrmExportarInscritos);
 end;
end;

procedure TDlgExporterControler.ExportarJovensTM;
var
 aDataset: TDataset;
begin
 FrmExportarCadastrados := TFrmExportarCadastrados.Create(nil);

 try
  aDataset := FrmExportarCadastrados.DoExportarJovensTM;

  if (aDataset <> nil) then
   begin
    FExportFormat := FrmExportarCadastrados.ExportFormat;
    FFileName := FrmExportarCadastrados.EdtFileName.Text;
    FOpenFile := FrmExportarCadastrados.ChkOpenFile.Checked;

    DoExportData(aDataset);
   end;

 finally
  if Assigned(FrmExportarCadastrados) then FreeAndNil(FrmExportarCadastrados);
 end;
end;

procedure TDlgExporterControler.ExportarPesquisadores;
var
 aDataset: TDataset;
begin
 FrmExportarCadastrados := TFrmExportarCadastrados.Create(nil);

 try
  aDataset := FrmExportarCadastrados.DoExportarPesquisadores;

  if (aDataset <> nil) then
   begin
    FExportFormat := FrmExportarCadastrados.ExportFormat;
    FFileName := FrmExportarCadastrados.EdtFileName.Text;
    FOpenFile := FrmExportarCadastrados.ChkOpenFile.Checked;

    DoExportData(aDataset);
   end;

 finally
  if Assigned(FrmExportarCadastrados) then FreeAndNil(FrmExportarCadastrados);
 end;
end;

function TDlgExporterControler.GetExportFormat: TExportFormat;
begin
 Result := FExportFormat;
end;

function TDlgExporterControler.GetFileName: string;
begin
 Result := FFileName;
end;

function TDlgExporterControler.GetOpenFile: boolean;
begin
 Result := FOpenFile;
end;

initialization
 RegisterClass(TDlgExporterControler);

finalization
 UnRegisterClass(TDlgExporterControler);

end.
