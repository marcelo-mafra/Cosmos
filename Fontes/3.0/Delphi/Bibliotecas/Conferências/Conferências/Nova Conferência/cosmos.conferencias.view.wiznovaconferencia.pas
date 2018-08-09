unit cosmos.conferencias.view.wiznovaconferencia;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cosmos.framework.view.FrmDefWizard, Wizard, ImgList, ActnList, jpeg, ExtCtrls,
  ComCtrls, StdCtrls, Buttons, ValueComboBox, GroupHeader, Spin, cosmos.frames.searchdata,
  Cosmos.Framework.Interfaces.Root, Cosmos.Framework.Interfaces.DataAcess,
  cosmos.classes.ServerInterface, cosmos.classes.application, Vcl.Imaging.pngimage,
  System.Actions;

type
  TFrmNovaConferencia = class(TFrmCosmosWizard)
    TabSheet2: TTabSheet;
    EdtNomeConf: TEdit;
    Label2: TLabel;
    MSGroupHeader1: TMSGroupHeader;
    Label3: TLabel;
    EdtFocoPromotor: TEdit;
    Label4: TLabel;
    CBXCampo: TValueComboBox;
    MSGroupHeader2: TMSGroupHeader;
    Label5: TLabel;
    Label6: TLabel;
    EdtDataInicial: TDateTimePicker;
    EdtHoraInicio: TDateTimePicker;
    EdtHoraFim: TDateTimePicker;
    Label7: TLabel;
    EdtDataFinal: TDateTimePicker;
    Label8: TLabel;
    TabSheet3: TTabSheet;
    MSGroupHeader3: TMSGroupHeader;
    Label9: TLabel;
    EdtDataLimite: TDateTimePicker;
    EdtLimite: TSpinEdit;
    Label10: TLabel;
    MSGroupHeader4: TMSGroupHeader;
    RdbProgramada: TRadioButton;
    RdbCorrente: TRadioButton;
    RdbEncerrada: TRadioButton;
    ChkEspecial: TCheckBox;
    ChkModelo: TCheckBox;
    ActAjuda: TAction;
    TabSheet5: TTabSheet;
    MSGroupHeader5: TMSGroupHeader;
    RdbByCheckin: TRadioButton;
    RdbByConference: TRadioButton;
    RdbByAtivity: TRadioButton;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    CBXMesReferencia: TValueComboBox;
    Label16: TLabel;
    MSGroupHeader6: TMSGroupHeader;
    EdtTaxa: TEdit;
    Label11: TLabel;
    procedure ActAjudaExecute(Sender: TObject);
    procedure ActProximoUpdate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EdtTaxaKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    function CreateConference: boolean;
  public
    { Public declarations }
    function Execute: boolean; override;
  end;

var
  FrmNovaConferencia: TFrmNovaConferencia;

implementation

{$R *.dfm}

procedure TFrmNovaConferencia.ActAjudaExecute(Sender: TObject);
begin
  inherited;
  Application.HelpSystem.ShowTopicHelp(HelpKeyword, Application.CurrentHelpFile);
end;

procedure TFrmNovaConferencia.ActProximoUpdate(Sender: TObject);
begin
  inherited;
 case WzCosmos.ActivePageIndex of
  0: TAction(Sender).Enabled := True;
  1: begin
      TAction(Sender).Enabled :=  (Trim(EdtNomeConf.Text) <> '')
       and (EdtDataInicial.Date <= EdtDataFinal.Date)
       and (CBXCampo.ItemIndex >= 0);
     end;
  2: begin
      TAction(Sender).Enabled := (EdtLimite.Value > 0) and (EdtTaxa.Text <> '');
     end;
 end;
end;

