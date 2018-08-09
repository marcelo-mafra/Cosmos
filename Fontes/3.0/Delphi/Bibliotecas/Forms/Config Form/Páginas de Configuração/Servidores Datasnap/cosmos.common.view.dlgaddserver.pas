unit cosmos.common.view.dlgaddserver;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Buttons, Winapi.ActiveX, Cosmos.classes.application, GroupHeader,
  cosmos.system.types, Cosmos.Framework.Interfaces.Root, cosmos.system.messages,
  cosmos.core.client.connection, Vcl.ComCtrls, System.TypInfo, System.UITypes,
  cosmos.system.winshell;

type
  TFrmAddServer = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    EdtConnectionName: TLabeledEdit;
    GrpProtocolos: TMSGroupHeader;
    RdbSocket: TRadioButton;
    RdbHTTP: TRadioButton;
    Image1: TImage;
    CBXStatus: TComboBox;
    Label1: TLabel;
    PageOptions: TPageControl;
    TabTCP: TTabSheet;
    TabHTTP: TTabSheet;
    GrpTCP: TMSGroupHeader;
    EdtSocketServer: TLabeledEdit;
    EdtSocketPort: TLabeledEdit;
    GrpHTTPS: TMSGroupHeader;
    EdtWebAgent: TLabeledEdit;
    EdtWebUrl: TLabeledEdit;
    MSGroupHeader1: TMSGroupHeader;
    EdtSocketProxy: TLabeledEdit;
    EdtSocketProxyPort: TLabeledEdit;
    MSGroupHeader2: TMSGroupHeader;
    EdtTCPConnectTimeout: TLabeledEdit;
    EdtTCPDataTimeout: TLabeledEdit;
    EdtProxyUserName: TLabeledEdit;
    EdtProxyPass: TLabeledEdit;
    MSGroupHeader3: TMSGroupHeader;
    EdtBufferSize: TComboBox;
    Label2: TLabel;
    MSGroupHeader4: TMSGroupHeader;
    RdbNotify: TRadioButton;
    RdbNoNotify: TRadioButton;
    RdbLogOnly: TRadioButton;
    MSGroupHeader5: TMSGroupHeader;
    EdtWebProxy: TLabeledEdit;
    EdtWebProxyPort: TLabeledEdit;
    EdtWebUserName: TLabeledEdit;
    EdtWebPassword: TLabeledEdit;
    EdtWebProxyByPass: TLabeledEdit;
    MSGroupHeader6: TMSGroupHeader;
    EdtWebConnectTimeout: TLabeledEdit;
    EdtWebDataTimeout: TLabeledEdit;
    EdtWebPort: TLabeledEdit;
    EdtWebDatasnapContext: TLabeledEdit;
    procedure EdtSocketPortKeyPress(Sender: TObject; var Key: Char);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure RdbSocketClick(Sender: TObject);
  private
    { Private declarations }
    procedure DoMarkControl(Control: TControl; Color: TColor = clInfoBk); inline;
    procedure FillConnectionData(var Connection: TClientConnectionInfo);
    function HasValue(Control: TControl): boolean;
    function ValidateFields: boolean;

  public
    { Public declarations }
    function AddConnection: TClientConnectionInfo;
    function EditConnection(var Connection: TClientConnectionInfo): boolean;
  end;

var
  FrmAddServer: TFrmAddServer;

implementation



{$R *.dfm}

function TFrmAddServer.AddConnection: TClientConnectionInfo;
begin
 Result := nil;
 CBXStatus.ItemIndex := 0;
 EdtBufferSize.ItemIndex := 1;

 if self.ShowModal = mrOk then
  begin
   if ValidateFields then
    begin
     Result := TClientConnectionInfo.Create;
     FillConnectionData(Result);
    end;
  end;
end;

procedure TFrmAddServer.DoMarkControl(Control: TControl; Color: TColor);
begin
if IsPublishedProp(Control, 'Color') then
 SetPropValue(Control, 'Color' , Color);
end;

