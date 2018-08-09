unit cosmos.secretarias.view.FormNovoLivroEI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GraphicHeader, Mask, DBCtrls, StdCtrls, cosmos.frames.FrameLivrosLicoesEI, DB,
  DBClient, Cosmos.Framework.Interfaces.DataAcess, ExtCtrls, FrameEditButtons,
  cosmos.classes.application, cosmos.framework.interfaces.root,
  Datasnap.DSConnect;

type
  TFrmNovoLivrosEI = class(TForm)
    MSGraphicHeader1: TMSGraphicHeader;
    DBMemo1: TDBMemo;
    DBEdit1: TDBEdit;
    Label1: TLabel;
    CdsLivros: TClientDataSet;
    Label2: TLabel;
    Label3: TLabel;
    EdtDiscipulado: TEdit;
    Image1: TImage;
    Image2: TImage;
    FmeEditButtons1: TFmeEditButtons;
    procedure CdsLivrosAfterPost(DataSet: TDataSet);
    procedure CdsLivrosBeforePost(DataSet: TDataSet);
    procedure CdsLivrosAfterInsert(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FIRemoteCon: ICosmosRemoteConnection;
    FRemoteConnection: TDSProviderConnection;

  public
    { Public declarations }
    procedure NewBook(const coddis: integer; Discipulado: string);
    procedure EditBook(const coddis, codliv: integer);

    property IRemoteCon: ICosmosRemoteConnection read FIRemoteCon;
  end;

var
  FrmNovoLivrosEI: TFrmNovoLivrosEI;

implementation


{$R *.dfm}

procedure TFrmNovoLivrosEI.CdsLivrosAfterInsert(DataSet: TDataSet);
begin
 CdsLivros.Fields.FieldByName('coddis').AsInteger := CdsLivros.Params.Items[0].AsInteger;
end;

procedure TFrmNovoLivrosEI.CdsLivrosAfterPost(DataSet: TDataSet);
begin
 if TClientDataset(Dataset).ChangeCount > 0 then
  TClientDataset(Dataset).ApplyUpdates(0);
end;

procedure TFrmNovoLivrosEI.CdsLivrosBeforePost(DataSet: TDataSet);
var
SequenceName: string;
begin
 if Dataset.State = dsInsert then
  begin
   SequenceName := TClientDataset(DataSet).GetOptionalParam('SequenceName');
   Dataset.Fields.Fields[0].AsInteger := IRemoteCon.GetSequenceValue(SequenceName);
  end;
end;

procedure TFrmNovoLivrosEI.EditBook(const coddis, codliv: integer);
begin
 CdsLivros.Params.Items[0].AsInteger := coddis;
 CdsLivros.Params.Items[1].AsInteger := codliv;
 CdsLivros.Open;
 ShowModal;
end;

procedure TFrmNovoLivrosEI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if CdsLivros.Active then CdsLivros.Close;
 CdsLivros.RemoteServer := nil;

 if Assigned(FRemoteConnection) then
  IRemoteCon.DropConnection(FRemoteConnection);
end;

procedure TFrmNovoLivrosEI.FormCreate(Sender: TObject);
begin
 FIRemoteCon := Application.MainForm as ICosmosRemoteConnection;

 FRemoteConnection := IRemoteCon.CreateConnection(scEscolaInterna);
 CdsLivros.RemoteServer := FRemoteConnection;
end;

procedure TFrmNovoLivrosEI.NewBook(const coddis: integer; Discipulado: string);
begin
 EdtDiscipulado.Text := Discipulado;
 CdsLivros.Params.Items[0].AsInteger := coddis;
 CdsLivros.Params.Items[1].AsInteger := -1;
 CdsLivros.Open;
 ShowModal;
end;

end.
