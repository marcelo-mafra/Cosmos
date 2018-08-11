unit cosmos.framework.forms.pages;

interface

uses
  Winapi.Windows, System.Classes, Vcl.Forms, cosmos.framework.interfaces.dialogs,
  Xml.XMLDoc, Xml.XMLIntf, System.SysUtils, cosmos.framework.interfaces.root,
  cosmos.framework.interfaces.DataAcess, Vcl.StdCtrls, cosmos.classes.application,
  cosmos.system.types, cosmos.system.messages, Vcl.Controls, Vcl.Graphics,
  System.TypInfo, System.UITypes, cosmos.system.winshell;

type
  TFrmCosmosPages = class(TForm, ICosmosConfigurationPage)
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    FICosmosApp: ICosmosApplication;
    function GetIRemoteConnection: ICosmosRemoteConnection;
    procedure DoMarkControl(Control: TControl; Color: TColor = clInfoBk); inline;

  protected
   procedure DisableControls;
   procedure EnableControls;

   function GetChanged: boolean; virtual; abstract;
   function GetEnabled: boolean; virtual; abstract;
   function GetPageInfo: TPageInfo; virtual; abstract;

   function SaveOptions: boolean; virtual; abstract;
   procedure LoadOptions; virtual; abstract;

   function ValidateFields: boolean; virtual; abstract;

   property Changed: boolean read GetChanged;
   property Enabled: boolean read GetEnabled;
   property PageInfo: TPageInfo read GetPageInfo;



  public
    { Public declarations }
    function HasValue(Control: TControl): boolean;
    function CreateXMLDocument(const FileName: string; OpenFile: boolean = True): TXMLDocument;

    property ICosmosApp: ICosmosApplication read FICosmosApp;
    property IRemoteCon: ICosmosRemoteConnection read GetIRemoteConnection;
  end;

var
  FrmCosmosPages: TFrmCosmosPages;

implementation

{$R *.dfm}

procedure TFrmCosmosPages.DisableControls;
var
 I: integer;
begin
 for I := 0 to Pred(self.ControlCount) do
  if not (self.Controls[I] is TLabel) then
   self.Controls[I].Enabled := False;
end;

procedure TFrmCosmosPages.DoMarkControl(Control: TControl; Color: TColor);
begin
if IsPublishedProp(Control, 'Color') then
 SetPropValue(Control, 'Color' , Color);
end;

procedure TFrmCosmosPages.EnableControls;
var
 I: integer;
begin
 for I := 0 to Pred(self.ControlCount) do
   self.Controls[I].Enabled := True;
end;

procedure TFrmCosmosPages.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := ValidateFields;
end;

procedure TFrmCosmosPages.FormCreate(Sender: TObject);
begin
 self.FICosmosApp := Application.MainForm as ICosmosApplication;
end;

procedure TFrmCosmosPages.FormDestroy(Sender: TObject);
begin
 if Assigned(self.FICosmosApp) then
  self.FICosmosApp := nil;
end;

function TFrmCosmosPages.GetIRemoteConnection: ICosmosRemoteConnection;
begin
 if ICosmosApp = nil then
  FICosmosApp := Application.MainForm as ICosmosApplication;

 Result := ICosmosApp.IRemoteCon
end;

function TFrmCosmosPages.HasValue(Control: TControl): boolean;
var
 AValue: string;
 AIntValue: integer;
begin
//Verifica se um controle possui algum valor na sua propriedade "Text".
 Result := True;

 if IsPublishedProp(Control, 'Text') then
  begin
   AValue := GetPropValue(Control, 'Text' );
   Result := AValue.Trim <> '';
  end;

 if IsPublishedProp(Control, 'Value') then
  begin
   AIntValue := GetPropValue(Control, 'Value' );
   Result := AIntValue > 0;
  end;

//Caso o controle não possua valor, sinaliza-o para o usuário.
 if not Result then
  DoMarkControl(Control)
 else
  DoMarkControl(Control, clWindow)
end;

function TFrmCosmosPages.CreateXMLDocument(const FileName: string;
    OpenFile: boolean): TXMLDocument;
begin
 Result := TXMLDocument.Create(self);
 Result.Options := [doNodeAutoCreate,doNodeAutoIndent,doAttrNull,doNamespaceDecl];
 Result.NodeIndentStr := #13;

 try
  Result.FileName := FileName;
  Result.Active := OpenFile;

 except
  on E: Exception do
   begin
     Result := nil;
     ICosmosApp.MainLog.RegisterError(E.Message);
     ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, TCosmosErrorMsg.ReadCosmosConfigurations);
   end;
 end;
end;


end.
