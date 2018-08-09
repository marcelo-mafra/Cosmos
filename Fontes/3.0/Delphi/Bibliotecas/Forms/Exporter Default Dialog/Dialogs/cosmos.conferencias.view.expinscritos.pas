unit cosmos.conferencias.view.expinscritos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, GroupHeader,
  cosmos.framework.interfaces.Dialogs, cosmos.business.focos, Vcl.ComCtrls,
  cosmos.framework.interfaces.Root, cosmos.system.messages, Datasnap.DBClient,
  cosmos.classes.application, cosmos.classes.ServerInterface, Vcl.Buttons,
  cosmos.framework.interfaces.DataAcess, cosmos.system.winshell, Data.DB,
  cosmos.system.types;

type
  TFrmExportarInscritos = class(TForm)
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
    Panel1: TPanel;
    RdbAllSexes: TRadioButton;
    RdbMen: TRadioButton;
    RdbWomen: TRadioButton;
    Panel2: TPanel;
    RdbAllHoused: TRadioButton;
    RdbHoused: TRadioButton;
    RdbNotHoused: TRadioButton;
    Bevel2: TBevel;
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure RdbDocClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FConferenceId: integer;
    FExportFormat: TExportFormat;
    FICosmosApp: ICosmosApplication;
    procedure LoadFocus;
    function GetFocosParam: string;

    function GetExportFormat: TExportFormat;
    procedure SetExportFormat(const Value: TExportFormat);

  public
    { Public declarations }
    function DoExportarInscritos(ConferenceId: integer): TClientDataset;

    property ConferenceId: integer read FConferenceId;
    property ExportFormat: TExportFormat read GetExportFormat write SetExportFormat;
    property ICosmosApp: ICosmosApplication read FICosmosApp;
  end;

var
  FrmExportarInscritos: TFrmExportarInscritos;

implementation

{$R *.dfm}

{ TFrmExportarCadastrados }

procedure TFrmExportarInscritos.Button1Click(Sender: TObject);
begin
 if Trim(EdtFileName.Text) <> '' then
  ModalResult := mrOk;
end;

function TFrmExportarInscritos.DoExportarInscritos(ConferenceId: integer): TClientDataset;
var
I: integer;
AParams: TCosmosData;
sFilter: string;
Filters: TSTringList;
begin
 FConferenceId := ConferenceId;
 LoadFocus;

 if ShowModal = mrOk then
  begin
     Result := TClientDataset.Create(self);
     AParams := TCosmosData.Create(5);
     Filters := TStringList.Create;

     AParams.WriteValue('CODCON', ConferenceId);
     AParams.WriteValue('FOCOS', self.GetFocosParam, 1);

     try
      ICosmosApp.IRemoteCon.ExecuteDQL(csIncritosConferenciaFocos, AParams.Data, Result);

      if Result.Active then
       begin
        if RdbMen.Checked then Filters.Append(Format('SEXCAD = %s', [QuotedStr('M')]))
        else
        if RdbWomen.Checked then Filters.Append(Format('SEXCAD = %s', [QuotedStr('F')]));

        if RdbHoused.Checked then Filters.Append(Format('CODLEI %s', ['is not null']))
        else
        if RdbNotHoused.Checked then Filters.Append(Format('CODLEI %s', ['is null']));

        for I := 0 to Pred(Filters.Count) do
         begin
          sFilter := Filters.Strings[I];
          if TClientDataset(Result).Filter.Trim = '' then
           TClientDataset(Result).Filter := sFilter
          else
           TClientDataset(Result).Filter := TClientDataset(Result).Filter + ' AND ' + sFilter;
         end;

        if TClientDataset(Result).Filter.Trim <> '' then
         TClientDataset(Result).Filtered := True;

        if Assigned(Filters) then FreeAndNil(Filters);
        if Assigned(aParams) then FreeAndNil(aParams);
       end;

     except
      on E: Exception do
      begin
       if Assigned(Filters) then FreeAndNil(Filters);
       if Assigned(aParams) then FreeAndNil(aParams);
       ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.ExportData, TCosmosErrorMsg.ExportDataSearch);
       ICosmosApp.MainLog.RegisterError(E.Message);
      end;
     end;
    end;
end;

procedure TFrmExportarInscritos.FormCreate(Sender: TObject);
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;
 ExportFormat := efMSExcel; //default
end;

procedure TFrmExportarInscritos.FormDestroy(Sender: TObject);
begin
 if Assigned(ICosmosApp) then
  FICosmosApp := nil;
end;

function TFrmExportarInscritos.GetFocosParam: string;
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

function TFrmExportarInscritos.GetExportFormat: TExportFormat;
begin
 Result := FExportFormat;
end;

procedure TFrmExportarInscritos.LoadFocus;
var
 ADataset: TClientDataset;
 aParams: TCosmosData;
 AItem: TListItem;
begin
 aParams := TCosmosData.Create(5);
 ADataset := TClientDataset.Create(self);

 try
  aParams.WriteValue('CODCON', ConferenceId);
  ICosmosApp.IRemoteCon.ExecuteDQL(csFocosInscritos, aParams.Data, aDataset);

  if ADataset <> nil then
   begin
    while not ADataset.Eof do
     begin
      AItem := LsvFocos.Items.Add;
      AItem.Caption := ADataset.FieldValues['NOMFOC']; //do not localize!
      AItem.SubItems.Add(ADataset.FieldValues['SIGFOC']); //do not localize!
      AItem.SubItems.Add(ADataset.FieldValues['CODFOC']); //do not localize!
      AItem.Checked := True;
      ADataset.Next;
     end;
   end;

 finally
  if Assigned(aParams) then FreeAndNil(aParams);
  if Assigned(ADataset) then FreeAndNil(ADataset);
 end;
end;

procedure TFrmExportarInscritos.RdbDocClick(Sender: TObject);
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

procedure TFrmExportarInscritos.SetExportFormat(const Value: TExportFormat);
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

procedure TFrmExportarInscritos.SpeedButton1Click(Sender: TObject);
begin
 if DlgSave.Execute(Application.Handle) then
  EdtFileName.Text := DlgSave.FileName;
end;


end.
