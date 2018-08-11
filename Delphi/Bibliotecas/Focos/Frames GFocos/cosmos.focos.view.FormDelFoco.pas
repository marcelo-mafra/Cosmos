unit cosmos.focos.view.FormDelFoco;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, GraphicHeader, GroupHeader, ValueComboBox, Grids,
  cosmos.frames.searchdata, ComCtrls, DBClient, cosmos.classes.application,
  cosmos.classes.ServerInterface, cosmos.system.messages,
  cosmos.framework.interfaces.root, cosmos.framework.interfaces.Applications;

type
  TFrmDelFocus = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    Label1: TLabel;
    Bevel1: TBevel;
    MSGroupHeader1: TMSGroupHeader;
    MSGroupHeader2: TMSGroupHeader;
    FmeSearchNewFocus: TFmeSearchData;
    Label2: TLabel;
    FmeSearchFocoDesativado: TFmeSearchData;
    Label3: TLabel;
    LsvInfo: TListView;
    BtnTransferir: TButton;
    Button2: TButton;
    Button3: TButton;
    BtnDel: TButton;
    procedure BtnDelClick(Sender: TObject);
    procedure BtnTransferirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FICosmosApp: ICosmosApplication;

  public
    { Public declarations }
    function DesactiveFocus(const codfoc: integer; nomfoc: string): boolean;
    function DeleteFocus(const codfoc: integer; nomfoc: string): boolean;

    property ICosmosApp: ICosmosApplication read FICosmosApp;
  end;

var
  FrmDelFocus: TFrmDelFocus;

implementation

{$R *.dfm}

function TFrmDelFocus.DesactiveFocus(const codfoc: integer;
  nomfoc: string): boolean;
var
AData: TCosmosData;
begin
 Result := False;
 AData := TCosmosData.Create(10);
 AData.WriteValue('codfoc', codfoc);
 AData.WriteValue('nomfoc', nomfoc, 1);

 try
  FmeSearchFocoDesativado.WriteData(AData, 'nomfoc');
  Result := ShowModal = mrOk;

 finally
  if Assigned(AData) then
   FreeAndNil(AData);
 end;
end;

procedure TFrmDelFocus.FormCreate(Sender: TObject);
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;
 FmeSearchNewFocus.CosmosSearch := csFocosAtivos;
end;

procedure TFrmDelFocus.FormDestroy(Sender: TObject);
begin
 FICosmosApp := nil;
end;

procedure TFrmDelFocus.BtnTransferirClick(Sender: TObject);
var
I: integer;
aStringList: TStringList;
OldFocus, NewFocus: integer;
Item: TListItem;
IFocos: ICosmosFocos;
begin
 if FmeSearchNewFocus.CosmosData <> nil then
  begin
   ICosmosApp.DlgMessage.InfoMessage(TCosmosTitles.Focos, TCosmosErrorFocMsg.NoTargetFocus);
   Exit;
  end;

 if FmeSearchNewFocus.ReadValue('codfoc') = FmeSearchFocoDesativado.ReadValue('codfoc') then
  begin
   ICosmosApp.DlgMessage.InfoMessage(TCosmosTitles.Focos, TCosmosErrorFocMsg.SameTargetFocus);
   Exit;
  end;

 aStringList := TStringList.Create;
 IFocos := Application.MainForm as ICosmosFocos;

 try
  LsvInfo.Items.Clear;
  OldFocus := FmeSearchFocoDesativado.ReadValue('codfoc');
  NewFocus := FmeSearchNewFocus.ReadValue('codfoc');
  aStringList.CommaText := IFocos.DesactiveFocus(OldFocus, NewFocus, True);

  if aStringList.Count > 0 then
   begin
     for I := 0 to Pred(aStringList.Count) do
       begin
        Item := LsvInfo.Items.Add;
        Item.Caption := aStringList.Strings[I];
        Item.SubItems.Add('ok'); //do not localize!
       end;
   end;

  IFocos := nil;
  ModalResult := mrOk;

 except
  if Assigned(aStringList) then FreeAndNil(aStringList);
  if Assigned(IFocos) then IFocos := nil;
  raise;
 end;
end;

function TFrmDelFocus.DeleteFocus(const codfoc: integer;
  nomfoc: string): boolean;
var
AData: TCosmosData;
begin
 Result := False;
 AData := TCosmosData.Create(10);

 try
  AData.WriteValue('codfoc', codfoc);
  AData.WriteValue('nomfoc', nomfoc, 1);
  FmeSearchFocoDesativado.WriteData(AData, 'nomfoc');
  FmeSearchFocoDesativado.Enabled := False;
  FmeSearchNewFocus.Enabled := False;
  BtnTransferir.Enabled := False;
  BtnDel.Enabled := True;

  Result := ShowModal = mrOk;

 finally
  if Assigned(AData) then FreeAndNil(AData);
 end;
end;

procedure TFrmDelFocus.BtnDelClick(Sender: TObject);
var
 IFocos: ICosmosFocos;
begin
 //Chama o método remoto que exclui um foco.
 IFocos := Application.MainForm as ICosmosFocos;

 try
   if IFocos.DeleteFocus(FmeSearchFocoDesativado.ReadValue('codfoc')) then
    ModalResult := mrOk;

 finally
  if Assigned(IFocos) then IFocos := nil;
 end;
end;

end.
