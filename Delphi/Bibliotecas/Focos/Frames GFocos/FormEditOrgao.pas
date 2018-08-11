unit FormEditOrgao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, GroupHeader, StdCtrls, Mask, DBCtrls, FrameEditButtons, DB,
  DBClient, ValueRadioGroup, FrameForeignKeySearch, ValueComboBox,
  DBValueComboBox, Buttons, FrameUsuarioCadastrador, cosmos.framework.interfaces.Root,
  cosmos.frames.usuariocad, cosmos.frames.fkSearch;

type
  TFrmEditOrgao = class(TForm)
    MSGroupHeader1: TMSGroupHeader;
    MSGroupHeader2: TMSGroupHeader;
    MSGroupHeader3: TMSGroupHeader;
    MSGroupHeader4: TMSGroupHeader;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    FmeEditButtons1: TFmeEditButtons;
    CdsOrgaos: TClientDataSet;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    DBEdit4: TDBEdit;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox2: TDBCheckBox;
    DBCheckBox3: TDBCheckBox;
    DBCheckBox4: TDBCheckBox;
    Label6: TLabel;
    Label7: TLabel;
    DBValueComboBox1: TDBValueComboBox;
    Label1: TLabel;
    MSGroupHeader5: TMSGroupHeader;
    DBCheckBox5: TDBCheckBox;
    DBCheckBox6: TDBCheckBox;
    DBCheckBox7: TDBCheckBox;
    SpeedButton1: TSpeedButton;
    FmeFKSearchSubordinacao: TFmeFKSearch;
    FmeFKSearchFocos: TFmeFKSearch;
    FmeUsuarioCadastrador1: TFmeUsuarioCadastrador;
    procedure SpeedButton1Click(Sender: TObject);
    procedure CdsOrgaosReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
    procedure CdsOrgaosAfterPost(DataSet: TDataSet);
    procedure CdsOrgaosAfterInsert(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure NovoOrgao;  overload;
    procedure NovoOrgao(const codpai, nomorg: variant); overload;
    procedure EditOrgao(const codorg: integer);
  end;

var
  FrmEditOrgao: TFrmEditOrgao;

implementation

uses cosmos.core.SQLServerInterface, cosmos.core.ConstantesMsg,
  cosmos.framework.forms.mydialogs;

{$R *.dfm}

procedure TFrmEditOrgao.EditOrgao(const codorg: integer);
begin
 CdsOrgaos.Params.Items[0].AsInteger := codorg;
 CdsOrgaos.Open;
 if not CdsOrgaos.IsEmpty then
  Caption := CdsOrgaos.Fields.FieldByName('nomorg').AsString;
 ShowModal;
end;

procedure TFrmEditOrgao.FormCreate(Sender: TObject);
var
 ICosmosApp: ICosmosApplication;
begin
 ICosmosApp := Application.MainForm as ICosmosApplication;

 try
  self.CdsOrgaos.ConnectionBroker := ICosmosApp.IRemoteCon.ConnectionBroker;
  FmeFkSearchFocos.Configure('codpai', csFocosAtivos);
  FmeFKSearchSubordinacao.Configure('codpai',csOrgaosSuperiores);

 finally
  if Assigned(ICosmosApp) then
   ICosmosApp := nil;
 end;
end;

procedure TFrmEditOrgao.NovoOrgao;
begin
 CdsOrgaos.Params.Items[0].AsInteger := 0;
 CdsOrgaos.Open;
 CdsOrgaos.Insert;
 ShowModal;
end;

procedure TFrmEditOrgao.CdsOrgaosAfterInsert(DataSet: TDataSet);
begin
{*** Dataset.Fields.FieldByName('codorg').AsInteger :=
  DM.GetSequenceValue(sqOrgaosGestores,True);***}
end;

procedure TFrmEditOrgao.CdsOrgaosAfterPost(DataSet: TDataSet);
begin
 CdsOrgaos.ApplyUpdates(0);
end;

procedure TFrmEditOrgao.CdsOrgaosReconcileError(DataSet: TCustomClientDataSet;
  E: EReconcileError; UpdateKind: TUpdateKind; var Action: TReconcileAction);
begin
// Action := HandleReconcileError(Dataset, UpdateKind, E);
end;

procedure TFrmEditOrgao.NovoOrgao(const codpai, nomorg: variant);
begin
 CdsOrgaos.Params.Items[0].AsInteger := 0;
 CdsOrgaos.Open;
 CdsOrgaos.Insert;
 FmeFKSearchSubordinacao.SetValues(codpai, nomorg);
 ShowModal;
end;

procedure TFrmEditOrgao.SpeedButton1Click(Sender: TObject);
begin
 if CdsOrgaos.Fields.FieldByName('codpai').IsNull then
  TMyDialogs.InfoMessage(sInfoAlreadyRootOrgao)
 else
 if TMyDialogs.ConfirmMessage(sConfRemoveSubordinacaoLink) = mrYes then
  begin
//***   DM.EditDataset(CdsOrgaos);
   CdsOrgaos.Fields.FieldByName('codpai').Clear;
   CdsOrgaos.Fields.FieldByName('orgsup').Clear;
  end;
end;

end.
