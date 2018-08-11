unit cosmos.common.view.LoginForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Cosmos.Framework.Interfaces.Dialogs, cosmos.system.messages;

type
  TFrmLogin = class(TForm, ICosmosLogin)
    Bevel1: TBevel;
    BtnConnect: TButton;
    Button2: TButton;
    EdtName: TEdit;
    EdtPassword: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
    procedure EdtPasswordChange(Sender: TObject);
    procedure EdtPasswordKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    FXPStyle: boolean;
    { Private declarations }
   function GetXPStyle: boolean;
   procedure SetXPStyle(value: boolean);

  public
    { Public declarations }
   function Login(var UserName, Password: string): boolean;
   function LoginDefaultRole(var UserName, Password: string; const RoleName: string): boolean;
   function LoginDefaultUser(var Password: string; const UserName, RoleName: string): boolean;
   property XPStyle: boolean read GetXPStyle write SetXPStyle;
  end;

var
  FrmLogin: TFrmLogin;

implementation


{$R *.DFM}

procedure TFrmLogin.EdtPasswordKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if Key = 13 then
  if BtnConnect.Enabled then
   BtnConnect.Click;
end;

procedure TFrmLogin.FormCreate(Sender: TObject);
begin
 FXPStyle := False;
end;

procedure TFrmLogin.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if Key = VK_ESCAPE then
  ModalResult := mrCancel;
end;

procedure TFrmLogin.FormShow(Sender: TObject);
begin
 EdtName.SetFocus;
end;

function TFrmLogin.GetXPStyle: boolean;
begin
 Result := FXPStyle;
end;

procedure TFrmLogin.EdtPasswordChange(Sender: TObject);
begin
 BtnConnect.Enabled := (EdtName.Text <> '') and (EdtPassword.Text <> '');
end;

function TFrmLogin.Login(var UserName, Password: string): boolean;
begin
   Result := False;
   EdtName.Text := UserName;
   EdtPassword.Text := Password;

   if ShowModal = mrOK then
    begin
     Result := True;
     UserName := EdtName.Text;
     Password := EdtPassword.Text;
    end;
end;

function TFrmLogin.LoginDefaultRole(var UserName, Password: string;
  const RoleName: string): boolean;
begin
 Result := False;
 EdtName.Text := UserName;
 EdtPassword.Text := Password;

 if ShowModal = mrOK then
  begin
   Result := True;
   UserName := EdtName.Text;
   Password := EdtPassword.Text;
  end;
end;

function TFrmLogin.LoginDefaultUser(var Password: string; const UserName,
  RoleName: string): boolean;
begin
 Result := False;
 EdtName.Text := UserName;
 EdtName.Enabled := False;
 EdtPassword.Text := Password;

 if ShowModal = mrOK then
  begin
   Result := True;
   Password := EdtPassword.Text;
  end;
end;

procedure TFrmLogin.SetXPStyle(value: boolean);
begin
 FXPStyle := Value;

 if FXPStyle = False then //Windows Vista em diante
  begin
   EdtPassword.Font.Name := 'Wingdings';
   EdtPassword.PasswordChar := 'l';
  end
 else //Windowx XP
  begin
   EdtPassword.Font.Name := EdtName.Font.Name;
   EdtPassword.PasswordChar := '*';
  end;
end;

initialization
 RegisterClass(TFrmLogin);

finalization
 UnRegisterClass(TFrmLogin);
end.
