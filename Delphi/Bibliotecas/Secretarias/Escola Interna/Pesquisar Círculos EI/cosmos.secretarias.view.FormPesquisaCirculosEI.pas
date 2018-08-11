unit cosmos.secretarias.view.FormPesquisaCirculosEI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ValueComboBox, ExtCtrls, GroupHeader, DB, DBClient,
  Buttons, ImgList, ActnList, cosmos.frames.gridsearch, Cosmos.Framework.Interfaces.Root,
  Cosmos.Framework.Interfaces.DataAcess, Cosmos.Framework.Interfaces.Dialogs,
  cosmos.classes.application, cosmos.system.messages, cosmos.classes.ServerInterface,
  cosmos.system.files, System.Actions, System.ImageList;

type
  TFrmPesquisaCirculosEI = class(TForm, ISearchCirculosEI)
    CdsData: TClientDataSet;
    DsrData: TDataSource;
    MSGroupHeader1: TMSGroupHeader;
    MSGroupHeader2: TMSGroupHeader;
    CBXDiscipulados: TValueComboBox;
    FmeGridSearch1: TFmeGridSearch;
    ActionList1: TActionList;
    ActSelect: TAction;
    ActCancel: TAction;
    ActHelp: TAction;
    ImageList1: TImageList;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    procedure FmeGridSearch1DBGrid1DblClick(Sender: TObject);
    procedure CBXDiscipuladosDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure CBXDiscipuladosChange(Sender: TObject);
    procedure ActSelectUpdate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ActHelpExecute(Sender: TObject);
    procedure ActCancelExecute(Sender: TObject);
    procedure ActSelectExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FActiveFocus: integer;
    FICosmosApp: ICosmosApplication;
    FIRemoteCon: ICosmosRemoteConnection;

    procedure ListDiscipuladosEI(const ADataset: TClientDataset);
    function GetDataset: TDataset;

  protected
    function GetValue(FieldName: string): variant;
    property Dataset: TDataset read GetDataset;
    function Execute: boolean;

  public
    { Public declarations }
    property ActiveFocus: integer read FActiveFocus;
    property ICosmosApp: ICosmosApplication read FICosmosApp;
    property IRemoteCon: ICosmosRemoteConnection read FIRemoteCon;
  end;

var
  FrmPesquisaCirculosEI: TFrmPesquisaCirculosEI;

implementation

{$R *.dfm}

procedure TFrmPesquisaCirculosEI.ActCancelExecute(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TFrmPesquisaCirculosEI.ActHelpExecute(Sender: TObject);
begin
 if Self.HelpContext <> 0 then
  Application.HelpSystem.ShowContextHelp(Self.HelpContext, Application.CurrentHelpFile);
end;

procedure TFrmPesquisaCirculosEI.ActSelectExecute(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TFrmPesquisaCirculosEI.ActSelectUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := (CdsData.Active) and not (CdsData.IsEmpty);
end;

procedure TFrmPesquisaCirculosEI.CBXDiscipuladosChange(Sender: TObject);
var
AParams: TCosmosData;
begin
 AParams := TCosmosData.Create(10);
 CdsData.DisableControls;

 try
  if CdsData.Active then
   CdsData.Close;

  AParams.WriteValue('CODFOC', ICosmosApp.ActiveFocus.FocusID);
  AParams.WriteValue('CODDIS', StrToInt(CBXDiscipulados.GetValue), 1);

  IRemoteCon.ExecuteDQL(csCirculosEIFocoDiscipulado, AParams.Data, CdsData);
  IRemoteCon.LoadFieldsInfo(CdsData);

 finally
  CdsData.EnableControls;
  if Assigned(AParams) then FreeAndNil(AParams);
 end;
end;

procedure TFrmPesquisaCirculosEI.CBXDiscipuladosDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
Bmp: TBitmap;
begin
 Bmp := TBitmap.Create;
 ImageList1.GetBitmap(3,Bmp);

 with CBXDIscipulados.Canvas do
  begin
   FillRect(REct);
   Draw(Rect.Left , Rect.Top, Bmp);
   TextOut(Rect.Left + 20, Rect.Top + 2,CBXDIscipulados.Items.Strings[Index]);
  end;
end;

function TFrmPesquisaCirculosEI.Execute: boolean;
begin
 Result := ShowModal = mrOk;
end;

procedure TFrmPesquisaCirculosEI.FmeGridSearch1DBGrid1DblClick(Sender: TObject);
begin
 if (CdsData.Active) and not (CdsData.IsEmpty) then
  ActSelect.Execute;
end;

procedure TFrmPesquisaCirculosEI.FormCreate(Sender: TObject);
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;
 FIRemoteCon := Application.MainForm as ICosmosRemoteConnection;
 FActiveFocus := ICosmosApp.ActiveFocus.FocusID;


 CdsData.RemoteServer := IRemoteCon.ConnectionBroker;

 FmeGridSearch1.ShowSearchBar := False;

 ListDiscipuladosEI(IRemoteCon.OpenBufferedData(TCosmosFiles.BufDiscipulados));
end;

procedure TFrmPesquisaCirculosEI.FormDestroy(Sender: TObject);
begin
 if Assigned(ICosmosApp) then FICosmosApp := nil;
 if Assigned(IRemoteCon) then FIRemoteCon := nil;
end;

function TFrmPesquisaCirculosEI.GetDataset: TDataset;
begin
 Result := CdsData;
end;

function TFrmPesquisaCirculosEI.GetValue(FieldName: string): variant;
begin
 if CdsData.Active then
  begin
    if CdsData.FindField(FieldName) <> nil then
     Result := CdsData.Fields.FieldByName(FieldName).Value
    else
     Result := unassigned;
  end
 else
  Result := unassigned;
end;

procedure TFrmPesquisaCirculosEI.ListDiscipuladosEI(const ADataset: TClientDataset);
begin
//Lista os discipulados da Escola Interna no combobox
 ADataset.Filter := Format('INDESCINT = %s AND INDATI = %s', [QuotedStr('S'), QuotedStr('S')]);
 ADataset.Filtered := True;
 ADataset.IndexFieldNames := 'seqdis';

 with CBXDiscipulados do
  begin
    Items.Clear;
    Values.Clear;
    while not ADataset.Eof do
     begin
       Items.Append(ADataset.Fields.FieldByName('nomdis').AsString);
       Values.Append(ADataset.Fields.FieldByName('coddis').AsString);
       ADataset.Next;
     end;
  end;
end;


initialization
 RegisterClass(TFrmPesquisaCirculosEI);

finalization
 UnRegisterClass(TFrmPesquisaCirculosEI);

end.
