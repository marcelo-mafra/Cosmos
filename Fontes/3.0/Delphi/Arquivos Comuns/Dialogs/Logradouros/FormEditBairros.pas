unit FormEditBairros;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, StdCtrls, FrameDeleteButtons, Grids, DBGrids, Buttons,
  FrameSearchData, ExtCtrls, GroupHeader, ActnList;

type
  TFrmEditBairros = class(TForm)
    MSGroupHeader1: TMSGroupHeader;
    Label1: TLabel;
    Label2: TLabel;
    FmeSearchDataPaises: TFmeSearchData;
    FmeSearchDataEstados: TFmeSearchData;
    MSGroupHeader2: TMSGroupHeader;
    SbnLocate: TSpeedButton;
    DBGrid1: TDBGrid;
    EdtLocate: TEdit;
    FmeDBDelButtons1: TFmeDBDelButtons;
    ChkAutoList: TCheckBox;
    CdsBairros: TClientDataSet;
    FmeSearchDataCidades: TFmeSearchData;
    Label3: TLabel;
    ActionList1: TActionList;
    ActSearch: TAction;
    Button1: TButton;
    ActSelect: TAction;
    BtnSearch: TButton;
    procedure ActSelectUpdate(Sender: TObject);
    procedure ActSelectExecute(Sender: TObject);
    procedure ActSearchUpdate(Sender: TObject);
    procedure ActSearchExecute(Sender: TObject);
    procedure EdtLocateKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SbnLocateClick(Sender: TObject);
    procedure CdsBairrosBeforePost(DataSet: TDataSet);
    procedure CdsBairrosReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
    procedure CdsBairrosBeforeDelete(DataSet: TDataSet);
    procedure CdsBairrosAfterPost(DataSet: TDataSet);
    procedure CdsBairrosAfterInsert(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
  private
    FSearchMode: boolean;
    { Private declarations }
    procedure SelectData(Sender: TObject);

  public
    { Public declarations }
    procedure Edit; overload;
    procedure Edit(const codbai: integer); overload;
    function Search: integer;

  end;

var
  FrmEditBairros: TFrmEditBairros;

implementation

uses DMClient, RecError, SQLServerInterface;

{$R *.dfm}

procedure TFrmEditBairros.FormCreate(Sender: TObject);
begin
 FmeSearchDataPaises.FKSearch := fkPaises;
 FmeSearchDataEstados.FKSearch := fkEstados;
 FmeSearchDataCidades.FKSearch := fkCidades;
 FmeSearchDataEstados.MasterFrame := FmeSearchDataPaises;
 FmeSearchDataCidades.MasterFrame := FmeSearchDataEstados;
 FmeSearchDataPaises.OnSelectData := SelectData;
 FmeSearchDataEstados.OnSelectData := SelectData;
 FmeSearchDataCidades.OnSelectData := SelectData;
 FmeSearchDataPaises.ClearData;
 FmeSearchDataEstados.ClearData;
 FmeSearchDataCidades.ClearData;
end;

procedure TFrmEditBairros.SelectData(Sender: TObject);
begin
 if Sender = FmeSearchDataPaises then
  begin
   FmeSearchDataEstados.ClearData;
   FmeSearchDataCidades.ClearData;
   DM.CloseDataset(CdsBairros);
  end
 else
 if Sender = FmeSearchDataEstados then
  begin
   FmeSearchDataCidades.ClearData;
   DM.CloseDataset(CdsBairros);
  end
 else
  if ChkAutoList.Checked then
   BtnSearch.Click;
end;

procedure TFrmEditBairros.CdsBairrosAfterInsert(DataSet: TDataSet);
begin
 with TClientDataset(Dataset) do
  begin
   Fields.FieldByName('codcid').AsInteger := Params.Items[0].AsInteger;
   if Visible then
    Fields.FieldByName('nombai').FocusControl;
  end;
end;

procedure TFrmEditBairros.CdsBairrosAfterPost(DataSet: TDataSet);
begin
 DM.ApplyUpdates(TClientDataset(Dataset));
end;

procedure TFrmEditBairros.CdsBairrosBeforeDelete(DataSet: TDataSet);
begin
 DM.ConfirmDataDelete;
end;

procedure TFrmEditBairros.CdsBairrosReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
 Action := HandleReconcileError(Dataset, UpdateKind, E);
end;

procedure TFrmEditBairros.CdsBairrosBeforePost(DataSet: TDataSet);
begin
 with Dataset do
  begin
   if State = dsInsert then
    Fields.FieldByName('codbai').AsInteger := DM.GetSequenceValue(sqBairros, True);
  end;
end;

procedure TFrmEditBairros.SbnLocateClick(Sender: TObject);
begin
 if (CdsBairros.Active) then
  if not CdsBairros.Locate('nombai', EdtLocate.Text,
   [loPartialKey, loCaseInsensitive]) then
   beep;
end;

procedure TFrmEditBairros.EdtLocateKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 SbnLocate.Enabled := Trim(EdtLocate.Text) <> '';
 if Key = 13 then
  SbnLocate.Click;
end;

procedure TFrmEditBairros.ActSearchExecute(Sender: TObject);
begin
 try
  CdsBairros.DisableControls;
  DM.CloseDataset(CdsBairros);
  CdsBairros.Params.Items[0].Value := FmeSearchDataCidades.Code;
  CdsBairros.Open;

 finally
  CdsBairros.EnableControls;
 end;
end;

procedure TFrmEditBairros.ActSearchUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := (FmeSearchDataPaises.Code <> null) and
  (FmeSearchDataEstados.Code <> null) and (FmeSearchDataCidades.Code <> null);
end;


function TFrmEditBairros.Search: integer;
begin
 FSearchMode := True;
 Result :=  ShowModal;
end;

procedure TFrmEditBairros.Edit(const codbai: integer);
begin
 FSearchMode := False;
 ShowModal;
end;

procedure TFrmEditBairros.Edit;
begin
 FSearchMode := False;
 ShowModal;
end;

procedure TFrmEditBairros.ActSelectExecute(Sender: TObject);
begin
 ModalResult := mrOk;
end;

procedure TFrmEditBairros.ActSelectUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := (FSearchMode) and (CdsBairros.Active)
  and not (CdsBairros.IsEmpty);
end;

end.
