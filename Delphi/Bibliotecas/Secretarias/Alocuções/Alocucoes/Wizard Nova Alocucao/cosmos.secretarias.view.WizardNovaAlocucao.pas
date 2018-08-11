unit cosmos.secretarias.view.WizardNovaAlocucao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cosmos.framework.view.FrmDefWizard, Wizard, ImgList, ActnList, jpeg, ExtCtrls,
  ComCtrls, StdCtrls, Buttons, DBCtrls, Mask, Grids, DBGrids, DB, DBClient,
  DBActns, cosmos.classes.application, Vcl.Imaging.pngimage, System.Actions;

type
  TFrmWzNovaAlocucao = class(TFrmCosmosWizard)
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBComboBox1: TDBComboBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    DBGrid1: TDBGrid;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox2: TDBCheckBox;
    DBCheckBox3: TDBCheckBox;
    DBCheckBox4: TDBCheckBox;
    DBMemo1: TDBMemo;
    Label6: TLabel;
    CdsAlocucoes: TClientDataSet;
    DsrAlocucoes: TDataSource;
    CdsAssuntos: TClientDataSet;
    DsrAssuntos: TDataSource;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    DataSetInsert1: TDataSetInsert;
    DataSetDelete1: TDataSetDelete;
    DataSetPost1: TDataSetPost;
    procedure WzCosmosFinishWizard(Sender: TObject);
    procedure ActProximoUpdate(Sender: TObject);
    procedure CdsAssuntosAfterInsert(DataSet: TDataSet);
    procedure CdsAlocucoesAfterInsert(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
   function GetWizardName: string;
   property WizardName: string read GetWizardName;
   function Execute: boolean; override;
  end;

var
  FrmWzNovaAlocucao: TFrmWzNovaAlocucao;

implementation

{$R *.dfm}

{ TFrmCosmosWizard1 }

procedure TFrmWzNovaAlocucao.ActProximoUpdate(Sender: TObject);
begin
  inherited;
 case WzCosmos.ActivePageIndex of
  0: TAction(Sender).Enabled := True;
  1: TAction(Sender).Enabled :=
     (not CdsAlocucoes.Fields.FindField('TITALO').IsNull) and
     (not CdsAlocucoes.Fields.FindField('FRAALO').IsNull) and
     (not CdsAlocucoes.Fields.FindField('NOMAUT').IsNull) ;
  2: TAction(Sender).Enabled := True;

  3: begin
      BtnNext.Action := ActProximo;
      TAction(Sender).Enabled := not CdsAssuntos.IsEmpty;
     end;
 end;
end;

procedure TFrmWzNovaAlocucao.CdsAlocucoesAfterInsert(DataSet: TDataSet);
begin
  inherited;
 CdsAlocucoes.Fields.Fields[0].AsInteger := 1;
 CdsAlocucoes.Fields.FieldByName('INDLEC').AsString := 'S';
 CdsAlocucoes.Fields.FieldByName('INDTMO').AsString := 'N';
 CdsAlocucoes.Fields.FieldByName('INDTMB').AsString := 'N';
 CdsAlocucoes.Fields.FieldByName('INDTPU').AsString := 'N';
end;

procedure TFrmWzNovaAlocucao.CdsAssuntosAfterInsert(DataSet: TDataSet);
begin
  inherited;
 CdsAssuntos.Fields.FieldByName('codkey').AsInteger := 0;
 CdsAssuntos.Fields.FieldByName('codalo').AsInteger := 0;
 CdsAssuntos.Fields.FieldByName('keywor').FocusControl;  
end;

function TFrmWzNovaAlocucao.Execute: boolean;
var
AReturn: TServerReturn;
begin
{ WzCosmos.StartWizard;
 CdsAlocucoes.Insert;
 Result := ShowModal = mrOk;

 if Result then
  begin
   AReturn := TServerReturn.Create;

   try
    AReturn.ReadServerReturn(IRemoteCon.ConnectionBroker.AppServer.NovaAlocucao(CdsAlocucoes.Data, CdsAssuntos.Data));
    Result := AReturn.ServerData;
    if AReturn.ServerData = False then
     ICosmosApp.DlgMessage.Execute(AReturn);

    WzCosmos.FinishWizard;

   finally
    if Assigned(AReturn) then
     AReturn.Free;
   end;
  end;}
end;

function TFrmWzNovaAlocucao.GetWizardName: string;
begin
 Result := WzCosmos.Title;
end;

procedure TFrmWzNovaAlocucao.WzCosmosFinishWizard(Sender: TObject);
begin
  inherited;
 Close;
end;

initialization
 RegisterClass(TFrmWzNovaAlocucao);

finalization
 UnRegisterClass(TFrmWzNovaAlocucao);

end.
