unit cosmos.secretarias.view.FormPesquisarTurmasTP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FormDefaultSearchs, ImgList, ActnList, DB, DBClient, StdCtrls,
  Buttons, ExtCtrls, GroupHeader, cosmos.frames.gridsearch, cosmos.system.messages,
  Cosmos.Framework.Interfaces.Dialogs, System.Actions, cosmos.classes.application,
  cosmos.classes.ServerInterface;
  

type
  TFrmPesquisarTurmasTP = class(TFrmDefaultSearchs, ISearchTurmasTP)
    MSGroupHeader1: TMSGroupHeader;
    MSGroupHeader2: TMSGroupHeader;
    RdbTurmasAbertas: TRadioButton;
    RdbTurmasEncerradas: TRadioButton;
    FmeGridSearch1: TFmeGridSearch;
    DsrData: TDataSource;
    procedure ActHelpExecute(Sender: TObject);
    procedure RdbTurmasAbertasClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FmeGridSearch1DBGrid1DblClick(Sender: TObject);
  private
    { Private declarations }
    CdsSearchData: TClientDataset;
    procedure DoSearch;

  protected
    function GetDataset: TDataset;

    property Dataset: TDataset read GetDataset;
    function Execute: boolean;  

  public
    { Public declarations }
    function GetWindowsId: string; override;
  end;

var
  FrmPesquisarTurmasTP: TFrmPesquisarTurmasTP;

implementation

{$R *.dfm}

procedure TFrmPesquisarTurmasTP.ActHelpExecute(Sender: TObject);
begin
  inherited;
 if Self.HelpContext <> 0 then
  Application.HelpSystem.ShowContextHelp(Self.HelpContext, Application.CurrentHelpFile);
end;

procedure TFrmPesquisarTurmasTP.DoSearch;
var
 AParams: TCosmosData;
 AValue: string;
begin
 AParams := TCosmosData.Create(5);

 try
  AParams.WriteValue('CODFOC',ICosmosApp.ActiveFocus.FocusID);

  if RdbTurmasAbertas.Checked then
   AValue := QuotedStr('N')
  else
   AValue := QuotedStr('S');

  AParams.WriteValue('INDENC', AValue, 1);

  if Assigned(CdsSearchData) then FreeAndNil(CdsSearchData);
  CdsSearchData := TClientDataset.Create(self);
  CdsSearchData.DisableControls;

  IRemoteCon.ExecuteDQL(csTurmasTP, AParams.Data, CdsSearchData);

 finally
  if Assigned(AParams) then FreeAndNil(AParams);
  DsrData.DataSet := CdsSearchData;
  CdsSearchData.EnableControls;
  ActiveDataset := CdsSearchData;
 end;
end;

function TFrmPesquisarTurmasTP.Execute: boolean;
begin
  RdbTurmasAbertas.Checked := True;
  RdbTurmasAbertas.OnClick(RdbTurmasAbertas);
  Result := ShowModal = mrOk;
end;

procedure TFrmPesquisarTurmasTP.FmeGridSearch1DBGrid1DblClick(Sender: TObject);
begin
  inherited;
  if (ActiveDataset <> nil) and (ActiveDataset.Active) and not (ActiveDataset.IsEmpty) then
   ActSelect.Execute;
end;

procedure TFrmPesquisarTurmasTP.FormCreate(Sender: TObject);
begin
  inherited;
  FmeGridSearch1.ShowSearchBar := False;
end;

function TFrmPesquisarTurmasTP.GetDataset: TDataset;
begin
 Result := ActiveDataset;
end;

function TFrmPesquisarTurmasTP.GetWindowsId: string;
begin
 Result := '{18618CB8-7CAA-4380-A721-0EDA2B0379B5}';
end;

procedure TFrmPesquisarTurmasTP.RdbTurmasAbertasClick(Sender: TObject);
begin
  inherited;
  DoSearch;
end;


initialization
 RegisterClass(TFrmPesquisarTurmasTP);

finalization
 UnRegisterClass(TFrmPesquisarTurmasTP);

end.