function TFrmAddServer.EditConnection(var Connection: TClientConnectionInfo): boolean;
begin
 Result := False;

 if Connection <> nil then
  begin
   EdtConnectionName.Text := Connection.ConnectionName;
   RdbSocket.Checked := Connection.Protocolo = cpTCP;
   RdbHTTP.Checked := Connection.Protocolo = cpHTTPS;

   case Connection.Protocolo of
     cpTCP:
      begin
       EdtSocketServer.Text := Connection.ServerHost;
       EdtSocketPort.Text := Connection.ServerPort.ToString;
       EdtSocketProxy.Text := Connection.ProxyHost;
       EdtSocketProxyPort.Text := Connection.ProxyPort;
       EdtProxyUserName.Text := Connection.ProxyUsername;
       EdtProxyPass.Text := Connection.ProxyPassword;
       EdtTCPConnectTimeout.Text := Connection.ConnectionTimeout.ToString;
       EdtTCPDataTimeout.Text := Connection.CommunicationTimeout.ToString;
       EdtBufferSize.Text := Connection.BufferKBSize.ToString;
      end;
     cpHTTP, cpHTTPS:
      begin
       EdtWebAgent.Text := Connection.Agent;
       EdtWebURL.Text := Connection.ServerHost;
       EdtWebPort.Text := Connection.ServerPort.ToString;
       EdtWebProxy.Text := Connection.ProxyHost;
       EdtWebProxyByPass.Text := Connection.ProxyByPass;
       EdtWebUserName.Text := Connection.ProxyUserName;
       EdtWebPassword.Text := Connection.ProxyPassword;
       EdtWebConnectTimeout.Text := Connection.ConnectionTimeout.ToString;
       EdtWebDataTimeout.Text := Connection.CommunicationTimeout.ToString;
       EdtWebDatasnapContext.Text := Connection.DatasnapContext;
      end;
   end;

   case Connection.NotifyMode of
     nmNotify: RdbNotify.Checked := True;
     nmNoNotify: RdbNoNotify.Checked := True;
     nmRegisterLog: RdbLogOnly.Checked := True;
   end;


   if Connection.Enabled then
    CBXStatus.ItemIndex := 0
   else
    CBXStatus.ItemIndex := 1;

   if self.ShowModal = mrOk then
    begin
     Result := True;
     FillConnectionData(Connection);
    end;
  end;
end;

procedure TFrmAddServer.FillConnectionData(var Connection: TClientConnectionInfo);
begin
  Connection.ConnectionName := self.EdtConnectionName.Text;
  Connection.Enabled := CBXStatus.ItemIndex = 0;

  if RdbSocket.Checked then
    Connection.Protocolo := cpTCP
  else if RdbHTTP.Checked then
    Connection.Protocolo := cpHTTPS
  else
    Connection.Protocolo := cpTCP; //default

  if RdbNotify.Checked then
    Connection.NotifyMode := nmNotify
  else
  if RdbNoNotify.Checked then
    Connection.NotifyMode := nmNoNotify
  else
  if RdbLogOnly.Checked then
    Connection.NotifyMode := nmRegisterLog;


  case Connection.Protocolo of
    cpTCP:
     begin
      Connection.Agent := ''; //default. Propriedade não usada para tcp.
      Connection.ServerHost := EdtSocketServer.Text;
      Connection.ServerPort := StrToInt(EdtSocketPort.Text);
      Connection.BufferKBSize := StrToInt(EdtBufferSize.Text);

      Connection.ConnectionTimeout := StrToInt(EdtTCPConnectTimeout.Text);
      Connection.CommunicationTimeout := StrToInt(EdtTCPDataTimeout.Text);

      Connection.ProxyHost := EdtSocketProxy.Text;
      Connection.ProxyPort := EdtSocketProxyPort.Text;
      Connection.ProxyByPass := ''; //Propriedade não usada para tcp.
      Connection.ProxyUsername := EdtProxyUserName.Text;
      Connection.ProxyPassword := EdtProxyPass.Text;
     end;
    cpHTTP, cpHTTPS:
     begin
      Connection.Agent := EdtWebAgent.Text;
      Connection.ServerHost := EdtWebURL.Text;
      Connection.ServerPort := StrToInt(EdtWebPort.Text);
      Connection.BufferKBSize := 32; //default. Propriedade não usada para https.

      Connection.ConnectionTimeout := StrToInt(EdtWebConnectTimeout.Text);
      Connection.CommunicationTimeout := StrToInt(EdtWebDataTimeout.Text);

      Connection.ProxyHost := EdtWebProxy.Text;
      Connection.ProxyPort := EdtWebProxyPort.Text;
      Connection.ProxyByPass := EdtWebProxyByPass.Text;
      Connection.ProxyUserName := EdtWebUserName.Text;
      Connection.ProxyPassword := EdtWebPassword.Text;
      Connection.DatasnapContext := EdtWebDatasnapContext.Text;
     end;
  end;
