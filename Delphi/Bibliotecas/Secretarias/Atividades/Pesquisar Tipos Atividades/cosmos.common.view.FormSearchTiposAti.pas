unit cosmos.common.view.FormSearchTiposAti;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, GroupHeader, StdCtrls, cosmos.frames.gridsearch, Buttons,
  Cosmos.Framework.Interfaces.Root, Cosmos.Framework.Interfaces.DataAcess,
  Cosmos.Framework.Interfaces.Dialogs, DB, DBClient, ActnList, ImgList,
  cosmos.classes.application, cosmos.business.focos, System.Actions, cosmos.business.focos.helpers,
  cosmos.classes.ServerInterface, cosmos.system.dataconverter, System.ImageList;

type
  TFrmSearchTiposAti = class(TForm, ISearchTiposAtividades)
    MSGroupHeader1: TMSGroupHeader;
    RdbLec: TRadioButton;
    RdbTM: TRadioButton;
    RdbTPU: TRadioButton;
    RdbEI: TRadioButton;
    FmeGridSearch1: TFmeGridSearch;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    CdsData: TClientDataSet;
    DsrData: TDataSource;
    ActionList1: TActionList;
    ImageList1: TImageList;
    ActSelect: TAction;
    ActCancel: TAction;
    ActHelp: TAction;
    Bevel1: TBevel;
    RdbSimpatizantes: TRadioButton;
    procedure ActHelpExecute(Sender: TObject);
    procedure FmeGridSearch1DBGrid1DblClick(Sender: TObject);
    procedure ActSelectUpdate(Sender: TObject);
    procedure ActCancelExecute(Sender: TObject);
    procedure ActSelectExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RdbEIClick(Sender: TObject);
    procedure RdbTPUClick(Sender: TObject);
    procedure RdbTMClick(Sender: TObject);
    procedure RdbLecClick(Sender: TObject);
    procedure RdbSimpatizantesClick(Sender: TObject);
    procedure CdsDataAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
    FCampoTrabalho: TCampoTrabalho;
    FIRemoteCon: ICosmosRemoteConnection;
    procedure SetCampoTrabalho(const Value: TCampoTrabalho);

  protected
    function GetValue(const FieldName: string): variant;

    function Execute: boolean; overload;
    function Execute(Campos: TCamposTrabalho; Default: TCampoTrabalho): boolean; overload;


  public
    { Public declarations }
    property CampoTrabalho: TCampoTrabalho read FCampoTrabalho write SetCampoTrabalho;
    property IRemoteCon: ICosmosRemoteConnection read FIRemoteCon;

  end;

var
  FrmSearchTiposAti: TFrmSearchTiposAti;

implementation

{$R *.dfm}

{ TFrmSearchTiposAti }

procedure TFrmSearchTiposAti.ActCancelExecute(Sender: TObject);
begin
 ModalResult := mrCancel;
end;

procedure TFrmSearchTiposAti.ActHelpExecute(Sender: TObject);
begin
 if Self.HelpContext <> 0 then
  Application.HelpSystem.ShowContextHelp(Self.HelpContext, Application.CurrentHelpFile);
end;

procedure TFrmSearchTiposAti.ActSelectExecute(Sender: TObject);
begin
 ModalResult := mrOk;
end;

procedure TFrmSearchTiposAti.ActSelectUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := (CdsData.Active) and not (CdsData.IsEmpty);
end;

procedure TFrmSearchTiposAti.CdsDataAfterOpen(DataSet: TDataSet);
begin
 IRemoteCon.LoadFieldsInfo(Dataset);
end;

function TFrmSearchTiposAti.Execute(Campos: TCamposTrabalho;
  Default: TCampoTrabalho): boolean;
