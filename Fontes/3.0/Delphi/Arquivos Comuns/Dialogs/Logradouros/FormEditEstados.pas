unit FormEditEstados;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FrameEditButtons, StdCtrls, Mask, DBCtrls, FrameForeignKeySearch, DB,
  DBClient, GraphicHeader, FrameSearchData, Grids, DBGrids, FrameDeleteButtons;

type
  TFrmEditEstados = class(TForm)
    CdsEstados: TClientDataSet;
    FmeSearchData1: TFmeSearchData;
    DBGrid1: TDBGrid;
    MSGraphicHeader2: TMSGraphicHeader;
    Label4: TLabel;
    FmeDBDelButtons1: TFmeDBDelButtons;
    procedure CdsEstadosReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
    procedure CdsEstadosBeforeDelete(DataSet: TDataSet);
    procedure CdsEstadosAfterPost(DataSet: TDataSet);
    procedure CdsEstadosAfterInsert(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure ListData(Sender: TObject);
  public
    { Public declarations }
    procedure NovoEstado;
    procedure EditarEstado(const codest: integer);
  end;

var
  FrmEditEstados: TFrmEditEstados;

implementation

uses DMClient, SQLServerInterface, RecError;

{$R *.dfm}

procedure TFrmEditEstados.EditarEstado(const codest: integer);
begin

end;

procedure TFrmEditEstados.FormCreate(Sender: TObject);
begin
 FmeSearchData1.FKSearch := fkPaises;
 FmeSearchData1.OnSelectData := ListData;
end;

procedure TFrmEditEstados.NovoEstado;
begin
 CdsEstados.Params.Items[0].AsInteger := 0;
 ShowModal;
end;

procedure TFrmEditEstados.CdsEstadosAfterInsert(DataSet: TDataSet);
begin
 CdsEstados.Fields.FieldByName('codpai').Value := FmeSearchData1.Code;
 Dataset.Fields.FieldByName('codest').AsInteger :=
  DM.GetSequenceValue(sqPaises,True);
end;

procedure TFrmEditEstados.CdsEstadosAfterPost(DataSet: TDataSet);
begin
 DM.ApplyUpdates(CdsEstados);
end;

procedure TFrmEditEstados.ListData(Sender: TObject);
begin
 if FmeSearchData1.Code <> null then
  begin
   DM.CloseDataset(CdsEstados);
   CdsEstados.Params.Items[0].Value := FmeSearchData1.Code;
   CdsEstados.Open;
  end;

end;

procedure TFrmEditEstados.CdsEstadosBeforeDelete(DataSet: TDataSet);
begin
 DM.ConfirmDataDelete;
end;

procedure TFrmEditEstados.CdsEstadosReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
 Action := HandleReconcileError(Dataset, UpdateKind, E);
end;

end.
