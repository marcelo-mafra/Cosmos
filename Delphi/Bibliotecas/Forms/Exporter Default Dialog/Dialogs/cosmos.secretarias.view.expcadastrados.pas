unit cosmos.secretarias.view.expcadastrados;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, GroupHeader,
  cosmos.framework.interfaces.Dialogs, cosmos.business.focos, Vcl.ComCtrls,
  cosmos.framework.interfaces.Root, cosmos.system.messages, Datasnap.DBClient,
  cosmos.classes.application, cosmos.classes.ServerInterface, Vcl.Buttons,
  cosmos.framework.interfaces.DataAcess, cosmos.system.winshell, cosmos.system.types,
  cosmos.system.files, cosmos.data.dataobjects, Data.DB;

type
  TFrmExportarCadastrados = class(TForm)
    MSGroupHeader1: TMSGroupHeader;
    ChkDadosPessoais: TCheckBox;
    ChkEnderecos: TCheckBox;
    ChkTelefones: TCheckBox;
    MSGroupHeader2: TMSGroupHeader;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    ChkEmails: TCheckBox;
    LsvDiscipulados: TListView;
    MSGroupHeader3: TMSGroupHeader;
    Label1: TLabel;
    SpeedButton1: TSpeedButton;
    EdtFileName: TEdit;
    Bevel1: TBevel;
    DlgSave: TSaveDialog;
    MSGroupHeader4: TMSGroupHeader;
    RdbExcel: TRadioButton;
    RdbXML: TRadioButton;
    RdbCSV: TRadioButton;
    RdbDoc: TRadioButton;
    RdbHTML: TRadioButton;
    RdbTXT: TRadioButton;
    RdbOpenOffice: TRadioButton;
    ChkOpenFile: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure RdbDocClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FExportFormat: TExportFormat;
    FICosmosApp: ICosmosApplication;
    function DoExportData: TClientDataset;
    procedure LoadDiscipulados(const Campo: TCampoTrabalho);
    function GetDiscipulados: string;
    function GetSearch: TCosmosSearch;

    function GetExportFormat: TExportFormat;
    procedure SetExportFormat(const Value: TExportFormat);

  public
    { Public declarations }
    function DoExportarAlunos: TDataset;
    function DoExportarMembros: TDataset;
    function DoExportarJovensTM: TDataset;
    function DoExportarPesquisadores: TDataset;

    property ExportFormat: TExportFormat read GetExportFormat write SetExportFormat;
    property ICosmosApp: ICosmosApplication read FICosmosApp;
  end;

var
  FrmExportarCadastrados: TFrmExportarCadastrados;

implementation

{$R *.dfm}

{ TFrmExportarCadastrados }

procedure TFrmExportarCadastrados.Button1Click(Sender: TObject);
begin
 if Trim(EdtFileName.Text) <> '' then
  ModalResult := mrOk;
end;

function TFrmExportarCadastrados.DoExportarAlunos: TDataset;
begin
 LoadDiscipulados(ctLectorium);
 if ShowModal = mrOk then
  Result := DoExportData;
end;

function TFrmExportarCadastrados.DoExportarJovensTM: TDataset;
begin
 self.LoadDiscipulados(ctTM);
 if ShowModal = mrOk then
  Result := DoExportData;
end;

function TFrmExportarCadastrados.DoExportarMembros: TDataset;
begin
 self.LoadDiscipulados(ctTMB);
 if ShowModal = mrOk then
  Result := DoExportData;
end;

function TFrmExportarCadastrados.DoExportarPesquisadores: TDataset;
begin
 self.LoadDiscipulados(ctTP);
 if ShowModal = mrOk then
  Result := DoExportData;
end;

