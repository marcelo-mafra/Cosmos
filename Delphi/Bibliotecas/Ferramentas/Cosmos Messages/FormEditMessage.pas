unit FormEditMessage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, GroupHeader, Vcl.StdCtrls, Vcl.ComCtrls, DBClient,
  cosmos.framework.forms.customdialog, cosmos.core.classes, cosmos.core.SQLServerInterface,
  cosmos.framework.interfaces.root, Vcl.ActnList;

type
  TFrmEditMessage = class(TFrmCustomDialog)
    MSGroupHeader1: TMSGroupHeader;
    MSGroupHeader2: TMSGroupHeader;
    MmoBody: TMemo;
    LsvDestinatarios: TListView;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    CbxAssunto: TComboBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    ActionList1: TActionList;
    ActInsert: TAction;
    ActSave: TAction;
    ActClose: TAction;
    procedure FormCreate(Sender: TObject);
    procedure ActCloseExecute(Sender: TObject);
  private
    { Private declarations }
    function GetICosmosApp: ICosmosApplication;
    procedure ListarUsuarios;

  public
    { Public declarations }
    property ICosmosApp: ICosmosApplication read GetICosmosApp;
  end;

var
  FrmEditMessage: TFrmEditMessage;

implementation

{$R *.dfm}

{ TFrmEditMessage }

procedure TFrmEditMessage.ActCloseExecute(Sender: TObject);
begin
 Close;
end;

procedure TFrmEditMessage.FormCreate(Sender: TObject);
begin
  inherited;
  Tag := 100;
  ListarUsuarios;
end;

function TFrmEditMessage.GetICosmosApp: ICosmosApplication;
begin
 Result := Application.MainForm as ICosmosApplication;
end;

procedure TFrmEditMessage.ListarUsuarios;
var
 AItem: TListItem;
 CdsUsers: TClientDataset;
 AReturn: TServerReturn;
begin
 AReturn := TServerReturn.Create;
 Cdsusers := TClientDataset.Create(nil);

 LsvDestinatarios.Clear;

 try
  AReturn.ReadServerReturn(ICosmosApp.IRemoteCon.ConnectionBroker.AppServer.ExecuteDQL(csCosmosUsers, null));
  if AReturn.MessageType = mtpSucess then
   begin
    CdsUsers.Data := AReturn.ServerData;

    while not CdsUsers.Eof do
     begin
      AItem := LsvDestinatarios.Items.Add;
      AItem.Caption := CdsUsers.FieldValues['nomcad'];
      AItem.SubItems.Append(CdsUsers.FieldValues['sigfoc']);
      AItem.SubItems.Append(CdsUsers.FieldValues['codcad']);
      CdsUsers.Next;
     end;
   end
  else
   ICosmosApp.DlgMessage.ErrorMessage(AReturn.MessageTitle, AReturn.MessageText);

 finally
  if Assigned(CdsUsers) then
   FreeAndNil(CdsUsers);
 end;
end;

end.
