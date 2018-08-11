unit cosmos.focos.view.FormEditMentores;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, GroupHeader, StdCtrls, cosmos.frames.searchdata, DB, DBClient,
  Grids, DBGrids, FrameDeleteButtons, Mask, DBCtrls, cosmos.framework.interfaces.Root,
  cosmos.framework.interfaces.DataAcess, cosmos.frames.fkSearch,
  cosmos.classes.application, cosmos.classes.ServerInterface,
  cosmos.system.messages;

type
  TFrmEditMentores = class(TForm)
    MSGroupHeader1: TMSGroupHeader;
    MSGroupHeader2: TMSGroupHeader;
    FmeSearchDataRA: TFmeSearchData;
    CdsMentores: TClientDataSet;
    DBGrid1: TDBGrid;
    FmeDBDelButtons1: TFmeDBDelButtons;
    Image1: TImage;
    FmeFKMentores: TFmeFKSearch;
    procedure CdsMentoresBeforeDelete(DataSet: TDataSet);
    procedure CdsMentoresAfterPost(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure CdsMentoresBeforePost(DataSet: TDataSet);
    procedure FormDestroy(Sender: TObject);
    procedure CdsMentoresReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
  private
    { Private declarations }
    FICosmosApp: ICosmosApplication;
    procedure SelectMentores(Sender: TObject);

  public
    { Public declarations }
    procedure SelectMentoresRA(const codreg: integer; Ra: string);
    property ICosmosApp: ICosmosApplication read FICosmosApp;
  end;

var
  FrmEditMentores: TFrmEditMentores;

implementation



{$R *.dfm}

procedure TFrmEditMentores.FormCreate(Sender: TObject);
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;

 CdsMentores.RemoteServer := ICosmosApp.IRemoteCon.CreateConnection(scFocos);
 FmeSearchDataRA.CosmosSearch := csRegioes;
 FmeFkMentores.Configure('CODCAD', csAlunos);
 FmeSearchDataRA.OnSelectData := SelectMentores;
end;

procedure TFrmEditMentores.FormDestroy(Sender: TObject);
begin
 FICosmosApp := nil;
end;

procedure TFrmEditMentores.SelectMentores(Sender: TObject);
begin
//Seleciona os mentores de uma ra...
 try
  CdsMentores.DisableControls;
  CdsMentores.Close;
  CdsMentores.Params.Items[0].Value := FmeSearchDataRA.ReadValue('CODRA');
  CdsMentores.Open;

 finally
  CdsMentores.EnableControls;
 end;
end;

procedure TFrmEditMentores.SelectMentoresRA(const codreg: integer; Ra: string);
var
AData: TCosmosData;
begin
 AData := TCosmosData.Create(2);

 try
  AData.WriteValue('CODRA', codreg);
  AData.WriteValue('NOMRA', Ra, 1);
  CdsMentores.Params.Items[0].Value := codreg;
  CdsMentores.Open;
  FmeSearchDataRA.WriteData(AData, 'NOMRA');

  ShowModal;

 finally
  CdsMentores.EnableControls;
  if Assigned(AData) then FreeAndNil(AData);
 end;
end;

procedure TFrmEditMentores.CdsMentoresAfterPost(DataSet: TDataSet);
begin
 if CdsMentores.ChangeCount > 0 then
  CdsMentores.ApplyUpdates(0);
end;

procedure TFrmEditMentores.CdsMentoresBeforeDelete(DataSet: TDataSet);
begin
 if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.MentoresRa, TCosmosConfMsg.DelMentorRA) = mrNo then
  Abort;
end;

procedure TFrmEditMentores.CdsMentoresBeforePost(DataSet: TDataSet);
var
SequenceName: string;
begin
 if Dataset.State = dsInsert then
  begin
   SequenceName := TClientDataset(DataSet).GetOptionalParam('SequenceName');
   Dataset.Fields.Fields[0].AsInteger := ICosmosApp.IRemoteCon.GetSequenceValue(SequenceName);
   Dataset.Fields.FieldByName('CODREG').Value := CdsMentores.Params.Items[0].Value;
  end;
end;

procedure TFrmEditMentores.CdsMentoresReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
 Action := ICosmosApp.IRemoteCon.ReconcileError(E, UpdateKind);
end;

end.
