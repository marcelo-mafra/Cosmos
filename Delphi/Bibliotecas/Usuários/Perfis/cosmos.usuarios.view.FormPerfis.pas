unit cosmos.usuarios.view.FormPerfis;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cosmos.framework.view.FrmDocked, ActnList, ImgList, Cosmos.system.messages, DB, DBClient,
  XPStyleActnCtrls, ActnMan, ToolWin, ActnCtrls, Grids, DBGrids,
  Menus, ActnPopup, cosmos.frames.gridsearch, PlatformDefaultStyleActnCtrls,
  cosmos.framework.datanavigators.datasets, System.Actions, Datasnap.DSConnect,
  cosmos.framework.interfaces.dataacess, cosmos.system.formsconst,
  cosmos.classes.application;

type
  TFrmPerfis = class(TFrmCosmosDocked)
    ActNovo: TAction;
    ActDelete: TAction;
    CdsPerfis: TClientDataSet;
    ActionManager1: TActionManager;
    DsrPerfis: TDataSource;
    ImgGrid: TImageList;
    ActEdit: TAction;
    ActionToolBar1: TActionToolBar;
    PopupActionBar1: TPopupActionBar;
    NovoPerfil1: TMenuItem;
    EditarPerfil1: TMenuItem;
    ExcluirPerfil1: TMenuItem;
    FmeGridSearch1: TFmeGridSearch;
    procedure FmeGridSearch2DBGrid1DrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure CdsPerfisBeforeDelete(DataSet: TDataSet);
    procedure ActDeleteExecute(Sender: TObject);
    procedure ActEditUpdate(Sender: TObject);
    procedure ActEditExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure CdsPerfisAfterPost(DataSet: TDataSet);
    procedure ActNovoExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PopupActionBar1Popup(Sender: TObject);
    procedure FmeGridSearch1DBGrid1DblClick(Sender: TObject);
  private
    { Private declarations }
    BmpPerfil, BmpOk, BmpNo: TBitmap;
    FDataNavigator: TDatasetDataNavigator;
    FRemoteConnection: TDSProviderConnection;
    procedure LoadPerfis;
    procedure InsertPerfil;
    procedure EditPerfil;
    procedure UpdateData(Sender: TObject);

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
  FrmPerfis: TFrmPerfis;

implementation

uses cosmos.usuarios.view.FormEditarPerfil;

{$R *.dfm}

procedure TFrmPerfis.ActDeleteExecute(Sender: TObject);
begin
  inherited;
  CdsPerfis.Delete;
end;

procedure TFrmPerfis.ActEditExecute(Sender: TObject);
begin
  inherited;
  self.EditPerfil;
end;

procedure TFrmPerfis.ActEditUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := ((CdsPerfis.Active) and not (CdsPerfis.IsEmpty));
end;

procedure TFrmPerfis.ActNovoExecute(Sender: TObject);
begin
  inherited;
  self.InsertPerfil;
end;

procedure TFrmPerfis.CdsPerfisAfterPost(DataSet: TDataSet);
begin
  inherited;
  if CdsPerfis.ChangeCount > 0 then
   CdsPerfis.ApplyUpdates(0);
end;

procedure TFrmPerfis.CdsPerfisBeforeDelete(DataSet: TDataSet);
begin
  inherited;
  if ICosmosApp.DlgMessage.ConfirmationMessage(TCosmosTitles.Permissoes, TCosmosConfMsg.DelPerfil) = mrNo then
   Abort;
end;

procedure TFrmPerfis.EditPerfil;
begin
 FrmEditarperfil := TFrmEditarPerfil.Create(Application);

 try
   FrmEditarPerfil.EditarPerfil(CdsPerfis.Fields.FieldByName('codper').Value);

 finally
   if Assigned(FrmEditarPerfil) then
    FreeAndNil(FrmEditarPerfil);
 end;
end;

procedure TFrmPerfis.ExportData;
begin
  inherited;
 IRemoteCon.DefaultExport(CdsPerfis);
end;

procedure TFrmPerfis.FmeGridSearch1DBGrid1DblClick(Sender: TObject);
begin
  inherited;
  if (CdsPerfis.Active) and not (CdsPerfis.IsEmpty) then
   ActEdit.Execute;
end;

procedure TFrmPerfis.FmeGridSearch2DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
const
  Margin = 12;
  Space = 8;
var
  R: TRect;
  CenterY, CenterX, H: integer;
  S: string;
