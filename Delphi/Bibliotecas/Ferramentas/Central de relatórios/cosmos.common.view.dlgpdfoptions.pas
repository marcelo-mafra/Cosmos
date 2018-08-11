unit cosmos.common.view.dlgpdfoptions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, GroupHeader, frxExportPDF;

type
  TFrmPDFOptions = class(TForm)
    Image1: TImage;
    MSGroupHeader1: TMSGroupHeader;
    EdtAutor: TEdit;
    EdtTitulo: TEdit;
    EdtAssunto: TEdit;
    EdtKeywords: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    MSGroupHeader2: TMSGroupHeader;
    ChkFontes: TCheckBox;
    ChkComprimir: TCheckBox;
    ChkHiperlink: TCheckBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ConfigurePDFOptions(PDFExport: TFrxPDFExport);
  end;

var
  FrmPDFOptions: TFrmPDFOptions;

implementation

{$R *.dfm}

{ TFrmPDFOptions }

procedure TFrmPDFOptions.Button3Click(Sender: TObject);
begin
 if Self.HelpContext <> 0 then
  Application.HelpSystem.ShowContextHelp(Self.HelpContext, Application.CurrentHelpFile);
end;

procedure TFrmPDFOptions.ConfigurePDFOptions(PDFExport: TFrxPDFExport);
begin
  EdtAutor.Text := PDFExport.Author;
  EdtTitulo.Text := PDFExport.Title;
  EdtAssunto.Text := PDFExport.Subject;
  EdtKeywords.Text := PDFExport.Keywords;
  ChkFontes.Checked := PDFExport.EmbeddedFonts;
  ChkHiperlink.Checked := PDFExport.HTMLTags;
  ChkComprimir.Checked := PDFExport.Compressed;

  if ShowModal = mrOk then
    begin
     PDFExport.Author := EdtAutor.Text;
     PDFExport.Title := EdtTitulo.Text;
     PDFExport.Subject := EdtAssunto.Text;
     PDFExport.KeyWords := EdtKeywords.Text;
     PDFExport.EmbeddedFonts := ChkFontes.Checked;
     PDFExport.HTMLTags := ChkHiperlink.Checked;
     PDFExport.Compressed := ChkComprimir.Checked;
    end;
end;

end.
