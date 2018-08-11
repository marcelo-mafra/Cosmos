unit cosmos.secretarias.view.statusfrequencias;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ImgList, Cosmos.Framework.Interfaces.Dialogs,
  Vcl.PlatformDefaultStyleActnCtrls, System.Actions, Vcl.ActnList, Vcl.ActnMan,
  Vcl.ExtCtrls, Vcl.ToolWin, Vcl.ActnCtrls, Vcl.StdCtrls, cosmos.business.focos,
  cosmos.framework.interfaces.root, cosmos.classes.application, Data.DB,
  Datasnap.DBClient, cosmos.classes.ServerInterface, cosmos.frames.gridsearch,
  Vcl.Grids, Vcl.DBGrids;

type
  TFrmStatusFrequencias = class(TForm)
    Panel1: TPanel;
    ActionManager1: TActionManager;
    ActionToolBar1: TActionToolBar;
    LblYear: TLabel;
    ImageList2: TImageList;
    ActPriorYear: TAction;
    ActNextYear: TAction;
    DsrData: TDataSource;
    FmeGridSearch1: TFmeGridSearch;
    ActLR: TAction;
    ActTM: TAction;
    ActTP: TAction;
    ActSIM: TAction;
    ActExport: TAction;
    ActStartLevantamento: TAction;
    procedure ActPriorYearExecute(Sender: TObject);
    procedure ActNextYearExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ActLRExecute(Sender: TObject);
    procedure ActTMExecute(Sender: TObject);
    procedure ActTPExecute(Sender: TObject);
    procedure ActSIMExecute(Sender: TObject);
    procedure FmeGridSearch1DBGrid1DrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure ActExportExecute(Sender: TObject);
    procedure ActExportUpdate(Sender: TObject);
    procedure ActStartLevantamentoExecute(Sender: TObject);
    procedure ActStartLevantamentoUpdate(Sender: TObject);
  private
    { Private declarations }
    FCampoTrabalho: TCampoTrabalho;
    FCurrentYear: integer;
    FICosmosApp: ICosmosApplication;
    CdsSearchData: TClientDataset;
    procedure SetCurrentYear(value: integer);
    procedure SetCampoTrabalho(value: TCampoTrabalho);

    procedure ExecuteSearch;

  public
    { Public declarations }
    property CampoTrabalho: TCampoTrabalho read FCampoTrabalho write SetCampoTrabalho;
    property CurrentYear: integer read FCurrentYear write SetCurrentYear;
    property ICosmosApp: ICosmosApplication read FICosmosApp;
  end;

var
  FrmStatusFrequencias: TFrmStatusFrequencias;

implementation

{$R *.dfm}

{ TFrmStatusFrequencias }

procedure TFrmStatusFrequencias.ActPriorYearExecute(Sender: TObject);
begin
 CurrentYear := CurrentYear - 1;
 ExecuteSearch;
end;

procedure TFrmStatusFrequencias.ActSIMExecute(Sender: TObject);
begin
 CampoTrabalho := ctSimpatizantes;
end;

procedure TFrmStatusFrequencias.ActStartLevantamentoExecute(Sender: TObject);
var
  AForm: TCustomForm;
  IFrequencia: IControleFrequencia;
  codati, codcon: integer;
begin
  inherited;
  if not Assigned(CdsSearchData) and not (CdsSearchData.Active) and (CdsSearchData.IsEmpty) then
   Exit;

  if CdsSearchData.FieldByName('indlev').AsString = 'Sim' then
   Exit;

  AForm := ICosmosApp.OpenRegisteredWindow('confreq.bpl', 'TFrmFrequencia');

  if AForm <> nil then
  begin
   with AForm do
    begin
     IFrequencia := AForm as IControleFrequencia;
     if Assigned(IFrequencia) then
      begin
       codati := CdsSearchData.Fields.FieldByName('codati').AsInteger;

       //Lança presença em uma atividade
       if CdsSearchData.Fields.FieldByName('codcon').IsNull then
         IFrequencia.LancarPresencas(codati)
       else
        begin //Lança presença em uma conferência
         codcon := CdsSearchData.Fields.FieldByName('codcon').AsInteger;
         if CdsSearchData.Fields.FieldByName('tiplev').Value = 'ATI' then
           IFrequencia.LancarPresencas(codati, codcon)
         else
           IFrequencia.LancarPresencasConferencia(codcon);
        end;
      end;
    end;
  end;

end;