begin
 //Disponibiliza os controles dos campos recebidos em parâmetro.
 RdbLec.Enabled := ctLectorium in Campos;
 RdbTM.Enabled := ctTM in Campos;
 RdbTPU.Enabled := ctTP in Campos;
 RdbEI.Enabled := ctEI in Campos;
 RdbSimpatizantes.Enabled := ctSimpatizantes in Campos;

 //Marca como "checked" o controle do campo default.
 if Default in Campos then
  begin
   case Default of
     ctLectorium: RdbLEC.Checked := True;
     ctTM: RdbTM.Checked := True;
     ctTP: RdbTPU.Checked := True;
     ctEI: RdbEI.Checked := True;
     ctSimpatizantes: RdbSimpatizantes.Checked := True;
   end;

   //Troca a propriedade "CampoTrabalho".
   CampoTrabalho := Default;
  end
 else
  CampoTrabalho := ctNone;

 Result := ShowModal = mrOk;
end;

function TFrmSearchTiposAti.Execute: boolean;
begin
 RdbLec.OnClick(Self);
 Result := ShowModal = mrOk;
end;

procedure TFrmSearchTiposAti.FmeGridSearch1DBGrid1DblClick(Sender: TObject);
begin
 if (CdsData.Active) and not (CdsData.IsEmpty) then
   ModalResult := mrOk;
end;

procedure TFrmSearchTiposAti.FormCreate(Sender: TObject);
begin
 FIRemoteCon := Application.MainForm as ICosmosRemoteConnection;
 CdsData.RemoteServer := IRemoteCon.ConnectionBroker;
 FmeGridSearch1.SearchFields := 'destipati';
 CampoTrabalho := ctNone;
end;

function TFrmSearchTiposAti.GetValue(const FieldName: string): variant;
begin
 if CdsData.Active then
  begin
    if CdsData.FindField(FieldName) <> nil then
     Result := CdsData.Fields.FieldByName(FieldName).Value
    else
     Result := unassigned;
  end
 else
  Result := unassigned;
end;

procedure TFrmSearchTiposAti.RdbLecClick(Sender: TObject);
begin
 CampoTrabalho := ctLectorium;
end;

procedure TFrmSearchTiposAti.RdbSimpatizantesClick(Sender: TObject);
begin
 CampoTrabalho := ctSimpatizantes;
end;

procedure TFrmSearchTiposAti.RdbTMClick(Sender: TObject);
begin
 CampoTrabalho := ctTM;
end;

procedure TFrmSearchTiposAti.RdbTPUClick(Sender: TObject);
begin
 CampoTrabalho := ctTP;
end;

procedure TFrmSearchTiposAti.RdbEIClick(Sender: TObject);
begin
 CampoTrabalho := ctEI;
end;

procedure TFrmSearchTiposAti.SetCampoTrabalho(const Value: TCampoTrabalho);
var
 sCampro: string;
 AParams: TCosmosData;
 IndEI: boolean;
 aTempDataset: TClientDataset;
begin
 if FCampoTrabalho <> Value then
  begin
   FCampoTrabalho := Value;
   if FCampoTrabalho = ctNone then
    Abort;

   IndEI := Value = ctEI;
   sCampro := FCampoTrabalho.ShortName;

   CdsData.DisableControls;
   if CdsData.Active then CdsData.Close;

   AParams := TCosmosData.Create(3);
   aTempDataset := TClientDataset.Create(self);

   try
    AParams.WriteValue('CAMPRO', QuotedStr(sCampro));
    AParams.WriteValue('INDESCINT', TDataConverter.ToBoleanString(IndEI, True), 1);
    AParams.WriteValue('INDATI', TDataConverter.ToBoleanString(True, True), 2);

    IRemoteCon.ExecuteDQL(csTiposAtividades, AParams.Data, aTempDataset);
    CdsData.Data := aTempDataset.Data;

    finally
     CdsData.EnableControls;
     if Assigned(AParams) then FreeAndNil(AParams);
     if Assigned(aTempDataset) then FreeAndNil(aTempDataset);
    end
  end;
end;

initialization
 RegisterClass(TFrmSearchTiposAti);

finalization
 UnRegisterClass(TFrmSearchTiposAti);

end.
