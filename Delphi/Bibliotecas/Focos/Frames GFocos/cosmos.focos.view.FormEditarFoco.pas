unit cosmos.focos.view.FormEditarFoco;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, GroupHeader, cosmos.frames.fkSearch, Mask, DBCtrls,
  ValueComboBox, DB, DBClient, DBValueComboBox, Buttons, cosmos.system.messages,
  cosmos.framework.interfaces.root, FrameDBInsertVertical, cosmos.classes.application,
  cosmos.business.focos, cosmos.classes.ServerInterface, cosmos.system.dataconverter,
  Cosmos.Framework.Interfaces.DataAcess ;

type
  TFrmEditarFoco = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    Label1: TLabel;
    Bevel1: TBevel;
    MSGroupHeader1: TMSGroupHeader;
    MSGroupHeader2: TMSGroupHeader;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    ChkHasLEC: TDBCheckBox;
    ChkHasTPU: TDBCheckBox;
    ChkHasSIM: TDBCheckBox;
    ChkHasTM: TDBCheckBox;
    DBEdit3: TDBEdit;
    Label7: TLabel;
    DBValueComboBox1: TDBValueComboBox;
    MSGroupHeader3: TMSGroupHeader;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox2: TDBCheckBox;
    SpeedButton1: TSpeedButton;
    DBCheckBox3: TDBCheckBox;
    DBCheckBox4: TDBCheckBox;
    FmeFKRas: TFmeFKSearch;
    FmeFKFocoPai: TFmeFKSearch;
    CdsFoco: TClientDataSet;
    CBXEInterna: TDBCheckBox;
    FmeDBInsertVertical1: TFmeDBInsertVertical;
    procedure CdsFocoAfterPost(DataSet: TDataSet);
    procedure CdsFocoBeforePost(DataSet: TDataSet);
    procedure DBValueComboBox1Change(Sender: TObject);
    procedure CdsFocoAfterOpen(DataSet: TDataSet);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CdsFocoAfterApplyUpdates(Sender: TObject;
      var OwnerData: OleVariant);
    procedure FormDestroy(Sender: TObject);
    procedure CdsFocoReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
    procedure CdsFocoAfterInsert(DataSet: TDataSet);
  private
    { Private declarations }
    FFoco: TFocus;
    FICosmosApp: ICosmosApplication;

    procedure ChangeFocusType(Sender: TField);
    procedure SetCampos(const TipoFoco: string); inline;
    function DatasetToObject(Dataset: TDataset): TFocus;

  public
    { Public declarations }
    procedure EditarFoco(const codfoc: integer);

    property Foco: TFocus read FFoco;
    property ICosmosApp: ICosmosApplication read FICosmosApp;
  end;

var
  FrmEditarFoco: TFrmEditarFoco;

implementation

{$R *.dfm}

{ TFrmEditarFoco }

procedure TFrmEditarFoco.EditarFoco(const codfoc: integer);
begin
//Altera os dados de um determinado foco.
 CdsFoco.Params.Items[0].AsInteger := codfoc;
 CdsFoco.Open;

 if not CdsFoco.IsEmpty then
  begin
   self.DatasetToObject(CdsFoco);
   Caption := Foco.FocusName;
  end;

 ShowModal;
end;

procedure TFrmEditarFoco.FormCreate(Sender: TObject);
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;

 CdsFoco.RemoteServer := ICosmosApp.IRemoteCon.CreateConnection(scFocos);
 FmeFKRAs.Configure('codreg', csRegioes);
 FmeFKFocoPai.Configure('codtit', csFocosDependentes);
 FFoco := nil;
end;

procedure TFrmEditarFoco.FormDestroy(Sender: TObject);
begin
 FICosmosApp := nil;
end;

procedure TFrmEditarFoco.CdsFocoAfterPost(DataSet: TDataSet);
begin
 if CdsFoco.ChangeCount > 0  then
  CdsFoco.ApplyUpdates(0);
end;

procedure TFrmEditarFoco.CdsFocoBeforePost(DataSet: TDataSet);
begin
//A sigla do foco deve possuir 3 caracteres
 if CdsFoco.Fields.FieldByName('sigfoc').AsString.Trim.Length <> 3 then
  begin
   ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.FocosUpdate, TCosmosErrorFocMsg.LengthSiglaFoco);
   CdsFoco.Fields.FieldByName('sigfoc').FocusControl;
   Abort;
  end;
end;

procedure TFrmEditarFoco.CdsFocoReconcileError(DataSet: TCustomClientDataSet;
  E: EReconcileError; UpdateKind: TUpdateKind; var Action: TReconcileAction);
begin
 Action := ICosmosApp.IRemoteCon.ReconcileError(E, UpdateKind);
end;

procedure TFrmEditarFoco.CdsFocoAfterApplyUpdates(Sender: TObject;
  var OwnerData: OleVariant);
begin
 DatasetToObject(CdsFoco);
end;

procedure TFrmEditarFoco.CdsFocoAfterInsert(DataSet: TDataSet);
begin
 CdsFoco.FieldValues['indlec'] := 'S';
 CdsFoco.FieldValues['indtpu'] := 'S';
 CdsFoco.FieldValues['indtmo'] := 'S';
 CdsFoco.FieldValues['indsim'] := 'S';
 CdsFoco.FieldValues['indein'] := 'N';
 CdsFoco.FieldValues['indati'] := 'S';
 CdsFoco.FieldValues['indnac'] := 'S';
 CdsFoco.FieldValues['indcab'] := 'N';
 CdsFoco.FieldValues['indind'] := 'S';
