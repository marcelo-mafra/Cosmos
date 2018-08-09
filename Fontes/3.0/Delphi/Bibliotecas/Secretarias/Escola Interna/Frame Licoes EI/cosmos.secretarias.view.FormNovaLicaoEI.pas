unit cosmos.secretarias.view.FormNovaLicaoEI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FrameEditButtons, DB, DBClient, Mask, DBCtrls, ExtCtrls, StdCtrls,
  GroupHeader, cosmos.frames.FrameLivrosLicoesEI, Cosmos.Framework.Interfaces.DataAcess,
  cosmos.classes.application, cosmos.framework.interfaces.root, Datasnap.DSConnect,
  cosmos.system.messages;

type
  TFrmNovaLicaoEI = class(TForm)
    CdsLicoes: TClientDataSet;
    FmeEditButtons1: TFmeEditButtons;
    MSGroupHeader1: TMSGroupHeader;
    DBMemo1: TDBMemo;
    Label2: TLabel;
    DBEdit1: TDBEdit;
    Label1: TLabel;
    MSGroupHeader2: TMSGroupHeader;
    DBEdit2: TDBEdit;
    Label4: TLabel;
    FmeEIBooks1: TFmeEIBooks;
    procedure CdsLicoesAfterInsert(DataSet: TDataSet);
    procedure CdsLicoesAfterPost(DataSet: TDataSet);
    procedure CdsLicoesBeforePost(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FICosmosApp: ICosmosApplication;
    FRemoteConnection: TDSProviderConnection;

  public
    { Public declarations }
    procedure NewLesson(const codliv: integer);
    procedure EditLesson(const codliv, codlic: integer);

    property ICosmosApp: ICosmosApplication read FICosmosApp;
  end;

var
  FrmNovaLicaoEI: TFrmNovaLicaoEI;

implementation


{$R *.dfm}

procedure TFrmNovaLicaoEI.CdsLicoesAfterInsert(DataSet: TDataSet);
begin
 CdsLicoes.Fields.FieldByName('codliv').AsInteger := FmeEIBooks1.SelectedID;
end;

procedure TFrmNovaLicaoEI.CdsLicoesAfterPost(DataSet: TDataSet);
begin
 TClientDataset(Dataset).ApplyUpdates(0);
end;

procedure TFrmNovaLicaoEI.CdsLicoesBeforePost(DataSet: TDataSet);
var
SequenceName: string;
begin
 if Dataset.State = dsInsert then
  begin
   if FmeEIbooks1.SelectedType <> otLivro then
    begin
     ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.LivrosEI, TCosmosInfoMsg.SelectBook);
     Abort;
    end;

   CdsLicoes.Fields.FieldByName('codliv').AsInteger := FmeEIBooks1.SelectedID;
   SequenceName := TClientDataset(DataSet).GetOptionalParam('SequenceName');
   Dataset.Fields.Fields[0].AsInteger := ICosmosApp.IRemoteCon.GetSequenceValue(SequenceName);
  end;
end;

procedure TFrmNovaLicaoEI.EditLesson(const codliv, codlic: integer);
begin
 FMeEIBooks1.Enabled := False;
 CdsLicoes.Params.Items[0].AsInteger := codliv;
 CdsLicoes.Params.Items[1].AsInteger := codlic;
 CdsLicoes.Open;
 ShowModal;
end;

procedure TFrmNovaLicaoEI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if CdsLicoes.Active then CdsLicoes.Close;
 CdsLicoes.RemoteServer := nil;

 if Assigned(FRemoteConnection) then
  ICosmosApp.IRemoteCon.DropConnection(FRemoteConnection);
end;

procedure TFrmNovaLicaoEI.FormCreate(Sender: TObject);
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;

 FRemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scEscolaInterna);
 CdsLicoes.RemoteServer := FRemoteConnection;

 with FmeEIBooks1 do
  begin
   HideMenu := True;
   ListLessons := False;
   ListarDiscipuladosEI;
  end;
end;

procedure TFrmNovaLicaoEI.NewLesson(const codliv: integer);
begin
 CdsLicoes.Params.Items[0].AsInteger := codliv;
 CdsLicoes.Params.Items[1].AsInteger := 0;
 CdsLicoes.Open;
 ShowModal;
end;

end.
