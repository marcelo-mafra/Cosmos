unit DLgEditPaises;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, FrameDeleteButtons, DB, DBClient, FrameGridSearch,
  StdCtrls;

type
  TFrmDlgPaises = class(TForm)
    FmeDBDelButtons1: TFmeDBDelButtons;
    CdsPaises: TClientDataSet;
    FmeGridSearchPaises: TFmeGridSearch;
    Label1: TLabel;
    procedure CdsPaisesAfterInsert(DataSet: TDataSet);
    procedure CdsPaisesReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
    procedure CdsPaisesBeforeDelete(DataSet: TDataSet);
    procedure CdsPaisesAfterPost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Open;
  end;

var
  FrmDlgPaises: TFrmDlgPaises;

implementation

uses DMClient, RecError, SQLServerInterface;

{$R *.dfm}

{ TFrmDlgPaises }

procedure TFrmDlgPaises.Open;
begin
 FmeGridSearchPaises.SearchFields := 'nompai';
 DM.CloseDataset(CdsPaises);
 CdsPaises.Open;
 ShowModal;
end;

procedure TFrmDlgPaises.CdsPaisesAfterPost(DataSet: TDataSet);
begin
 DM.ApplyUpdates(TClientDataset(Dataset));
end;

procedure TFrmDlgPaises.CdsPaisesBeforeDelete(DataSet: TDataSet);
begin
 DM.ConfirmDataDelete;
end;

procedure TFrmDlgPaises.CdsPaisesReconcileError(DataSet: TCustomClientDataSet;
  E: EReconcileError; UpdateKind: TUpdateKind; var Action: TReconcileAction);
begin
 case UpdateKind of
  ukDelete: Action := HandleReconcileError(Dataset, UpdateKind, E);
  else
   Action := HandleReconcileError(Dataset, UpdateKind, E);
 end; 
end;


procedure TFrmDlgPaises.CdsPaisesAfterInsert(DataSet: TDataSet);
begin
 Dataset.Fields.FieldByName('codpai').AsInteger :=
  DM.GetSequenceValue(sqPaises,True);
end;

end.
