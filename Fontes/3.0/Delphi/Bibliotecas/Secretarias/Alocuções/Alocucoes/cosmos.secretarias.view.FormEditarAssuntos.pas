unit cosmos.secretarias.view.FormEditarAssuntos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, ExtCtrls, GroupHeader, DB, DBClient,
  FrameDBDeleteVertical, cosmos.frames.gridsearch, cosmos.classes.application,
  cosmos.framework.interfaces.root;

type
  TFrmEditAssuntos = class(TForm)
    CdsKeywords: TClientDataSet;
    MSGroupHeader2: TMSGroupHeader;
    FmeDBDeleteVertical1: TFmeDBDeleteVertical;
    FmeGridSearch1: TFmeGridSearch;
    procedure FormCreate(Sender: TObject);
    procedure CdsKeywordsAfterDelete(DataSet: TDataSet);
    procedure CdsKeywordsBeforeDelete(DataSet: TDataSet);
    procedure CdsKeywordsAfterInsert(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CdsKeywordsBeforePost(DataSet: TDataSet);
    procedure CdsKeywordsReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
  private
    { Private declarations }
    FICosmosApp: ICosmosApplication;

  public
    { Public declarations }
    procedure EditarAssuntos(const codalo: integer);

    property ICosmosApp: ICosmosApplication read FICosmosApp;
  end;

var
  FrmEditAssuntos: TFrmEditAssuntos;

implementation

uses cosmos.system.messages;

{$R *.dfm}

{ TFrmEditAlocucoes }

procedure TFrmEditAssuntos.CdsKeywordsAfterDelete(DataSet: TDataSet);
begin
 if TClientDataset(Dataset).ChangeCount > 0 then
   TClientDataset(Dataset).ApplyUpdates(0);
end;

procedure TFrmEditAssuntos.CdsKeywordsAfterInsert(DataSet: TDataSet);
begin
 CdsKeywords.Fields.FieldByName('codalo').AsInteger := CdsKeywords.Params.Items[0].AsInteger;
end;

procedure TFrmEditAssuntos.CdsKeywordsBeforeDelete(DataSet: TDataSet);
begin
 if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.Alocucoes, TCosmosConfMsg.AssuntoAlocucao) = mrNo then
  Abort;
end;

procedure TFrmEditAssuntos.CdsKeywordsBeforePost(DataSet: TDataSet);
var
Sequence: string;
begin
 if Dataset.State = dsInsert then
  begin
   Sequence := CdsKeywords.GetOptionalParam('SequenceName');
   Dataset.Fields.Fields[0].AsInteger := ICosmosApp.IRemoteCon.GetSequenceValue(Sequence);
  end;
end;

procedure TFrmEditAssuntos.CdsKeywordsReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
 Action := ICosmosApp.IRemoteCon.ReconcileError(E, UpdateKind);
end;

procedure TFrmEditAssuntos.EditarAssuntos(const codalo: integer);
begin
 CdsKeywords.Params.Items[0].AsInteger := codalo;
 CdsKeywords.Open;
 ShowModal;
end;

procedure TFrmEditAssuntos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 FICosmosApp := nil;
end;

procedure TFrmEditAssuntos.FormCreate(Sender: TObject);
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;
 FmeGridSearch1.SearchFields := 'keywor';
 CdsKeywords.RemoteServer := ICosmosApp.IRemoteCon.ConnectionBroker;
end;


end.
