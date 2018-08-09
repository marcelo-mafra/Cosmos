unit FormOrgaosGestores;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FormCosmosDocked, ActnList, ImgList, ExtCtrls, ComCtrls, StdCtrls,
  GroupHeader, Cosmos.Frames.FrameGestoes, cosmos.framework.datanavigators.treeview,
  cosmos.core.ConstantesMsg, Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnMan,
  System.Actions, Vcl.ToolWin, Vcl.ActnCtrls, Vcl.Menus, Data.DB,
  Datasnap.DBClient, System.Rtti, System.Bindings.Outputs, Vcl.Bind.Editors,
  Data.Bind.EngExt, Vcl.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope;

type
  TFrmOrgaosGestores = class(TFrmCosmosDocked)
    MainPage: TPageControl;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    MSGroupHeader2: TMSGroupHeader;
    Label3: TLabel;
    LblOrgaoSigla: TLabel;
    Label6: TLabel;
    LblEnglishName: TLabel;
    Label8: TLabel;
    LblOrgaoSup: TLabel;
    Label9: TLabel;
    LblOrgaoFoco: TLabel;
    MSGroupHeader3: TMSGroupHeader;
    LsvMembrosAtuais: TListView;
    Panel3: TPanel;
    LblOrgao: TLabel;
    Image4: TImage;
    TabSheet7: TTabSheet;
    Panel4: TPanel;
    LblOrgao2: TLabel;
    Image5: TImage;
    MSGroupHeader4: TMSGroupHeader;
    Label10: TLabel;
    LblPeriodo: TLabel;
    Label12: TLabel;
    LblGestaoFoco: TLabel;
    MSGroupHeader5: TMSGroupHeader;
    Label18: TLabel;
    LblGestorName: TLabel;
    Label21: TLabel;
    LblGestorDisc: TLabel;
    Label23: TLabel;
    LblGestorCargo: TLabel;
    Label25: TLabel;
    LblGestorPosse: TLabel;
    Label27: TLabel;
    LblGestorFoco: TLabel;
    Image6: TImage;
    Label20: TLabel;
    LblGestorTermino: TLabel;
    Bevel1: TBevel;
    TabSheet8: TTabSheet;
    Panel5: TPanel;
    LblGestaoOrgao: TLabel;
    Image7: TImage;
    MSGroupHeader6: TMSGroupHeader;
    Label13: TLabel;
    LblGestaoPeriodo: TLabel;
    Label15: TLabel;
    LblGestaoFoco2: TLabel;
    MSGroupHeader7: TMSGroupHeader;
    LsvMembrosGestao: TListView;
    Splitter1: TSplitter;
    ActionManager1: TActionManager;
    ActionToolBar1: TActionToolBar;
    FmeGestoes1: TFmeGestoes;
    CdsDirigentesGestao: TClientDataSet;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    CdsOrgaos: TClientDataSet;
    BindSourceDB2: TBindSourceDB;
    LinkPropertyToFieldCaption2: TLinkPropertyToField;
    LinkPropertyToFieldCaption3: TLinkPropertyToField;
    LinkPropertyToFieldCaption4: TLinkPropertyToField;
    LinkPropertyToFieldCaption: TLinkPropertyToField;
    LinkPropertyToFieldCaption5: TLinkPropertyToField;
    CdsDirigente: TClientDataSet;
    BindSourceDB3: TBindSourceDB;
    LinkPropertyToFieldCaption6: TLinkPropertyToField;
    LinkPropertyToFieldCaption7: TLinkPropertyToField;
    LinkPropertyToFieldCaption8: TLinkPropertyToField;
    LinkPropertyToFieldCaption9: TLinkPropertyToField;
    LinkPropertyToFieldCaption10: TLinkPropertyToField;
    LinkPropertyToFieldCaption11: TLinkPropertyToField;
    LinkPropertyToFieldCaption12: TLinkPropertyToField;
    LinkFillControlToField1: TLinkFillControlToField;
    LinkPropertyToFieldCaption13: TLinkPropertyToField;
    CdsDirigentesAtuais: TClientDataSet;
    BindSourceDB4: TBindSourceDB;
    LinkFillControlToField2: TLinkFillControlToField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FDataNavigator: TTreeviewDataNavigator;
    procedure UpdateData(Sender: TObject);
    procedure OnSelectItem(Sender: TObject);

  protected
    function GetFormDescription: string; override;
    function GetFormIDName: string; override;
    function GetHelpFile: string; override;
    function GetHelpID: integer; override;
    function GetTitle: string; override;
    procedure Locate; override;
    procedure ExportData; override;
    procedure UpdateVisualElements; override;

    property FormDescription: string read GetFormDescription;
    property HelpFile: string read GetHelpFile;
    property HelpID: integer read GetHelpID;
    property FormIDName: string read GetFormIDName;
    property Title: string read GetTitle;

  public
    { Public declarations }
  end;

