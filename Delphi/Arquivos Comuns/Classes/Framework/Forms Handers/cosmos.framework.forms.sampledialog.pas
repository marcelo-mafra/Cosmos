unit cosmos.framework.forms.sampledialog;

interface

uses
  Winapi.Windows, System.SysUtils, Vcl.Dialogs, System.Classes, Vcl.Forms,
  Vcl.StdCtrls, cosmos.system.messages;


function MyMessageDlg(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; Title: string; Captions: array of string): Integer;

type

 TSampleDialog = class
  class function ErrorMessage(const Msg: string): Integer; overload;
  class function ErrorMessageWithHelp(const Msg: string): Integer;
  class function ConfirmMessage(const Msg: string): Integer;
  class function InfoMessage(const Msg: string): Integer; overload;
  class function WarningMessage(const Msg: string): Integer;
  class function CustomMessage(const Msg: string; DlgType: TMsgDlgType;
    Buttons: TMsgDlgButtons; Title: string; Captions: array of string): Integer;

 end;


implementation

function MyMessageDlg(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; Title: string; Captions: array of string): Integer;
var
  aMsgDlg: TForm;
  i: Integer;
  dlgButton: TButton;
  CaptionIndex: Integer;
begin
  { Cria a caixa de diálogo }

  aMsgDlg := CreateMessageDialog(Msg, DlgType, Buttons);
  aMsgDlg.Caption := Title;
  captionIndex := 0;
  { Loop nos objetos da caixa de diálogo }

  for i := 0 to aMsgDlg.ComponentCount - 1 do
  begin
   { Se o objeto é um TButton, então }

    if (aMsgDlg.Components[i] is TButton) then
    begin
      dlgButton := TButton(aMsgDlg.Components[i]);
      if CaptionIndex > High(Captions) then Break;
      { Dá um novo caption a partir do array de captions}

      dlgButton.Caption := Captions[CaptionIndex];
      Inc(CaptionIndex);
    end;
  end;
  Result := aMsgDlg.ShowModal;
  if aMsgDlg <> nil then
   aMsgDlg.Free;
end;


{ TMyDialogs }

class function TSampleDialog.ConfirmMessage(const Msg: string): Integer;
begin
 Result := MyMessageDlg(Msg,mtConfirmation,[mbYes,mbNo],TMessagesConst.TitleConf,[TMessagesConst.BtYes,TMessagesConst.BtNo]);
end;

class function TSampleDialog.CustomMessage(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; Title: string; Captions: array of string): Integer;
var
  aMsgDlg: TForm;
  i: Integer;
  dlgButton: TButton;
  CaptionIndex: Integer;
begin
  { Cria a caixa de diálogo }

  aMsgDlg := CreateMessageDialog(Msg, DlgType, Buttons);
  aMsgDlg.Caption := Title;
  captionIndex := 0;
  { Loop nos objetos da caixa de diálogo }

  for i := 0 to aMsgDlg.ComponentCount - 1 do
  begin
   { Se o objeto é um TButton, então }

    if (aMsgDlg.Components[i] is TButton) then
    begin
      dlgButton := TButton(aMsgDlg.Components[i]);
      if CaptionIndex > High(Captions) then Break;
      { Dá um novo caption a partir do array de captions}

      dlgButton.Caption := Captions[CaptionIndex];
      Inc(CaptionIndex);
    end;
  end;
  Result := aMsgDlg.ShowModal;

end;

class function TSampleDialog.ErrorMessage(const Msg: string): Integer;
begin
 Result := MyMessageDlg(Msg,mtError,[mbOk],TMessagesConst.TitleError,[TMessagesConst.BtOK]);
end;

class function TSampleDialog.ErrorMessageWithHelp(const Msg: string): Integer;
begin
 Result := MyMessageDlg(Msg,mtError,[mbOk, mbHelp],TMessagesConst.TitleError,[TMessagesConst.BtOK, TMessagesConst.BtHelp]);
end;

class function TSampleDialog.InfoMessage(const Msg: string): Integer;
begin
 Result := MyMessageDlg(Msg,mtInformation,[mbOk],TMessagesConst.TitleInfo,[TMessagesConst.BtOK]);
end;

class function TSampleDialog.WarningMessage(const Msg: string): Integer;
begin
 Result := MyMessageDlg(Msg,mtWarning,[mbOk],TMessagesConst.TitleWarn,[TMessagesConst.BtOK]);
end;

end.