end;

procedure TFrmAddServer.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
 ICosmosApp: ICosmosApplication;
begin
 if ModalResult = mrOk then
  begin
   CanClose := ValidateFields;
   if not CanClose then
    begin
      ICosmosApp := Application.MainForm as ICosmosApplication;
      try
       ICosmosApp.DlgMessage.WarningMessage(TCosmosTitles.Atenttion, TCosmosWarningMsg.IncompletedFields);

      finally
        if Assigned(ICosmosAPp) then ICosmosApp := nil;
      end;
    end;
  end;
end;

procedure TFrmAddServer.FormCreate(Sender: TObject);
var
I: integer;
begin
 for I := 0 to PageOptions.PageCount - 1 do
   PageOptions.Pages[I].TabVisible := False;

 PageOptions.ActivePageIndex := 0;

 if  TWinShell.GetOperatingSystem = cOsVista then //Windows Vista em diante
  begin
   EdtProxyPass.Font.Name := 'Wingdings'; //do not localize!
   EdtProxyPass.PasswordChar := 'l'; //do not localize!
   EdtWebPassword.Font.Name := 'Wingdings'; //do not localize!
   EdtWebPassword.PasswordChar := 'l'; //do not localize!
  end
 else //Windowx XP
  begin
   EdtProxyPass.PasswordChar := '*'; //do not localize!
   EdtWebPassword.PasswordChar := '*'; //do not localize!
  end;
end;

function TFrmAddServer.HasValue(Control: TControl): boolean;
var
 AValue: string;
begin
//Verifica se um controle possui algum valor na sua propriedade "Text".
 if IsPublishedProp(Control, 'Text') then
  begin
   AValue := GetPropValue(Control, 'Text' );
   Result := AValue.Trim <> '';
  end
 else
  Result := True; //assume que possui valor, uma vez que não sabemos ler o dado.

//Caso o controle não possua valor, sinaliza-o para o usuário.
 if not Result then
  DoMarkControl(Control)
 else
  DoMarkControl(Control, clWindow)
end;

procedure TFrmAddServer.RdbSocketClick(Sender: TObject);
begin
 if Sender = RdbSocket then
  PageOptions.ActivePageIndex := 0
 else
 if Sender = RdbHttp then
  PageOptions.ActivePageIndex := 1;
end;

function TFrmAddServer.ValidateFields: boolean;
 var
 I, Y: integer;
 ATab: TTabSheet;
 AWinControl: TWinControl;
begin
{Valida o preenchimento dos campos e destaca os campos requeridos para sinalização
 ao usuário. O convencionado é que os campos com o valor de TAG igual a 1
 são os requeridos.}

 Result := HasValue(EdtConnectionName);

 if RdbSocket.Checked then
  ATab := TabTCP
 else
  ATab := TabHTTP;

 for I := 0 to Pred(ATab.ControlCount) do
  begin
   //Primeiro, varre os controles diretamente inseridos no tabsheet.
   if (ATab.Controls[I].Tag = 1) and not (HasValue(ATab.Controls[I])) then
     Result := False;

   //Agora, varre os controles inseridos em um controle "filho" do tabsheet.
   if ATab.Controls[I] is TWinControl then
    begin
     AWinControl := TWinControl(ATab.Controls[I]);
     for Y := 0 to Pred(AWinControl.ControlCount) do
      begin
       if (AWinControl.Controls[Y].Tag = 1) and not (HasValue(AWinControl.Controls[Y])) then
         Result := False;
      end;
    end;
  end;
end;

procedure TFrmAddServer.EdtSocketPortKeyPress(Sender: TObject; var Key: Char);
begin
if not CharInSet(Key, ['0'.. '9', #8]) then
  Abort;
end;

end.
