unit cosmos.common.view.FormPesquisarDiscipulados;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, ActnList, DB, DBClient, StdCtrls, Buttons, cosmos.frames.gridsearch,
  ExtCtrls, GroupHeader, Cosmos.Framework.Interfaces.Root, Cosmos.Framework.Interfaces.DataAcess,
  Cosmos.Framework.Interfaces.Dialogs, System.Actions, cosmos.classes.ServerInterface,
  cosmos.business.focos, cosmos.system.messages;

type
  TFrmPesquisarDiscipulados = class(TForm, ISearchDiscipulados)
    MSGroupHeader1: TMSGroupHeader;
    RdbLec: TRadioButton;
    RdbTMO: TRadioButton;
    RdbTPU: TRadioButton;
    RdbEI: TRadioButton;
    FmeGridSearch1: TFmeGridSearch;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    CdsDiscipulados: TClientDataSet;
    DsrData: TDataSource;
    ActionList1: TActionList;
    ActSelect: TAction;
    ActCancel: TAction;
    ActHelp: TAction;
    ImageList1: TImageList;
    Bevel1: TBevel;
    RdbSIM: TRadioButton;
    procedure FmeGridSearch1DBGrid1DblClick(Sender: TObject);
    procedure ActHelpExecute(Sender: TObject);
    procedure ActCancelExecute(Sender: TObject);
    procedure ActSelectUpdate(Sender: TObject);
    procedure ActSelectExecute(Sender: TObject);
    procedure RdbLecClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CdsDiscipuladosAfterOpen(DataSet: TDataSet);
    procedure RdbTMOClick(Sender: TObject);
    procedure RdbTPUClick(Sender: TObject);
    procedure RdbSIMClick(Sender: TObject);
    procedure RdbEIClick(Sender: TObject);
  private
    { Private declarations }
    FCampoTrabalho: TCampoTrabalho;
    FICosmosApp: ICosmosApplication;
    procedure BuscarDiscipulados;
    procedure SetCampoTrabalho(value: TCampoTrabalho);

  protected
    function GetValue(const FieldName: string): variant;

    function Execute: boolean; overload;
    function Execute(const LEC, TMO, TMB, TPU, EI: boolean): boolean; overload;

  public
    { Public declarations }
    property CampoTrabalho: TCampoTrabalho read FCampoTrabalho write SetCampoTrabalho;
    property ICosmosApp: ICosmosApplication read FICosmosApp;
  end;

var
  FrmPesquisarDiscipulados: TFrmPesquisarDiscipulados;

implementation

{$R *.dfm}

function TFrmPesquisarDiscipulados.Execute: boolean;
begin
 RdbLec.Checked := True;
 RdbLec.OnClick(Self);
 Result :=  ShowModal = mrOk;
end;

procedure TFrmPesquisarDiscipulados.ActCancelExecute(Sender: TObject);
begin
 ModalResult := mrCancel;
end;

procedure TFrmPesquisarDiscipulados.ActHelpExecute(Sender: TObject);
begin
 if Self.HelpContext <> 0 then
  Application.HelpSystem.ShowContextHelp(Self.HelpContext, Application.CurrentHelpFile);
end;

procedure TFrmPesquisarDiscipulados.ActSelectExecute(Sender: TObject);
begin
 if (CdsDiscipulados.Active) and not (CdsDiscipulados.IsEmpty) then
   ModalResult := mrOk;
end;

procedure TFrmPesquisarDiscipulados.ActSelectUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := (CdsDiscipulados.Active) and not (CdsDiscipulados.IsEmpty);
end;

function TFrmPesquisarDiscipulados.Execute(const LEC, TMO, TMB, TPU,
  EI: boolean): boolean;
begin
 RdbLEC.Enabled := LEC;
 RdbTMO.Enabled := TMO;
 RdbTPU.Enabled := TPU;
 RdbEI.Enabled := EI;

 Result :=  ShowModal = mrOk;
end;

procedure TFrmPesquisarDiscipulados.FmeGridSearch1DBGrid1DblClick(
  Sender: TObject);
begin
 if (CdsDiscipulados.Active) and not (CdsDiscipulados.IsEmpty) then
  ModalResult := mrOk;
end;

