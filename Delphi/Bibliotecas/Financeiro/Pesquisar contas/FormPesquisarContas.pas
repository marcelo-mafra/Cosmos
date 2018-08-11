unit FormPesquisarContas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, cosmos.frames.gridsearch,
  cosmos.frames.PlanoContas, DB, DBClient, Cosmos.Framework.Interfaces.Root,
  Cosmos.Framework.Interfaces.DataAcess, Cosmos.Framework.Interfaces.Dialogs;

type

  TFrmPesquisarContas = class(TForm, ISearchPlanoContas)
    RdbHierarquica: TRadioButton;
    RadioButton2: TRadioButton;
    Bevel1: TBevel;
    Bevel2: TBevel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    FmePlanoContas1: TFmePlanoContas;
    FmeGridSearch1: TFmeGridSearch;
    CdsContas: TClientDataSet;
    DsrContas: TDataSource;
    procedure RadioButton2Click(Sender: TObject);
    procedure RdbHierarquicaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FVisaoPlanoContas: TVisaoPlanoContas;
    FIRemoteCon: ICosmosRemoteConnection;
    FICosmosApp: ICosmosApplication;

  protected
    function GetValue(const FieldName: string): variant;
    function GetVisao: TVisaoPlanoContas;
    procedure SetVisao(Value: TVisaoPlanoContas);

    property Visao:TVisaoPlanoContas read GetVisao write SetVisao;
    function Execute: boolean;

  public
    { Public declarations }
    property ICosmosApp: ICosmosApplication read FICosmosApp;
    property IRemoteCon: ICosmosRemoteConnection read FIRemoteCon;

  end;

var
  FrmPesquisarContas: TFrmPesquisarContas;

implementation

{$R *.dfm}

function TFrmPesquisarContas.Execute: boolean;
begin

 Result := ShowModal = mrOk;
end;

procedure TFrmPesquisarContas.FormCreate(Sender: TObject);
var
I: integer;
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;
 FIRemoteCon := Application.MainForm as ICosmosRemoteConnection;

 for I := 0 to PageControl1.PageCount - 1 do
  PageControl1.Pages[I].TabVisible := False;

 CdsContas.Params.Items[0].Value := ICosmosApp.ActiveFocus.FocusID;

 FmePlanoContas1.ListarContas;
 FmePlanoContas1.CanEdit := False;

 Visao := vpHierarquico;

 FmeGridSearch1.SearchFields := 'descon';
 PageControl1.ActivePageIndex := 0;

end;

function TFrmPesquisarContas.GetValue(const FieldName: string): variant;
begin
 Result := null; //default
 case self.Visao of
   vpHierarquico:
    begin
     if self.FmePlanoContas1.SelectedItem <> nil then
      begin
       if LowerCase(FieldName) = 'codcon' then
        Result := self.FmePlanoContas1.SelectedItem.codcon
       else
       if LowerCase(FieldName) = 'descon' then
        Result := self.FmePlanoContas1.SelectedItem.descon
       else
       if LowerCase(FieldName) = 'desconing' then
        Result := self.FmePlanoContas1.SelectedItem.desconing
       else
       if LowerCase(FieldName) = 'indnac' then
        Result := self.FmePlanoContas1.SelectedItem.indnac
       else
       if LowerCase(FieldName) = 'codfoc' then
        Result := self.FmePlanoContas1.SelectedItem.codfoc
       else
       if LowerCase(FieldName) = 'nomfoc' then
        Result := self.FmePlanoContas1.SelectedItem.nomfoc;
      end;
    end;
   vpTabular:
    begin
     if CdsContas.FindField(FieldName) <> nil then
      Result := CdsContas.Fields.FieldByName(FieldName).Value;
    end;
 end;
end;

function TFrmPesquisarContas.GetVisao: TVisaoPlanoContas;
begin
 Result := FVisaoPlanoContas;
end;

procedure TFrmPesquisarContas.RadioButton2Click(Sender: TObject);
begin
 Visao := vpTabular;
end;

procedure TFrmPesquisarContas.RdbHierarquicaClick(Sender: TObject);
begin
 Visao := vpHierarquico;
end;

procedure TFrmPesquisarContas.SetVisao(Value: TVisaoPlanoContas);
begin
 if Value <> FVisaoPlanoContas then
  begin
    FVisaoPlanoContas := Value;

    case Value of
      vpHierarquico: PageControl1.ActivePageIndex := 0;
      vpTabular:
       begin
        PageControl1.ActivePageIndex := 1;
        if not CdsContas.Active then
         CdsContas.Open;
       end;
    end;
  end;
end;

initialization
 RegisterClass(TFrmPesquisarContas);

finalization
 UnRegisterClass(TFrmPesquisarContas);

end.
