unit FormMessages;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FormCosmosDocked, ActnList, ImgList, ComCtrls, DBClient,
  cosmos.core.constantesmsg, cosmos.framework.datanavigators.listview,
  cosmos.core.classes, cosmos.core.SQLServerInterface, Vcl.ToolWin, Vcl.ActnMan,
  Vcl.ActnCtrls, Vcl.PlatformDefaultStyleActnCtrls, Vcl.Menus, Vcl.ActnPopup,
  Data.DB;

type
  TFrmMessages = class(TFrmCosmosDocked)
    ActNew: TAction;
    ActResponse: TAction;
    ActSearch: TAction;
    LsvMessages: TListView;
    ImageList2: TImageList;
    ActionManager1: TActionManager;
    ActionToolBar1: TActionToolBar;
    ActDelete: TAction;
    PopupActionBar1: TPopupActionBar;
    NovaMensagem1: TMenuItem;
    Responder1: TMenuItem;
    ExcluirMensagem1: TMenuItem;
    Pesquisar1: TMenuItem;
    N1: TMenuItem;
    CdsData: TClientDataSet;
    procedure ActNewExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ActResponseUpdate(Sender: TObject);
    procedure ActSearchExecute(Sender: TObject);
    procedure ActDeleteExecute(Sender: TObject);
    procedure PopupActionBar1Popup(Sender: TObject);
  private
    { Private declarations }
    FDataNavigator: TListviewDataNavigator;
    procedure LoadMessages;
    procedure UpdateData(Sender: TObject);

    function GetSelectedMessage: TListItem;

  protected
    function GetFormDescription: string; override;
    function GetFormIDName: string; override;
    function GetHelpFile: string; override;
    function GetHelpID: integer; override;
    function GetTitle: string; override;
    procedure Locate; override;
    procedure ExportData; override;


    property FormDescription: string read GetFormDescription;
    property HelpFile: string read GetHelpFile;
    property HelpID: integer read GetHelpID;
    property FormIDName: string read GetFormIDName;
    property Title: string read GetTitle;

  public
    { Public declarations }

    property SelectedMessage: TlistItem read GetSelectedMessage;
  end;

var
  FrmMessages: TFrmMessages;

implementation

uses FormEditMessage;

{$R *.dfm}

procedure TFrmMessages.ActDeleteExecute(Sender: TObject);
begin
  inherited;
  LsvMessages.DeleteSelected;
end;

procedure TFrmMessages.ActNewExecute(Sender: TObject);
begin
  inherited;
 try
  if not Assigned(FrmEditMessage) then
   FrmEditMessage := TFrmEditMessage.Create(self);
  FrmEditMessage.ShowModal;

 finally
  if Assigned(FrmEditMessage) then
   FreeAndNil(FrmEditMessage);
 end;


end;

procedure TFrmMessages.ActResponseUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := SelectedMessage <> nil;
end;

procedure TFrmMessages.ActSearchExecute(Sender: TObject);
begin
  inherited;
  ICosmosApp.IRemoteCon.DefaultLocate;
end;

procedure TFrmMessages.ExportData;
begin
  inherited;
//To-do..
end;

procedure TFrmMessages.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Assigned(FDataNavigator) then
   FreeAndNil(FDataNavigator);

  Action := caFree;
  FrmMessages := nil;
end;

procedure TFrmMessages.FormCreate(Sender: TObject);
begin
  inherited;
  FDataNavigator := TListviewDataNavigator.Create(LsvMessages);
  DataNavigator := FDataNavigator;
  TListviewDataNavigator(DataNavigator).OnUpdateData := UpdateData;
  LoadMessages;
end;

function TFrmMessages.GetFormDescription: string;
begin
 Result := sDesFormMessages;
end;

function TFrmMessages.GetFormIDName: string;
begin
 Result := 'Cosmos.Messages';
end;

function TFrmMessages.GetHelpFile: string;
begin
 Result := HelpFile;
end;

function TFrmMessages.GetHelpID: integer;
begin

end;

function TFrmMessages.GetSelectedMessage: TListItem;
begin
 Result := LsvMessages.Selected;
end;

function TFrmMessages.GetTitle: string;
begin
 Result := Caption;
end;

procedure TFrmMessages.LoadMessages;
var
 AItem: TListItem;
 AParams: TSQLParams;
begin
 AParams := TSQLParams.Create(1);
 AParams.AppendData(QuotedStr(TrimRight(ICosmosApp.IRemoteCon.CurrentUser.Login)));
 CdsData.Data := ICosmosApp.IRemoteCon.ExecuteDQL(csMyMessages, AParams.Params);

 LsvMessages.Items.BeginUpdate;

 try
   LsvMessages.Items.Clear;

    while not CdsData.Eof do
     begin
      AItem := LsvMessages.Items.Add;
      AItem.Caption := CdsData.FieldValues['titmen'];
      AItem.SubItems.Append(CdsData.FieldValues['remmen']);
      AItem.SubItems.Append(CdsData.FieldValues['datmen']);
      AItem.SubItems.Append(CdsData.FieldValues['stamen']);
      CdsData.Next;
     end;

   finally
    LsvMessages.Items.EndUpdate;
    if Assigned(CdsData) then
     FreeAndNil(CdsData);
    if Assigned(AParams) then
     FreeAndNil(AParams);
   end;
end;

procedure TFrmMessages.Locate;
begin
  inherited;
  ActSearch.Execute;
end;

procedure TFrmMessages.PopupActionBar1Popup(Sender: TObject);
begin
  inherited;
  TPopupActionBar(Sender).Style := ICosmosApp.InterfaceStyle;
end;

procedure TFrmMessages.UpdateData(Sender: TObject);
begin
  inherited;
  LoadMessages;
end;

initialization
 RegisterClass(TFrmMessages);

finalization
 UnRegisterClass(TFrmMessages);

end.
