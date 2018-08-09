unit FormEditDirecoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FrameEditButtons, ExtCtrls, GroupHeader, StdCtrls, DBCtrls,
  FrameForeignKeySearch, DB, DBClient, Mask, ComCtrls, DBDateTimePicker,
  FrameUsuarioCadastrador, cosmos.framework.interfaces.Root;

type
  TFrmEditDirecoes = class(TForm)
    FmeEditButtons1: TFmeEditButtons;
    MSGroupHeader1: TMSGroupHeader;
    MSGroupHeader2: TMSGroupHeader;
    MSGroupHeader3: TMSGroupHeader;
    DBCheckBox1: TDBCheckBox;
    DBMemo1: TDBMemo;
    Image1: TImage;
    CdsDirecoes: TClientDataSet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    Label6: TLabel;
    DBDateTimePicker1: TDBDateTimePicker;
    DBDateTimePicker2: TDBDateTimePicker;
    FmeUsuarioCadastrador1: TFmeUsuarioCadastrador;
    FmeFKSearchCargos: TFmeFKSearch;
    FmeFkSearchDirigentes: TFmeFKSearch;
    procedure CdsDirecoesReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
    procedure CdsDirecoesBeforePost(DataSet: TDataSet);
    procedure CdsDirecoesAfterPost(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure NovoDirigente(const codges: integer);
    procedure EditDirigente(const codges, coddir: integer);
  end;

var
  FrmEditDirecoes: TFrmEditDirecoes;

implementation

uses cosmos.core.SQLServerInterface;

{$R *.dfm}

procedure TFrmEditDirecoes.EditDirigente(const codges, coddir: integer);
begin
//*** DM.CloseDataset(CdsDirecoes);
 CdsDirecoes.Params.Items[0].AsInteger := codges;
 CdsDirecoes.Params.Items[1].AsInteger := coddir;
 CdsDirecoes.Open;
 ShowModal;
end;

procedure TFrmEditDirecoes.FormCreate(Sender: TObject);
var
 ICosmosApp: ICosmosApplication;
begin
 ICosmosApp := Application.MainForm as ICosmosApplication;

 try
  self.CdsDirecoes.ConnectionBroker := ICosmosApp.IRemoteCon.ConnectionBroker;
  FmeFKSearchCargos.Configure('codcar', csCargos);
  FmeFkSearchDirigentes.Configure('codcad', csAlunos);

 finally
  if Assigned(ICosmosApp) then
   ICosmosApp := nil;
 end;
end;

procedure TFrmEditDirecoes.CdsDirecoesAfterPost(DataSet: TDataSet);
begin
//*** DM.ApplyUpdates(CdsDirecoes);
end;

procedure TFrmEditDirecoes.CdsDirecoesBeforePost(DataSet: TDataSet);
begin
 with CdsDirecoes do
  begin
   Fields.FieldByName('codges').AsInteger:= Params.Items[0].AsInteger;
   if State = dsInsert then
//***    Fields.FieldByName('coddir').AsInteger := DM.GetSequenceValue(sqDirecoes);
  end;
end;

procedure TFrmEditDirecoes.CdsDirecoesReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
// Action := HandleReconcileError(Dataset, UpdateKind, E);
end;

procedure TFrmEditDirecoes.NovoDirigente(const codges: integer);
begin
//*** DM.CloseDataset(CdsDirecoes);
 CdsDirecoes.Params.Items[0].AsInteger := codges;
 CdsDirecoes.Params.Items[1].AsInteger := 0; //qualquer valor
 CdsDirecoes.Open;
 CdsDirecoes.Insert;
 ShowModal;
end;

end.
