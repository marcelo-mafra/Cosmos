unit FormAtaPosse;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FormCosmosHelpDialog, ExtCtrls, StdCtrls, ImgList, ComCtrls, Buttons,
  DB, DBClient, cosmos.core.ConstantesMsg, ActnList,
  Cosmos.Framework.Interfaces.DataAcess, Cosmos.Framework.Interfaces.Dialogs,
  cosmos.Framework.forms.mydialogs, System.Actions;

type

  TFrmAtaPosse = class(TFrmCosmosHelpDialog, IAtaPosse)
    LsvOG: TListView;
    Label2: TLabel;
    ImageList1: TImageList;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Label3: TLabel;
    EdtModelFile: TEdit;
    SpeedButton1: TSpeedButton;
    Bevel2: TBevel;
    CdsData: TClientDataSet;
    DlgOpen: TOpenDialog;
    EdtFileName: TEdit;
    SpeedButton2: TSpeedButton;
    Label4: TLabel;
    CdsTeams: TClientDataSet;
    ActionList1: TActionList;
    ActGerar: TAction;
    EdtGestao: TEdit;
    Label5: TLabel;
    procedure EdtGestaoChange(Sender: TObject);
    procedure EdtGestaoKeyPress(Sender: TObject; var Key: Char);
    procedure ActGerarUpdate(Sender: TObject);
    procedure ActGerarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
    fgestao: integer;
    function GetGestao: integer;
    procedure SetGestao(const Value: integer);

    procedure ListaOrgaos;
    function GetTeam(const codorg: integer; Periodo: integer): string;
    procedure DoGenerateAta(var Model: Olevariant; Periodo: integer);
    procedure ReplaceText(var FindTo, ReplaceFor: Olevariant;
      Doc: TWordDocument); inline;

  protected

   procedure GenerateAta;
   property Gestao: integer read GetGestao write SetGestao;

  public
    { Public declarations }


  end;

var
  FrmAtaPosse: TFrmAtaPosse;

implementation

{$R *.dfm}

{ TFrmAtaPosse }

procedure TFrmAtaPosse.ActGerarExecute(Sender: TObject);
var
ModelFile: Olevariant;
begin
  inherited;
  if LsvOG.Items.Count = 0 then
   begin
    TMyDialogs.WarningMessage(sWarnNoOrgaoSelcionado);
    Exit;
   end;

  ModelFile := EdtModelFile.Text;
  DoGenerateAta(ModelFile, Gestao);
end;

procedure TFrmAtaPosse.ActGerarUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (Trim(EdtModelFile.Text) <> '') and
   (Trim(EdtFileName.Text) <> '') and (EdtModelFile.Text <> EdtFileName.Text)
   and (EdtGestao.Text <> '');
end;

procedure TFrmAtaPosse.EdtGestaoChange(Sender: TObject);
begin
  inherited;
  if TEdit(Sender).Text <> '' then
   Gestao := StrToInt(EdtGestao.Text);
end;

