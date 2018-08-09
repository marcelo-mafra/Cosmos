unit cosmos.frames.cadsearch;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls,
  Vcl.DBCGrids, Vcl.Buttons, Vcl.StdCtrls, Data.DB, Vcl.DBCtrls,
  Datasnap.DBClient, cosmos.framework.interfaces.root, cosmos.classes.ServerInterface,
  cosmos.classes.application, Vcl.Menus, Vcl.Imaging.pngimage;

type
  TFmeCadastradosSearch = class(TFrame)
    EdtArguments: TLabeledEdit;
    BtnExecute: TSpeedButton;
    DBCtrlGrid1: TDBCtrlGrid;
    BvlTop: TBevel;
    DsrData: TDataSource;
    DBText1: TDBText;
    DBText2: TDBText;
    DBText3: TDBText;
    DBText4: TDBText;
    Image1: TImage;
    Image2: TImage;
    PopupMenu1: TPopupMenu;
    Apenaslocal1: TMenuItem;
    odososncleo1: TMenuItem;
    Image3: TImage;
    N1: TMenuItem;
    PesquisarpeloNome1: TMenuItem;
    Pesquisarpelamatrcula1: TMenuItem;
    procedure BtnExecuteClick(Sender: TObject);
    procedure EdtArgumentsChange(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
  private
    { Private declarations }
    FCollapsed: boolean;
    aDataset: TClientDataSet;
    FOnSelectData: TNotifyEvent;
    FCurrentWidth, FCurrentHeight: integer;

    procedure SetCollapsed(value: boolean);
    procedure ExecuteSearch;

  public
    { Public declarations }
   property Collapsed: boolean read FCollapsed write SetCollapsed default False;
   property OnSelectData: TNotifyEvent read FOnSelectData write FOnSelectData;
   function GetValue(const FieldName: string): variant;
  end;

implementation

{$R *.dfm}

{ TFmeCadastradosSearch }

procedure TFmeCadastradosSearch.ExecuteSearch;
var
 ICosmosApp: ICosmosApplication;
 aParams: TCosmosData;
 aFieldValue: string;
begin
 if assigned(aDataset) then FreeAndNil(aDataset);

 aDataset := TClientDataSet.Create(self);
 aParams := TCosmosData.Create(10);
 ICosmosApp := Application.MainForm as ICosmosApplication;

 try
  aFieldValue := TrimRight(EdtArguments.Text) + '%';
  aFieldValue := AFieldValue.QuotedString;

  aParams.WriteValue('nomcad', 'nomcad');
  aParams.WriteValue('fieldvalue', aFieldValue, 1);

  aFieldValue := '= ' + QuotedStr('S');
  aParams.WriteValue('indati', aFieldValue, 2);

  ICosmosApp.IRemoteCon.ExecuteDQL(csCadastrado, aParams.Data, aDataset);
  DsrData.DataSet := aDataset;

 finally
  if Assigned(ICosmosApp) then ICosmosApp := nil;
  if Assigned(aParams) then FreeAndNil(aParams);
 end;
end;

function TFmeCadastradosSearch.GetValue(const FieldName: string): variant;
begin
 if (Assigned(aDataset)) and (aDataset.Active) then
  begin
   if aDataset.FindField(FieldName) <> nil then
    Result := aDataset.FieldValues[FieldName]
   else
    Result := null;
  end
 else
  Result := null;

end;

procedure TFmeCadastradosSearch.Image1Click(Sender: TObject);
begin
 if Assigned(FOnSelectData) then
   FOnSelectData(self);
end;

procedure TFmeCadastradosSearch.Image2Click(Sender: TObject);
begin
 Collapsed := not Collapsed;
end;

procedure TFmeCadastradosSearch.Image3Click(Sender: TObject);
var
 MousePos: TPoint;
begin
 GetCursorPos(MousePos);
 PopupMenu1.Popup(MousePos.X, MousePos.Y);
end;

procedure TFmeCadastradosSearch.SetCollapsed(value: boolean);
begin
 FCollapsed := value;

 if Value = True then
  begin
   FCurrentWidth := self.Width;
   FCurrentHeight := self.Height;
   self.Height := BvlTop.Height;
  end
 else
  begin
   self.Width := FCurrentWidth;
   self.Height := FCurrentHeight;
  end;

 DBCtrlGrid1.Visible := not Collapsed;
end;

procedure TFmeCadastradosSearch.EdtArgumentsChange(Sender: TObject);
begin
 BtnExecute.Enabled := Trim(EdtArguments.Text) <> '';
end;

procedure TFmeCadastradosSearch.BtnExecuteClick(Sender: TObject);
begin
 ExecuteSearch;
end;

end.
