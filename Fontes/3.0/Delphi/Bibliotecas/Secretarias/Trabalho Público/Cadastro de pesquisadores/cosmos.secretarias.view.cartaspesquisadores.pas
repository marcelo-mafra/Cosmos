unit cosmos.secretarias.view.cartaspesquisadores;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FrameDBInsertVertical, cosmos.frames.fksearch, StdCtrls, DBCtrls,
  ComCtrls, DBDateTimePicker, DB, DBClient, Cosmos.Framework.Interfaces.Root,
  Cosmos.Framework.Interfaces.DataAcess, cosmos.classes.ServerInterface, Mask,
  cosmos.classes.application, cosmos.frames.gridsearch, cosmos.system.messages,
  Vcl.ExtCtrls, Datasnap.DSConnect;

type
  TFrmEnviarCartas = class(TForm)
    FmeDBInsertVertical1: TFmeDBInsertVertical;
    FmeFKSearchCartasTP: TFmeFKSearch;
    Label1: TLabel;
    EdtDataEntrega: TDBDateTimePicker;
    Label2: TLabel;
    Label3: TLabel;
    DBMemo1: TDBMemo;
    CdsCartas: TClientDataSet;
    DBEdit1: TDBEdit;
    Label4: TLabel;
    DBEdit2: TDBEdit;
    Label5: TLabel;
    DBEdit3: TDBEdit;
    Image1: TImage;
    Bevel1: TBevel;
    FmeGridSearch1: TFmeGridSearch;
    procedure CdsCartasBeforePost(DataSet: TDataSet);
    procedure CdsCartasAfterPost(DataSet: TDataSet);
    procedure CdsCartasAfterInsert(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CdsCartasReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
  private
    { Private declarations }
    FICosmosApp: ICosmosApplication;
    FRemoteConnection: TDSProviderConnection;

  public
    { Public declarations }
    property ICosmosApp: ICosmosApplication read FICosmosApp;
    procedure NovaCarta(const codcad: integer);
  end;

var
  FrmEnviarCartas: TFrmEnviarCartas;

implementation

{$R *.dfm}

procedure TFrmEnviarCartas.CdsCartasAfterInsert(DataSet: TDataSet);
begin
 with CdsCartas do
  begin
   Fields.FieldByName('codcad').Value := CdsCartas.Params.Items[0].Value;
   Fields.FieldByName('codfoc').Value := ICosmosApp.ActiveFocus.FocusID;
   Fields.FieldByName('nomfoc').Value := ICosmosApp.ActiveFocus.FocusName;
   Fields.FieldByName('dathis').Value := EdtDataEntrega.MaxDate;
  end;
end;

procedure TFrmEnviarCartas.CdsCartasAfterPost(DataSet: TDataSet);
begin
 if CdsCartas.ChangeCount > 0 then
  CdsCartas.ApplyUpdates(0);
end;

procedure TFrmEnviarCartas.CdsCartasBeforePost(DataSet: TDataSet);
var
SequenceName: string;
begin
 if Dataset.State = dsInsert then
  begin
   SequenceName := TClientDataset(DataSet).GetOptionalParam('SequenceName');
   Dataset.Fields.Fields[0].AsInteger := ICosmosApp.IRemoteCon.GetSequenceValue(SequenceName);
  end;
end;

procedure TFrmEnviarCartas.CdsCartasReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
 Action := ICosmosApp.IRemoteCon.ReconcileError(E, UpdateKind);
end;

procedure TFrmEnviarCartas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if CdsCartas.Active then CdsCartas.Close;
 CdsCartas.RemoteServer := nil;

 if Assigned(FRemoteConnection) then
  ICosmosApp.IRemoteCon.DropConnection(FRemoteConnection);
end;

procedure TFrmEnviarCartas.FormCreate(Sender: TObject);
begin
 FmeGridSearch1.ShowSearchBar := False;
 FICosmosApp := Application.MainForm as ICosmosApplication;

 FRemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scPesquisadores);
 CdsCartas.RemoteServer := FRemoteConnection;

 FmeFKSearchCartasTP.Configure('codtipeve', csCartasTP);
 EdtDataEntrega.MaxDate := ICosmosApp.IRemoteCon.ServerDateTime;
end;

procedure TFrmEnviarCartas.NovaCarta(const codcad: integer);
begin
 with CdsCartas do
  begin
   Params.Items[0].Value := codcad;
   Open;
  end;

 ShowModal;
end;

end.
