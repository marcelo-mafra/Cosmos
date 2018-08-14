unit cosmos.conferencias.view.FormStaffConferencias;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cosmos.framework.view.FrmDocked, Vcl.ActnList,
  Vcl.ImgList, cosmos.system.messages, Vcl.ToolWin, Vcl.ActnMan,
  Vcl.ActnCtrls, Vcl.PlatformDefaultStyleActnCtrls, Vcl.ComCtrls,
  cosmos.framework.datanavigators.treeview, cosmos.classes.application, DBClient,
  cosmos.classes.ServerInterface, Data.DB, Vcl.ExtCtrls, Vcl.StdCtrls,
  cosmos.framework.interfaces.dialogs, cosmos.business.focos, cosmos.frames.gridsearch,
  Vcl.Buttons, Vcl.Menus, Vcl.ActnPopup, cosmos.frames.areasstaff, Vcl.Mask, GroupHeader,
  System.Actions, Datasnap.DSConnect, cosmos.framework.interfaces.dataacess,
  cosmos.framework.interfaces.root, cosmos.system.formsconst, cosmos.system.dataconverter,
  System.ImageList;

type

  TFrmStaffConferencias = class(TFrmCosmosDocked)
    ActionManager1: TActionManager;
    ActionToolBar1: TActionToolBar;
    CdsStaffTarefa: TClientDataSet;
    DsrSTaffTarefa: TDataSource;
    TreeList: TImageList;
    Panel1: TPanel;
    Label1: TLabel;
    LblPromotor: TLabel;
    Label2: TLabel;
    LblInicio: TLabel;
    Label4: TLabel;
    LblTermino: TLabel;
    LblConferencia: TLinkLabel;
    Splitter1: TSplitter;
    Panel2: TPanel;
    FmeGridStaffs: TFmeGridSearch;
    EdtSearchInscrito: TLabeledEdit;
    Bevel1: TBevel;
    ActPesquisar: TAction;
    ActAddInscrito: TAction;
    ActDelInscrito: TAction;
    PopupActionBar1: TPopupActionBar;
    AbrirConferncia1: TMenuItem;
    FmeAreasStaff: TFmeAreasStaff;
    BitBtn1: TBitBtn;
    MSGroupHeader1: TMSGroupHeader;
    LblNomeInscrito: TLabel;
    LblNucleo: TLabel;
    LblDiscipulado: TLabel;
    LblQuarto: TLabel;
    LblAlojamento: TLabel;
    MSGroupHeader2: TMSGroupHeader;
    LblTarefa: TLabel;
    Label6: TLabel;
    EdtDataTarefa: TDateTimePicker;
    EdtInicio: TMaskEdit;
    Label3: TLabel;
    Label5: TLabel;
    EdtTermino: TMaskEdit;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    PopupActionBar2: TPopupActionBar;
    MenuItem2: TMenuItem;
    RetirarTarefa1: TMenuItem;
    Novarea1: TMenuItem;
    NovoSubrea1: TMenuItem;
    Renomearrea1: TMenuItem;
    NovaTarefa1: TMenuItem;
    AlterarTarefa1: TMenuItem;
    ExcluirTarefa1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure ActPesquisarExecute(Sender: TObject);
    procedure ActPesquisarUpdate(Sender: TObject);
    procedure ActAddInscritoExecute(Sender: TObject);
    procedure ActAddInscritoUpdate(Sender: TObject);
    procedure PopupActionBar1Popup(Sender: TObject);
    procedure CdsStaffTarefaAfterPost(DataSet: TDataSet);
    procedure CdsStaffTarefaBeforePost(DataSet: TDataSet);
    procedure ActDelInscritoExecute(Sender: TObject);
    procedure ActDelInscritoUpdate(Sender: TObject);
    procedure CdsStaffTarefaBeforeDelete(DataSet: TDataSet);

  private
    { Private declarations }
    FCurrentFocusID: integer;
    FIConference: ICosmosConference;
    FDataNavigator: TTreeviewDataNavigator;
    FRemoteConnection: TDSProviderConnection;
    FCadastradoData, FConferenceData: TCosmosData;

    procedure OnChangeSelected(Sender: TObject; Node: TTreeNode);
    procedure ClearInscritoInfo; inline;
    procedure UpdateData(Sender: TObject);
    function ValidateData: boolean; inline;
    procedure ShowConferenceInfo;

  protected
    function GetFormDescription: string; override;
    function GetFormIDName: string; override;
    function GetHelpFile: string; override;
    function GetHelpID: integer; override;
    function GetTitle: string; override;
    procedure Locate; override;
    procedure ExportData; override;
    procedure UpdateVisualElements; override;

    property FormDescription: string read GetFormDescription;
    property HelpFile: string read GetHelpFile;
    property HelpID: integer read GetHelpID;
    property FormIDName: string read GetFormIDName;
    property Title: string read GetTitle;

  public
    { Public declarations }
    property CadastradoData: TCosmosData read FCadastradoData;
    property ConferenceData: TCosmosData read FConferenceData;
    property CurrentFocusID: integer read FCurrentFocusID write FCurrentFocusID;
    property IConference: ICosmosConference read FIConference;
  end;

