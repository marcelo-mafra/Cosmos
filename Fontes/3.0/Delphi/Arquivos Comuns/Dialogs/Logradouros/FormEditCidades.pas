unit FormEditCidades;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, GroupHeader, StdCtrls, FrameSearchData, FrameDeleteButtons,
  Grids, DBGrids, DB, DBClient, Mask, DBCtrls, Buttons;

type
  TFrmEditCidades = class(TForm)
    MSGroupHeader1: TMSGroupHeader;
    MSGroupHeader2: TMSGroupHeader;
    FmeSearchDataPaises: TFmeSearchData;
    FmeSearchDataEstados: TFmeSearchData;
    BtnSearch: TButton;
    FmeDBDelButtons1: TFmeDBDelButtons;
    DBGrid1: TDBGrid;
    EdtLocate: TEdit;
    CdsCidades: TClientDataSet;
    Label1: TLabel;
    Label2: TLabel;
    ChkAutoList: TCheckBox;
    SbnLocate: TSpeedButton;
    procedure EdtLocateKeyPress(Sender: TObject; var Key: Char);
    procedure EdtLocateKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SbnLocateClick(Sender: TObject);
    procedure CdsCidadesBeforePost(DataSet: TDataSet);
    procedure CdsCidadesReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
    procedure CdsCidadesBeforeDelete(DataSet: TDataSet);
    procedure CdsCidadesAfterPost(DataSet: TDataSet);
    procedure CdsCidadesAfterInsert(DataSet: TDataSet);
    procedure BtnSearchClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure SelectData(Sender: TObject);
  public
    { Public declarations }
  end;

var
  FrmEditCidades: TFrmEditCidades;

implementation

uses DMClient, SQLServerInterface, RecError;

{$R *.dfm}

procedure TFrmEditCidades.FormCreate(Sender: TObject);
begin
 FmeSearchDataPaises.FKSearch := fkPaises;
 FmeSearchDataEstados.FKSearch := fkEstados;
 FmeSearchDataEstados.MasterFrame := FmeSearchDataPaises;
 FmeSearchDataPaises.OnSelectData := SelectData;
 FmeSearchDataEstados.OnSelectData := SelectData;
end;

procedure TFrmEditCidades.SelectData(Sender: TObject);
begin
//
 BtnSearch.Enabled := (FmeSearchDataPaises.Code <> null) and
  (FmeSearchDataEstados.Code <> null);

 if Sender = FmeSearchDataPaises then
  begin
   FmeSearchDataEstados.ClearData;
   DM.CloseDataset(CdsCidades);
  end
 else
  if ChkAutoList.Checked then
   BtnSearch.Click;
end;

procedure TFrmEditCidades.BtnSearchClick(Sender: TObject);
begin
 try
  CdsCidades.DisableControls;
  DM.CloseDataset(CdsCidades);
  CdsCidades.Params.Items[0].Value := FmeSearchDataEstados.Code;
  CdsCidades.Open;

 finally
  CdsCidades.EnableControls;
 end;
end;

procedure TFrmEditCidades.CdsCidadesAfterInsert(DataSet: TDataSet);
begin
 with CdsCidades do
  begin
   Fields.FieldByName('codest').AsInteger := Params.Items[0].AsInteger;
   if Visible then
    Fields.FieldByName('nomcid').FocusControl;
  end; 
end;

procedure TFrmEditCidades.CdsCidadesAfterPost(DataSet: TDataSet);
begin
 DM.ApplyUpdates(TClientDataset(Dataset));
end;

procedure TFrmEditCidades.CdsCidadesBeforeDelete(DataSet: TDataSet);
begin
 DM.ConfirmDataDelete;
end;

procedure TFrmEditCidades.CdsCidadesReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
 Action := HandleReconcileError(Dataset, UpdateKind, E);
end;

procedure TFrmEditCidades.CdsCidadesBeforePost(DataSet: TDataSet);
begin
 with Dataset do
  begin
   if State = dsInsert then
    Fields.FieldByName('codcid').AsInteger := DM.GetSequenceValue(sqCidades, True);
  end;
end;

procedure TFrmEditCidades.SbnLocateClick(Sender: TObject);
begin
 if (cdsCidades.Active) then
  if not CdsCidades.Locate('nomcid', EdtLocate.Text,
   [loPartialKey, loCaseInsensitive]) then
   beep;
end;

procedure TFrmEditCidades.EdtLocateKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if Key = 13 then
  SbnLocate.Click;
end;

procedure TFrmEditCidades.EdtLocateKeyPress(Sender: TObject; var Key: Char);
begin
 SbnLocate.Enabled := Trim(EdtLocate.Text) <> '';
end;

end.