procedure TFrmPesquisarDiscipulados.FormCreate(Sender: TObject);
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;
 FmeGridSearch1.ShowSearchBar := False;
 FCAmpoTrabalho := ctNone; //default
end;

procedure TFrmPesquisarDiscipulados.FormDestroy(Sender: TObject);
begin
 if Assigned(ICosmosApp) then FICosmosApp := nil;
end;

function TFrmPesquisarDiscipulados.GetValue(const FieldName: string): variant;
begin
 if CdsDiscipulados.Active then
  begin
    if CdsDiscipulados.FindField(FieldName) <> nil then
     Result := CdsDiscipulados.Fields.FieldByName(FieldName).Value
    else
     Result := unassigned;
  end
 else
  Result := unassigned;
end;

procedure TFrmPesquisarDiscipulados.BuscarDiscipulados;
var
 sFilter: string;
 aTempDataset: TClientDataset;
begin
 case CampoTrabalho of
   ctLectorium:
    begin
     sFilter := 'CAMDIS = %s and indati = %s and indescint = %s'; //do not localize!
     sFilter := sFilter.Format(sFilter, [QuotedStr('LEC'), QuotedStr('S'), QuotedStr('N')]);
    end;
   ctTM:
    begin
     sFilter := 'CAMDIS = %s and indati = %s and indescint = %s'; //do not localize!
     sFilter := sFilter.Format(sFilter, [QuotedStr('TMO'), QuotedStr('S'), QuotedStr('N')]);
    end;
   ctTP:
    begin
     sFilter := 'CAMDIS = %s and indati = %s and indescint = %s'; //do not localize!
     sFilter := sFilter.Format(sFilter, [QuotedStr('TPU'), QuotedStr('S'), QuotedStr('N')]);
    end;
   ctEI:
    begin
     sFilter := 'CAMDIS = %s and indati = %s and indescint = %s'; //do not localize!
     sFilter := sFilter.Format(sFilter, [QuotedStr('LEC'), QuotedStr('S'), QuotedStr('S')]);
    end;
   ctSimpatizantes:
    begin
     sFilter := 'CAMDIS = %s and indati = %s and indescint = %s'; //do not localize!
     sFilter := sFilter.Format(sFilter, [QuotedStr('SIM'), QuotedStr('S'), QuotedStr('N')]);
    end;
 end;


 try
  CdsDiscipulados.DisableControls;
  if CdsDiscipulados.Active then CdsDiscipulados.Close;

  aTempDataset := ICosmosApp.IRemoteCon.OpenBufferedData(TCosmosFiles.BufDiscipulados);

  CdsDiscipulados.Data := aTempDataset.Data;
  CdsDiscipulados.Filter := sFilter;
  CdsDiscipulados.Filtered := True;
  CdsDiscipulados.IndexFieldNames := 'SEQDIS'; //do not localize!

 finally
  CdsDiscipulados.EnableControls;
  if Assigned(aTempDataset) then FreeAndNil(aTempDataset);
 end;
end;

procedure TFrmPesquisarDiscipulados.CdsDiscipuladosAfterOpen(DataSet: TDataSet);
begin
 ICosmosApp.IRemoteCon.LoadFieldsInfo(Dataset);
end;

procedure TFrmPesquisarDiscipulados.RdbEIClick(Sender: TObject);
begin
 CampoTrabalho := ctEI;
end;

procedure TFrmPesquisarDiscipulados.RdbLecClick(Sender: TObject);
begin
 CampoTrabalho := ctLectorium;
end;

procedure TFrmPesquisarDiscipulados.RdbSIMClick(Sender: TObject);
begin
 CampoTrabalho := ctSimpatizantes;
end;

procedure TFrmPesquisarDiscipulados.RdbTMOClick(Sender: TObject);
begin
 CampoTrabalho := ctTM;
end;

procedure TFrmPesquisarDiscipulados.RdbTPUClick(Sender: TObject);
begin
 CampoTrabalho := ctTP;
end;

procedure TFrmPesquisarDiscipulados.SetCampoTrabalho(value: TCampoTrabalho);
begin
 if Value <> FCampoTrabalho then
  begin
    FCampoTrabalho := Value;
    BuscarDiscipulados;
  end;
end;

initialization
 RegisterClass(TFrmPesquisarDiscipulados);

finalization
 UnRegisterClass(TFrmPesquisarDiscipulados);

end.
