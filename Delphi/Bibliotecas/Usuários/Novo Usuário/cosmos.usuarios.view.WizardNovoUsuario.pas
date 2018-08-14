unit cosmos.usuarios.view.WizardNovoUsuario;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cosmos.framework.view.FrmDefWizard, Wizard, ImgList, ActnList, jpeg, ExtCtrls,
  ComCtrls, StdCtrls, Buttons, GroupHeader, cosmos.frames.fkSearch, cosmos.system.dataconverter,
  Cosmos.classes.ServerInterface, Mask, DBCtrls, cosmos.frames.gridsearch, DB, DBClient,
  cosmos.system.messages, cosmos.classes.application, Vcl.Imaging.pngimage,
  System.Actions, Data.DBXCommon, cosmos.usuarios.clientconnections,
  System.ImageList;

type
  TFrmWizardNovoUsuario = class(TFrmCosmosWizard)
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    MSGroupHeader1: TMSGroupHeader;
    Label2: TLabel;
    Label3: TLabel;
    FmeFkAluno: TFmeFKSearch;
    DBEdit1: TDBEdit;
    MSGroupHeader2: TMSGroupHeader;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox2: TDBCheckBox;
    CdsUsuario: TClientDataSet;
    CdsFocos: TClientDataSet;
    DsrUsuarios: TDataSource;
    DsrFocos: TDataSource;
    MSGroupHeader3: TMSGroupHeader;
    Label4: TLabel;
    FmeFkFocos: TFmeFKSearch;
    FmeGridSearch1: TFmeGridSearch;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    DBEdit2: TDBEdit;
    Label5: TLabel;
    EdtConfirmPass: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    CBXRoles: TDBComboBox;
    TabSheet4: TTabSheet;
    MmoResumo: TMemo;
    DBRadioGroup1: TDBRadioGroup;
    MSGroupHeader4: TMSGroupHeader;
    DBCheckBox3: TDBCheckBox;
    DBCheckBox4: TDBCheckBox;
    DBCheckBox5: TDBCheckBox;
    DBCheckBox6: TDBCheckBox;
    DBCheckBox7: TDBCheckBox;
    CdsFocosCODGRU: TIntegerField;
    CdsFocosCODFOC: TIntegerField;
    CdsFocosNOMFOC: TStringField;
    CdsFocosNOMGRU: TStringField;
    CdsFocosSIGFOC: TStringField;
    CdsFocosTIPPER: TStringField;
    CdsFocosINDSEC: TStringField;
    CdsFocosINDCON: TStringField;
    CdsFocosINDFIN: TStringField;
    CdsFocosINDFOC: TStringField;
    CdsFocosINDUSU: TStringField;
    procedure DBEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure WzCosmosBeforeNextPage(Sender: TObject; CurrentPage: Integer);
    procedure ActProximoUpdate(Sender: TObject);
    procedure CdsUsuarioAfterInsert(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure CdsFocosAfterInsert(DataSet: TDataSet);
  private
    { Private declarations }
    procedure ShowResume; inline;
  public
    { Public declarations }
    function Execute: boolean; override;
  end;

var
  FrmWizardNovoUsuario: TFrmWizardNovoUsuario;

implementation

{$R *.dfm}

procedure TFrmWizardNovoUsuario.ActProximoUpdate(Sender: TObject);
begin
  inherited;
  case WzCosmos.ActivePageIndex of
   2: TAction(Sender).Enabled := not (CdsFocos.IsEmpty);
  end;
end;

procedure TFrmWizardNovoUsuario.CdsFocosAfterInsert(DataSet: TDataSet);
begin
  inherited;
  Dataset.Fields.FieldByName('tipper').Value := 'E'; //do not localize!
 CdsFocos.Fields.FieldByName('indsec').Value := TDataConverter.ToBoleanString(False);
 CdsFocos.Fields.FieldByName('indfin').Value := TDataConverter.ToBoleanString(False);
 CdsFocos.Fields.FieldByName('indfoc').Value := TDataConverter.ToBoleanString(False);
 CdsFocos.Fields.FieldByName('indcon').Value := TDataConverter.ToBoleanString(False);
 CdsFocos.Fields.FieldByName('indusu').Value := TDataConverter.ToBoleanString(True);
end;

procedure TFrmWizardNovoUsuario.CdsUsuarioAfterInsert(DataSet: TDataSet);
begin
  inherited;
  CdsUsuario.Fields.FieldByName('indati').AsString := TDataConverter.ToBoleanString(True);
  CdsUsuario.Fields.FieldByName('indadm').AsString := TDataConverter.ToBoleanString(False);
  CdsUsuario.Fields.FieldByName('indblo').AsString := TDataConverter.ToBoleanString(False);
  CdsUsuario.Fields.FieldByName('indpro').AsString := TDataConverter.ToBoleanString(True);
end;

procedure TFrmWizardNovoUsuario.DBEdit1KeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  //do not localize!
  if key in [' ','á','é','í','ó','ú','ç','ü','ö',';',':','â','ê','î','ô','û',
   'à','è','ì','ò','ù','^','~','"','´','`','¨',',',''''] then
   Abort;
end;

function TFrmWizardNovoUsuario.Execute: boolean;
var
ACommand: TDBXCommand;
begin
  WzCosmos.StartWizard;
  CdsUsuario.Insert;

  Result := ShowModal = mrOK;

  if Result then
   begin
    CdsUsuario.Edit;
    CdsUsuario.FieldValues['passwrd'] := ICosmosApp.IUtilities.HashString(CdsUsuario.FieldValues['passwrd']);
    CdsUsuario.Post;

    ACommand := IRemoteCon.CreateCommand;

    try
      ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
      ACommand.Text := 'TDMUserMethods.CreateCosmosUser'; //do not localize!
      ACommand.Prepare;

      ACommand.Parameters[0].Value.SetString(CdsUsuario.XMLData);
      ACommand.Parameters[1].Value.SetString(CdsFocos.XMLData);

      ACommand.ExecuteUpdate;

      Result := ACommand.Parameters[2].Value.GetInt32 = 0;
      ICosmosApp.MainLog.RegisterRemoteCallSucess(Format(TCosmosLogs.ExecutedRemoteCommand, [ACommand.Text]), IRemoteCon.ConnectionParamsInfo);
      ACommand.Free;

    except
      ICosmosApp.MainLog.RegisterRemoteCallFailure(Format(TCosmosLogs.ExecutedRemoteCommand, [ACommand.Text]), IRemoteCon.ConnectionParamsInfo);
      if Assigned(ACommand) then FreeAndNil(ACommand);
    end;
   end;
end;

procedure TFrmWizardNovoUsuario.FormCreate(Sender: TObject);
var
AList: TStringList;
begin
  inherited;
  FmeFkAluno.Configure('codcad', csAlunos);
  FmeFkFocos.Configure('codfoc', csFocos);
  FmeGridSearch1.ShowSearchBar := False;

  AList := TStringList.Create;

  try
   DMCon.ListCosmosRoles(AList);
   CBXRoles.Items.Assign(AList);

  finally
   if Assigned(AList) then AList.Free;
  end;
end;


procedure TFrmWizardNovoUsuario.ShowResume;
begin
 with MmoResumo.Lines do
  begin
    Clear;
    Append(TSecurityConst.UserName + ': ' + CdsUsuario.Fields.FieldByName('nomcad').AsString);
    Append(TSecurityConst.Login + ': ' + CdsUsuario.Fields.FieldByName('logusu').AsString);
    Append(TSecurityConst.RoleName + ': ' + CdsUsuario.Fields.FieldByName('rolename').AsString);
  end;
end;

procedure TFrmWizardNovoUsuario.SpeedButton1Click(Sender: TObject);
begin
  inherited;
  CdsFocos.Insert;
end;

procedure TFrmWizardNovoUsuario.SpeedButton2Click(Sender: TObject);
begin
  inherited;
  if CdsFocos.IsEmpty then
   Exit;

  if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.Users, TCosmosConfMsg.DelFocoUser) = mrYes  then
   CdsFocos.Delete;
end;

procedure TFrmWizardNovoUsuario.WzCosmosBeforeNextPage(Sender: TObject;
  CurrentPage: Integer);
begin
  inherited;
  case CurrentPage of
   1:
     begin
      if (CdsUsuario.Fields.FieldByName('nomcad').IsNull) or
       (CdsUsuario.Fields.FieldByName('logusu').IsNull) or
       (Trim(CdsUsuario.Fields.FieldByName('logusu').AsString) = '') or
       (CdsUsuario.Fields.FieldByName('passwrd').IsNull) or
       (Trim(CdsUsuario.Fields.FieldByName('passwrd').AsString) = '') then
        begin
         ICosmosApp.DlgMessage.InfoMessage(TCosmosTitles.Users, TCosmosWarningMsg.WzNovoUsuarioStep1);
         Abort;
        end;

      if (CdsUsuario.Fields.FieldByName('rolename').AsString = '') then
       begin
        ICosmosApp.DlgMessage.InfoMessage(TCosmosTitles.Permissoes, TCosmosErrorMsg.IncorrectRoleName);
        Abort;
       end;

      if (CdsUsuario.Fields.FieldByName('passwrd').AsString <> self.EdtConfirmPass.Text) then
       begin
        ICosmosApp.DlgMessage.InfoMessage(TCosmosTitles.Users, TCosmosErrorMsg.PasswordNotConfirmed);
        Abort;
       end;
     end;
   2: ShowResume;
  end;
end;

initialization
 RegisterClass(TFrmWizardNovoUsuario);

finalization
 UnRegisterClass(TFrmWizardNovoUsuario);


end.
