unit cosmos.secretarias.view.WzTurmasTP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cosmos.framework.view.FrmDefWizard, Wizard, ImgList, ActnList, jpeg, ExtCtrls,
  ComCtrls, StdCtrls, Buttons, Cosmos.Framework.Interfaces.Root, cosmos.classes.application,
  Cosmos.Framework.Interfaces.Dialogs, DB, DBClient, cosmos.frames.gridsearch,
  cosmos.system.messages, cosmos.business.focos, cosmos.Framework.forms.datadialogs,
  Vcl.Imaging.pngimage, System.Actions, Cosmos.Framework.Interfaces.Applications;

type
  TFrmWzTurmasTP = class(TFrmCosmosWizard)
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    Label2: TLabel;
    EdtFoco: TEdit;
    EdtNumero: TEdit;
    Label3: TLabel;
    Button1: TButton;
    EdtDate: TEdit;
    Label4: TLabel;
    Image3: TImage;
    RdbPesquisadores: TRadioButton;
    RdbJovens: TRadioButton;
    Button2: TButton;
    CdsMembros: TClientDataSet;
    DataSource1: TDataSource;
    Button3: TButton;
    TabSheet4: TTabSheet;
    LstResumo: TListBox;
    FmeGridSearch1: TFmeGridSearch;
    CdsMembrosCODCAD: TIntegerField;
    CdsMembrosMATCAD: TStringField;
    CdsMembrosNOMCAD: TStringField;
    CdsMembrosAPECAD: TStringField;
    CdsMembrosCODDIS: TIntegerField;
    CdsMembrosSIGDIS: TStringField;
    CdsMembrosCODFOC: TIntegerField;
    CdsMembrosSIGFOC: TStringField;
    procedure WzCosmosBeforeChangePage(Sender: TObject; CurrentPage: Integer);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ActProximoUpdate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    procedure SetResume; inline;

  public
    { Public declarations }
    function Execute: boolean; override;
  end;

var
  FrmWzTurmasTP: TFrmWzTurmasTP;

implementation

{$R *.dfm}

procedure TFrmWzTurmasTP.ActProximoUpdate(Sender: TObject);
begin
  inherited;
 case WzCosmos.ActivePageIndex of
  1: begin
      TAction(Sender).Enabled :=  (EdtFoco.Text <> '') and
        (EdtNumero.Text <> '') and (EdtDate.Text <> '') ;
     end;
  2: TAction(Sender).Enabled := not (CdsMembros.IsEmpty);
 end;
end;

procedure TFrmWzTurmasTP.Button1Click(Sender: TObject);
var
 ISecretarias: ICosmosSecretarias;
begin
  inherited;
  ISecretarias := Application.MainForm as ICosmosSecretarias;

  try
   EdtNumero.Text := ISecretarias.GetPublicTeamId(ICosmosApp.ActiveFocus.FocusID);

  finally
   if Assigned(ISecretarias) then ISecretarias := nil;
  end;
end;

procedure TFrmWzTurmasTP.Button2Click(Sender: TObject);
var
 AData: TCosmosData;
begin
 inherited;
 try
   if self.RdbPesquisadores.Checked then
    AData := TCosmosCadastradosDialogs.SelecionarCadastrado(ctTP, scTodos, False)
   else
    AData := TCosmosCadastradosDialogs.SelecionarCadastrado(ctTM, scTodos, False);

   if Assigned(AData) then
    begin
     if not CdsMembros.Locate('CODCAD', AData.FindValue('CODCAD'),[]) then
       begin
         CdsMembros.Append;
         with CdsMembros.Fields do
           begin
             FieldByName('codcad').Value := AData.FindValue('CODCAD');
             FieldByName('nomcad').Value := AData.FindValue('NOMCAD');
             FieldByName('matcad').Value := AData.FindValue('MATCAD');
             FieldByName('apecad').Value := AData.FindValue('APECAD');
             FieldByName('coddis').Value := AData.FindValue('CODDIS');
             FieldByName('sigdis').Value := AData.FindValue('SIGDIS');
             FieldByName('codfoc').Value := AData.FindValue('CODFOC');
             FieldByName('sigfoc').Value := AData.FindValue('SIGFOC');
           end;
         CdsMembros.Post;
       end
      else
       ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.TurmasTP , TCosmosErrorMsg.CadastradoJaSelecionado);
    end;

 except
  on E: Exception do
   begin
    ICosmosApp.MainLog.RegisterError(E.Message);
    ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.TurmasTP, TCosmosErrorMsg.MembrosTurmaInstalacao);
   end;
 end;
end;

procedure TFrmWzTurmasTP.Button3Click(Sender: TObject);
begin
  inherited;
 if not CdsMembros.IsEmpty then
  if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.TurmasTP, TCosmosConfMsg.ConfDelete) = mrYes then
   CdsMembros.Delete;
end;

function TFrmWzTurmasTP.Execute: boolean;
var
 ISecretarias: ICosmosSecretarias;
begin
 WzCosmos.StartWizard;
 Result := self.ShowModal = mrOk;

 if Result then
  begin
   ISecretarias := Application.MainForm as ICosmosSecretarias;

   try
    Result := ISecretarias.CreatePublicTeam(ICosmosApp.ActiveFocus.FocusID, CdsMembros.Data);

   finally
    if Assigned(ISecretarias) then ISecretarias := nil;
   end;
  end;
end;

procedure TFrmWzTurmasTP.FormCreate(Sender: TObject);
var
vDate: TDate;
begin
  inherited;
 EdtFoco.Text := ICosmosApp.ActiveFocus.FocusName;
 vDate := IRemoteCon.ServerDateTime;
 EdtDate.Text := DateToStr(vDate);
 FmeGridSearch1.ShowSearchBar := False;
end;

procedure TFrmWzTurmasTP.SetResume;
begin
 LstResumo.Items.Clear;
 LstResumo.Items.Add('Turma: ' + EdtNumero.Text);
 LstResumo.Items.Add('Criação: ' + EdtDate.Text);

 CdsMembros.First;
 LstResumo.Items.Add('');
 LstResumo.Items.Add('Membros da turma:');
 LstResumo.Items.Add('');
 
 while not CdsMembros.Eof do
  begin
   LstResumo.Items.Add(CdsMembros.Fields.FieldByName('nomcad').AsString);
   CdsMembros.Next;
  end;
end;

procedure TFrmWzTurmasTP.WzCosmosBeforeChangePage(Sender: TObject;
  CurrentPage: Integer);
begin
  inherited;
 if CurrentPage = 2 then
  SetResume;
end;

initialization
 RegisterClass(TFrmWzTurmasTP);

finalization
 UnRegisterClass(TFrmWzTurmasTP);

end.