procedure TFrmAtaPosse.EdtGestaoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if not (key in ['0'..'9', #8]) then
   Abort;
end;

procedure TFrmAtaPosse.FormCreate(Sender: TObject);
var
IRemoteCon: ICosmosRemoteConnection;
begin
  inherited;
  IRemoteCon := Application.MainForm as ICosmosRemoteConnection;
  CdsData.ConnectionBroker := IRemoteCon.ConnectionBroker;
  CdsTeams.ConnectionBroker := IRemoteCon.ConnectionBroker;
end;

procedure TFrmAtaPosse.GenerateAta;
begin
 ListaOrgaos;
 ShowModal;
end;

procedure TFrmAtaPosse.DoGenerateAta(var Model: Olevariant; Periodo: integer);
var
codorg: integer;
Template, NewTemplate, ItemIndex, FindText, ReplacedText: OleVariant;
vReadOnly, NewFile: OleVariant;
Item: TListItem;
I: integer;
begin
 Template := EmptyParam;
 NewTemplate := True;
 ItemIndex := 1;

 try
  WA.Connect;

 except
  TMyDialogs.ErrorMessage(sErrorMSWord);
  Abort;
 end;


 try
   WA.Visible := True;
   WA.Caption := sMSWordCaption;
  
   Template := EmptyParam;
   NewTemplate := False;
   vReadOnly := False;
  
   WA.Documents.Open(Model, EmptyParam, vReadOnly, EmptyParam, EmptyParam, EmptyParam,
    EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam,
    EmptyParam, EmptyParam);
  
   WD.ConnectTo(WA.Documents.Item(ItemIndex));
  
   for I := 0 to Pred(LsvOG.Items.Count) do
     begin
       Item := LsvOG.Items.Item[I];
       if (Item <> nil) and (Item.Checked) then
        begin
         FindText := Format('[%s]', [Item.SubItems.Strings[0]]);
         ReplacedText := Item.Caption;
         ReplaceText(FindText,ReplacedText, WD);
  
         codorg := Item.OverlayIndex;
         FindText := Format('[%s_TEAM]', [Item.SubItems.Strings[0]]);
         ReplacedText := GetTeam(codorg,Periodo);
         ReplaceText(FindText, ReplacedText, WD);
        end;
     end;
  
   NewFile := EdtFileName.Text;
   WD.SaveAs(NewFile, EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam,
    EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam);


 finally
   WD.Disconnect;
   WA.Disconnect;
 end;
end;

function TFrmAtaPosse.GetGestao: integer;
begin
 Result := fGestao;
end;

function TFrmAtaPosse.GetTeam(const codorg: integer; Periodo: integer): string;
var
I: integer;
List: TStringList;
s: string;
begin
 try
  Result := '';
  if CdsTeams.Active then
   CdsTeams.Close;
  CdsTeams.Params.Items[0].Value := Periodo;
  CdsTeams.Params.Items[1].Value := codorg;
  CdsTeams.Open;
  if not CdsTeams.IsEmpty then
   begin
    List := TStringList.Create;

    while not CdsTeams.Eof do
     begin
      List.Append(CdsTeams.Fields.Fields[0].AsString);
      CdsTeams.Next;
     end;

    if List.Count > 0 then
     for I := 0 to Pred(List.Count) do
      begin
       s := s + List.Strings[I] + ', ';
      end;

     Delete(s, Length(s) - 1, 2);
    Result := s;

   end;

 finally
  if CdsTeams.Active then
   CdsTeams.Close;
 end;
end;

procedure TFrmAtaPosse.ListaOrgaos;
var
Item: TListItem;
begin
 with CdsData do
  begin
   if Active then Close;

   Open;
   LsvOG.Items.BeginUpdate;
   LsvOG.Items.Clear;

   while not EOF do
    begin
     Item := LsvOG.Items.Add;
     Item.Caption := Trim(Fields.FieldByName('nomorg').AsString);
     Item.SubItems.Add(Trim(Fields.FieldByName('sigorg').AsString));
     Item.ImageIndex := 0;
     Item.OverlayIndex := Fields.FieldByName('codorg').AsInteger;

     Item.Checked := Fields.FieldByName('indata').AsString = 'S';
     Next;
    end;

   LsvOG.Items.EndUpdate; 
   Close;
  end;
end;

procedure TFrmAtaPosse.ReplaceText(var FindTo, ReplaceFor: Olevariant;
  Doc: TWordDocument);
var
vForward, vReplace, vReplaceAll: Olevariant;
begin
 vForward := True;
 vReplace := True;
 vReplaceAll := wdReplaceAll;

 Doc.Content.Find.Forward := True;
 Doc.Content.Find.Wrap := 2;
 Doc.Content.Find.Execute(FindTo ,EmptyParam, EmptyParam, EmptyParam, EmptyParam,
   EmptyParam, vForward, EmptyParam, EmptyParam, ReplaceFor, vReplaceAll, EmptyParam,
   EmptyParam, EmptyParam, EmptyParam);
end;

procedure TFrmAtaPosse.SetGestao(const Value: integer);
begin
 fGestao := Value;
 EdtGestao.Text := IntToStr(Value);
end;

procedure TFrmAtaPosse.SpeedButton1Click(Sender: TObject);
begin
  inherited;
  if DlgOpen.Execute then
   EdtModelFile.Text := DlgOpen.FileName;
end;

procedure TFrmAtaPosse.SpeedButton2Click(Sender: TObject);
begin
  inherited;
  if DlgOpen.Execute then
   EdtFileName.Text := DlgOpen.FileName;
end;

initialization
 RegisterClass(TFrmAtaPosse);

finalization
 UnRegisterClass(TFrmAtaPosse);

end.
