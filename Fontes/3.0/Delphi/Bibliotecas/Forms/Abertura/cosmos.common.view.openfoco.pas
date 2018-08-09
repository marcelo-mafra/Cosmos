unit cosmos.common.view.openfoco;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FormCosmosHelpDialog, ExtCtrls, StdCtrls, ComCtrls, ImgList,
  DBClient, Cosmos.Framework.Interfaces.Root, Cosmos.Framework.Interfaces.DataAcess,
  Cosmos.Framework.Interfaces.Dialogs, cosmos.classes.security, Data.DB, Data.DBXCommon,
  Data.SqlExpr, cosmos.system.messages, cosmos.classes.application, cosmos.business.focos;

type
  TFrmOpenFocus = class(TFrmCosmosHelpDialog, ICosmosOpenFocus)
    LblUserName: TLabel;
    Image2: TImage;
    LsvFocos: TListView;
    Button1: TButton;
    Button2: TButton;
    ImageList1: TImageList;
    Button3: TButton;
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    FConnectionMode: TConnectionMode;

    procedure ListFocus(Dataset: TDataset); inline;
    procedure SetTipoAcesso(value: string); inline;

    function GetSelectedID: integer; inline;
    function GetSelectedText: string; inline;
    function GetConnectionMode: TConnectionMode;

  protected
    function OpenFocus(const UserName: string): TFocus;
    property ConnectionMode: TConnectionMode read GetConnectionMode;

  public
    { Public declarations }

  end;

var
  FrmOpenFocus: TFrmOpenFocus;

implementation

{$R *.dfm}

{ TFrmOpenFocus }

procedure TFrmOpenFocus.Button1Click(Sender: TObject);
begin
  inherited;
  if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.Autentication, TCosmosConfMsg.CancelSection) = mrYes then
   ModalResult := mrCancel;
end;

procedure TFrmOpenFocus.Button2Click(Sender: TObject);
begin
  inherited;
 if LsvFocos.Selected <> nil then
  ModalResult := mrOk;
end;

procedure TFrmOpenFocus.Button3Click(Sender: TObject);
begin
  inherited;
 if Self.HelpContext <> 0 then
  Application.HelpSystem.ShowContextHelp(Self.HelpContext, Application.CurrentHelpFile);
end;

function TFrmOpenFocus.GetSelectedID: integer;
begin
 if LsvFocos.Selected <> nil then
  Result := StrToInt(LsvFocos.Selected.SubItems.Strings[2])
 else
  Result := 0;
end;

function TFrmOpenFocus.GetSelectedText: string;
begin
 if LsvFocos.Selected <> nil then
  Result := LsvFocos.Selected.Caption
 else
  Result := '';
end;

function TFrmOpenFocus.GetConnectionMode: TConnectionMode;
begin
 Result := FConnectionMode;
end;

procedure TFrmOpenFocus.ListFocus(Dataset: TDataset);
var
Item: TListItem;
begin
 try
  LsvFocos.Items.BeginUpdate;
  LsvFocos.Items.Clear;

  while not Dataset.Eof do
   begin
    Item := LsvFocos.Items.Add;
    Item.Caption := Dataset.Fields.FindField('onomfoc').AsString;
    Item.SubItems.Add(Dataset.Fields.FindField('osigfoc').AsString);
    if Dataset.Fields.FindField('otipper').AsString = 'E' then
     Item.SubItems.Add(TSecurityConst.WriteRight)
    else
     Item.SubItems.Add(TSecurityConst.ReadRight);

    Item.SubItems.Add(Dataset.Fields.FindField('ocodfoc').AsString);
    Item.ImageIndex := 0;
    Dataset.Next;
   end;

 finally
  LsvFocos.Items.EndUpdate;
 end;
end;

function TFrmOpenFocus.OpenFocus(const UserName: string): TFocus;
var
 ADataset: TSQLDataset;
 ACds: TClientDataset;
begin
 //Lista os focos que um usuário pode acessar.
 ACds := TClientDataset.Create(nil);

 try
  ADataset := IRemoteCon.GetAcessedFocus(UserName, ICosmosApp.CosmosModule);

  if ADataset = nil then
   raise Exception.Create(TCosmosErrorMsg.LoadAcessedFocus);

  ACds := IRemoteCon.ToClientDataset(ADataset);

  if ACds.RecordCount = 1 then //Apenas um foco pode ser acessado pelo usuário
   begin
     Result := TFocus.Create;
     Result.FocusID := ACds.Fields.FieldByName('ocodfoc').AsInteger;
     Result.FocusName := ACds.Fields.FieldByName('onomfoc').AsString;

     SetTipoAcesso(Trim(ACds.Fields.FieldByName('otipper').AsString));
   end
  else
  if ACds.RecordCount > 1 then  //Mais de um foco pode ser acessado pelo usuário
   begin
     LblUserName.Caption := Format(LblUserName.Caption, [ACds.Fields.FieldByName('onomcad').AsString]);
     ListFocus(ACds);
     ACds.Close;

     if ShowModal = mrOk then
      begin
       Result := TFocus.Create;
       Result.FocusID :=  GetSelectedID;
       Result.FocusName := GetSelectedText;

       if LsvFocos.Selected <> nil then
         SetTipoAcesso(Trim(LsvFocos.Selected.SubItems.Strings[1]))
       else
         self.FConnectionMode := cmRead;
      end;
   end
  else
   begin
    ICosmosApp.DlgMessage.InfoMessage(TCosmosTitles.OpenFocus, TCosmosInfoMsg.NoFocusAcess); //Nenhum foco pode ser acessado pelo usuário
    ICosmosApp.IRemoteCon.CloseConnection;
   end;

  ACds.Free;
  ADataset.Free;

 except
  on E: TDBXError do
   begin
    Result := nil;
    //ICosmosApp.MainLog.RegisterError(E.Message);
   end;
  on E: Exception do
   begin
    Result := nil;
    ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, E.Message);
    ICosmosApp.MainLog.RegisterError(E.Message);
   end;
 end;
end;

procedure TFrmOpenFocus.SetTipoAcesso(value: string);
begin
 if Copy(value, 0, 1) = 'E' then
  self.FConnectionMode := cmWrite
 else
  self.FConnectionMode := cmRead;
end;

initialization
 RegisterClass(TFrmOpenFocus);

finalization
 UnRegisterClass(TFrmOpenFocus);

end.
