unit cosmos.secretarias.view.expagenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, GroupHeader,
  cosmos.framework.interfaces.Dialogs, cosmos.business.focos, Vcl.ComCtrls,
  cosmos.framework.interfaces.Root, cosmos.system.messages, Datasnap.DBClient,
  cosmos.classes.application, cosmos.classes.ServerInterface, Vcl.Buttons,
  cosmos.framework.interfaces.DataAcess, cosmos.system.winshell, Data.DB,
  cosmos.system.types, System.DateUtils;

type
  TFrmExportarAgenda = class(TForm)
    MSGroupHeader1: TMSGroupHeader;
    MSGroupHeader2: TMSGroupHeader;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    LsvFocos: TListView;
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
    EdtInicio: TDateTimePicker;
    EdtTermino: TDateTimePicker;
    Label2: TLabel;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure RdbDocClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FExportFormat: TExportFormat;
    FICosmosApp: ICosmosApplication;
    procedure LoadFocus;
    function GetFocosParam: string;

    function GetExportFormat: TExportFormat;
    procedure SetExportFormat(const Value: TExportFormat);

  public
    { Public declarations }
    function DoExportarAgenda: TClientDataset;

    property ExportFormat: TExportFormat read GetExportFormat write SetExportFormat;
    property ICosmosApp: ICosmosApplication read FICosmosApp;
  end;

var
  FrmExportarAgenda: TFrmExportarAgenda;

implementation

{$R *.dfm}

{ TFrmExportarCadastrados }

procedure TFrmExportarAgenda.Button1Click(Sender: TObject);
begin
 if Trim(EdtFileName.Text) <> '' then
  ModalResult := mrOk;
end;

function TFrmExportarAgenda.DoExportarAgenda: TClientDataset;
var
 AParams: TCosmosData;
 sFormatedDate: string;
begin
 LoadFocus;

 if ShowModal = mrOk then
  begin
     Result := TClientDataset.Create(self);
     AParams := TCosmosData.Create(5);

     sFormatedDate := FormatDateTime('yyyy/mm/dd', EdtInicio.Date);
     AParams.WriteValue('STARTDATE',  sFormatedDate.QuotedString);

     sFormatedDate := FormatDateTime('yyyy/mm/dd', EdtTermino.Date);
     AParams.WriteValue('ENDDATE', sFormatedDate.QuotedString, 1);

     AParams.WriteValue('FOCOS', self.GetFocosParam, 2);

     try
      ICosmosApp.IRemoteCon.ExecuteDQL(csAtividadesDatasFoco, AParams.Data, Result);

      if Assigned(aParams) then FreeAndNil(aParams);

     except
      on E: Exception do
      begin
       if Assigned(aParams) then FreeAndNil(aParams);
       ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.ExportData, TCosmosErrorMsg.ExportDataSearch);
       ICosmosApp.MainLog.RegisterError(E.Message);
      end;
     end;
    end;
end;

procedure TFrmExportarAgenda.FormCreate(Sender: TObject);
var
 aDate: TDateTime;
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;
 ExportFormat := efMSExcel; //default

 aDate := ICosmosApp.IRemoteCon.ServerDateTime;
 EdtInicio.Date :=  StartOfTheMonth(aDate);
 EdtTermino.Date := EndOfTheMonth(aDate);
end;

procedure TFrmExportarAgenda.FormDestroy(Sender: TObject);
begin
 if Assigned(ICosmosApp) then
  FICosmosApp := nil;
end;

function TFrmExportarAgenda.GetFocosParam: string;
var
I: integer;
AItem: TListItem;
begin
//Retorna, na forma de uma string separada por vírgulas os focos selecionados.
 for I := 0 to Pred(LsvFocos.Items.Count) do
   begin
    AItem := self.LsvFocos.Items.Item[I];
    if AItem.Checked then
     begin
      if (AItem.Index < I) then
       Result := Result + AItem.SubItems.Strings[1] + ', '
      else
       Result := Result + ', ' + AItem.SubItems.Strings[1];
     end;
   end;

 Delete(Result, 1, 2);
end;

function TFrmExportarAgenda.GetExportFormat: TExportFormat;
begin
 Result := FExportFormat;
end;

procedure TFrmExportarAgenda.LoadFocus;
var
 ADataset: TClientDataset;
 AItem: TListItem;
begin
 ADataset := ICosmosApp.IRemoteCon.OpenBufferedData(TCosmosFiles.BufFocos);

 try
  if ADataset <> nil then
   begin
    ADataset.Filter := Format('INDATI = %s', [QuotedStr('S')]);
    ADataset.Filtered := True;
    ADataset.IndexFieldNames := 'NOMFOC';

    while not ADataset.Eof do
     begin
      AItem := LsvFocos.Items.Add;
      AItem.Caption := ADataset.FieldValues['NOMFOC']; //do not localize!
      AItem.SubItems.Add(ADataset.FieldValues['SIGFOC']); //do not localize!
      AItem.SubItems.Add(ADataset.FieldValues['CODFOC']); //do not localize!

      if ICosmosApp.ActiveFocus.FocusID =  ADataset.FieldValues['CODFOC'] then
        AItem.Checked := True;

      ADataset.Next;
     end;
   end;

 finally
  if Assigned(ADataset) then FreeAndNil(ADataset);
 end;
end;

procedure TFrmExportarAgenda.RdbDocClick(Sender: TObject);
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

procedure TFrmExportarAgenda.SetExportFormat(const Value: TExportFormat);
begin
 FExportFormat := Value;

 case Value of
   efMSWord:
    begin
     DlgSave.Filter := TCosmosFiles.DocFilter;
     DlgSave.DefaultExt := 'docx';
    end;
   efMSExcel:
    begin
     DlgSave.Filter := TCosmosFiles.ExcelFilter;
     DlgSave.DefaultExt := 'xlsx';
    end;
   efXML:
    begin
     DlgSave.Filter := TCosmosFiles.XmlFilter;
     DlgSave.DefaultExt := 'xml';
    end;
   efHTML:
    begin
     DlgSave.Filter := TCosmosFiles.HTMLFilter;
     DlgSave.DefaultExt := 'htm';
    end;
   efText:
    begin
     DlgSave.Filter := TCosmosFiles.TXTFilter;
     DlgSave.DefaultExt := 'txt';
    end;
   efOpenOffice:
    begin
     DlgSave.Filter := TCosmosFiles.OpenOfficeFilter;
     DlgSave.DefaultExt := 'odt';
    end;
   efCSV:
    begin
     DlgSave.Filter := TCosmosFiles.CSVFilter;
     DlgSave.DefaultExt := 'csv';
    end;
 end;

 self.EdtFileName.Text := '';
end;

procedure TFrmExportarAgenda.SpeedButton1Click(Sender: TObject);
begin
 if DlgSave.Execute(Application.Handle) then
  EdtFileName.Text := DlgSave.FileName;
end;


end.