var
  FrmStaffConferencias: TFrmStaffConferencias;

implementation

{$R *.dfm}

{ TFrmStaffConferencias }

procedure TFrmStaffConferencias.ActAddInscritoExecute(Sender: TObject);
var
sInfo: string;
begin
  inherited;
  //Vincula o inscrito à tarefa selecionada.
  if not ValidateData then
   Exit;

  CdsStaffTarefa.DisableControls;

  if CdsStaffTarefa.Locate('CODINS', CadastradoData.FindValue('CODINS'), []) then
   begin
    if (CdsStaffTarefa.FieldValues['DATSTA'] = EdtDataTarefa.Date) and
       (CdsStaffTarefa.FieldValues['HORINI'] = EdtInicio.Text) then
       begin
        sInfo := Format(TCosmosInfoMsg.StaffTarefaRegistrado, [CadastradoData.FindValue('NOMCAD'),
        self.FmeAreasStaff.SelectedArea.Nome]);
        ICosmosApp.DlgMessage.InfoMessage(TCosmosTitles.Staff, sInfo);
        CdsStaffTarefa.EnableControls;
        Exit;
       end;
    CdsStaffTarefa.EnableControls;
   end;

  try
   CdsStaffTarefa.Append;

   with CdsStaffTarefa.Fields do
    begin
     FieldByName('codins').Value := self.CadastradoData.FindValue('CODINS');
     FieldByName('indfix').Value := 'N';
     FieldByName('datsta').Value := self.EdtDataTarefa.Date;
     FieldByName('horini').Value := self.EdtInicio.Text;
     FieldByName('horter').Value := self.EdtTermino.Text;
     FieldByName('codtar').Value := self.FmeAreasStaff.SelectedArea.code;
     FieldByName('matcad').Value := self.CadastradoData.FindValue('MATCAD');
     FieldByName('nomcad').Value := self.CadastradoData.FindValue('NOMCAD');
     FieldByName('sigdis').Value := self.CadastradoData.FindValue('SIGDIS');
     FieldByName('sigfoc').Value := self.CadastradoData.FindValue('SIGFOC');
     FieldByName('sexcad').Value := self.CadastradoData.FindValue('SEXCAD');
    end;

   CdsStaffTarefa.Post;

  finally
   CdsStaffTarefa.EnableControls;
  end;
end;

procedure TFrmStaffConferencias.ActAddInscritoUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (FmeAreasStaff.SelectedArea <> nil) and
   (FmeAreasStaff.SelectedArea.NType = ntAtividade) and (CadastradoData <> nil);
end;

procedure TFrmStaffConferencias.ActDelInscritoExecute(Sender: TObject);
begin
  inherited;
  CdsStaffTarefa.Delete;
