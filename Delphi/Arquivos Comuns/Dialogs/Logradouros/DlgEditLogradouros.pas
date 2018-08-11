unit DlgEditLogradouros;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, DB, DBClient, FrameHorEditButtons,
  FrameForeignKeySearch, Mask, DBCtrls, Buttons, GraphicHeader,
  FrameDeleteButtons;

type
  TFrmEditLogradouros = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    Label1: TLabel;
    Bevel1: TBevel;
    MSGraphicHeader1: TMSGraphicHeader;
    Label2: TLabel;
    Label3: TLabel;
    MSGraphicHeader2: TMSGraphicHeader;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton4: TSpeedButton;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    FmeFKSearchBairro: TFmeFKSearch;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    CdsLogradouros: TClientDataSet;
    Label10: TLabel;
    EdtCep: TMaskEdit;
    BtnSearch: TButton;
    FmeDBDelButtons1: TFmeDBDelButtons;
    procedure SpeedButton1Click(Sender: TObject);
    procedure CdsLogradourosBeforeDelete(DataSet: TDataSet);
    procedure EdtCepKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BtnSearchClick(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure CdsLogradourosReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
    procedure SpeedButton2Click(Sender: TObject);
    procedure CdsLogradourosBeforePost(DataSet: TDataSet);
    procedure CdsLogradourosAfterPost(DataSet: TDataSet);
    procedure CdsLogradourosAfterInsert(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
    procedure NovoLogradouro;
    procedure EditLogradouro(const ceplog: string);

  end;

var
  FrmEditLogradouros: TFrmEditLogradouros;

implementation

uses DMClient, SQLServerInterface, MyDialogs, ConstantesMsg, RecError,
  DLgEditPaises, FormEditEstados, FormEditCidades;

{$R *.dfm}

procedure TFrmEditLogradouros.EditLogradouro(const ceplog: string);
begin
 CdsLogradouros.Params.Items[0].AsString := ceplog;
 CdsLogradouros.Open;
 ShowModal;
end;

procedure TFrmEditLogradouros.FormCreate(Sender: TObject);
begin
 FmeFKSearchBairro.FKSearch := fkBairros;
 FmeFKSearchBairro.FullScan := True;
end;

procedure TFrmEditLogradouros.NovoLogradouro;
begin
 CdsLogradouros.Open;
 CdsLogradouros.Insert;
 ShowModal;
end;

procedure TFrmEditLogradouros.CdsLogradourosAfterInsert(DataSet: TDataSet);
begin
//Pega um ID temporário
 CdsLogradouros.Fields.FieldByName('codlog').AsInteger := DM.GetTempID;
 if Self.Visible then
  Dataset.Fields.FieldByName('ceplog').FocusControl;
end;

procedure TFrmEditLogradouros.CdsLogradourosAfterPost(DataSet: TDataSet);
begin
 DM.ApplyUpdates(TClientDataset(Dataset));
end;

procedure TFrmEditLogradouros.CdsLogradourosBeforePost(DataSet: TDataSet);
begin
 if Length(Dataset.Fields.FieldByName('ceplog').AsString) <> 9 then
  if TMyDialogs.ConfirmMessage(sConfCep) = mrNo then
   begin
    Dataset.Fields.FieldByName('ceplog').FocusControl;
    Abort;
   end; 
end;

procedure TFrmEditLogradouros.SpeedButton2Click(Sender: TObject);
begin
 try
  if not Assigned(FrmDlgPaises) then
   FrmDlgPaises := TFrmDlgPaises.Create(self);
  FrmDlgPaises.Open;

 finally
  if Assigned(FrmDlgPaises) then
   FreeAndNil(FrmDlgPaises);
 end;
end;

procedure TFrmEditLogradouros.CdsLogradourosReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
 Action := HandleReconcileError(Dataset, UpdateKind, E);
end;

procedure TFrmEditLogradouros.SpeedButton4Click(Sender: TObject);
begin
 try
  if not Assigned(FrmEditEstados) then
   FrmEditEstados := TFrmEditEstados.Create(self);
  FrmEditEstados.NovoEstado;

 finally
  if Assigned(FrmEditEstados) then
   FreeAndNil(FrmEditEstados);
 end;
end;

procedure TFrmEditLogradouros.BtnSearchClick(Sender: TObject);
begin
 DM.CloseDataset(CdsLogradouros);
 CdsLogradouros.Params.Items[0].AsString := EdtCep.Text;
 CdsLogradouros.Open;
 if CdsLogradouros.IsEmpty then
  TMyDialogs.InfoMessage(Format(sCepNotFound, [EdtCep.Text]));
end;

procedure TFrmEditLogradouros.EdtCepKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if key = 13 then
  BtnSearch.Click;
end;

procedure TFrmEditLogradouros.CdsLogradourosBeforeDelete(DataSet: TDataSet);
begin
 DM.ConfirmDataDelete;
end;

procedure TFrmEditLogradouros.SpeedButton1Click(Sender: TObject);
begin
 try
  if not Assigned(FrmEditCidades) then
   FrmEditCidades := TFrmEditCidades.Create(self);
  FrmEditCidades.ShowModal;

 finally
  if Assigned(FrmEditCidades) then
   FreeAndNil(FrmEditCidades);
 end;
end;

end.
