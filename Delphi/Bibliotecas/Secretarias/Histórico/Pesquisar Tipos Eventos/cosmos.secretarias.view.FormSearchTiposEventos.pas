unit cosmos.secretarias.view.FormSearchTiposEventos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FormDefaultSearchs, ImgList, ActnList, DB, DBClient, StdCtrls,
  Buttons, ExtCtrls, Cosmos.Framework.Interfaces.Dialogs, ValueComboBox,
  Cosmos.system.messages, Cosmos.classes.ServerInterface, cosmos.frames.gridsearch,
  cosmos.system.files, cosmos.classes.application, System.Actions,
  System.ImageList;

type
  TFrmSearchTiposEventos = class(TFrmDefaultSearchs, ISearchTiposEventosDiscipulares)
    CBXTiposEventos: TValueComboBox;
    Label1: TLabel;
    FmeGridSearch1: TFmeGridSearch;
    DsrData: TDataSource;
    procedure FmeGridSearch1DBGrid1DblClick(Sender: TObject);
    procedure CBXTiposEventosChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
    CdsSearchData: TClientDataset;
    procedure LoadTiposEventos;

  protected
    function GetDataset: TDataset;

    property Dataset: TDataset read GetDataset;
    function Execute: boolean;overload;
    function Execute(const tipeve: string): boolean; overload;

  public
    { Public declarations }
    function GetWindowsId: string; override;
  end;

var
  FrmSearchTiposEventos: TFrmSearchTiposEventos;

implementation

{$R *.dfm}

function TFrmSearchTiposEventos.Execute: boolean;
begin
 Result := ShowModal = mrOk;
end;

procedure TFrmSearchTiposEventos.CBXTiposEventosChange(Sender: TObject);
var
AParams: TCosmosData;
begin
  inherited;
  if CBXTiposEventos.Text <> '' then
   begin
    AParams := TCosmosData.Create(5);

    try
     AParams.WriteValue('TIPEVE', QuotedStr(CBXTiposEventos.GetValue));

     if Assigned(CdsSearchData) then FreeAndNil(CdsSearchData);
     CdsSearchData := TClientDataset.Create(self);
     CdsSearchData.DisableControls;

     IRemoteCon.ExecuteDQL(csEventosDiscipulares, AParams.Data, CdsSearchData);


    finally
     if Assigned(AParams) then FreeAndNil(AParams);
     DsrData.DataSet := CdsSearchData;
     CdsSearchData.EnableControls;
     ActiveDataset := CdsSearchData;
    end;
   end;
end;

function TFrmSearchTiposEventos.Execute(const tipeve: string): boolean;
begin
 Result := ShowModal = mrOk;
end;

procedure TFrmSearchTiposEventos.FmeGridSearch1DBGrid1DblClick(Sender: TObject);
begin
  inherited;
 if (ActiveDataset <> nil) and (ActiveDataset.Active) and not (ActiveDataset.IsEmpty) then
   ModalResult := mrOk;
end;

procedure TFrmSearchTiposEventos.FormCreate(Sender: TObject);
begin
  inherited;
  self.LoadTiposEventos;
  self.FmeGridSearch1.ShowSearchBar := False;
end;

function TFrmSearchTiposEventos.GetDataset: TDataset;
begin
 Result := self.ActiveDataset;
end;

function TFrmSearchTiposEventos.GetWindowsId: string;
begin
 Result := '{FEE867E0-3920-4343-9BEF-D9CD6831B6CB}';
end;

procedure TFrmSearchTiposEventos.LoadTiposEventos;
var
ADataset: TClientDataset;
sTipoEvento: string;
begin
  ADataset := TClientDataset.Create(self);

  try
   ADataset := self.IRemoteCon.OpenBufferedData(TCosmosFiles.BufTiposEventos);
   ADataset.IndexFieldNames := 'deseve';
   ADataset.First;

   while not ADataset.Eof do
    begin
     sTipoEvento := TrimRight(ADataset.Fields.FieldByName('tipeve').AsString);
     if CBXTiposEventos.Values.IndexOf(sTipoEvento) < 0 then
      begin
       self.CBXTiposEventos.Items.Append(ADataset.Fields.FieldByName('deseve').AsString);
       self.CBXTiposEventos.Values.Append(ADataset.Fields.FieldByName('tipeve').AsString);
      end;

     ADataset.Next;
    end;

  finally
   ADataset.Free;
  end;
end;

initialization
 RegisterClass(TFrmSearchTiposEventos);

finalization
 UnRegisterClass(TFrmSearchTiposEventos);

end.