function TFrmExportarCadastrados.DoExportData: TClientDataset;
var
AParams: TCosmosData;
ASearch: TCosmosSearch;
begin
 if Trim(EdtFileName.Text) <> '' then
  begin
   Result := TClientDataset.Create(self);
   AParams := TCosmosData.Create(10);

   AParams.WriteValue('CODFOC', ICosmosApp.ActiveFocus.FocusID);
   AParams.WriteValue('DISCIPULADOS', GetDiscipulados, 1);
   AParams.WriteValue('INDATI', QuotedStr('S'), 2);

   try
    ASearch := GetSearch;
    ICosmosApp.IRemoteCon.ExecuteDQL(ASearch, AParams.Data, Result);

   except
    on E: Exception do
     begin
       ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.ExportData, TCosmosErrorMsg.ExportDataToFile);
       ICosmosApp.MainLog.RegisterError(E.Message);
     end;
   end;
  end
 else
  ICosmosApp.DlgMessage.WarningMessage(TCosmosTitles.ExportData, TCosmosErrorMsg.ExportDataSearch)
end;

procedure TFrmExportarCadastrados.FormCreate(Sender: TObject);
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;
 ExportFormat := efMSExcel; //default
end;

procedure TFrmExportarCadastrados.FormDestroy(Sender: TObject);
begin
 if Assigned(ICosmosApp) then
  FICosmosApp := nil;
end;

function TFrmExportarCadastrados.GetDiscipulados: string;
var
I: integer;
AItem: TListItem;
begin
//Retorna, na forma de uma string separada por vírgulas os discipulados selecionados.
 for I := 0 to Pred(LsvDiscipulados.Items.Count) do
   begin
    AItem := self.LsvDiscipulados.Items.Item[I];
    if AItem.Checked then
     begin
      if (AItem.Index < I) then
       Result := Result + QuotedStr(AItem.SubItems.Strings[0]) + ', '
      else
       Result := Result + ', ' + QuotedStr(AItem.SubItems.Strings[0])
     end;
   end;

 Delete(Result, 1, 2);
end;

function TFrmExportarCadastrados.GetExportFormat: TExportFormat;
begin
 Result := FExportFormat;
end;

function TFrmExportarCadastrados.GetSearch: TCosmosSearch;
begin
 if (ChkDadosPessoais.Checked) and not (ChkEnderecos.Checked) and not
  (ChkTelefones.Checked) and not (ChkEmails.Checked) then
 Result := csExportCadastrados;

 if (ChkDadosPessoais.Checked) and (ChkEnderecos.Checked) and not
  (ChkTelefones.Checked) and not (ChkEmails.Checked) then
 Result := csExportCadastradosEnderecos;

 if (ChkDadosPessoais.Checked) and not (ChkEnderecos.Checked) and
  (ChkTelefones.Checked) and not (ChkEmails.Checked) then
 Result := csExportCadastradosTelefones;

 if (ChkDadosPessoais.Checked) and not (ChkEnderecos.Checked) and not
  (ChkTelefones.Checked) and (ChkEmails.Checked) then
 Result := csExportCadastradosEmails;

 if (ChkDadosPessoais.Checked) and (ChkEnderecos.Checked) and (ChkTelefones.Checked)
  and (ChkEmails.Checked) then
 Result := csExportCadastradosEnderecosTelefonesEmails;

 if (ChkDadosPessoais.Checked) and (ChkEnderecos.Checked) and
  (ChkTelefones.Checked) and not (ChkEmails.Checked) then
 Result := csExportCadastradosEnderecosTelefones;

 if (ChkDadosPessoais.Checked) and (ChkEnderecos.Checked) and not
  (ChkTelefones.Checked) and (ChkEmails.Checked) then
 Result := csExportCadastradosEnderecosEmails;

 if (ChkDadosPessoais.Checked) and not (ChkEnderecos.Checked) and
  (ChkTelefones.Checked) and (ChkEmails.Checked) then
 Result := csExportCadastradosTelefonesEmails;
end;

