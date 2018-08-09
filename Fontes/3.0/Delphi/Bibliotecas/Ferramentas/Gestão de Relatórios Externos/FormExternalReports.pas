unit FormExternalReports;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, ExtCtrls, GroupHeader, StdCtrls, Mask, DBCtrls,
  Buttons, FrameGridSearch, FrameDeleteButtons, cosmos.core.constantesmsg,
  cosmos.core.classes, Cosmos.Framework.Interfaces.Root, Cosmos.Framework.Interfaces.DataAcess,
  cosmos.framework.forms.mydialogs, cosmos.business.focos;

type
  TFrmExternalReports = class(TForm)
    CdsExternalReports: TClientDataSet;
    MSGroupHeader1: TMSGroupHeader;
    MSGroupHeader2: TMSGroupHeader;
    MSGroupHeader3: TMSGroupHeader;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    DBEdit4: TDBEdit;
    Label4: TLabel;
    SpeedButton1: TSpeedButton;
    DlgOpen: TOpenDialog;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox2: TDBCheckBox;
    DBCheckBox3: TDBCheckBox;
    DBCheckBox4: TDBCheckBox;
    DBCheckBox5: TDBCheckBox;
    MSGroupHeader4: TMSGroupHeader;
    DBCheckBox6: TDBCheckBox;
    DBCheckBox7: TDBCheckBox;
    DBCheckBox8: TDBCheckBox;
    DBCheckBox9: TDBCheckBox;
    DBCheckBox10: TDBCheckBox;
    FmeGridSearch1: TFmeGridSearch;
    FmeDBDelButtons1: TFmeDBDelButtons;
    procedure CdsExternalReportsAfterInsert(DataSet: TDataSet);
    procedure CdsExternalReportsBeforePost(DataSet: TDataSet);
    procedure CdsExternalReportsBeforeDelete(DataSet: TDataSet);
    procedure CdsExternalReportsAfterPost(DataSet: TDataSet);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FICosmosApp: ICosmosApplication;

  public
    { Public declarations }
    property ICosmosApp: ICosmosApplication read FICosmosApp;
  end;

var
  FrmExternalReports: TFrmExternalReports;

implementation

{$R *.dfm}

procedure TFrmExternalReports.CdsExternalReportsAfterInsert(DataSet: TDataSet);
begin
 with Dataset.Fields do
  begin
    FieldByName('indati').Value := 'S';
    FieldByName('indlec').Value := 'N';
    FieldByName('indtmo').Value := 'N';
    FieldByName('indtmb').Value := 'N';
    FieldByName('indtpu').Value := 'N';
    FieldByName('indein').Value := 'N';
    FieldByName('indfoc').Value := 'N';
    FieldByName('indsec').Value := 'N' ;
    FieldByName('indfin').Value := 'N';
    FieldByName('indcon').Value := 'N' ;

    if ctLectorium in  ICosmosApp.CamposAtivos then
      FieldByName('indlec').Value := 'S';

    if ctTM in ICosmosApp.CamposAtivos then
      FieldByName('indtmo').Value := 'S';

    if ctTMB in ICosmosApp.CamposAtivos then
      FieldByName('indtmb').Value := 'S';

    if ctTP in ICosmosApp.CamposAtivos then
      FieldByName('indtpu').Value := 'S';

    if ctEI in ICosmosApp.CamposAtivos then
      FieldByName('indein').Value := 'S';


    case ICosmosApp.CosmosModule of
      cmFocos: FieldByName('indfoc').Value := 'S';
      cmSecretarias: FieldByName('indsec').Value := 'S' ;
      cmFinanceiro: FieldByName('indfin').Value := 'S';
      cmConferencias: FieldByName('indcon').Value := 'S' ;
    end;
  end;
end;

procedure TFrmExternalReports.CdsExternalReportsAfterPost(DataSet: TDataSet);
begin
 if CdsExternalReports.ChangeCount > 0 then
   CdsExternalReports.ApplyUpdates(0);
end;

procedure TFrmExternalReports.CdsExternalReportsBeforeDelete(
  DataSet: TDataSet);
begin
 if TMyDialogs.ConfirmMessage(sConfDeleteExternalReport)= mrNo then
  Abort;
end;

procedure TFrmExternalReports.CdsExternalReportsBeforePost(
  DataSet: TDataSet);
var
SequenceName: string;
begin
 inherited;
 if Dataset.State = dsInsert then
  begin
   SequenceName := TClientDataset(DataSet).GetOptionalParam('SequenceName');
   Dataset.Fields.Fields[0].AsInteger := ICosmosApp.IRemoteCon.GetSequenceValue(SequenceName);
  end;
end;

procedure TFrmExternalReports.FormCreate(Sender: TObject);
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;
 CdsExternalReports.ConnectionBroker := ICosmosApp.IRemoteCon.ConnectionBroker;
 FmeGridSearch1.SearchFields := 'nomrel';
 CdsExternalReports.Open;
end;

procedure TFrmExternalReports.SpeedButton1Click(Sender: TObject);
begin
 if DlgOpen.Execute then
  begin
    CdsExternalReports.Edit;
    CdsExternalReports.Fields.FieldByName('nomarq').Value := DlgOpen.FileName;
  end;
end;

initialization
 RegisterClass(TFrmExternalReports);

finalization
 UnRegisterClass(TFrmExternalReports);

end.
