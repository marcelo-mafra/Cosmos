unit cosmos.secretarias.view.FormSearchAlocucoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, GroupHeader, Buttons, ComCtrls, ImgList, DBClient,
  cosmos.classes.application, cosmos.framework.interfaces.root, cosmos.framework.interfaces.DataAcess,
  cosmos.classes.ServerInterface, Data.SqlExpr;

type
  TFrmSearchAlocucoes = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    MSGroupHeader1: TMSGroupHeader;
    RdbAssunto: TRadioButton;
    RdbAutor: TRadioButton;
    Image1: TImage;
    MSGroupHeader2: TMSGroupHeader;
    EdtArgs: TEdit;
    BtnInclude: TSpeedButton;
    Image2: TImage;
    SpeedButton2: TSpeedButton;
    LsvArgs: TListView;
    ImageList1: TImageList;
    GrpCamposTrabalho: TMSGroupHeader;
    ChkLec: TCheckBox;
    ChkTM: TCheckBox;
    ChkTMB: TCheckBox;
    ChkTP: TCheckBox;
    RdbCampos: TRadioButton;
    procedure Button2Click(Sender: TObject);
    procedure EdtArgsKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure BtnIncludeClick(Sender: TObject);
    procedure RdbCamposClick(Sender: TObject);
  private
    { Private declarations }
    FSearchArguments: TStringList;
    FDataset: TClientDataset;
    procedure DoSearch;

  public
    { Public declarations }
    procedure ExecuteSearch(Dataset: TClientDataset);

    property Dataset: TClientDataset read FDataset write FDataset;
    property SearchArguments: TStringList read FSearchArguments write FSearchArguments;
  end;

var
  FrmSearchAlocucoes: TFrmSearchAlocucoes;

implementation

{$R *.dfm}

procedure TFrmSearchAlocucoes.Button1Click(Sender: TObject);
begin
 DoSearch;
end;

procedure TFrmSearchAlocucoes.Button2Click(Sender: TObject);
begin
 if Self.HelpContext <> 0 then
  Application.HelpSystem.ShowContextHelp(Self.HelpContext, Application.CurrentHelpFile);
end;

procedure TFrmSearchAlocucoes.DoSearch;
var
IRemoteCon: ICosmosRemoteConnection;
ASearch: TCosmosSearch;
AParamsList: TSQLParams;
ADataset: TSQLDataset;
begin
 if RdbAssunto.Checked then
  ASearch := csAlocucoesAssunto
 else
 if RdbAutor.Checked then
  ASearch := csAlocucoesAutor
 else
 if RdbCampos.Checked then
  begin
   ASearch := csAlocucoesCamposTrabalho;
   AParamsList := TSQLParams.Create(4);
   AParamsList.AppendData(ChkLec.Checked);
   AParamsList.AppendData(ChkTM.Checked, 1);
   AParamsList.AppendData(ChkTMB.Checked, 2);
   AParamsList.AppendData(ChkTP.Checked, 3);
  end;

 ADataset := TSQLDataset.Create(nil);

 try
  IRemoteCon := Application.MainForm as ICosmosRemoteConnection;
  ADataset := IRemoteCon.ExecuteDQL(ASearch, AParamsList.Params) as TSQLDataset;

  if (ADataset <> nil) and (ADataset.Active) then
   Dataset := IRemoteCon.ToClientDataset(ADataset);


 finally
  if Assigned(AParamsList) then FreeAndNil(AParamsList);
  if Assigned(ADataset) then FreeAndNil(ADataset);
 end;

{ if LsvArgs.Items.Count > 0 then
  begin
   FSearchArguments.Clear;
   for I := 0 to Pred(LsvArgs.Items.Count) do
    begin
     Item := LsvArgs.Items.Item[I];
     FSearchArguments.Add(Item.Caption + '||' + Item.SubItems.Strings[0]);
    end;

   AReturn := TServerReturn.Create;

   try
    AReturn.ReadServerReturn(AppServer.SearchAlocucoes(null, FSearchArguments.CommaText,
    ChkLec.Checked, ChkTM.Checked, ChkTMB.Checked, ChkTP.Checked));
    if AReturn.MessageType = mtpSucess then
     Dataset.Data := AReturn.ServerData
    else
     begin
      ICosmosApp := Application.MainForm as ICosmosApplication;
      ICosmosApp.DlgMessage.Execute(AReturn);
     end;

   finally
    if Assigned(AReturn) then
     AReturn.Free;
    if ICosmosApp <> nil then
     ICosmosApp := nil;
   end;
  end; }


end;

procedure TFrmSearchAlocucoes.EdtArgsKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if (Key = 13) and (TEdit(Sender).Text <> '') then
 BtnInclude.Click;
end;

procedure TFrmSearchAlocucoes.ExecuteSearch(Dataset: TClientDataset);
begin
 self.Dataset := Dataset;
 self.ShowModal;
end;

procedure TFrmSearchAlocucoes.FormCreate(Sender: TObject);
begin
  FSearchArguments := TStringList.Create;
end;

procedure TFrmSearchAlocucoes.RdbCamposClick(Sender: TObject);
begin
 self.GrpCamposTrabalho.Enabled := TRAdioButton(Sender).Checked;
end;

procedure TFrmSearchAlocucoes.BtnIncludeClick(Sender: TObject);
var
Item: TListItem;
begin
 if Trim(EdtArgs.Text) <> '' then
  begin
   Item := LsvArgs.Items.Add;
   Item.Caption := EdtArgs.Text;
   if RdbAssunto.Checked then
    begin
     Item.SubItems.Add('Assunto');
     Item.ImageIndex := 0;
    end
   else
    begin
     Item.SubItems.Add('Autor');
     Item.ImageIndex := 1;
    end;
   Item.OverlayIndex := Item.ImageIndex; 
  end;
end;

procedure TFrmSearchAlocucoes.SpeedButton2Click(Sender: TObject);
begin
 if LsvArgs.SelCount > 0 then
  LsvArgs.Selected.Delete;

end;

end.
