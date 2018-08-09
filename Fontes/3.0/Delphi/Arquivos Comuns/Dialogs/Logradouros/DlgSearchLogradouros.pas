unit DlgSearchLogradouros;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Grids, DBGrids, DB, DBClient, Mask, ActnList;

type
  TFrmSearchLogradouro = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    Label1: TLabel;
    Bevel1: TBevel;
    BtnSelect: TButton;
    Button2: TButton;
    Button3: TButton;
    EdtCep: TMaskEdit;
    DsrLogradouros: TDataSource;
    CdsLogradouros: TClientDataSet;
    DBGrid1: TDBGrid;
    Label2: TLabel;
    BtnSearch: TButton;
    Bevel2: TBevel;
    Button4: TButton;
    Button5: TButton;
    ActionList1: TActionList;
    ActPesquisar: TAction;
    ActNovo: TAction;
    ActEditar: TAction;
    procedure ActEditarUpdate(Sender: TObject);
    procedure ActEditarExecute(Sender: TObject);
    procedure ActNovoExecute(Sender: TObject);
    procedure ActPesquisarExecute(Sender: TObject);
    procedure BtnSelectClick(Sender: TObject);
    procedure EdtCepKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }

  end;


 function LocateLogradouro: Olevariant;

implementation

uses DMClient, DlgEditLogradouros;

{$R *.dfm}

function LocateLogradouro: Olevariant;
begin
 Result := Null;
 with TFrmSearchLogradouro.Create(nil) do
   begin
    try
     if ShowModal = mrOk then
      Result := CdsLogradouros.Data;

   finally
    Free;
   end;
 end;
end;

procedure TFrmSearchLogradouro.EdtCepKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if key = 13 then
  BtnSearch.Click;
end;


procedure TFrmSearchLogradouro.BtnSelectClick(Sender: TObject);
begin
 if (CdsLogradouros.Active) and not (CdsLogradouros.IsEmpty) then
  ModalResult := mrOk;
end;

procedure TFrmSearchLogradouro.ActPesquisarExecute(Sender: TObject);
begin
 try
  with CdsLogradouros do
   begin
    DisableControls;
    DM.CloseDataset(CdsLogradouros);
    Params.Items[0].AsString := EdtCep.Text;
    Open;
   end;

 finally
  CdsLogradouros.EnableControls;
 end;
end;

procedure TFrmSearchLogradouro.ActNovoExecute(Sender: TObject);
begin
 try
  if not Assigned(FrmEditLogradouros) then
   FrmEditLogradouros := TFrmEditLogradouros.Create(self);
  FrmEditLogradouros.NovoLogradouro;

 finally
  if Assigned(FrmEditLogradouros) then
   FreeAndNil(FrmEditLogradouros);
 end;
end;

procedure TFrmSearchLogradouro.ActEditarExecute(Sender: TObject);
begin
 try
  if not Assigned(FrmEditLogradouros) then
   FrmEditLogradouros := TFrmEditLogradouros.Create(self);
  FrmEditLogradouros.EditLogradouro(CdsLogradouros.Fields.FieldByName('ceplog').AsString);

 finally
  if Assigned(FrmEditLogradouros) then
   FreeAndNil(FrmEditLogradouros);
 end;
end;

procedure TFrmSearchLogradouro.ActEditarUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := (CdsLogradouros.Active) and not (CdsLogradouros.IsEmpty);
end;

end.
