unit cosmos.usuarios.view.FormUserRoles;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Cosmos.Framework.Interfaces.DataAcess, ActnList, ImgList,
  Buttons, ExtCtrls, cosmos.Framework.Interfaces.Root, cosmos.classes.application,
  System.Actions, Data.DBXCommon, cosmos.usuarios.clientconnections;

type
  TFrmUsersRoles = class(TForm)
    Label1: TLabel;
    EdtUser: TEdit;
    LstRoles: TListBox;
    LstUserRoles: TListBox;
    Label2: TLabel;
    Label3: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    ActionList1: TActionList;
    ImageList1: TImageList;
    ActLeft: TAction;
    ActRight: TAction;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Bevel1: TBevel;
    procedure ActRightUpdate(Sender: TObject);
    procedure ActLeftUpdate(Sender: TObject);
    procedure ActRightExecute(Sender: TObject);
    procedure ActLeftExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FICosmosApp: ICosmosApplication;
    procedure MoveItem(Source, Target: TListBox);
    function GetAddedRoles: string;

  public
    { Public declarations }
    function ListUserRoles(const UserName, Login: string): TModalResult;

    property AddedRoles: string read GetAddedRoles;
    property ICosmosApp: ICosmosApplication read FICosmosApp;
  end;

var
  FrmUsersRoles: TFrmUsersRoles;

implementation

{$R *.dfm}

procedure TFrmUsersRoles.ActLeftExecute(Sender: TObject);
begin
 self.MoveItem(LstUserRoles, LstRoles);
end;

procedure TFrmUsersRoles.ActLeftUpdate(Sender: TObject);
begin
TAction(Sender).Enabled := True;//LstRoles.SelCount > 0;
end;

procedure TFrmUsersRoles.ActRightExecute(Sender: TObject);
begin
 self.MoveItem(LstRoles, LstUserRoles);
end;

procedure TFrmUsersRoles.ActRightUpdate(Sender: TObject);
begin
TAction(Sender).Enabled := True;//LstUserRoles.SelCount > 0;
end;

procedure TFrmUsersRoles.FormCreate(Sender: TObject);
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;
end;

function TFrmUsersRoles.GetAddedRoles: string;
begin
 Result := LstUserRoles.Items.CommaText;
end;

function TFrmUsersRoles.ListUserRoles(const UserName, Login: string): TModalResult;
var
ACommand: TDBXCommand;
AList: TStringList;
I, RoleIndex: integer;
sRole: string;
begin
 ACommand := ICosmosApp.IRemoteCon.CreateCommand;
 AList := TStringList.Create;

 try
  //Lista todas as roles disponibilizadas pelo Cosmos.
  DMCon.ListCosmosRoles(AList);
  LstRoles.Items.Assign(AList);

  AList.Clear;
  ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
  ACommand.Text := 'TDMUserMethods.GetUserRoles'; //do not localize!
  ACommand.Prepare;

  ACommand.Parameters[0].Value.SetWideString(Login);
  ACommand.ExecuteUpdate;

  AList.CommaText := ACommand.Parameters[1].Value.GetWideString;
  LstUserRoles.Items.Assign(AList);

  //Exclui as roles já atribuídas ao usuário da lista das roles disponíveis.
  for I := 0 to LstUserRoles.Items.Count - 1 do
    begin
     sRole := LstUserRoles.Items.Strings[I];
     RoleIndex := LstRoles.Items.IndexOf(sRole);
     if RoleIndex >= 0 then
      LstRoles.Items.Delete(RoleIndex);
    end;

  EdtUser.Text := UserName;
  Result := self.ShowModal;


 finally
  if Assigned(AList) then FreeAndNil(AList);
  if Assigned(ACommand) then FreeAndNil(ACommand);
 end;
end;

procedure TFrmUsersRoles.MoveItem(Source, Target: TListBox);
var
sRole: string;
begin
 if Source.ItemIndex >= 0 then
  begin
   sRole := Source.Items.Strings[Source.ItemIndex];
   if Target.Items.IndexOf(sRole) < 0 then
     Source.MoveSelection(Target);
  end;
end;

end.
