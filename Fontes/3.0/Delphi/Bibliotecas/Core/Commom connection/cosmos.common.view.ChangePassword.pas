unit cosmos.common.view.ChangePassword;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, cosmos.system.messages,
  Cosmos.Framework.Interfaces.Root, Vcl.ExtCtrls, cosmos.system.winshell;

type
  TOperation = (opChangePassword, opIdenticacaoAtiva);

  TFrmChangePassword = class(TForm)
    EdtUserName: TEdit;
    EdtConfirm: TEdit;
    EdtNewPassword: TEdit;
    Label1: TLabel;
    LblPassword: TLabel;
    LblConfirm: TLabel;
    BtnConfirm: TButton;
    Button2: TButton;
    Image1: TImage;
    procedure BtnConfirmClick(Sender: TObject);
    procedure EdtNewPasswordKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FCurrentPassword: string;
    FOperation: TOperation;
    FICosmosApp: ICosmosApplication;
    function GetNewPassword: string;

  public
    { Public declarations }
    function DoIdentificacaoAtiva(const UserName: string): boolean;
    function ShowDialogs(const UserName, CurrentPassword: string): boolean;

    property CurrentPassword: string read FCurrentPassword;
    property NewPassword: string read GetNewPassword;

    property ICosmosApp: ICosmosApplication read FICosmosApp;
    property Operation: TOperation read FOperation;
  end;

var
  FrmChangePassword: TFrmChangePassword;

implementation

{$R *.dfm}

{ TFrmChangePassword }

procedure TFrmChangePassword.BtnConfirmClick(Sender: TObject);
begin
 if Operation = opChangePassword then
  begin
     if (CurrentPassword <> '') and (CurrentPassword = EdtNewPassword.Text) then
      begin
        ICosmosApp.DlgMessage.InfoMessage(TCosmosTitles.Users, TCosmosErrorMsg.IncorrectNewPassword);
        EdtNewPassword.SetFocus;
        Abort;
      end;

     if (EdtNewPassword.Text = EdtConfirm.Text) then
      ModalResult := mrOk
     else
      ICosmosApp.DlgMessage.InfoMessage(TCosmosTitles.Users, TCosmosErrorMsg.UnConfirmedNewPassword);
  end
  else
   begin
     if Trim(EdtNewPassword.Text) <> '' then
      ModalResult := mrOk
   end;
end;

function TFrmChangePassword.DoIdentificacaoAtiva(
  const UserName: string): boolean;
begin
 FOperation := opIdenticacaoAtiva;
 Caption := TCosmosTitles.IdentificaoAtiva;
 LblConfirm.Visible := False;
 EdtUserName.Text := UserName;
 EdtConfirm.Visible := False;

 Result :=  FrmChangePassword.ShowModal = mrOk;
end;

procedure TFrmChangePassword.EdtNewPasswordKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 case Operation of
   opChangePassword: BtnConfirm.Enabled := (Trim(EdtNewPassword.Text) <> '') and (Trim(EdtConfirm.Text) <> '');
   opIdenticacaoAtiva: BtnConfirm.Enabled := (Trim(EdtNewPassword.Text) <> '');
 end;
end;

procedure TFrmChangePassword.FormCreate(Sender: TObject);
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;

 if  TWinShell.GetOperatingSystem = cOsVista then //Windows Vista em diante
  begin
   EdtNewPassword.Font.Name := 'Wingdings'; //do not localize!
   EdtNewPassword.PasswordChar := 'l'; //do not localize!
   EdtConfirm.Font.Name := 'Wingdings'; //do not localize!
   EdtConfirm.PasswordChar := 'l'; //do not localize!
  end
 else //Windowx XP
  begin
   EdtNewPassword.PasswordChar := '*'; //do not localize!
   EdtConfirm.PasswordChar := '*'; //do not localize!
  end;
end;

function TFrmChangePassword.GetNewPassword: string;
begin
 Result := EdtNewPassword.Text;
end;

function TFrmChangePassword.ShowDialogs(const UserName, CurrentPassword: string): boolean;
begin
 FOperation := opChangePassword;
 EdtUserName.Text := UserName;
 FCurrentPassword := CurrentPassword;
 Result :=  FrmChangePassword.ShowModal = mrOk;
end;

end.
