unit cosmos.common.view.userinfo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.DBCtrls, Data.DB, Cosmos.Framework.Interfaces.Dialogs, Datasnap.DBClient,
  Cosmos.Framework.Interfaces.DataAcess, cosmos.system.messages,
  cosmos.framework.Interfaces.root, cosmos.classes.application,
  cosmos.classes.ServerInterface;

type
  TFrmUserInfo = class(TForm)
    Image1: TImage;
    Button1: TButton;
    Button2: TButton;
    Label2: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Bevel1: TBevel;
    DBText1: TDBText;
    DBText2: TDBText;
    DBText3: TDBText;
    DBText4: TDBText;
    CdsUsuario: TClientDataSet;
    DsrUsuario: TDataSource;
    Label1: TLabel;
    procedure Button2Click(Sender: TObject);
    procedure Label1Click(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
    procedure ShowUserInfo(const UserLogin: string);
  end;

var
  FrmUserInfo: TFrmUserInfo;

implementation

{$R *.dfm}

{ TFrmMain }

procedure TFrmUserInfo.Button2Click(Sender: TObject);
begin
 if Self.HelpContext <> 0 then
  Application.HelpSystem.ShowContextHelp(Self.HelpContext, Application.CurrentHelpFile);
end;

procedure TFrmUserInfo.Label1Click(Sender: TObject);
var
 AModule: HModule;
 AForm: TForm;
 IFicha: ICosmosFicha;
 ICosmosApp: ICosmosApplication;
begin
 inherited;
 ICosmosApp := Application.MainForm as ICosmosApplication;
 AForm := ICosmosApp.LoadDialog('ficha.bpl', 'TFrmFicha', AModule);

 try
  if AModule <> 0 then
  begin
     with AForm do
      begin
       if Supports(AForm, ICosmosFicha) then
        IFicha := AForm as ICosmosFicha;
       if Assigned(IFicha) then
         IFicha.ShowFicha(CdsUsuario.Fields.FieldByName('codcad').AsInteger);
       Free;
      end;
  end;

 finally
  if Assigned(IFicha) then IFicha := nil;
  if Assigned(ICosmosApp) then ICosmosApp := nil;
  UnloadPackage(AModule);
 end;
end;

procedure TFrmUserInfo.ShowUserInfo(const UserLogin: string);
var
 ICosmosApp: ICosmosApplication;
 AParams: TCosmosData;
begin
 inherited;
 ICosmosApp := Application.MainForm as ICosmosApplication;
 AParams := TCosmosData.Create(2);
 CdsUsuario.DisableControls;

 try
  AParams.WriteValue('LOGUSU', QuotedStr(UpperCase(UserLogin)));
  AParams.WriteValue('NOMUSU', QuotedStr(UpperCase(UserLogin)), 1);
  ICosmosApp.IRemoteCon.ExecuteDQL(csUsuarioCadastrador, AParams.Data, CdsUsuario);

  if (CdsUsuario.Active) and not (CdsUsuario.IsEmpty) then
   begin
    CdsUsuario.EnableControls;
    ShowModal;
   end
  else
   ICosmosApp.DlgMessage.InfoMessage(TCosmosTitles.Users, TCosmosErrorSecurityMsg.UserDataNotFound);

 finally
  if Assigned(AParams) then FreeAndNil(AParams);
  if Assigned(ICosmosApp) then ICosmosApp := nil;
 end;
end;

end.
