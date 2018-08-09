unit DlgCopyGestao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, DB, DBClient, ImgList,
  Controls, ComCtrls, StdCtrls, Graphics, Forms, Dialogs,
  cosmos.framework.interfaces.dataacess;

type
  PDirigente = ^TDirigente;
  TDirigente = record
   coddir: integer;
   codcad: integer;
   nomcad: string;
   matcad: string;
   coddis: integer;
   sigdis: string;
   codfoc: integer;
   sigfoc: string;
  end;

  TFrmDlgCopyGestao = class(TForm)
    Label1: TLabel;
    EdtOrgao: TEdit;
    LsvDirigentes: TListView;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    ImgTree: TImageList;
    EdtPosse: TDateTimePicker;
    Label2: TLabel;
    EdtTermino: TDateTimePicker;
    Label3: TLabel;
    Label4: TLabel;
    CdsDirigentes: TClientDataSet;
    procedure FormCreate(Sender: TObject);
  private
    FIRemoteCon: ICosmosRemoteConnection;

    { Private declarations }
    procedure ListarDirigentes(const codges: integer);
  public
    { Public declarations }
    function CopyGestao(const codges, codorg: integer; Orgao: string): boolean;
    property IRemoteCon: ICosmosRemoteConnection read FIRemoteCon;
  end;

var
  FrmDlgCopyGestao: TFrmDlgCopyGestao;

implementation

uses cosmos.core.ConstantesMsg, cosmos.framework.forms.mydialogs;

{$R *.dfm}

{ TFrmDlgCopyGestao }

function TFrmDlgCopyGestao.CopyGestao(const codges, codorg: integer;
  Orgao: string): boolean;
var
I: integer;
Item: TListItem;
PDir: PDirigente;
begin
 ListarDirigentes(codges);

 EdtOrgao.Text := Orgao;

 if ShowModal = mrOk then
   begin
    if EdtPosse.Date >= EdtTermino.Date then
     raise exception.Create(sErrorDatasGestao);

    CdsDirigentes.First;
    for I := 0 to Pred(LsvDirigentes.Items.Count) do
     begin
      Item := LsvDirigentes.Items.Item[I];
      if not Item.Checked then
       begin
        PDir := Item.Data;
        if CdsDirigentes.Locate('coddir', PDir.coddir,[]) then
         CdsDirigentes.Delete;
       end;
     end;

    if not CdsDirigentes.IsEmpty then
     self.IRemoteCon.ConnectionBroker.AppServer.DuplicarGestao(codorg, codges, EdtPosse.Date, EdtTermino.Date, CdsDirigentes.Data)
    else
      TMyDialogs.InfoMessage(sInfoNoSelectedDirigente);
   end;
end;

procedure TFrmDlgCopyGestao.FormCreate(Sender: TObject);
begin
 FIRemoteCon := Application.MainForm as ICosmosRemoteConnection;
 self.EdtPosse.Date := IRemoteCon.ConnectionBroker.AppServer.ServerDateTime;
 self.EdtTermino.Date := IRemoteCon.ConnectionBroker.AppServer.ServerDateTime;
end;

procedure TFrmDlgCopyGestao.ListarDirigentes(const codges: integer);
var
 Item: TListItem;
 PDir: PDirigente;
begin
  CdsDirigentes.Params.Items[0].AsInteger := codges;
  CdsDirigentes.Open;

  with LsvDirigentes do
   begin
    Items.BeginUpdate;
    Items.Clear;

    while not CdsDirigentes.Eof do
     begin
      New(PDir);
      PDir.coddir := CdsDirigentes.Fields.FieldByName('coddir').AsInteger;
      PDir.codcad := CdsDirigentes.Fields.FieldByName('codcad').AsInteger;
      PDir.nomcad := CdsDirigentes.Fields.FieldByName('nomcad').AsString;
      PDir.matcad := CdsDirigentes.Fields.FieldByName('matcad').AsString;
      PDir.coddis := CdsDirigentes.Fields.FieldByName('coddis').AsInteger;
      PDir.sigdis := CdsDirigentes.Fields.FieldByName('sigdis').AsString;
      PDir.codfoc := CdsDirigentes.Fields.FieldByName('codfoc').AsInteger;

      Item := Items.Add;
      Item.Caption := PDir.nomcad;
      Item.SubItems.Add(PDir.matcad);
      Item.SubItems.Add(PDir.sigdis);
      Item.Checked := True;
      Item.Data := PDir;
      CdsDirigentes.Next;
     end;

    Items.EndUpdate;
   end;
end;

end.
