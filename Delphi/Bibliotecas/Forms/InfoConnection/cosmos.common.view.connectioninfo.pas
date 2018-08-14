unit cosmos.common.view.connectioninfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, GroupHeader, Cosmos.Framework.Interfaces.Root,
  Cosmos.Framework.Interfaces.Dialogs, Cosmos.Framework.Interfaces.DataAcess,
  Cosmos.system.messages,cosmos.classes.application, cosmos.classes.security,
  cosmos.system.types, cosmos.system.files, cosmos.core.client.connection,
  cosmos.system.winshell, cosmos.system.nettypes;

type
  TFrmInfoConnection = class(TForm, ICosmosConnectionInfo)
    MSGroupHeader1: TMSGroupHeader;
    MSGroupHeader2: TMSGroupHeader;
    Button1: TButton;
    Button2: TButton;
    Image1: TImage;
    Image2: TImage;
    LblUserName: TLabel;
    Label1: TLabel;
    LblMatricula: TLabel;
    Label4: TLabel;
    LblFoco: TLabel;
    Label6: TLabel;
    LblConnectionId: TLabel;
    Label8: TLabel;
    LblStartTime: TLabel;
    Label12: TLabel;
    LblServerName: TLabel;
    LblServerHost: TLabel;
    Label17: TLabel;
    Bevel1: TBevel;
    Label2: TLabel;
    LblProtocol: TLabel;
    LblDisc: TLabel;
    Label5: TLabel;
    Label3: TLabel;
    LblUserType: TLabel;
    Label7: TLabel;
    LblConnectionMode: TLabel;
    Label10: TLabel;
    LsbPerfis: TListBox;
    LblCertificado: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LblCertificadoClick(Sender: TObject);
  private
    { Private declarations }
    FICosmosApp: ICosmosApplication;
    procedure DoServerAddressClick(Sender: TObject);

  public
    { Public declarations }
    procedure ShowConnectionInfo;
    property ICosmosApp: ICosmosApplication read FICosmosApp;
  end;

var
  FrmInfoConnection: TFrmInfoConnection;

implementation

{$R *.dfm}

uses cosmos.common.view.certificatedata;

{ TFrmInfoConnection }

procedure TFrmInfoConnection.Button2Click(Sender: TObject);
begin
 if Self.HelpContext <> 0 then
  Application.HelpSystem.ShowContextHelp(Self.HelpContext, Application.CurrentHelpFile);
end;

procedure TFrmInfoConnection.DoServerAddressClick(Sender: TObject);
begin
 //Acessa a url do servidor pelo navegador padrão.
 TWinShell.BrowseToURL(LblServerHost.Caption);
end;

procedure TFrmInfoConnection.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 if Assigned(FICosmosApp) then
  FICosmosApp := nil;
end;

procedure TFrmInfoConnection.FormCreate(Sender: TObject);
begin
  FICosmosApp := Application.MainForm as ICosmosApplication;
end;

procedure TFrmInfoConnection.LblCertificadoClick(Sender: TObject);
begin
 FrmCertificateData := TFrmCertificateData.Create(self);

 try
   FrmCertificateData.ShowModal;

 finally
   FreeAndNil(FrmCertificateData);
 end;
end;

procedure TFrmInfoConnection.ShowConnectionInfo;
begin
{Lista informações do usuário conectado e da seção corrente com a aplicação
servidora do Cosmos.}

  with ICosmosApp do
    begin
      //Nome da aplicação Cosmos.
      LblServerName.Caption := CosmosModuleName;
      //Protocolo de conexão.
      case IRemoteCon.ConnectionProtocol of
       cpTCP: LblProtocol.Caption := TConnectionsConst.TCP;
       cpHTTP:
        begin
         LblProtocol.Caption := TConnectionsConst.HTTP;
         LblServerHost.Cursor := crHandPoint;
         LblServerHost.Font.Style := [fsUnderline];
         LblServerHost.Font.Color := clHotLight;
         LblServerHost.OnClick := DoServerAddressClick;
        end;
       cpHTTPS:
        begin
         LblProtocol.Caption := TConnectionsConst.HTTPS;
         LblServerHost.Cursor := crHandPoint;
         LblServerHost.Font.Style := [fsUnderline];
         LblServerHost.Font.Color := clHotLight;
         LblServerHost.OnClick := DoServerAddressClick;
         LblCertificado.Enabled := True;
        end;
      end;

      //Modo de acesso ao foco (escrita/leitura).
      case IRemoteCon.CurrentConnectionMode of
        cmWrite: LblConnectionMode.Caption := TSecurityConst.WriteRight;
        cmRead: LblConnectionMode.Caption := TSecurityConst.ReadRight;
      end;
      //Id da seção com o servidor.
      LblConnectionId.Caption := IRemoteCon.CurrentConnectionInfo.CurrentSection.ConnectionID;
      //Nome do usuário
      LblUserName.Caption := IRemoteCon.CurrentUser.UserName;
      //Matrícula do usuário.
      LblMatricula.Caption := IRemoteCon.CurrentUser.Matricula;
      //Grupo de acesso.
      LsbPerfis.Items.CommaText := IRemoteCon.CurrentConnectionInfo.CurrentUser.Group;
      //Data e hora da conexão com o sevidor.
      LblStartTime.Caption := DateTimeToStr(IRemoteCon.CurrentConnectionInfo.CurrentSection.ConnectionTime);
      //Discipulado do usuário.
      LblDisc.Caption := IRemoteCon.CurrentConnectionInfo.CurrentUser.Discipulado;
      //Foco do usuário.
      LblFoco.Caption := IRemoteCon.CurrentConnectionInfo.CurrentUser.Foco;
      //Nome, url ou Ip do servidor conectado.
      LblServerHost.Caption := IRemoteCon.ConnectedServer;
      //Tipo do usuário.
      if IRemoteCon.CurrentUser.Administrator then
       LblUserType.Caption := TSecurityConst.AdministratorUser
      else
       LblUserType.Caption := TSecurityConst.NormalUser;
    end;

  ShowModal;
end;

initialization
 RegisterClass(TFrmInfoConnection);

finalization
 UnRegisterClass(TFrmInfoConnection);


end.
