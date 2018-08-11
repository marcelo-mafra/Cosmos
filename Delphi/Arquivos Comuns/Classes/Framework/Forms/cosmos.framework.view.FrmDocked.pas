unit cosmos.framework.view.FrmDocked;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms,  Vcl.ImgList, Vcl.ActnList, System.Actions,
  Vcl.Dialogs, Cosmos.Framework.Interfaces.Root, Cosmos.Framework.Interfaces.DataAcess,
  cosmos.framework.datanavigators.common, System.ImageList;

  {Esta classe implementa um form especializado que é usado em todos os aplicativos
   Cosmos. A classe implementa a interface ICosmosDockedForm e disponibiliza
   um acesso às seguintes interfaces:

    1) ICosmosApplication: representa a aplicação Cosmos em execução;
    2) ICosmosRemoteConnection: oferece acesso à camada servidora.

   Os descendentes desta classe devem sobrescrever os métodos e propriedades
   protegidos desta classe.}

type
  TFrmCosmosDocked = class(TForm, ICosmosDockedForm)
    ImageList1: TImageList;
    ActionList1: TActionList;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FICosmosApp: ICosmosApplication;
    FDataNavigator: TCustomDataNavigator;

    function GetIRemoteCon: ICosmosRemoteConnection;
    procedure SetDataNavigator(value: TCustomDataNavigator);


  protected
  {ICosmosDockedForm}
    function GetFormDescription: string; virtual; abstract;
    function GetFormIDName: string; virtual; abstract;
    function GetHelpFile: string; virtual; abstract;
    function GetHelpID: integer; virtual; abstract;
    function GetTitle: string; virtual; abstract;
    procedure Locate; virtual; abstract;
    procedure ExportData; virtual; abstract;
    procedure UpdateVisualElements; virtual; abstract;

    property FormDescription: string read GetFormDescription;
    property HelpFile: string read GetHelpFile;
    property HelpID: integer read GetHelpID;
    property FormIDName: string read GetFormIDName;
    property Title: string read GetTitle;


  public
    { Public declarations }
    property DataNavigator: TCustomDataNavigator read FDataNavigator write SetDataNavigator;
    property ICosmosApp: ICosmosApplication read FICosmosApp;
    property IRemoteCon: ICosmosRemoteConnection read GetIRemoteCon;
  end;

var
  FrmCosmosDocked: TFrmCosmosDocked;

implementation

{$R *.dfm}

procedure TFrmCosmosDocked.FormActivate(Sender: TObject);
begin
 if ICosmosApp <> nil then
  begin
   ICosmosApp.ActiveDockedForm := Self;
   IRemoteCon.ActiveDataNavigator := self.DataNavigator;
  end;

 if Assigned(Screen.OnActiveFormChange) then
  Screen.OnActiveFormChange(sender);
end;

procedure TFrmCosmosDocked.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if FICosmosApp <> nil then
  begin
   ICosmosApp.UnregisterWindow(self.ClassType);
   ICosmosApp.DropCategory(Self.Caption);

   if IRemoteCon <> nil then
     IRemoteCon.ActiveDataNavigator := nil;

   //Somente anula o ponteiro aqui, pois IRemoteCon é um atributo de FICosmosApp.
   FICosmosApp := nil;
  end;

 Action := caFree;
 FrmCosmosDocked := nil;
end;

procedure TFrmCosmosDocked.FormCreate(Sender: TObject);
begin
 if Supports(Application.MainForm, ICosmosApplication) then
  begin
    FICosmosApp := Application.MainForm as ICosmosApplication;

    self.CustomHint := ICosmosApp.CustomHintObj;
    Touch.GestureManager := ICosmosApp.GestureManager;
    ICosmosApp.AddCategory(Self.Caption,ActionList1);

    UpdateVisualElements;
  end;
end;

function TFrmCosmosDocked.GetIRemoteCon: ICosmosRemoteConnection;
begin
 Result := nil;
 if Assigned(FICosmosApp) then
  Result := ICosmosApp.IRemoteCon;
end;

procedure TFrmCosmosDocked.SetDataNavigator(value: TCustomDataNavigator);
begin
 FDataNavigator := Value;
end;




end.
