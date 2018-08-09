unit Cosmos.Common.View.TipsForm;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms,
  StdCtrls, IniFiles, ExtCtrls, Cosmos.Framework.Interfaces.Dialogs;

type
  TFrmTips = class(TForm, ICosmosTips)
    ChkStartTips: TCheckBox;
    Button1: TButton;
    Button2: TButton;
    Shape1: TShape;
    Shape2: TShape;
    Bevel1: TBevel;
    Label1: TLabel;
    LblTip: TLabel;
    Image1: TImage;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    TipList : TStringList;
    FCurrent: integer;
    procedure SetTip;

  protected
   function ShowTips(FileName: string): boolean;

  public
    { Public declarations }
   property Current: integer read FCurrent write FCurrent;

  end;

implementation


{$R *.dfm}

{ TFrmTips }

procedure TFrmTips.Button2Click(Sender: TObject);
begin
 Close;
end;

procedure TFrmTips.SetTip;
begin
 current := current + 1;
 if current > Pred(TipList.Count) then
  Current := 0;

 LblTip.Caption := TipList.ValueFromIndex[current];
end;

function TFrmTips.ShowTips(FileName: string): boolean;
var
 NewTip: string;
 Ini: TIniFile;
begin
 Ini := TiniFile.Create(FileName);

 try
  Current := Ini.ReadInteger('current','current_tip',0);

  TipList := TStringList.Create;
  Ini.ReadSectionValues('tips', TipList);

  if Current < 0 then
   Current := 0;
  if Current >= TipList.Count then
   Current := 0;
  try
   NewTip := TipList.ValueFromIndex[Current];

  except
   begin
    Current := 0;
    NewTip := '';
   end;
  end;

  if NewTip <> '' then
   begin
    LblTip.Caption := NewTip;
    ShowModal;
   end;

  Result := ChkStartTips.Checked;

 finally
  Inc(FCurrent);
  if Assigned(Ini) then
   begin
    Ini.WriteInteger('current','current_tip',Current);
    Ini.Free;
   end;
 end;
end;

procedure TFrmTips.Button1Click(Sender: TObject);
begin
 SetTip;
end;

initialization
 RegisterClass(TFrmTips);

finalization
 UnregisterClass(TFrmTips); 

end.
