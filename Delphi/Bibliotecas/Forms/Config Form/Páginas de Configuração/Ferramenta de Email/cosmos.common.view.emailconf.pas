unit cosmos.common.view.emailconf;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Cosmos.Framework.Interfaces.Dialogs, StdCtrls, ExtCtrls, GroupHeader,
  cosmos.framework.forms.pages, Cosmos.system.messages, XMLDoc, XMLIntf,
  Vcl.ImgList, cosmos.classes.security, cosmos.system.formsconst;

type
  TFrmEmailOptions = class(TFrmCosmosPages)
    MSGroupHeader1: TMSGroupHeader;
    EdtSMTPhost: TEdit;
    Label1: TLabel;
    EdtPort: TEdit;
    Label2: TLabel;
    MSGroupHeader2: TMSGroupHeader;
    Label3: TLabel;
    Label4: TLabel;
    EdtUserName: TEdit;
    EdtPassword: TEdit;
    RdbNoneAutent: TRadioButton;
    RdbDefaultAutent: TRadioButton;
    RdbSASLAutent: TRadioButton;
    Image1: TImage;
    Label5: TLabel;
    ImageList1: TImageList;
    procedure RdbDefaultAutentClick(Sender: TObject);
    procedure RdbNoneAutentClick(Sender: TObject);
    procedure EdtPortKeyPress(Sender: TObject; var Key: Char);
    procedure EdtSMTPhostChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
   { Private declarations }
   FChanged: boolean;
   function LoadBitmap: TBitmap;



  protected
   function GetChanged: boolean; override;
   function GetEnabled: boolean; override;
   function GetPageInfo: TPageInfo; override;

   function SaveOptions: boolean; override;
   procedure LoadOptions; override;

   function ValidateFields: boolean; override;

   property Changed: boolean read GetChanged;
   property Enabled: boolean read GetEnabled;
   property PageInfo: TPageInfo read GetPageInfo;

  public
    { Public declarations }
  end;

var
  FrmEmailOptions: TFrmEmailOptions;

implementation

{$R *.dfm}