var
  FrmOrgaosGestores: TFrmOrgaosGestores;

implementation

{$R *.dfm}

procedure TFrmOrgaosGestores.ExportData;
begin
  inherited;
  ICosmosApp.DlgMessage.InfoMessage('Cosmos', 'Este recurso não foi implementado.')
end;

procedure TFrmOrgaosGestores.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if Assigned(FDataNavigator) then
   FreeAndNil(FDataNavigator);

  Action := caFree;
  FrmOrgaosGestores := nil;
end;

procedure TFrmOrgaosGestores.FormCreate(Sender: TObject);
var
 I: integer;
begin
  inherited;
  FDataNavigator := TTreeviewDataNavigator.Create(self.FmeGestoes1.TrvGestoes);
  self.DataNavigator := FDataNavigator;
  TTreeviewDataNavigator(DataNavigator).OnUpdateData := UpdateData;
  ICosmosApp.AddCategory(Self.Caption, self.FmeGestoes1.ActionFrame);

  FmeGestoes1.ListType := ltOrgaos;
  FmeGestoes1.OnSelectItem := self.OnSelectItem;

  CdsOrgaos.RemoteServer := IRemoteCon.ConnectionBroker;
  CdsDirigentesGestao.RemoteServer := IRemoteCon.ConnectionBroker;
  CdsDirigente.RemoteServer := IRemoteCon.ConnectionBroker;
  CdsDirigentesAtuais.RemoteServer := IRemoteCon.ConnectionBroker;

 for I := 0 to Pred(MainPage.PageCount) do
   MainPage.Pages[I].TabVisible := False;

   MainPage.ActivePageIndex := 0;

end;


function TFrmOrgaosGestores.GetFormDescription: string;
begin
 Result := sDescFormOrgaosGestores;
end;

function TFrmOrgaosGestores.GetFormIDName: string;
begin
 Result := 'GestorFocos.OrgaosGestores';
end;

function TFrmOrgaosGestores.GetHelpFile: string;
begin
 Result := Self.HelpFile;
end;

function TFrmOrgaosGestores.GetHelpID: integer;
begin
 Result := HelpContext;
end;

function TFrmOrgaosGestores.GetTitle: string;
begin
 Result := Caption;
end;

procedure TFrmOrgaosGestores.Locate;
begin
  inherited;
  IRemoteCon.DefaultLocate;
end;

procedure TFrmOrgaosGestores.OnSelectItem(Sender: TObject);
begin
 if CdsOrgaos.Active then CdsOrgaos.Close;
 if CdsDirigentesGestao.Active then CdsDirigentesGestao.Close;
 if CdsDirigente.Active then CdsDirigente.Close;
 if CdsDirigentesAtuais.Active then CdsDirigentesAtuais.Close;


 case FmeGestoes1.SelectedType of
  tiOrgaoGestor:
   begin
     MainPage.ActivePageIndex := 1;
     CdsOrgaos.Params.Items[0].AsInteger := FmeGestoes1.GetItemID(FmeGestoes1.SelectedItem);
     CdsDirigentesAtuais.Params.Items[0].AsInteger := FmeGestoes1.GetItemID(FmeGestoes1.SelectedItem);

     CdsOrgaos.Open;
     CdsDirigentesAtuais.Open;
   end;
  tiGestao:
   begin
     MainPage.ActivePageIndex := 3;
     CdsOrgaos.Params.Items[0].AsInteger := FmeGestoes1.GetItemID(FmeGestoes1.SelectedItem.Parent);
     CdsDirigentesGestao.Params.Items[0].AsInteger := FmeGestoes1.GetItemID(FmeGestoes1.SelectedItem);

     CdsOrgaos.Open;
     CdsDirigentesGestao.Open;
   end;
  tiMembro:
   begin
     MainPage.ActivePageIndex := 2;
     CdsOrgaos.Params.Items[0].AsInteger := FmeGestoes1.GetItemID(FmeGestoes1.SelectedItem.Parent.Parent);
     CdsDirigente.Params.Items[0].AsInteger := FmeGestoes1.GetItemID(FmeGestoes1.SelectedItem.Parent);
     CdsDirigente.Params.Items[1].AsInteger := FmeGestoes1.GetItemID(FmeGestoes1.SelectedItem);

     CdsOrgaos.Open;
     CdsDirigente.Open;
   end;
  tiEsfera, tiUnknown: MainPage.ActivePageIndex := 0;
 end;
end;

procedure TFrmOrgaosGestores.UpdateData(Sender: TObject);
begin

end;

procedure TFrmOrgaosGestores.UpdateVisualElements;
begin
  inherited;
 ActionManager1.Style := ICosmosApp.InterfaceStyle;
end;

initialization
 RegisterClass(TFrmOrgaosGestores);

finalization
 UnRegisterClass(TFrmOrgaosGestores);

end.
