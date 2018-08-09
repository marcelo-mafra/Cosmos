unit cosmos.common.view.PesquisarConferencias;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FormDefaultSearchs, Vcl.ImgList,
  System.Actions, Vcl.ActnList, Data.DB, Datasnap.DBClient, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, cosmos.frames.gridsearch, Vcl.Samples.Spin,
  ValueComboBox, cosmos.system.messages, cosmos.business.focos,
  Cosmos.Framework.Interfaces.DataAcess, Cosmos.Framework.Interfaces.Dialogs,
  Datasnap.DSConnect;

type
  TFrmPesquisarConferencias = class(TFrmDefaultSearchs, IPesquisaConferencias)
    Label1: TLabel;
    CBXFocos: TValueComboBox;
    Label2: TLabel;
    EdtAno: TSpinEdit;
    CBXCampo: TValueComboBox;
    BitBtn4: TBitBtn;
    FmeGridSearch1: TFmeGridSearch;
    Bevel2: TBevel;
    ActPesquisar: TAction;
    CdsData: TClientDataSet;
    DsrData: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure ActPesquisarExecute(Sender: TObject);
    procedure ActPesquisarUpdate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FmeGridSearch1DBGrid1DblClick(Sender: TObject);
  private
    { Private declarations }
    FActiveFocus: boolean;
    FCampoTrabalho: TCampoTrabalho;
    FRemoteConnection: TDSProviderConnection;
    procedure ListFocos;

    function GetActiveFocus: boolean;
    function GetCampoTrabalho: TCampoTrabalho;
    procedure SetCampoTrabalho(value: TCampoTrabalho);
    procedure SetActiveFocus(const value: boolean);
    function GetDataset: TDataset;


  protected
    function Execute: boolean;
    function GetValue(FieldName: string): variant;

    property ActiveFocus: boolean read GetActiveFocus write SetActiveFocus ;
    property CampoTrabalho: TCampoTrabalho read GetCampoTrabalho write SetCampoTrabalho;
    property Dataset: TDataset read GetDataset;

  public
    { Public declarations }
    function GetWindowsId: string; override;
  end;

var
  FrmPesquisarConferencias: TFrmPesquisarConferencias;

implementation

{$R *.dfm}

procedure TFrmPesquisarConferencias.ActPesquisarExecute(Sender: TObject);
begin
  inherited;
 try
   with CdsData do
    begin
      DisableControls;
      if Active then Close;
      Params.Items[0].Value := CBXFocos.GetValue;
      Params.Items[1].Value := CBXCampo.GetValue;
      Params.Items[2].Value := EdtAno.Value;
      Open;
    end;

 finally
  CdsData.EnableControls;
  ActiveDataset := CdsData;
 end;
end;

procedure TFrmPesquisarConferencias.ActPesquisarUpdate(Sender: TObject);
begin
  inherited;
 TAction(Sender).Enabled := (CBXFOcos.ItemIndex >= 0) and (CBXCampo.ItemIndex >= 0)
  and (EdtAno.Text <> '');
end;

function TFrmPesquisarConferencias.Execute: boolean;
begin
 Result := ShowModal = mrOk;
end;

procedure TFrmPesquisarConferencias.FmeGridSearch1DBGrid1DblClick(
  Sender: TObject);
begin
  inherited;
  if (CdsData.Active) and not (CdsData.IsEmpty) then
   ActSelect.Execute;
end;

procedure TFrmPesquisarConferencias.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
//Não fecha o dataset aqui porque ele precisa estar aberto para leitura nos métodos evocadores.
 if Assigned(FRemoteConnection) then
  ICosmosApp.IRemoteCon.DropConnection(FRemoteConnection);

 inherited;
end;

procedure TFrmPesquisarConferencias.FormCreate(Sender: TObject);
var
m, d, y: word;
begin
  inherited;
 FCampoTrabalho := ctAll;
 FRemoteConnection := ICosmosApp.IRemoteCon.CreateConnection(scCommon);
 CdsData.RemoteServer := FRemoteConnection;

 DecodeDate(IRemoteCon.ServerDateTime, y, m, d);
 EdtAno.Value := y;
 FmeGridSearch1.SearchFields := 'nomcon';
 ListFocos;
end;

function TFrmPesquisarConferencias.GetActiveFocus: boolean;
begin
 Result := FActiveFocus;
end;

function TFrmPesquisarConferencias.GetCampoTrabalho: TCampoTrabalho;
begin
 Result := FCampoTrabalho;
end;

function TFrmPesquisarConferencias.GetDataset: TDataset;
begin
 Result := CdsData;
end;

function TFrmPesquisarConferencias.GetValue(FieldName: string): variant;
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

function TFrmPesquisarConferencias.GetWindowsId: string;
begin
 Result := '{182F6764-0E51-4916-8F2F-5F86FF7E8870}';
end;

procedure TFrmPesquisarConferencias.ListFocos;
var
Cds : TClientDataset;
begin
 if (ActiveFocus) and (ICosmosApp.ActiveFocus <> nil) then
  begin
   CBXFocos.Items.Add(ICosmosApp.ActiveFocus.FocusName);
   CBXFocos.Values.Add(IntToStr(ICosmosApp.ActiveFocus.FocusID));
   CBXFocos.ItemIndex := 0;
   Exit;
  end;

 try
  Cds := IRemoteCon.OpenBufferedData(TCosmosFiles.BufFocos);
  Cds.Filter := Format('indati = %s', [QuotedStr('S')]);
  Cds.Filtered := True;
  Cds.IndexFieldNames := 'NOMFOC';

  while not Cds.Eof do
   begin
    CBXFocos.Items.Add(Cds.Fields.FieldByName('nomfoc').AsString);
    CBXFocos.Values.Add(Cds.Fields.FieldByName('codfoc').AsString);
    Cds.Next;
   end;

 finally
  Cds.Free;
  if (ICosmosApp.ActiveFocus <> nil) then
   CBXFocos.ItemIndex := CBXFocos.Items.IndexOf(ICosmosApp.ActiveFocus.FocusName)
  else
   CBXFocos.ItemIndex := 0; //Primeiro foco da lista.
 end;

end;

procedure TFrmPesquisarConferencias.SetActiveFocus(const value: boolean);
begin
 FActiveFocus := Value;
 //Caso ACtiveFocos seja True desabilita o controle de seleção de focos.
 CBXFocos.Enabled := not FActiveFocus;
end;

procedure TFrmPesquisarConferencias.SetCampoTrabalho(value: TCampoTrabalho);
begin
 FCampoTrabalho := Value;

 case Value of
   ctLectorium: CBXCampo.ItemIndex := 0;
   ctTM: CBXCampo.ItemIndex := 1;
   ctTP: CBXCampo.ItemIndex := 2;
   ctSimpatizantes: CBXCampo.ItemIndex := 3;
   ctEI: CBXCampo.ItemIndex := 4;
   ctTMB: CBXCampo.ItemIndex := -1;
   ctAll: CBXCampo.ItemIndex := 0;
 end;
end;

initialization
 RegisterClass(TFrmPesquisarConferencias);

finalization
 UnRegisterClass(TFrmPesquisarConferencias);

end.
