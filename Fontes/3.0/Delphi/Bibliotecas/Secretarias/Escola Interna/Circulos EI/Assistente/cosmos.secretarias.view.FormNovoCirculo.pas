unit cosmos.secretarias.view.FormNovoCirculo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cosmos.framework.view.FrmDefWizard, Wizard, ImgList, ActnList, jpeg, ExtCtrls,
  ComCtrls, StdCtrls, Buttons, CheckLst, Grids, DBGrids, Mask, DBCtrls, DB,
  DBClient, Cosmos.Framework.Interfaces.Root, Cosmos.Framework.Interfaces.Dialogs,
  cosmos.frames.fkSearch, cosmos.classes.ServerInterface, DBCGrids, System.Actions,
  GroupHeader, cosmos.system.messages, Cosmos.Framework.Interfaces.Applications,
  cosmos.frames.gridsearch, cosmos.classes.application, cosmos.business.focos,
  cosmos.Framework.forms.datadialogs, Vcl.Imaging.pngimage;

type
  TFrmWzNovoCirculoEI = class(TFrmCosmosWizard)
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    DBEdit1: TDBEdit;
    Button1: TButton;
    Button2: TButton;
    CdsCirculo: TClientDataSet;
    CdsMembros: TClientDataSet;
    DsrCirculo: TDataSource;
    DsrMembros: TDataSource;
    EdtFoco: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    ActNew: TAction;
    ActDelete: TAction;
    FmeFKSearch1: TFmeFKSearch;
    FmeFKSearch2: TFmeFKSearch;
    FmeFKSearch3: TFmeFKSearch;
    Label6: TLabel;
    FmeFKSearch4: TFmeFKSearch;
    Label7: TLabel;
    MSGroupHeader1: TMSGroupHeader;
    Label8: TLabel;
    DBEdit2: TDBEdit;
    Label9: TLabel;
    EdtConfirm: TEdit;
    MSGroupHeader2: TMSGroupHeader;
    DBCtrlGrid1: TDBCtrlGrid;
    DBText1: TDBText;
    DBCheckBox1: TDBCheckBox;
    FmeGridSearch1: TFmeGridSearch;
    CdsMembrosCODMEM: TIntegerField;
    CdsMembrosCODCAD: TIntegerField;
    CdsMembrosNOMCAD: TStringField;
    CdsMembrosMATCAD: TStringField;
    CdsMembrosCODDIS: TIntegerField;
    CdsMembrosSIGDIS: TStringField;
    CdsMembrosCODGRU: TIntegerField;
    CdsMembrosINDCON: TStringField;
    CdsMembrosSIGFOC: TStringField;
    procedure WzCosmosBeforeNextPage(Sender: TObject; CurrentPage: Integer);
    procedure CdsCirculoAfterInsert(DataSet: TDataSet);
    procedure ActNewUpdate(Sender: TObject);
    procedure ActNewExecute(Sender: TObject);
    procedure ActDeleteUpdate(Sender: TObject);
    procedure ActDeleteExecute(Sender: TObject);
    procedure CdsMembrosAfterInsert(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
    function Execute: boolean; override;
  end;

var
  FrmWzNovoCirculoEI: TFrmWzNovoCirculoEI;

implementation

{$R *.dfm}

procedure TFrmWzNovoCirculoEI.ActDeleteExecute(Sender: TObject);
begin
  inherited;
 CdsMembros.Delete;
end;

procedure TFrmWzNovoCirculoEI.ActDeleteUpdate(Sender: TObject);
begin
  inherited;
TAction(Sender).Enabled := (CdsMembros.Active) and not (CdsMembros.IsEmpty);
end;

procedure TFrmWzNovoCirculoEI.ActNewExecute(Sender: TObject);
var
 AData: TCosmosData;
begin
 inherited;
 AData := TCosmosCadastradosDialogs.SelecionarCadastrado(ctLectorium, scTodos, False);

 try
  if AData <> nil then
   begin
    if not CdsMembros.Locate('CODCAD', AData.FindValue('codcad'),[]) then
      begin
        CdsMembros.Append;
        with CdsMembros.Fields do
         begin
          FieldByName('codcad').Value := AData.FindValue('codcad');
          FieldByName('nomcad').Value := AData.FindValue('nomcad');
          FieldByName('matcad').Value := AData.FindValue('matcad');
          FieldByName('sigdis').Value := AData.FindValue('sigdis');
          FieldByName('coddis').Value := AData.FindValue('coddis');
          FieldByName('sigfoc').Value := AData.FindValue('sigfoc');
         end;
      //        CdsMembros.Post;
      end;
   end;

 finally
  if Assigned(AData) then
   FreeAndNil(AData);
 end;
end;

procedure TFrmWzNovoCirculoEI.ActNewUpdate(Sender: TObject);
begin
  inherited;
TAction(Sender).Enabled := CdsMembros.Active;
end;

procedure TFrmWzNovoCirculoEI.CdsCirculoAfterInsert(DataSet: TDataSet);
begin
  inherited;
  with CdsCirculo.Fields do
   begin
     FieldByName('codfoc').AsInteger := ICosmosApp.ActiveFocus.FocusID;
     FieldByName('codgru').AsInteger := 0;
     FieldByName('codlic').AsInteger := 1;
     FieldByName('nomliv').AsString := 'Novo livro';
   end;
end;

procedure TFrmWzNovoCirculoEI.CdsMembrosAfterInsert(DataSet: TDataSet);
begin
  inherited;
 CdsMembros.Fields.FieldByName('codmem').AsInteger := 0;
 CdsMembros.Fields.FieldByName('codgru').AsInteger := 0;
 CdsMembros.Fields.FieldByName('indcon').AsString := 'N'; 
end;

function TFrmWzNovoCirculoEI.Execute: boolean;
var
 ISecretarias: ICosmosSecretarias;
begin
 self.WzCosmos.StartWizard;
 Result := self.ShowModal = mrOk;
 if Result then
  begin
   if CdsCirculo.Fields.FieldByName('nomlic').IsNull then
    begin
     ICosmosApp.DlgMessage.InfoMessage(TCosmosTitles.EI, TCosmosInfoMsg.IncompleteData);
     Abort;
    end;

    if CdsCirculo.State in [dsEdit, dsInsert] then
     CdsCirculo.Post;

   ISecretarias := Application.MainForm as ICosmosSecretarias;

   try
    Result := ISecretarias.CreateCircle(CdsCirculo.Data, CdsMembros.Data);

   finally
    begin
     if Assigned(ISecretarias) then  FreeAndNil(ISecretarias);
     Close;
    end;
   end;
  end;
end;

procedure TFrmWzNovoCirculoEI.FormCreate(Sender: TObject);
begin
  inherited;
  EdtFoco.Text := ICosmosApp.ActiveFocus.FocusName;

  CdsCirculo.Insert;

  FmeFkSearch1.Configure('codsac',csMentoresEI);
  FmeFkSearch2.Configure('codsaz',csMentorasEI);
  FmeFkSearch3.Configure('coddis',csDiscipuladosEI);
  FmeFkSearch4.Configure('codlic',csLicoesEI);
 
  FmeGridSearch1.ShowSearchBar := False;
end;

procedure TFrmWzNovoCirculoEI.WzCosmosBeforeNextPage(Sender: TObject;
  CurrentPage: Integer);
begin
  inherited;
 case CurrentPage of
  1: with CdsCirculo.Fields do
      begin
        if (FieldByName('sigdis').IsNull) or (FieldByName('nomgru').IsNull) then
         begin
          ICosmosApp.DlgMessage.InfoMessage(TCosmosTitles.EI, TCosmosInfoMsg.IncompleteData);
          Abort;
         end;
      end;
  2: if CdsMembros.IsEmpty then
      begin
       ICosmosApp.DlgMessage.InfoMessage(TCosmosTitles.EI, TCosmosInfoMsg.MembrosCirculo);
       Abort;
      end;
 end;
end;

initialization
 RegisterClass(TFrmWzNovoCirculoEI);

finalization
 UnRegisterClass(TFrmWzNovoCirculoEI);

end.
