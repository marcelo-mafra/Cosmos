unit cosmos.servers.focos.mainform;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ImgList, Datasnap.DSSession,
  Datasnap.DSCommonServer, Data.DBXCommon, Vcl.Menus, Vcl.ExtCtrls;

type
  TFrmFocosMainForm = class(TForm)
    LsvInfo: TListView;
    Label1: TLabel;
    LblPorta: TLabel;
    Label2: TLabel;
    LblServer: TLabel;
    Label3: TLabel;
    LblRunOn: TLabel;
    ImageList1: TImageList;
    Label4: TLabel;
    LblProtocol: TLabel;
    Label5: TLabel;
    LblSelectedIp: TLabel;
    ServerTrayIcon: TTrayIcon;
    PopMnTrayIcon: TPopupMenu;
    ExibirInformaes1: TMenuItem;
    N1: TMenuItem;
    Encerrar1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure LsvInfoSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure Encerrar1Click(Sender: TObject);
    procedure ServerTrayIconDblClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    function FindSessionRecord(const Session: string): TListItem; inline;

    procedure NotifyConnectServer(DSConnectEventObject: TDSConnectEventObject);
    procedure NotifyDisconnectServer(DSConnectEventObject: TDSConnectEventObject);
    procedure NotifyUserActivity(Session: TDSSession);

  public
    { Public declarations }

  end;

var
  FrmFocosMainForm: TFrmFocosMainForm;

implementation

{$R *.dfm}

uses cosmos.servers.focos.appcontainer;

{ TFrmSecretariasMainForm }

procedure TFrmFocosMainForm.Encerrar1Click(Sender: TObject);
begin
 Application.Terminate;
end;

function TFrmFocosMainForm.FindSessionRecord(
  const Session: string): TListItem;
begin
//Encontra um item da lista que representa uma seção de um usuário.
 Result := LsvInfo.FindCaption(0, Session, False, True, False);
end;

procedure TFrmFocosMainForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
 CanClose := False;
 self.Hide;
end;

procedure TFrmFocosMainForm.FormCreate(Sender: TObject);
begin
 DMConferenciasAppContainer.OnPrepareCommand := NotifyUserActivity;
 DMConferenciasAppContainer.OnConnectServer := NotifyConnectServer;
 DMConferenciasAppContainer.OnDisconnectServer := NotifyDisconnectServer;

 ServerTrayIcon.Icon.Assign(Application.Icon);
 ServerTrayIcon.Hint := Application.Title;
 Caption := Application.Title;
 ServerTrayIcon.Visible := True;
end;

procedure TFrmFocosMainForm.FormShow(Sender: TObject);
var
 AList: TStringList;
begin
 AList := TSTringList.Create;

 try
  DMConferenciasAppContainer.GetServerConfigurations(AList);
  LblServer.Caption := AList.Values['Servidor'];
  LblProtocol.Caption := AList.Values['Protocolo'];
  LblPorta.Caption := AList.Values['Porta'];
  LblRunOn.Caption := AList.Values['RunOn'];

 finally
  AList.Free;
 end;
end;

procedure TFrmFocosMainForm.LsvInfoSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
 if Item <> nil then
  LblSelectedIp.Caption := Item.SubItems.Strings[4]
 else
  LblSelectedIp.Caption := '-';
end;

procedure TFrmFocosMainForm.NotifyConnectServer(
  DSConnectEventObject: TDSConnectEventObject);
var
 AItem: TListItem;
begin
 {Registra na lista uma nova conexão feita por um usuário.}
 AItem := LsvInfo.Items.Add;
 Aitem.ImageIndex := 0;
 AItem.Caption := TDSSessionManager.GetThreadSession.Id.ToString;
 Aitem.SubItems.Clear;

 with DSConnectEventObject do
  begin
   AItem.SubItems.Append(ConnectProperties[TDBXPropertyNames.DSAuthenticationUser]);  //usuário.
   AItem.SubItems.Append(FormatDateTime('dd/mm/yyyy hh:nn:ss:zzz', Now)); //Hora exata da conexão
   AItem.SubItems.Append(ConnectProperties[TDBXPropertyNames.CommunicationProtocol]); //Protocolo de comunicação usado.
   AItem.SubItems.Append(FormatDateTime('dd/mm/yyyy hh:nn:ss:zzz', Now)); //Hora exata da última atividade
   AItem.SubItems.Append(ChannelInfo.ClientInfo.IpAddress); //Ip do cliente.
  end;
end;

procedure TFrmFocosMainForm.NotifyDisconnectServer(
  DSConnectEventObject: TDSConnectEventObject);
var
 AItem: TListItem;
begin
{Exclui da lista uma seção encerrada por um usuário.}
 AItem := FindSessionRecord(TDSSessionManager.GetThreadSession.Id.ToString);
 if (AItem <> nil) then
   LsvInfo.Items.Delete(AItem.Index);
end;

procedure TFrmFocosMainForm.NotifyUserActivity(Session: TDSSession);
var
 AItem: TListItem;
 sNow: string;
begin
 {Atualiza a lista na coluna "Última atividade", para indicar que o usuário
 continua utilizando o sistema.}
 sNow := FormatDateTime('dd/mm/yyyy hh:nn:ss:zzz', Now);
 AItem := FindSessionRecord(Session.Id.ToString);

// outputdebugstring(PWideChar(TDSSessionManager.GetThreadSession.Id.ToString));
// outputdebugstring(PWideChar(Session.Id.ToString));

 if (AItem <> nil) then
  AItem.SubItems.Strings[3] := sNow;
end;



procedure TFrmFocosMainForm.ServerTrayIconDblClick(Sender: TObject);
begin
 Show;
end;

end.