end;

procedure TFrmEditarFoco.CdsFocoAfterOpen(DataSet: TDataSet);
begin
 CdsFoco.Fields.FieldByName('tipfoc').OnChange := ChangeFocusType;
end;

procedure TFrmEditarFoco.SetCampos(const TipoFoco: string);
begin
 with CdsFoco.Fields do
  begin
   if TipoFoco = 'CCO' then
    begin
     FieldByName('INDLEC').AsString := TDataConverter.ToBoleanString(True);
     ChkHasLEC.Enabled := True;
     FieldByName('INDTPU').AsString := TDataConverter.ToBoleanString(False);
     ChkHasTPU.Enabled := False;
     FieldByName('INDSIM').AsString := TDataConverter.ToBoleanString(False);
     ChkHasSIM.Enabled := False;
     FieldByName('INDTMO').AsString := TDataConverter.ToBoleanString(False);
     ChkHasTM.Enabled := True;
    end
   else
   if TipoFoco = 'NUC' then
    begin
     FieldByName('INDLEC').AsString := TDataConverter.ToBoleanString(True);
     ChkHasLEC.Enabled := False;
     FieldByName('INDTPU').AsString := TDataConverter.ToBoleanString(True);
     ChkHasTPU.Enabled := False;
     FieldByName('INDSIM').AsString := TDataConverter.ToBoleanString(True);
     ChkHasSIM.Enabled := True;
     FieldByName('INDTMO').AsString := TDataConverter.ToBoleanString(True);
     ChkHasTM.Enabled := True;
    end
   else
   if TipoFoco = 'NCC' then
    begin
     FieldByName('INDLEC').AsString := TDataConverter.ToBoleanString(True);
     ChkHasLEC.Enabled := False;
     FieldByName('INDTPU').AsString := TDataConverter.ToBoleanString(True);
     ChkHasTPU.Enabled := False;
     FieldByName('INDSIM').AsString := TDataConverter.ToBoleanString(True);
     ChkHasSIM.Enabled := True;
     FieldByName('INDTMO').AsString := TDataConverter.ToBoleanString(True);
     ChkHasTM.Enabled := True;
    end
   else
    if (TipoFoco = 'STP') or (TipoFoco = 'LTP') then
     begin
      FieldByName('INDLEC').AsString := TDataConverter.ToBoleanString(False);
      ChkHasLEC.Enabled := False;
      FieldByName('INDTPU').AsString := TDataConverter.ToBoleanString(True);
      ChkHasTPU.Enabled := False;
      FieldByName('INDSIM').AsString := TDataConverter.ToBoleanString(True);
      ChkHasSIM.Enabled := True;
     FieldByName('INDTMO').AsString := TDataConverter.ToBoleanString(False);
     ChkHasTM.Enabled := True;
     end;
    if (TipoFoco = 'SDI') or (TipoFoco = 'SDN') then
    begin
     FieldByName('INDLEC').AsString := TDataConverter.ToBoleanString(True);
     ChkHasLEC.Enabled := False;
     FieldByName('INDTPU').AsString := TDataConverter.ToBoleanString(True);
     ChkHasTPU.Enabled := True;
     FieldByName('INDSIM').AsString := TDataConverter.ToBoleanString(True);
     ChkHasSIM.Enabled := True;
     FieldByName('INDTMO').AsString := TDataConverter.ToBoleanString(True);
     ChkHasTM.Enabled := True;
    end
   else
   end;
end;

procedure TFrmEditarFoco.ChangeFocusType(Sender: TField);
begin
 if CdsFoco.Active then
  begin
   SetCampos(Sender.AsString);
  end;
end;

function TFrmEditarFoco.DatasetToObject(Dataset: TDataset): TFocus;
begin
 if not Assigned(FFoco) then
  FFoco := TFocus.Create;

 FFoco.FocusID := Dataset.Fields.FieldByName('CODFOC').AsInteger;
 FFoco.FocusName := Dataset.Fields.FieldByName('NOMFOC').AsString;
 FFoco.Sigla := Dataset.Fields.FieldByName('SIGFOC').AsString;
 FFoco.FocusType := TFocusTypesInfo.GetFocusType(Dataset.Fields.FieldByName('TIPFOC').AsString);

 Result := Foco;
end;

procedure TFrmEditarFoco.DBValueComboBox1Change(Sender: TObject);
begin
 SetCampos(DBValueComboBox1.GetValue);
end;

procedure TFrmEditarFoco.SpeedButton1Click(Sender: TObject);
begin
 if CdsFoco.Fields.FieldByName('focpai').IsNull then
  ICosmosApp.DlgMessage.InfoMessage(TCosmosTitles.FocosUpdate, TCosmosInfoMsg.AlreadyRootFocus)
 else
 if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.FocosUpdate, TCosmosConfMsg.RemoveTitularLink) = mrYes then
  begin
   CdsFoco.Edit;
   CdsFoco.Fields.FieldByName('focpai').Clear;
   CdsFoco.Fields.FieldByName('nompai').Clear;
  end; 
end;

end.