end;

procedure TFrmStaffConferencias.ActDelInscritoUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (CdsStaffTarefa.Active) and not (CdsStaffTarefa.IsEmpty);
end;

procedure TFrmStaffConferencias.ActPesquisarExecute(Sender: TObject);
var
 ADataset: TClientDataset;
 AParams: TCosmosData;
begin
  inherited;
  ADataset := TClientDataset.Create(self);
  AParams := TCosmosData.Create(5);

  try
   AParams.WriteValue('CODCON', ConferenceData.FindValue('CODCON'));
   AParams.WriteValue('NOMCAD', QuotedStr(EdtSearchInscrito.Text + '%'), 1);   
   IRemoteCon.ExecuteDQL(csInscritoNome, AParams.Data, ADataset);

   if (ADataset.Active) and not (ADataset.IsEmpty) and (ADataset.FieldValues['CODCAD'] <> null) then
    begin
     if FCadastradoData = nil then
      FCadastradoData := TCosmosData.Create(15);

     CadastradoData.WriteValue('CODCAD', ADataset.FieldValues['CODCAD']);
     CadastradoData.WriteValue('NOMCAD', ADataset.FieldValues['NOMCAD'], 1);
     CadastradoData.WriteValue('MATCAD', ADataset.FieldValues['MATCAD'], 2);
     CadastradoData.WriteValue('SEXCAD', ADataset.FieldValues['SEXCAD'], 3);
     CadastradoData.WriteValue('SIGFOC', ADataset.FieldValues['SIGFOC'], 4);
     CadastradoData.WriteValue('SIGDIS', ADataset.FieldValues['SIGDIS'], 5);
     CadastradoData.WriteValue('NOMALO', ADataset.FieldValues['NOMALO'], 6);
     CadastradoData.WriteValue('NUMQUA', ADataset.FieldValues['NUMQUA'], 7);
     CadastradoData.WriteValue('CODINS', ADataset.FieldValues['CODINS'], 8);
     CadastradoData.WriteValue('NUMINS', ADataset.FieldValues['NUMINS'], 9);

     LblNomeInscrito.Caption := CadastradoData.FindValue('NOMCAD');
     LblNucleo.Caption := CadastradoData.FindValue('SIGFOC');
     LblDiscipulado.Caption := CadastradoData.FindValue('SIGDIS');

     if CadastradoData.FindValue('NUMQUA') <> null then
      LblQuarto.Caption := CadastradoData.FindValue('NUMQUA');

     if CadastradoData.FindValue('NOMALO') <> null then
      LblAlojamento.Caption := CadastradoData.FindValue('NOMALO');
    end
   else
    ClearInscritoInfo; 
  

  finally
   if Assigned(AParams) then FreeAndNil(AParams);
   if Assigned(ADataset) then FreeAndNil(ADataset);
  end;
end;

procedure TFrmStaffConferencias.ActPesquisarUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (ConferenceData <> nil) and (EdtSearchInscrito.Text <> '');
end;

procedure TFrmStaffConferencias.CdsStaffTarefaAfterPost(DataSet: TDataSet);
begin
  inherited;
  if CdsStaffTarefa.ChangeCount > 0 then
   CdsStaffTarefa.ApplyUpdates(0);
end;

procedure TFrmStaffConferencias.CdsStaffTarefaBeforeDelete(DataSet: TDataSet);
begin
  inherited;
  if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.Staff, TCosmosConfMsg.DelStaffConferencia) = mrNo  then
   Abort;
end;

procedure TFrmStaffConferencias.CdsStaffTarefaBeforePost(DataSet: TDataSet);
var
SequenceName: string;
begin
  inherited;
 if Dataset.State = dsInsert then
  begin
   SequenceName := TClientDataset(DataSet).GetOptionalParam('SequenceName');
   Dataset.FieldValues['codsta'] := IRemoteCon.GetSequenceValue(SequenceName);
  end;