begin
  inherited;
  R := Rect;

  CenterY := R.Top + (R.Bottom - R.Top) div 2;
  CenterX := R.Left + (R.Right - R.Left) div 2;


  S := Column.Field.AsString;

  with FmeGridSearch1.DBGrid1.Canvas do
   begin
    //Deixa o fundo da fonte e grade transparentes. Sem isso, a fonte fica distorcida.
    if  gdSelected in State then
     begin
      Font.Color  := clHighlightText;
      Brush.Color := clHighlight;
     end;

    FillRect(R);

    if S = '' then
      Exit;

    if Column.Field = CdsPerfis.FieldByName('nomper') then
     begin
      Draw(Margin, CenterY - BmpPerfil.Height div 2, BmpPerfil);
      Inc(R.Left, BmpPerfil.Width + Space);

      H := TextHeight(S);
      TextRect(R, R.Left, CenterY - H div 2, S);
    end
    else
     begin
      if Column.Field.Value = 'S' then
        Draw(CenterX - BmpOk.Width div 2, CenterY - BmpOk.Height div 2,BmpOk)
       else
        Draw(CenterX - BmpNo.Width div 2, CenterY - BmpOk.Height div 2,BmpNo);
     end;
  end;
end;

procedure TFrmPerfis.FormActivate(Sender: TObject);
begin
  inherited;
  IRemoteCon.ActiveDataset := CdsPerfis;
end;

procedure TFrmPerfis.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(IRemoteCon) then
   IRemoteCon.DropConnection(FRemoteConnection);

  if Assigned(FDataNavigator) then
   FreeAndNil(FDataNavigator);

  inherited;

  Action := caFree;
  FrmPerfis := nil;
end;

procedure TFrmPerfis.FormCreate(Sender: TObject);
begin
  inherited;
  FRemoteConnection := IRemoteCon.CreateConnection(scUsuarios);
  CdsPerfis.RemoteServer := FRemoteConnection;
  FDataNavigator := TDatasetDataNavigator.Create(CdsPerfis);
  DataNavigator := FDataNavigator;
  TDatasetDataNavigator(DataNavigator).OnUpdateData := UpdateData;

  self.FmeGridSearch1.SearchFields := 'nomper';

  BmpPerfil := TBitmap.Create;
  BmpOk := TBitmap.Create;
  BmpNo := TBitmap.Create;

  ImgGrid.GetBitmap(2, BmpPerfil);
  ImgGrid.GetBitmap(0, BmpOk);
  ImgGrid.GetBitmap(1, BmpNo);

  self.LoadPerfis;
end;

function TFrmPerfis.GetFormDescription: string;
begin
Result := TDockedFormDesc.FormPerfis;
end;

function TFrmPerfis.GetFormIDName: string;
begin
 Result := 'Cosmos.Perfis';
end;

function TFrmPerfis.GetHelpFile: string;
begin
 Result := self.HelpFile;
end;

function TFrmPerfis.GetHelpID: integer;
begin
 Result := self.HelpID;
end;

function TFrmPerfis.GetTitle: string;
begin
 Result := self.Caption;
end;

procedure TFrmPerfis.InsertPerfil;
begin
 try
   FrmEditarperfil := TFrmEditarPerfil.Create(Application);
   FrmEditarPerfil.NovoPerfil;

 finally
   if Assigned(FrmEditarPerfil) then
    FreeAndNil(FrmEditarPerfil);
 end;
end;

procedure TFrmPerfis.LoadPerfis;
begin
//Carrega as informações sobre os perfis
 CdsPerfis.DisableControls;

 try
  if CdsPerfis.Active then
   CdsPerfis.Close;

  CdsPerfis.Open;

 finally
  CdsPerfis.EnableControls;
 end;
end;

procedure TFrmPerfis.Locate;
begin
  inherited;
  IRemoteCon.DefaultLocate;
end;

procedure TFrmPerfis.PopupActionBar1Popup(Sender: TObject);
begin
  inherited;
  TPopupActionBar(Sender).Style := ICosmosApp.InterfaceStyle;
end;

procedure TFrmPerfis.UpdateData(Sender: TObject);
begin
  inherited;
  CdsPerfis.Refresh;
end;

procedure TFrmPerfis.UpdateVisualElements;
begin
  inherited;
 ActionManager1.Style := ICosmosApp.InterfaceStyle;
end;

initialization
 RegisterClass(TFrmPerfis);

finalization
 UnRegisterClass(TFrmPerfis);

end.
