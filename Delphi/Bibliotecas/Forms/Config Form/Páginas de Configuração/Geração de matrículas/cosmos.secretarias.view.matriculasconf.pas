unit cosmos.secretarias.view.matriculasconf;

interface

uses
  System.Classes, Vcl.Controls, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Forms,
  Cosmos.system.messages, Cosmos.Framework.Interfaces.Dialogs,System.SysUtils,
  cosmos.framework.forms.pages, Vcl.Graphics, cosmos.business.secretariats,
  Xml.XMLDoc, Xml.XMLIntf, cosmos.system.formsconst, Vcl.ImgList,
  Cosmos.Framework.Interfaces.Applications;

type
  TFrmPageMatriculas = class(TFrmCosmosPages)
    RdbIntervalo: TRadioButton;
    RdbLast: TRadioButton;
    Label1: TLabel;
    Label2: TLabel;
    ImageList1: TImageList;
    Image1: TImage;
    Image2: TImage;
    procedure RdbIntervaloClick(Sender: TObject);
    procedure RdbLastClick(Sender: TObject);
  private
    { Private declarations }
   FChanged: boolean;
   FNewMatriculaMode: TNewMatriculaMode;

   procedure SetNewMatriculaMode(value: TNewMatriculaMode);
   function LoadBitmap: TBitmap;

  protected
   function GetChanged: boolean; override;
   function GetEnabled: boolean; override;
   function GetPageInfo: TPageInfo; override;

   function SaveOptions: boolean; override;
   procedure LoadOptions; override;

   property Changed: boolean read GetChanged;
   property Enabled: boolean read GetEnabled;
   property PageInfo: TPageInfo read GetPageInfo;

  public
    { Public declarations }
    property NewMatriculaMode: TNewMatriculaMode read FNewMatriculaMode write SetNewMatriculaMode;
  end;

var
  FrmPageMatriculas: TFrmPageMatriculas;

implementation

{$R *.dfm}

{ TFrmPageMatriculas }

function TFrmPageMatriculas.GetChanged: boolean;
begin
 Result := FChanged;
end;

function TFrmPageMatriculas.GetEnabled: boolean;
begin
Result := True;
end;

function TFrmPageMatriculas.GetPageInfo: TPageInfo;
begin
 Result.CodePage := 'Cosmos.Matriculas.configuration';
 Result.PageTitle := Caption;
 Result.PageDesc := TConfigurationPagesDesc.ConfMatriculasOptions;
 Result.PageTreeRoot := TCosmosTitles.ConfSecretarias;
 Result.PageTreeItem := TCosmosTitles.ConfMatriculas;
 Result.PageIndex := 1;
 Result.PageImage := LoadBitmap;
 Result.HelpFile := Application.CurrentHelpFile;
 Result.HelpContext := self.HelpContext;
end;

function TFrmPageMatriculas.LoadBitmap: TBitmap;
begin
 Result := TBitMap.Create;
 ImageList1.GetBitmap(0, Result);
end;

procedure TFrmPageMatriculas.LoadOptions;
var
  AXMLDoc: TXMLDocument;
  ANode: IXMLNode;
  FNewMatriculaMode: TNewMatriculaMode;
begin
 AXMLDoc := CreateXMLDocument(ICosmosApp.IApplicationPaths.GetUserConfigurationsFile);
 if AXMLDoc = nil then
  Exit;

 try
   ANode := AXMLDoc.DocumentElement;
   ANode := ANode.ChildNodes.FindNode('ModulesOptions');
   ANode := ANode.ChildNodes.FindNode(ICosmosApp.CosmosModuleShortName);
   ANode := ANode.ChildNodes.FindNode('MatriculaOptions');

  //Lê a opção de opção de lógica de geração de matrículas novas.
   FNewMatriculaMode := TNewMatriculaMode(ANode.Attributes['GenerationOption']);

   case FNewMatriculaMode of
    mmFromLastNumber: RdbLast.Checked := True;
    mmEmptyIntervals: RdbIntervalo.Checked := True;
   end;

  FChanged := False; //default

 finally
  if Assigned(AXMLDoc) then FreeAndNil(AXMLDoc);
 end;;
end;

procedure TFrmPageMatriculas.RdbIntervaloClick(Sender: TObject);
begin
 NewMatriculaMode := TNewMatriculaMode.mmEmptyIntervals;
end;

procedure TFrmPageMatriculas.RdbLastClick(Sender: TObject);
begin
 NewMatriculaMode := TNewMatriculaMode.mmFromLastNumber;
end;

function TFrmPageMatriculas.SaveOptions: boolean;
var
  AXMLDoc: TXMLDocument;
  ANode: IXMLNode;
  ISecretarias: ICosmosSecretarias;
  FNewMatriculaMode: TNewMatriculaMode;
begin
  AXMLDoc := self.CreateXMLDocument(ICosmosApp.IApplicationPaths.GetUserConfigurationsFile);
  ANode := AXMLDoc.DocumentElement;
  ANode := ANode.ChildNodes.FindNode('ModulesOptions');
  ANode := ANode.ChildNodes.FindNode(ICosmosApp.CosmosModuleShortName);
  ANode := ANode.ChildNodes.FindNode('MatriculaOptions');

 try
  if RdbIntervalo.Checked then
   FNewMatriculaMode := TNewMatriculaMode.mmEmptyIntervals
  else
   FNewMatriculaMode := TNewMatriculaMode.mmFromLastNumber;

  ANode.Attributes['GenerationOption']:= Ord(FNewMatriculaMode);


  AXMLDoc.SaveToFile(AXMLDoc.FileName);
  Result := True;

  ISecretarias := ICosmosApp.MainForm as ICosmosSecretarias;
  ISecretarias.SecretariasOptions.NewMatriculaMode := FNewMatriculaMode;

  ISecretarias := nil;
  if Assigned(AXMLDoc) then FreeAndNil(AXMLDoc);

 except
  on E: Exception do
   begin
     Result := False;
     ICosmosApp.MainLog.RegisterError(E.Message);
     ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, TCosmosErrorMsg.SaveGUIConfigurations);
   end;
 end;
end;

procedure TFrmPageMatriculas.SetNewMatriculaMode(value: TNewMatriculaMode);
begin
 FNewMatriculaMode := Value;
 FChanged := True;
end;

initialization
 RegisterClass(TFrmPageMatriculas);

finalization
 UnRegisterClass(TFrmPageMatriculas);

end.
