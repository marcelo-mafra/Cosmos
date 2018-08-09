unit cosmos.common.view.dlgexporter;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  GroupHeader, Vcl.Buttons, Data.DB, Datasnap.DBClient, System.Win.ComObj,
  cosmos.system.types, cosmos.classes.application, Cosmos.Framework.Interfaces.Dialogs,
  cosmos.system.messages;

type

  TFrmExportar = class(TForm)
    MSGroupHeader1: TMSGroupHeader;
    MSGroupHeader2: TMSGroupHeader;
    RdbDoc: TRadioButton;
    RdbXLS: TRadioButton;
    RdbXML: TRadioButton;
    RdbHTML: TRadioButton;
    EdtFileName: TEdit;
    Label1: TLabel;
    SpeedButton1: TSpeedButton;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Image1: TImage;
    DlgSave: TSaveDialog;
    RdbTXT: TRadioButton;
    ChkOpenFile: TCheckBox;
    RdbRTF: TRadioButton;
    RdbCSV: TRadioButton;
    Bevel1: TBevel;
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure RdbDocClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    FExportFormat: TExportFormat;
    procedure SetExportFormat(const value: TExportFormat);

  public
    { Public declarations }
    property ExportFormat: TExportFormat read FExportFormat default efMSWord;

  end;

var
  FrmExportar: TFrmExportar;

implementation


{$R *.dfm}

procedure TFrmExportar.Button1Click(Sender: TObject);
begin
 if Trim(EdtFileName.Text) = '' then
  exit;

 ModalResult := mrOk;
end;

procedure TFrmExportar.Button2Click(Sender: TObject);
begin
Close;
end;

procedure TFrmExportar.Button3Click(Sender: TObject);
begin
 if Self.HelpContext <> 0 then
  Application.HelpSystem.ShowContextHelp(Self.HelpContext, Application.CurrentHelpFile);
end;

procedure TFrmExportar.FormCreate(Sender: TObject);
begin
 SetExportFormat(efMSWord);
end;

procedure TFrmExportar.RdbDocClick(Sender: TObject);
begin
 case TRadioButton(Sender).Tag of
  0: SetExportFormat(efMSWord);
  1: SetExportFormat(efMSExcel);
  2: SetExportFormat(efXML);
  3: SetExportFormat(efHTML);
  4: SetExportFormat(efText);
  5: SetExportFormat(efOpenOffice);
  6: SetExportFormat(efCSV);
 end;
end;

procedure TFrmExportar.SetExportFormat(const Value: TExportFormat);
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
     DlgSave.Filter := TCosmosFiles.CsvFilter;
     DlgSave.DefaultExt := 'csv';     
    end;
 end;
end;


procedure TFrmExportar.SpeedButton1Click(Sender: TObject);
begin
 if DlgSave.Execute(Application.Handle) then
  EdtFileName.Text := DlgSave.FileName;
end;

end.
