unit cosmos.frames.PlanoContas.FormEditarConta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, FrameDBInsertVertical, StdCtrls, Mask, DBCtrls,
  ExtCtrls, GroupHeader, cosmos.frames.fkSearch, cosmos.classes.ServerInterface,
  Cosmos.Framework.Interfaces.Root, Cosmos.Framework.Interfaces.DataAcess,
  ValueComboBox, DBValueComboBox, Buttons, cosmos.frames.usuariocad,
  cosmos.system.messages,cosmos.classes.application;

type
  TFrmEditarConta = class(TForm)
    CdsConta: TClientDataSet;
    FmeDBInsertVertical1: TFmeDBInsertVertical;
    MSGroupHeader1: TMSGroupHeader;
    MSGroupHeader2: TMSGroupHeader;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    FmeFKFocos: TFmeFKSearch;
    DBCheckBox1: TDBCheckBox;
    DBValueComboBox1: TDBValueComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    SpeedButton1: TSpeedButton;
    MSGroupHeader3: TMSGroupHeader;
    FmeUsuarioCadastrador1: TFmeUsuarioCadastrador;
    procedure CdsContaAfterInsert(DataSet: TDataSet);
    procedure SpeedButton1Click(Sender: TObject);
    procedure CdsContaReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
    procedure CdsContaBeforePost(DataSet: TDataSet);
    procedure CdsContaAfterPost(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FICosmosApp: ICosmosApplication;
  public
    { Public declarations }
    procedure NovaConta;
    procedure EditarConta(const codcon: integer);

    property ICosmosApp: ICosmosApplication read FICosmosApp;
  end;

var
  FrmEditarConta: TFrmEditarConta;

implementation

{$R *.dfm}

procedure TFrmEditarConta.CdsContaAfterInsert(DataSet: TDataSet);
begin
 with CdsConta.Fields do
  begin
    FieldByName('indnac').Value := TDataConverter.ToBoleanString(True);
    FieldByName('tipcon').Value := 'C'; //do not localize!
  end;
end;

procedure TFrmEditarConta.CdsContaAfterPost(DataSet: TDataSet);
begin
 if CdsConta.ChangeCount > 0 then
  CdsConta.ApplyUpdates(0);
end;

procedure TFrmEditarConta.CdsContaBeforePost(DataSet: TDataSet);
var
SequenceName: string;
begin
 Dataset.Fields.FieldByName('usures').Value := ICosmosApp.IRemoteCon.CurrentUser.UserName.ToUpper;
 Dataset.Fields.FieldByName('datcad').Value := ICosmosApp.IRemoteCon.ServerDateTime;

 if Dataset.State = dsInsert then
  begin
   SequenceName := TClientDataset(DataSet).GetOptionalParam('SequenceName');
   Dataset.Fields.Fields[0].AsInteger := ICosmosApp.IRemoteCon.GetSequenceValue(SequenceName);
  end;
end;

procedure TFrmEditarConta.CdsContaReconcileError(DataSet: TCustomClientDataSet;
  E: EReconcileError; UpdateKind: TUpdateKind; var Action: TReconcileAction);
begin
 Action :=  ICosmosApp.IRemoteCon.ReconcileError(E, UpdateKind);
end;

procedure TFrmEditarConta.EditarConta(const codcon: integer);
begin
 with CdsConta do
  begin
    Params.Items[0].Value := codcon;
    Open;
  end;
 ShowModal;
end;

procedure TFrmEditarConta.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if Assigned(ICosmosApp) then FICosmosApp := nil;
end;

procedure TFrmEditarConta.FormCreate(Sender: TObject);
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;
 CdsConta.RemoteServer := ICosmosApp.IRemoteCon.CreateConnection(scFinanceiro);

 FmeFKFocos.Configure('codfoc', csFocos);
end;

procedure TFrmEditarConta.NovaConta;
begin
 with CdsConta do
  begin
    Params.Items[0].Value := 0;
    Open;
    Insert;
  end;

 ShowModal;
end;

procedure TFrmEditarConta.SpeedButton1Click(Sender: TObject);
begin
 with CdsConta do
  begin
   if not (Fields.FieldByName('nomfoc').IsNull) then
    begin
     if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.PlanoContas, TCosmosConfMsg.ClearFocoConta) = mrYes then
      begin
       Edit;
       Fields.FieldByName('nomfoc').Clear;
       Fields.FieldByName('codfoc').Clear;
      end;
    end;
  end;
end;

end.
