unit cosmos.common.view.ficha;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Data.DB,
  Datasnap.DBClient, Vcl.StdCtrls, Vcl.DBCtrls, cosmos.frames.gridsearch,
  Cosmos.Framework.Interfaces.DataAcess, Cosmos.Framework.Interfaces.Dialogs,
  cosmos.classes.application, cosmos.classes.ServerInterface, Vcl.Imaging.jpeg,
  Data.FMTBcd;

type
  TFrmFicha = class(TForm, ICosmosFicha)
    CdsFicha: TClientDataSet;
    DsrFicha: TDataSource;
    DBText1: TDBText;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    DBText2: TDBText;
    Label1: TLabel;
    Label2: TLabel;
    DBText3: TDBText;
    Label3: TLabel;
    DBText4: TDBText;
    Label4: TLabel;
    DBText5: TDBText;
    Label6: TLabel;
    Bevel1: TBevel;
    CdsFuncoes: TClientDataSet;
    DsrFuncoes: TDataSource;
    Panel1: TPanel;
    FmeGridFuncoes: TFmeGridSearch;
    ImgFoto: TImage;
    Bevel2: TBevel;
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure LoadFotoCadastrado(const codcad: integer);
  public
    { Public declarations }
   procedure ShowFicha(const codcad: integer); overload;
   procedure SearchFicha(const LoginName: string);

  end;

var
  FrmFicha: TFrmFicha;

implementation

{$R *.dfm}

{ TFrmFicha }

procedure TFrmFicha.Button3Click(Sender: TObject);
begin
 if Self.HelpContext <> 0 then
  Application.HelpSystem.ShowContextHelp(Self.HelpContext, Application.CurrentHelpFile);
end;

procedure TFrmFicha.FormCreate(Sender: TObject);
begin
 FmeGridFuncoes.SearchFields := 'desfun'; //do not localize!
end;

procedure TFrmFicha.LoadFotoCadastrado(const codcad: integer);
var
 IRemoteCon: ICosmosRemoteConnection;
 APicture: TPicture;
begin
 IRemoteCon := Application.MainForm as ICosmosRemoteConnection;

 try
  //Obtém os dados do usuário
  APicture := IRemoteCon.GetFotoCadastrado(codcad);
  if APicture <> nil then
   ImgFoto.Picture.Assign(APicture);

 finally
  if Assigned(APicture) then FreeAndNil(APicture);
  if Assigned(IRemoteCon) then IRemoteCon := nil;
 end;
end;

procedure TFrmFicha.SearchFicha(const LoginName: string);
var
codcad: integer;
IRemoteCon: ICosmosRemoteConnection;
AParamsList: TSQLParams;
begin
 IRemoteCon := Application.MainForm as ICosmosRemoteConnection;
 AParamsList := TSQLParams.Create(1);

 try
  //Obtém os dados do usuário
  AParamsList.AppendData(QuotedStr(LoginName));
  IRemoteCon.ExecuteDQL(csFichaUsuario, AParamsList.Params, CdsFicha);

  //Agora, obtém os dados das funções do aluno.
  AParamsList.ClearParams(1);
  codcad := CdsFicha.Fields.FieldByName('codcad').AsInteger;
  AParamsList.AppendData(codcad);
  IRemoteCon.ExecuteDQL(csFuncoesCadastrado, AParamsList.Params, CdsFuncoes);

  ShowModal;

 finally
  if Assigned(IRemoteCon) then IRemoteCon := nil;
  if Assigned(AParamsList) then AParamsList.Free;
 end;
end;

procedure TFrmFicha.ShowFicha(const codcad: integer);
var
IRemoteCon: ICosmosRemoteConnection;
AParamsList: TSQLParams;
begin
 IRemoteCon := Application.MainForm as ICosmosRemoteConnection;
 AParamsList := TSQLParams.Create(1);
 CdsFicha.DisableControls;

 try
  //Obtém os dados do aluno.
  AParamsList.AppendData(codcad);
  IRemoteCon.ExecuteDQL(csDadosCadastrado, AParamsList.Params, CdsFicha);
  LoadFotoCadastrado(codcad);
  CdsFicha.EnableControls;

  //Agora, obtém os dados das funções do aluno.
  AParamsList.ClearParams(1);
  AParamsList.AppendData(codcad);
  IRemoteCon.ExecuteDQL(csFuncoesCadastrado, AParamsList.Params, CdsFuncoes);
  CdsFuncoes.First;
  CdsFuncoes.ReadOnly := True;

  ShowModal;

 finally
  CdsFicha.EnableControls;
  if Assigned(IRemoteCon) then IRemoteCon := nil;
  if Assigned(AParamsList) then AParamsList.Free;
 end;
end;


initialization
 RegisterClass(TFrmFicha);

finalization
 UnRegisterClass(TFrmFicha);

end.