end;

procedure TFrmStaffConferencias.ClearInscritoInfo;
begin
//Limpa todas as informações sobre o inscrito pesquisado.
 if Assigned(FCadastradoData) then
  FreeAndNil(FCadastradoData);

 LblNucleo.Caption := '';
 LblDiscipulado.Caption := '';
 LblQuarto.Caption := '';                        
 LblAlojamento.Caption := '';   
end;

procedure TFrmStaffConferencias.ExportData;
begin
  inherited;

end;

procedure TFrmStaffConferencias.FormActivate(Sender: TObject);
begin
  inherited;
  IRemoteCon.ActiveDataset := CdsStaffTarefa;
  IRemoteCon.ActiveDataNavigator := self.DataNavigator;
end;

procedure TFrmStaffConferencias.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 if CdsStaffTarefa.Active then CdsStaffTarefa.Close;
  CdsStaffTarefa.RemoteServer := nil;

 if Assigned(FRemoteConnection) then
  ICosmosApp.IRemoteCon.DropConnection(FRemoteConnection);

  inherited;
  if Assigned(FDataNavigator) then
   FreeAndNil(FDataNavigator);

  Action := caFree;
  FrmStaffConferencias := nil;
end;

procedure TFrmStaffConferencias.FormCreate(Sender: TObject);
begin
  inherited;
  FIConference := Application.MainForm as ICosmosConference;
  FCurrentFocusID := ICosmosApp.ActiveFocus.FocusID;
  FRemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scConferencias);
  CdsStaffTarefa.RemoteServer := FRemoteConnection;

  FDataNavigator := TTreeviewDataNavigator.Create(FmeAreasStaff.TreeData);
  self.DataNavigator := FDataNavigator;
  TTreeviewDataNavigator(DataNavigator).OnUpdateData := self.UpdateData;

  ShowConferenceInfo;
  ClearInscritoInfo;
  FmeGridStaffs.SearchFields := 'NOMCAD';
  FmeAreasStaff.Listagem := [ltAreas, ltTarefas];
  FmeAreasStaff.ChangeSelected := self.OnChangeSelected;
  FmeAreasStaff.ListarAreas(nil);
  EdtDataTarefa.Date := IConference.ActiveConference.ConferenceStart;
end;

function TFrmStaffConferencias.GetFormDescription: string;
begin
 Result := TDockedFormDesc.FormStaff;
end;

function TFrmStaffConferencias.GetFormIDName: string;
begin
 Result := 'Cosmos.Staff.Conferências';
end;

function TFrmStaffConferencias.GetHelpFile: string;
begin
 Result := self.HelpFile;
end;

function TFrmStaffConferencias.GetHelpID: integer;
begin

end;

function TFrmStaffConferencias.GetTitle: string;
begin
 Result := Caption;
end;

procedure TFrmStaffConferencias.Locate;
begin
  inherited;
  IRemoteCon.DefaultLocate;
end;

procedure TFrmStaffConferencias.OnChangeSelected(Sender: TObject;
  Node: TTreeNode);
begin
 //Método que implementa o evento "ChangeSelected" da classe TFmeAreasStaff.
 LblTarefa.Caption := '';

 if Node <> nil then
  begin
   if FmeAreasStaff.SelectedArea.NType = ntAtividade then
    begin
     LblTarefa.Caption := Format('%s / %s', [Node.Text, Node.Parent.Text]);

     CdsStaffTarefa.DisableControls;

     try
      if CdsStaffTarefa.Active then
       CdsStaffTarefa.Close;

      CdsStaffTarefa.Params[0].Value := FmeAreasStaff.SelectedArea.code;
      CdsStaffTarefa.Params[1].Value := ConferenceData.FindValue('CODCON');
      CdsStaffTarefa.Open;

     finally
      CdsStaffTarefa.EnableControls;
     end;
    end
   else
    if CdsStaffTarefa.Active then
     CdsStaffTarefa.Close;
  end;