function TFrmNovaConferencia.CreateConference: boolean;
var
DataInicial, DataFinal, HoraInicial, HoraFinal, DataLimite: string;
indesp, stacon, indmod, limins, tiplev: string;
codfoc, MesRef: integer;
AParams: TSQLParams;
begin
 codfoc := ICosmosApp.ActiveFocus.FocusID;
 MesRef := CBXMesReferencia.GetValue.ToInteger;
 DataInicial := FormatDateTime('yyyy/mm/dd',EdtDataInicial.Date).QuotedString;
 DataFinal := FormatDateTime('yyyy/mm/dd',EdtDataFinal.Date).QuotedString;
 HoraInicial := FormatDateTime('hh:nn', EdtHoraInicio.Time).QuotedString;
 HoraFinal := FormatDateTime('hh:nn', EdtHoraFim.Time).QuotedString;
 DataLimite := FormatDateTime('yyyy/mm/dd',EdtDataLimite.Date).QuotedString;
 tiplev := '';

 if EdtLimite.Value = 0 then limins := 'null'
 else
  limins := EdtLimite.Text;

 if ChkEspecial.Checked then indesp := TDataConverter.ToBoleanString(True, True)
 else
  indesp := TDataConverter.ToBoleanString(False, True);

 if ChkModelo.Checked then indmod := TDataConverter.ToBoleanString(True, True)
 else
  indmod := TDataConverter.ToBoleanString(False, True);

 if RdbProgramada.Checked then stacon := QuotedStr('P')
 else
 if RdbCorrente.Checked then stacon := QuotedStr('C')
 else
 if RdbEncerrada.Checked then stacon := QuotedStr('E');

 if rdbByCheckin.Checked then tiplev := 'CHK' else
 if RdbByConference.Checked then tiplev := 'CON' else
 if RdbByAtivity.Checked then tiplev := 'ATI';

 tiplev := QuotedStr(tiplev);

 AParams := TSQLParams.Create(17);

 try
  AParams.AppendData(QuotedStr(EdtNomeConf.Text), 0);
  AParams.AppendData(codfoc, 1);
  AParams.AppendData(QuotedStr(CBXCampo.GetValue), 2);
  AParams.AppendData(EdtTaxa.Text, 3);
  AParams.AppendData(limins, 4);
  AParams.AppendData(DataInicial, 5);
  AParams.AppendData(HoraInicial, 6);
  AParams.AppendData(DataFinal, 7);
  AParams.AppendData(HoraFinal, 8);
  AParams.AppendData(DataLimite, 9);
  AParams.AppendData(indesp, 10);
  AParams.AppendData(stacon, 11);
  AParams.AppendData(indmod, 12);
  AParams.AppendData(tiplev, 13);
  AParams.AppendData(MesRef, 14);
  AParams.AppendData(UpperCase(ICosmosApp.IRemoteCon.ConnectedUser).QuotedString, 15);
  AParams.AppendData(FormatDateTime('yyyy/mm/dd',ICosmosApp.IRemoteCon.ServerDateTime).QuotedString, 16);

 Result := IRemoteCon.ExecuteCommand(ccNovaConferencia, AParams.Params);

 finally
  if Assigned(AParams) then AParams.Free;
 end;
end;

procedure TFrmNovaConferencia.EdtTaxaKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if not CharInSet(Key, ['0'..'9','.', #8]) then //do not localize.
   Abort;
end;

function TFrmNovaConferencia.Execute: boolean;
begin
  WzCosmos.StartWizard;
  Result := ShowModal = mrOk;

  if Result then
    Result := CreateConference;
end;

procedure TFrmNovaConferencia.FormCreate(Sender: TObject);
var
 A, M, D: word;
begin
  inherited;
  EdtFocoPromotor.Text := ICosmosApp.ActiveFocus.FocusName;
  EdtDataInicial.DateTime := IRemoteCon.ServerDateTime;
  EdtDataFinal.DateTime := EdtDataInicial.DateTime;
  EdtDataLimite.DateTime := EdtDataInicial.DateTime;
  //Já marca o mês de referência como o mês corrente.
  DecodeDate(EdtDataInicial.DateTime, A, M, D);
  CBXMesReferencia.ItemIndex := M - 1;
end;


initialization
 RegisterClass(TFrmNovaConferencia);

finalization
 UnRegisterClass(TFrmNovaConferencia);

end.