procedure TFrmStatusFrequencias.ActStartLevantamentoUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := Assigned(CdsSearchData) and (CdsSearchData.Active)
  and not (CdsSearchData.IsEmpty) and (CdsSearchData.FieldByName('indlev').AsString = 'Não');
end;

procedure TFrmStatusFrequencias.ActTMExecute(Sender: TObject);
begin
 CampoTrabalho := ctTM;
end;

procedure TFrmStatusFrequencias.ActTPExecute(Sender: TObject);
begin
 CampoTrabalho := ctTP;
end;

procedure TFrmStatusFrequencias.ExecuteSearch;
var
 aParams: TCosmosData;
begin
 LblYear.Caption := CurrentYear.ToString;

 aParams := TCosmosData.Create(5);

 try
  aParams.WriteValue('ANO', CurrentYear);
  aParams.WriteValue('CODFOC', ICosmosApp.ActiveFocus.FocusID, 1);

  case CampoTrabalho of
   ctLectorium: aParams.WriteValue('CAMPRO', QuotedStr('LEC'), 2);
   ctTM: aParams.WriteValue('CAMPRO', QuotedStr('TMO'), 2);
   ctTP: aParams.WriteValue('CAMPRO', QuotedStr('TPU'), 2);
   ctSimpatizantes: aParams.WriteValue('CAMPRO', QuotedStr('SIM'), 2);
  end;

  if Assigned(CdsSearchData) then FreeAndNil(CdsSearchData);

  CdsSearchData := TClientDataset.Create(self);
  CdsSearchData.DisableControls;

  ICosmosApp.IRemoteCon.ExecuteDQL(csSituacaoAtividades, aParams.Data, CdsSearchData);

 finally
  DsrData.DataSet := CdsSearchData;
  CdsSearchData.EnableControls;
 end;
end;

procedure TFrmStatusFrequencias.FmeGridSearch1DBGrid1DrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  //Destaca com cores as atividades do foco corrente.
  if not Assigned(CdsSearchData)  then
   Exit;

  FmeGridSearch1.DBGrid1.Canvas.FillRect(Rect);

  //Deixa o fundo da fonte e grade transparentes. Sem isso, a fonte fica distorcida.
  if  gdSelected in State then
   begin
    FmeGridSearch1.DBGrid1.Canvas.Font.Color  := clHighlightText;
    FmeGridSearch1.DBGrid1.Canvas.Brush.Color := clHighlight;
   end;

    if CdsSearchData.FieldByName('indlev').AsString = 'Sim' then
     FmeGridSearch1.DBGrid1.Canvas.Font.Color := clWindowText//cor "ativa" de texto.
    else
     FmeGridSearch1.DBGrid1.Canvas.Font.Color := clRed; //Cor de background de texto


  FmeGridSearch1.DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TFrmStatusFrequencias.FormCreate(Sender: TObject);
var
 aDateTime: TDateTime;
 Year, Month, Day: word;
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;
 ActionManager1.Style := ICosmosApp.InterfaceStyle;

 FCampoTrabalho := ctLectorium;
 aDateTime := ICosmosApp.IRemoteCon.ServerDateTime;
 DecodeDate(aDateTime, Year, Month, Day);
 CurrentYear := Year;
end;

procedure TFrmStatusFrequencias.FormDestroy(Sender: TObject);
begin
 if Assigned(ICosmosApp) then FICosmosApp := nil;
end;

procedure TFrmStatusFrequencias.ActExportExecute(Sender: TObject);
begin
 ICosmosApp.IRemoteCon.DefaultExport(CdsSearchData);
end;

procedure TFrmStatusFrequencias.ActExportUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := Assigned(CdsSearchData) and (CdsSearchData.Active)
  and not (CdsSearchData.IsEmpty);
end;

procedure TFrmStatusFrequencias.ActLRExecute(Sender: TObject);
begin
 CampoTrabalho := ctLectorium;
end;

procedure TFrmStatusFrequencias.ActNextYearExecute(Sender: TObject);
begin
 CurrentYear := CurrentYear + 1;
 ExecuteSearch;
end;

procedure TFrmStatusFrequencias.SetCampoTrabalho(value: TCampoTrabalho);
begin
 FCampoTrabalho := value;
 ExecuteSearch;
end;

procedure TFrmStatusFrequencias.SetCurrentYear(value: integer);
begin
 FCurrentYear := Value;
 ExecuteSearch;
end;

end.
