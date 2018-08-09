unit FormEditGestoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FrameEditButtons, ExtCtrls, GroupHeader, DB, DBClient, StdCtrls, Mask,
  DBCtrls, FrameForeignKeySearch, ComCtrls, DBDateTimePicker, FrameUsuarioCadastrador,
  cosmos.framework.interfaces.Root;

type
  TFrmEditGestoes = class(TForm)
    FmeEditButtons1: TFmeEditButtons;
    MSGroupHeader2: TMSGroupHeader;
    CdsGestoes: TClientDataSet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    DBDateTimePicker1: TDBDateTimePicker;
    DBDateTimePicker2: TDBDateTimePicker;
    FmeFKSearchOrgao: TFmeFKSearch;
    MSGroupHeader1: TMSGroupHeader;
    FmeUsuarioCadastrador1: TFmeUsuarioCadastrador;
    procedure CdsGestoesReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
    procedure CdsGestoesAfterInsert(DataSet: TDataSet);
    procedure CdsGestoesBeforePost(DataSet: TDataSet);
    procedure CdsGestoesAfterPost(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure EditGestao(const codges: integer);
    procedure NovaGestao(const codorg: integer; nomorg: string);
  end;

var
  FrmEditGestoes: TFrmEditGestoes;

implementation

uses cosmos.core.SQLServerInterface;

{$R *.dfm}

procedure TFrmEditGestoes.FormCreate(Sender: TObject);
var
 ICosmosApp: ICosmosApplication;
begin
 ICosmosApp := Application.MainForm as ICosmosApplication;

 try
  self.CdsGestoes.ConnectionBroker := ICosmosApp.IRemoteCon.ConnectionBroker;
  FmeFKSearchOrgao.Configure('codorg', csOrgaosGestores);

 finally
  if Assigned(ICosmosApp) then
   ICosmosApp := nil;
 end;
end;

procedure TFrmEditGestoes.CdsGestoesAfterPost(DataSet: TDataSet);
begin
 if CdsGestoes.ChangeCount > 0 then
  CdsGestoes.ApplyUpdates(0);
end;

procedure TFrmEditGestoes.CdsGestoesBeforePost(DataSet: TDataSet);
begin
//*** Dataset.Fields.FieldByName('codges').AsInteger := DM.GetSequenceValue(sqGestoes,True);
end;

procedure TFrmEditGestoes.NovaGestao(const codorg: integer; nomorg: string);
begin
 CdsGestoes.Params.Items[0].AsInteger := 0;
 CdsGestoes.Open;
 CdsGestoes.Insert;
 FmeFKSearchOrgao.SetValues(codorg, nomorg);
 ShowModal;
end;

procedure TFrmEditGestoes.EditGestao(const codges: integer);
begin
 CdsGestoes.Params.Items[0].AsInteger := codges;
 CdsGestoes.Open;
 ShowModal;
end;

procedure TFrmEditGestoes.CdsGestoesAfterInsert(DataSet: TDataSet);
begin
 with Dataset.Fields do
  begin
   FieldByName('codorg').Value := FmeFKSearchOrgao.DefaultCode;
   FieldByName('nomorg').Value := FmeFKSearchOrgao.DefaultText;
  end;
end;

procedure TFrmEditGestoes.CdsGestoesReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
// Action := HandleReconcileError(Dataset, UpdateKind, E);
end;

end.