procedure TFrmEmailOptions.EdtPortKeyPress(Sender: TObject; var Key: Char);
begin
if CharInSet(Key, ['0'..'9',#8]) then
  Abort;
end;

procedure TFrmEmailOptions.EdtSMTPhostChange(Sender: TObject);
begin
 FChanged := True;
end;

procedure TFrmEmailOptions.FormCreate(Sender: TObject);
begin
 if (IRemoteCon <> nil) and (IRemoteCon.CurrentConnectionInfo <> nil) then
  begin
   if not (cfConfPageEmails in IRemoteCon.CurrentConnectionInfo.AuthorizedFeatures) then
     self.DisableControls;
  end
 else
     self.DisableControls;
end;

function TFrmEmailOptions.GetChanged: boolean;
begin
 Result := FChanged;
end;

function TFrmEmailOptions.GetEnabled: boolean;
begin
 Result := True;
end;

function TFrmEmailOptions.GetPageInfo: TPageInfo;
begin
 Result.CodePage := 'Cosmos.Mailtool';
 Result.PageTitle := Caption;
 Result.PageDesc := TConfigurationPagesDesc.ConfGerais;
 Result.PageTreeRoot := TCosmosTitles.ConfGerais;
 Result.PageTreeItem := TCosmosTitles.ConfEmail;
 Result.PageIndex := 1;
 Result.PageImage := LoadBitmap;
 Result.HelpFile := Application.CurrentHelpFile;
 Result.HelpContext := self.HelpContext;
end;

function TFrmEmailOptions.LoadBitmap: TBitmap;
begin
 Result := TBitMap.Create;
 ImageList1.GetBitmap(0, Result);
end;

procedure TFrmEmailOptions.LoadOptions;
var
 AXMLDoc: TXMLDocument;
 ANode: IXMLNode;
begin
 //Lê as opções de configuração salvas.
 AXMLDoc := CreateXMLDocument(ICosmosApp.IApplicationPaths.GetCommonConfigurationsFile);

 try
  ANode := AXMLDoc.DocumentElement;
  ANode := ANode.ChildNodes.FindNode('EmailInfo');
  ANode := ANode.ChildNodes.FindNode('Info');

  if ANode <> nil then
   begin
    {EdtSMTPHost.Text :=  ANode.Attributes['SMTPHost'];
    EdtPort.Text :=  ANode.Attributes['SMTPPort'];

    EdtUserName.Text := ANode.Attributes['SMTPUser'];

   if Trim(ANode.Attributes['SMTPPass']) <> '' then
    EdtPassword.Text := ReadCypheredValue(ANode.Attributes['SMTPPass']);

    //Lê a ação padrão a ser usada ao receber uma atualização.
   case ANode.Attributes['AuthenticationMode'] of
    0: RdbNoneAutent.Checked := True;
    1: RdbDefaultAutent.Checked := True;
    2: RdbSASLAutent.Checked := True;
    else
     RdbDefaultAutent.Checked := True;
   end;

   FChanged := False; //default}

   if Assigned(AXMLDoc) then
     FreeAndNil(AXMLDoc);
   end;

 except
  on E: Exception do
   begin
    ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, TCosmosErrorMsg.LoadConfigurations);

    ICosmosApp.MainLog.RegisterError(E.Message);

    if Assigned(AXMLDoc) then
     FreeAndNil(AXMLDoc);
   end;
 end;
end;

procedure TFrmEmailOptions.RdbDefaultAutentClick(Sender: TObject);
begin
 EdtUserName.Enabled := TRadioButton(Sender).Checked;
 EdtPassword.Enabled := EdtUserName.Enabled;
 FChanged := True;
end;

procedure TFrmEmailOptions.RdbNoneAutentClick(Sender: TObject);
begin
 EdtUserName.Enabled := not TRadioButton(Sender).Checked;
 EdtPassword.Enabled := EdtUserName.Enabled;
 FChanged := True;
end;

function TFrmEmailOptions.SaveOptions: boolean;
var
 AXMLDoc: TXMLDocument;
 ANode: IXMLNode;
begin
 {Salva as opções de configuração. Somente salva se houver um usuário autenticado
  e se o mesmo for administrador do Cosmos.}
 Result := ValidateFields;
 if not Result then
  begin
   ICosmosApp.DlgMessage.WarningMessage(TCosmosTitles.Atenttion, TCosmosWarningMsg.IncompletedFields);
   Exit;
  end;

 AXMLDoc := CreateXMLDocument(ICosmosApp.IApplicationPaths.GetCommonConfigurationsFile);

 try
  ANode := AXMLDoc.DocumentElement;
  ANode := ANode.ChildNodes.FindNode('EmailInfo');
  ANode := ANode.ChildNodes.FindNode('Info');

  if ANode <> nil then
   begin
    //Salva mode de autenticação;
    if RdbNoneAutent.Checked then
     ANode.Attributes['AuthenticationMode'] :=  0 //None
    else
    if RdbDefaultAutent.Checked then
     ANode.Attributes['AuthenticationMode'] :=  1  //Default
    else
     ANode.Attributes['AuthenticationMode'] :=  2;  //SASL

    //Salva endereço smtp e porta.
    ANode.Attributes['SMTPHost'] := EdtSMTPHost.Text;
    ANode.Attributes['SMTPPort'] := StrToInt(EdtPort.Text);

    //Salva dados de autenticação
    ANode.Attributes['SMTPUser'] := EdtUserName.Text;
    ANode.Attributes['SMTPPass'] := ICosmosApp.IUtilities.EncriptString(EdtPassword.Text);

    AXMLDoc.SaveToFile(AXMLDoc.FileName);
    Result := True;
   end;

 finally
  if Assigned(AXMLDoc) then
    FreeAndNil(AXMLDoc);
 end;
end;


function TFrmEmailOptions.ValidateFields: boolean;
begin
 Result := HasValue(EdtSMTPHost) and HasValue(EdtPort);

 if not RdbNoneAutent.Checked then
  begin
    Result := HasValue(EdtUserName);
    Result := HasValue(EdtPassword);
  end;
end;

initialization
 RegisterClass(TFrmEmailOptions);

finalization
 UnRegisterClass(TFrmEmailOptions);

end.
