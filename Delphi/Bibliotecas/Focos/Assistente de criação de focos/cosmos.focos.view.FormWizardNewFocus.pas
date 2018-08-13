unit cosmos.focos.view.FormWizardNewFocus;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cosmos.framework.view.FrmDefWizard, Wizard, ImgList, ActnList, jpeg, ExtCtrls,
  ComCtrls, StdCtrls, Buttons, DB, DBClient, DBCtrls, cosmos.frames.fkSearch,
  ValueComboBox, Mask, GraphicHeader, cosmos.frames.gridsearch, cosmos.classes.ServerInterface,
  cosmos.framework.interfaces.Dialogs, cosmos.classes.application, cosmos.system.messages,
  cosmos.framework.interfaces.Applications, System.Actions, Vcl.Imaging.pngimage,
  cosmos.system.dataconverter, System.ImageList;

type
  TFrmWizardNewFocus = class(TFrmCosmosWizard)
    CdsFocos: TClientDataSet;
    CdsFocosTIPFOC: TStringField;
    CdsFocosSIGFOC: TStringField;
    CdsFocosNOMFOC: TStringField;
    CdsFocosNOMTEM: TStringField;
    CdsFocosCODREG: TIntegerField;
    CdsFocosFOCPAI: TIntegerField;
    CdsFocosNOMPAI: TStringField;
    CdsFocosINDLEC: TStringField;
    CdsFocosINDTPU: TStringField;
    CdsFocosINDTMO: TStringField;
    CdsFocosINDEIN: TStringField;
    CdsFocosINDIND: TStringField;
    CdsFocosINDATI: TStringField;
    CdsFocosNOMREG: TStringField;
    CdsFocosINDNAC: TStringField;
    CdsFocosINDCAB: TStringField;
    DsrFocos: TDataSource;
    CdsGestoes: TClientDataSet;
    DsrGestoes: TDataSource;
    CdsContatos: TClientDataSet;
    DsrContatos: TDataSource;
    CdsEnderecos: TClientDataSet;
    DsrEnderecos: TDataSource;
    TabSheet2: TTabSheet;
    MSGraphicHeader1: TMSGraphicHeader;
    Label2: TLabel;
    wwDBEdit1: TDBEdit;
    Label3: TLabel;
    wwDBEdit2: TDBEdit;
    Label4: TLabel;
    CBXFocoType: TValueComboBox;
    DBEdit1: TDBEdit;
    Label7: TLabel;
    Label5: TLabel;
    FmeFKSearchFoco: TFmeFKSearch;
    Label6: TLabel;
    FmeFKSearchReg: TFmeFKSearch;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox2: TDBCheckBox;
    DBCheckBox3: TDBCheckBox;
    TabSheet3: TTabSheet;
    Label11: TLabel;
    ChkHasLEC: TDBCheckBox;
    ChkHasTPU: TDBCheckBox;
    ChkHasEI: TDBCheckBox;
    ChkHasSIM: TDBCheckBox;
    ChkHasTM: TDBCheckBox;
    TabSheet4: TTabSheet;
    MSGraphicHeader3: TMSGraphicHeader;
    Label13: TLabel;
    FmeFKSearchLog: TFmeFKSearch;
    wwDBEdit6: TDBEdit;
    Label14: TLabel;
    Label15: TLabel;
    wwDBEdit7: TDBEdit;
    Label16: TLabel;
    wwDBEdit8: TDBEdit;
    wwDBEdit11: TDBEdit;
    Label19: TLabel;
    Label17: TLabel;
    wwDBEdit9: TDBEdit;
    wwDBEdit10: TDBEdit;
    Label18: TLabel;
    Label20: TLabel;
    wwDBEdit12: TDBEdit;
    Label8: TLabel;
    DBEdit2: TDBEdit;
    Label9: TLabel;
    DBEdit3: TDBEdit;
    wwCheckBox5: TDBCheckBox;
    TabSheet5: TTabSheet;
    MSGraphicHeader4: TMSGraphicHeader;
    BitBtn4: TBitBtn;
    BitBtn8: TBitBtn;
    BitBtn5: TBitBtn;
    FmeGridSearch1: TFmeGridSearch;
    ActionList2: TActionList;
    ActAddMeioContato: TAction;
    ActSalvarContatos: TAction;
    ActDelMeiosContatos: TAction;
    ImageList2: TImageList;
    CdsContatosDESCON: TStringField;
    CdsContatosCODTIPCON: TIntegerField;
    CdsContatosDESTIPCON: TStringField;
    CdsContatosCODFOC: TIntegerField;
    CdsFocosINDSIM: TStringField;
    FmeFKSearchContatos: TFmeFKSearch;
    DBEdit4: TDBEdit;
    Label10: TLabel;
    Label21: TLabel;
    procedure ActProximoUpdate(Sender: TObject);
    procedure FmeGridSearch1DBGrid1EditButtonClick(Sender: TObject);
    procedure ActDelMeiosContatosUpdate(Sender: TObject);
    procedure ActDelMeiosContatosExecute(Sender: TObject);
    procedure ActSalvarContatosUpdate(Sender: TObject);
    procedure ActSalvarContatosExecute(Sender: TObject);
    procedure ActAddMeioContatoUpdate(Sender: TObject);
    procedure ActAddMeioContatoExecute(Sender: TObject);
    procedure CBXFocoTypeChange(Sender: TObject);
    procedure CdsFocosNewRecord(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure CdsEnderecosAfterInsert(DataSet: TDataSet);

  private
    { Private declarations }
    procedure SetCampos(const TipoFoco: string); inline;

  public
    { Public declarations }
    function Execute: boolean; override;
  end;

var
  FrmWizardNewFocus: TFrmWizardNewFocus;

implementation

{$R *.dfm}

procedure TFrmWizardNewFocus.ActAddMeioContatoExecute(Sender: TObject);
begin
  inherited;
//Salva os dados editados nos controles na grade
 CdsContatos.Append;
end;

procedure TFrmWizardNewFocus.ActAddMeioContatoUpdate(Sender: TObject);
begin
  inherited;
TAction(Sender).Enabled := (CdsContatos.Active) and (CdsContatos.State = dsBrowse);
end;

procedure TFrmWizardNewFocus.ActDelMeiosContatosExecute(Sender: TObject);
begin
  inherited;
//Exclui um meio de contato da grade
 if CdsContatos.State = dsBrowse then
  CdsContatos.Delete
 else
  CdsContatos.Cancel;
end;

procedure TFrmWizardNewFocus.ActDelMeiosContatosUpdate(Sender: TObject);
begin
  inherited;
TAction(Sender).Enabled := (CdsContatos.Active) and not (CdsContatos.IsEmpty);
end;

procedure TFrmWizardNewFocus.ActProximoUpdate(Sender: TObject);
begin
  inherited;
 with CdsFocos.Fields do
  begin
   case WzCosmos.CurrentPage.Index of
    0: Taction(Sender).Enabled := True;    //Página 1
    1: begin
        TAction(Sender).Enabled :=
        (Trim(FieldByName('NOMFOC').AsString) <> '') and
        (Trim(FieldByName('SIGFOC').AsString) <> '') and
        not (FieldByName('TIPFOC').IsNull) and
        not (FieldByName('CODREG').IsNull) ;
      end;
    2: Taction(Sender).Enabled := True;
    3: begin
        TAction(Sender).Enabled :=
        (Trim(CdsEnderecos.Fields.FieldByName('NOMLOG').AsString) <> '') and
        (Trim(CdsEnderecos.Fields.FieldByName('NUMEND').AsString) <> '') and
        (Trim(CdsEnderecos.Fields.FieldByName('INDCOR').AsString) <> '');
       end;
    end;
  end;
end;

procedure TFrmWizardNewFocus.ActSalvarContatosExecute(Sender: TObject);
begin
  inherited;
  CdsContatos.Post;
end;

procedure TFrmWizardNewFocus.ActSalvarContatosUpdate(Sender: TObject);
begin
  inherited;
 TAction(Sender).Enabled := (CdsContatos.Active) and (CdsContatos.State <> dsBrowse);
end;

procedure TFrmWizardNewFocus.CBXFocoTypeChange(Sender: TObject);
begin
  inherited;
  CdsFocos.Edit;
  CdsFocos.Fields.FieldByName('tipfoc').Value := CBXFocoType.Values.Strings[CBXFocoType.ItemIndex];
  self.SetCampos(CdsFocos.Fields.FieldByName('tipfoc').AsString);
end;

procedure TFrmWizardNewFocus.CdsEnderecosAfterInsert(DataSet: TDataSet);
begin
  inherited;
  Dataset.Fields.FieldByName('INDCOR').Value := TDataConverter.ToBoleanString(True);
end;

procedure TFrmWizardNewFocus.CdsFocosNewRecord(DataSet: TDataSet);
begin
  inherited;
  CdsFocos.FieldByName('INDATI').AsString := TDataConverter.ToBoleanString(True);
  CdsFocos.FieldByName('INDIND').AsString := TDataConverter.ToBoleanString(True);
  CdsFocos.FieldByName('INDNAC').AsString := TDataConverter.ToBoleanString(True);
  CdsFocos.FieldByName('INDCAB').AsString := TDataConverter.ToBoleanString(False);
end;

function TFrmWizardNewFocus.Execute: boolean;
var
 IFocos: ICosmosFocos;
begin
{Este método implementa a finalização do Wizard. É um método sobrescrito que já
é chamado na classe ancestral no momento da finalização do assistente, caso o
usuário seleciona a opção para concluir o assistente.}
 WzCosmos.StartWizard;
 Result := self.ShowModal = mrOk;

 if Result then
  begin
   if CdsFocos.State <> dsBrowse then
    CdsFocos.Post;
   if CdsEnderecos.State <> dsBrowse then
    CdsEnderecos.Post;

   IFocos := Application.MainForm as ICosmosFocos;

   try
    Result := IFocos.CreateFocus(CdsFocos.Data, CdsEnderecos.Data, CdsGestoes.Data, CdsContatos.Data);

   finally
    if Assigned(IFocos) then IFocos := nil;
   end;
  end;
end;

procedure TFrmWizardNewFocus.FmeGridSearch1DBGrid1EditButtonClick(
  Sender: TObject);
var
ISimpleSearch: ICosmosSimpleSearch;
AModule: HModule;
AForm: TForm;
begin
  inherited;
 AForm := ICosmosApp.LoadDialog('searcher.bpl', 'TFrmSearcher', AModule);


 try
  if (AModule <> 0) and (AForm <> nil) then
   begin
     with AForm do
      begin
       if Supports(AForm, ICosmosSimpleSearch) then
        ISimpleSearch := AForm as ICosmosSimpleSearch;
       if Assigned(ISimpleSearch) then
        begin
         if ISimpleSearch.ExecuteSearch(csMeiosContatos, unassigned) then
          begin
           CdsContatos.Edit;
           CdsContatos.Fields.FieldByName('codtipcon').Value := ISimpleSearch.Dataset.Fields.FieldByName('codtipcon').Value;
           CdsContatos.Fields.FieldByName('destipcon').Value := ISimpleSearch.Dataset.Fields.FieldByName('destipcon').Value;
          end;
        end;

       Free;
      end;
   end;

  finally
   if Assigned(ISimpleSearch) then
    ISimpleSearch := nil;
   if AModule <> 0 then
    UnloadPackage(AModule);
  end;
end;

procedure TFrmWizardNewFocus.FormShow(Sender: TObject);
begin
  inherited;
  FmeFKSearchFoco.Configure('codtit', csFocosDependentes);
  FmeFKSearchReg.Configure('codreg', csRegioes);
  FmeFKSearchlog.Configure('codend', csLogradouros);
  FmeFKSearchContatos.Configure('codtipcon',csMeiosContatos);

  if CdsFocos.State = dsBrowse then
   CdsFocos.Insert;
end;

procedure TFrmWizardNewFocus.SetCampos(const TipoFoco: string);
begin
 with CdsFocos.Fields do
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
     FieldByName('INDEIN').AsString := TDataConverter.ToBoleanString(True);
     ChkHasEI.Enabled := True;
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
     FieldByName('INDEIN').AsString := TDataConverter.ToBoleanString(True);
     ChkHasEI.Enabled := True;
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
     FieldByName('INDEIN').AsString := TDataConverter.ToBoleanString(True);
     ChkHasEI.Enabled := True;
    end
   else
    if (TipoFoco = 'STP') or (TipoFoco = 'LTP') then
     begin
      FieldByName('INDLEC').AsString := TDataConverter.ToBoleanString(True);
      ChkHasLEC.Enabled := False;
      FieldByName('INDTPU').AsString := TDataConverter.ToBoleanString(True);
      ChkHasTPU.Enabled := False;
      FieldByName('INDSIM').AsString := TDataConverter.ToBoleanString(True);
      ChkHasSIM.Enabled := True;
     FieldByName('INDTMO').AsString := TDataConverter.ToBoleanString(True);
     ChkHasTM.Enabled := True;
     FieldByName('INDEIN').AsString := TDataConverter.ToBoleanString(False);
     ChkHasEI.Enabled := False;
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
     FieldByName('INDEIN').AsString := TDataConverter.ToBoleanString(True);
     ChkHasEI.Enabled := True;     
    end
   else
   end;  

end;

initialization
 RegisterClass(TFrmWizardNewFocus);

finalization
 UnRegisterClass(TFrmWizardNewFocus);

end.