end;

procedure TFrmStaffConferencias.PopupActionBar1Popup(Sender: TObject);
begin
  inherited;
  TPopupActionBar(Sender).Style := ICosmosApp.InterfaceStyle;
end;

procedure TFrmStaffConferencias.ShowConferenceInfo;
begin
 if (IConference <> nil) then
  begin
   if IConference.ActiveConference <> nil then
    begin
     LblConferencia.Caption := IConference.ActiveConference.ConferenceName;
     LblPromotor.Caption := IConference.ActiveConference.FocoPromotor;
     LblInicio.Caption := DateTimeToStr(IConference.ActiveConference.ConferenceStart);
     LblTermino.Caption := DateTimeToStr(IConference.ActiveConference.ConferenceEnd);

     if not Assigned(FConferenceData) then
      FConferenceData := TCosmosData.Create(8);

     ConferenceData.ClearData;
     ConferenceData.WriteValue('codcon', IConference.ActiveConference.ConferenceID);
     ConferenceData.WriteValue('nomcon', IConference.ActiveConference.ConferenceName, 1);
     ConferenceData.WriteValue('camcon', IConference.ActiveConference.CampoPromotor, 2);
     ConferenceData.WriteValue('nomfoc', IConference.ActiveConference.FocoPromotor, 3);
     ConferenceData.WriteValue('datini', IConference.ActiveConference.ConferenceStart, 4);
     ConferenceData.WriteValue('datter', IConference.ActiveConference.ConferenceEnd, 5);
     ConferenceData.WriteValue('horche', null, 6); //default null. usado na tela de cadastro.
     ConferenceData.WriteValue('horter', null, 7); //default null. usado na tela de cadastro.
    end
   else
    begin
     LblConferencia.Caption := '-';
     LblPromotor.Caption := '-';
     LblInicio.Caption := '-';
     LblTermino.Caption := '-';

     if not Assigned(FConferenceData) then
      FConferenceData := TCosmosData.Create(8);

     ConferenceData.ClearData;
    end;
  end;
end;

procedure TFrmStaffConferencias.UpdateData(Sender: TObject);
begin
 {Caso o foco ativo mude, este método é chamado. Então, deve-se construir a
  árvore por completo. Do contrário, somente será atualizado os nós debaixo
  do selecionado.}
 if ConferenceData = nil then
  Exit;

 if CurrentFocusID = ICosmosApp.ActiveFocus.FocusID then
  FmeAreasStaff.TreeData.OnDblClick(FmeAreasStaff.TreeData)
 else
  begin
   CurrentFocusID := ICosmosApp.ActiveFocus.FocusID;
   FmeAreasStaff.ListarAreas(nil);
  end;
end;

procedure TFrmStaffConferencias.UpdateVisualElements;
begin
  inherited;
  ActionManager1.Style := ICosmosApp.InterfaceStyle;
end;

function TFrmStaffConferencias.ValidateData: boolean;
begin
 {Valida as informações preenchidas pelo usuário.}
 Result := (Trim(EdtInicio.Text) <> ':') and (Trim(EdtTermino.Text) <> ':');

 if not Result then
  begin
   ICosmosApp.DlgMessage.InfoMessage(TCosmosTitles.Staff, TCosmosInfoMsg.HoraTarefaStaff);
   Exit;
  end;

 try
   Result := TDataConverter.ToTime(EdtInicio.Text) <= TDataConverter.ToTime(EdtTermino.Text) ;

   if not Result then
    ICosmosApp.DlgMessage.InfoMessage(TCosmosTitles.Staff, TCosmosErrorMsg.CompareTime);

 except
   Result := False;
   ICosmosApp.DlgMessage.InfoMessage(TCosmosTitles.Staff, TCosmosInfoMsg.HoraTarefaStaff);
 end;
end;

initialization
 RegisterClass(TFrmStaffConferencias);

finalization
 UnRegisterClass(TFrmStaffConferencias);

end.
