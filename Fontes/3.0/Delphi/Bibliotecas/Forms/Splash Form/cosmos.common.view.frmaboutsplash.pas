unit cosmos.common.view.frmaboutsplash;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Cosmos.Framework.Interfaces.Dialogs,
  Vcl.Imaging.pngimage, cosmos.system.types, cosmos.system.messages,
  cosmos.classes.application, System.RTLConsts;

type
  ELoadDLLError = Exception;
  TGetCustomVersionInfo = function (AppPath, AKey: PChar): PChar; stdcall;
  TGetVersionInfo = function (AppPath: PChar): PChar; stdcall;

  TFrmAbout = class(TForm)
    LsvInfo: TListView;
    LblComments: TLabel;
    ImgMainLogo: TImage;
    LblSOInfo: TLabel;
    ImgIcon: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormClick(Sender: TObject);
  private
    { Private declarations }
    FAppName: string;
    procedure ReadVersionInfo;
    function ReadOSInfo: string;

  public
    { Public declarations }
    procedure ShowAppAbout;
  end;


var
  FrmAbout: TFrmAbout;

implementation

{$R *.dfm}

{ TFrmSplash }

procedure TFrmAbout.ShowAppAbout;
begin
 Caption := Application.Title;
 ReadVersionInfo;
 BorderStyle := bsDialog;
 LblComments.Visible := True;
 ShowModal;
end;

procedure TFrmAbout.FormClick(Sender: TObject);
begin
 Close;
end;

procedure TFrmAbout.FormCreate(Sender: TObject);
begin
 self.Icon := Application.Icon;
 FAppName := Application.ExeName;
 ImgIcon.Picture.Assign(Application.Icon);
end;

function TFrmAbout.ReadOSInfo: string;
var
sOSInfo, sOSName, sArchitecture: string;
begin
  //ShowMessage(GetOSVersion(MajorVersion, MinorVersion, Build));

  sOSInfo:= '%s Build: %s %s';

  if ((TOSVersion.Major = 5) and (TOSVersion.Minor = 0)) then
   sOSName := 'Windows 2000'
  else
  if ((TOSVersion.Major = 5) and (TOSVersion.Minor = 1)) then
   sOSName := 'Windows XP'
  else
  if ((TOSVersion.Major = 6) and (TOSVersion.Minor = 0)) then
   sOSName := 'Windows Vista'
  else
  if ((TOSVersion.Major = 6) and (TOSVersion.Minor= 1)) then
   sOSName := 'Windows 7'
  else
  if ((TOSVersion.Major = 6) and (TOSVersion.Minor = 2)) then
   sOSName := 'Windows 8';

  case TOSVersion.Architecture  of
   arIntelX86: sArchitecture := SVersion32;
   arIntelX64: sArchitecture := SVersion64;
   arARM32: sArchitecture := 'ARM32';
  end;

 Result := sOSInfo.Format(sOSInfo,[sOSName, TOSVersion.Build.ToString, sArchitecture]);
end;

procedure TFrmAbout.ReadVersionInfo;
var
Item: TListITem;
I: integer;
s: string;
List: TStringList;
LibHandle: THandle;
GetVersionInfo: TGetVersionInfo;
GetCustomVI: TGetCustomVersionInfo;
begin
//Lê os dados de versão do aplicativo
//Carrega a dll que contém as rotinas de leitura de versões
 LibHandle := LoadLibrary('VINFO.DLL'); //do not localize!

 try
  if LibHandle = 0 then
   raise ELoadDLLError.Create(Format(TCosmosErrorMsg.LoadDLL, ['vinfo.dll']));
  @GetVersionInfo := GetProcAddress(LibHandle, 'GetVersionInfo');
  if not (@GetVersionInfo = nil) then
   s := GetVersionInfo(PChar(FAppName))
  else
   RaiseLastOSError;

 List := TSTringList.Create; //Cria a lista de strings que receberá os dados
 List.CommaText := s;

 for I := 0 to Pred(List.Count) do //Escreve os dados no listview
  begin
   s := List.ValueFromIndex[I];
   if s <> '' then
    begin
     Item := LsvInfo.Items.Add;
     Item.Caption := List.Names[I];
     Item.SubItems.Add(s);
    end;
  end;

 //Agora, lê algumas informações acessórias
 @GetCustomVI := GetProcAddress(LibHandle, 'GetCustomVersionInfo');
 if not (@GetCustomVI = nil) then
  s := GetCustomVI(PChar(FAppName), 'comments')
 else
  RaiseLastOSError;

 LblComments.Caption := s;

 s := GetCustomVI(PChar(FAppName), 'Contact');
 if s <> '' then
  begin
   Item := LsvInfo.Items.Add;
   Item.Caption := 'Contato';
   Item.SubItems.Add(s);
  end;

 s := GetCustomVI(PChar(FAppName), 'CopyrightNote');
 if s <> '' then
  begin
   Item := LsvInfo.Items.Add;
   Item.Caption := 'Copyright';
   Item.SubItems.Add(s);
  end;

 //Escreve informações sobre o sistema operacional
// LblSOInfo.Caption := ReadOSInfo;
 LblSOInfo.Caption := TOSVersion.ToString;

 LsvInfo.Visible := True;

 finally
  FreeLibrary(LibHandle);
 end;
end;

end.