procedure TFrmExportarCadastrados.LoadDiscipulados(const Campo: TCampoTrabalho);
var
 ADataset: TClientDataset;
 AItem: TListItem;
begin
 ADataset := TClientDataset.Create(self);

 try
  ADataset := ICosmosApp.IRemoteCon.OpenBufferedData(TCosmosFiles.BufDiscipulados);

  case Campo of
   ctLectorium: ADataset.Filter := Format(TFilterData.CAMDIS_INDATI, [QuotedStr('LEC'), QuotedStr('S')]);
   ctTM: ADataset.Filter := Format(TFilterData.CAMDIS_INDATI, [QuotedStr('TMO'), QuotedStr('S')]);
   ctTMB: ADataset.Filter := Format(TFilterData.CAMDIS_INDATI, [QuotedStr('TMB'), QuotedStr('S')]);
   ctTP: ADataset.Filter := Format(TFilterData.CAMDIS_INDATI, [QuotedStr('TPU'), QuotedStr('S')]);
   ctEI: ADataset.Filter := Format(TFilterData.CAMDIS_INDESCINT_INDATI, [QuotedStr('LEC'), QuotedStr('S'), QuotedStr('S')]);
  end;

  if ADataset <> nil then
   begin
    ADataset.Filtered := True;
    ADataset.IndexFieldNames := TIndexData.CAMDIS_SEQDIS;

    while not ADataset.Eof do
     begin
      AItem := LsvDiscipulados.Items.Add;
      AItem.Caption := ADataset.FieldValues['NOMDIS'];
      AItem.SubItems.Add(ADataset.FieldValues['SIGDIS']);
      AItem.Checked := True;
      ADataset.Next;
     end;
   end;

 finally
  if Assigned(ADataset) then
   FreeAndNil(ADataset);
 end;
end;

procedure TFrmExportarCadastrados.RdbDocClick(Sender: TObject);
begin
 case TRadioButton(Sender).Tag of
  0: ExportFormat := efMSWord;
  1: ExportFormat := efMSExcel;
  2: ExportFormat := efXML;
  3: ExportFormat := efHTML;
  4: ExportFormat := efText;
  5: ExportFormat := efCSV;
  6: ExportFormat := efOpenOffice;
 end;
end;

procedure TFrmExportarCadastrados.SetExportFormat(const Value: TExportFormat);
begin
 FExportFormat := Value;

 case Value of
   efMSWord:
    begin
     DlgSave.Filter := TCosmosFiles.DocFilter;
     DlgSave.DefaultExt := TFilesExtensions.DOCX;
    end;
   efMSExcel:
    begin
     DlgSave.Filter := TCosmosFiles.ExcelFilter;
     DlgSave.DefaultExt := TFilesExtensions.XLSX;
    end;
   efXML:
    begin
     DlgSave.Filter := TCosmosFiles.XmlFilter;
     DlgSave.DefaultExt := TFilesExtensions.XML;
    end;
   efHTML:
    begin
     DlgSave.Filter := TCosmosFiles.HTMLFilter;
     DlgSave.DefaultExt := TFilesExtensions.HTM;
    end;
   efText:
    begin
     DlgSave.Filter := TCosmosFiles.TXTFilter;
     DlgSave.DefaultExt := TFilesExtensions.TXT;
    end;
   efOpenOffice:
    begin
     DlgSave.Filter := TCosmosFiles.OpenOfficeFilter;
     DlgSave.DefaultExt := TFilesExtensions.ODT;
    end;
   efCSV:
    begin
     DlgSave.Filter := TCosmosFiles.CSVFilter;
     DlgSave.DefaultExt := TFilesExtensions.CSV;
    end;
 end;

 self.EdtFileName.Text := '';
end;

procedure TFrmExportarCadastrados.SpeedButton1Click(Sender: TObject);
begin
 if DlgSave.Execute(Application.Handle) then
  EdtFileName.Text := DlgSave.FileName;
end;


end.
