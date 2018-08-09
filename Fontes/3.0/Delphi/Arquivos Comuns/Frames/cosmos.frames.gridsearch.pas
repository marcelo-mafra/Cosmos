unit cosmos.frames.gridsearch;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.ExtCtrls, Datasnap.DBclient,
  Cosmos.Framework.Interfaces.Root, Cosmos.Framework.Interfaces.Dialogs;

type
  TFmeGridSearch = class(TFrame)
    PnlSearchBar: TPanel;
    EdtSearch: TEdit;
    SbnSearch: TSpeedButton;
    SbnLocate: TSpeedButton;
    DBGrid1: TDBGrid;
    procedure SbnLocateClick(Sender: TObject);
    procedure EdtSearchKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SbnSearchClick(Sender: TObject);
    procedure DBGrid1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DBGrid1TitleClick(Column: TColumn);
  private
    { Private declarations }
    FSearchFields: string;
    FShowSearchBar: boolean;
    FCanDblClick: boolean;
    procedure SetShowSearchBar(const Value: boolean);
    function GetDataset: TDataset; inline;


  public
    { Public declarations }
    property CanDblClick: boolean read FCanDblClick;
    property SearchFields: string read FSearchFields write FSearchFields;

    procedure AutoFitColumns(Grid: TDBgrid);
    procedure DoSearch(const Argument: string); inline;
    property ShowSearchBar: boolean read FShowSearchBar write SetShowSearchBar default True;
  end;

implementation

uses cosmos.system.messages;

{$R *.dfm}

{ TFmeGridSearch }

function TFmeGridSearch.GetDataset: TDataset;
begin
 Result := nil;
 if DBgrid1.DataSource <> nil then
  Result := DBgrid1.DataSource.DataSet;
end;

procedure TFmeGridSearch.SbnLocateClick(Sender: TObject);
var
  AModule: HModule;
  AClass: TInterfacedPersistent;
  ICosmosApp: ICosmosApplication;
  ILocate: ICosmosLocateData;
  Dataset: TDataset;
begin
 inherited;
 Dataset := self.GetDataset;
 if (Dataset <> nil) and (Dataset.Active) then
  begin
    try
     ICosmosApp := Application.MainForm as ICosmosApplication;
     AClass := ICosmosApp.LoadClass('locdata.bpl', 'TDataLocateControler', AModule);

     if AModule <> 0 then
      begin
       with AClass do
        begin
         if Supports(AClass, ICosmosLocateData) then
          ILocate := AClass as ICosmosLocateData;

         if Assigned(ILocate) then
          ILocate.Execute(Dataset);


         Free;
        end;
      end;

    finally
     if Assigned(ICosmosApp) then
      ICosmosApp := nil;

     if Assigned(ILocate) then
      ILocate := nil;

     if AModule <> 0 then
      UnloadPackage(AModule);
    end;
 end;
end;

procedure TFmeGridSearch.SbnSearchClick(Sender: TObject);
begin
 DoSearch(EdtSearch.Text);
end;

procedure TFmeGridSearch.SetShowSearchBar(const Value: boolean);
begin
  FShowSearchBar := Value;
  PnlSearchBar.Visible := FShowSearchBar;
end;

procedure TFmeGridSearch.EdtSearchKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 SbnSearch.Enabled := EdtSearch.Text <> '';
 if (Key = 13) and (SbnSearch.Enabled) then
  SbnSearch.Click;
end;

procedure TFmeGridSearch.AutoFitColumns(Grid: TDBgrid);
const
  DEFBORDER = 10;
var
  temp, n: Integer;
  lmax: array [0..30] of Integer;
  Dataset: TDataset;
begin
  with Grid do
   begin
    Dataset := DataSource.DataSet;
    if (Dataset = nil) and not (Dataset.Active) then
     Exit
    else
     try
      Dataset.DisableControls;

      Canvas.Font := Font;
      for n := 0 to Columns.Count - 1 do
       //if columns[n].visible then
       lmax[n] := Canvas.TextWidth(Fields[n].FieldName) + DEFBORDER;
       grid.DataSource.DataSet.First;
       while not grid.DataSource.DataSet.EOF do
        begin
         for n := 0 to Columns.Count - 1 do
          begin
           //if columns[n].visible then begin
           temp := Canvas.TextWidth(trim(Columns[n].Field.DisplayText)) + DEFBORDER;
           if temp > lmax[n] then lmax[n] := temp;
           //end; { if }
          end; {for}
         grid.DataSource.DataSet.Next;
       end; { while }

       grid.DataSource.DataSet.First;
       for n := 0 to Columns.Count - 1 do
        if lmax[n] > 0 then
         Columns[n].Width := lmax[n];

     finally
      Dataset.EnableControls;
     end;
   end; { With }
end;


procedure TFmeGridSearch.DBGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if (Key = 13) and (Assigned(self.DBGrid1.OnDblClick)) then
  TDBgrid(Sender).OnDblClick(sender);
end;

procedure TFmeGridSearch.DBGrid1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  pt: TGridcoord;
begin
  pt:= DBGrid1.MouseCoord(x, y);

  if pt.y = 0 then //Linha de título
   DBGrid1.Cursor := crHandPoint
  else
   DBGrid1.Cursor := crDefault;

  FCanDblClick := pt.y <> 0;
end;

procedure TFmeGridSearch.DBGrid1TitleClick(Column: TColumn);
{$J+}
 const PreviousColumnIndex : integer = -1;
{$J-}
begin
  if DBGrid1.DataSource.DataSet is TClientDataset then
  with TClientDataset(DBGrid1.DataSource.DataSet) do
  begin
    try
      if PreviousColumnIndex >= 0 then
        DBGrid1.Columns[PreviousColumnIndex].title.Font.Style :=
          DBGrid1.Columns[PreviousColumnIndex].title.Font.Style - [fsBold];

      if Column.FieldName = 'MATCAD' then
       begin
        if FindField('MATCADINT') <> nil then
         IndexFieldNames := 'MATCADINT'
        else
         IndexFieldNames := 'MATCAD'
       end
      else
      if Column.FieldName = 'MES' then
       begin
        if FindField('MESREF') <> nil then
         IndexFieldNames := 'MESREF'
        else
         IndexFieldNames := 'MES'
       end
      else
       IndexFieldNames := Column.Field.FieldName;

    except

    end;

    Column.title.Font.Style := Column.title.Font.Style + [fsBold];
    PreviousColumnIndex := Column.Index;
  end;

end;

procedure TFmeGridSearch.DoSearch(const Argument: string);
var
Dataset: TDataset;
ICosmosApp: ICosmosApplication;
begin
 Dataset := GetDataset;
 if (Dataset <> nil) and (Dataset.Active) then
  begin
   if SearchFields <> '' then
    Dataset.Locate(SearchFields, Argument, [lopartialKey, loCaseInsensitive])
   else
    begin
     ICosmosApp := Application.MainForm as ICosmosApplication;

     try
      ICosmosApp.DlgMessage.WarningMessage(TCosmosTitles.SelectData, TCosmosWarningMsg.SearchFields);

     finally
      if ICosmosApp <> nil then
       ICosmosApp := nil;
     end;
    end;
  end;
end;

end.
