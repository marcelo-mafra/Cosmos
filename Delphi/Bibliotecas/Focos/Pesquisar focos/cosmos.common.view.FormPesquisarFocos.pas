unit cosmos.common.view.FormPesquisarFocos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FormCosmosHelpDialog, ExtCtrls, StdCtrls, ActnList, ImgList,
  cosmos.framework.interfaces.Root, Cosmos.Framework.Interfaces.DataAcess,
  cosmos.Framework.Interfaces.Dialogs, Buttons, cosmos.business.focos,
  System.Actions, cosmos.frames.FrameFocos;

type
  TFrmPesquisarFocos = class(TFrmCosmosHelpDialog, IPesquisaFocosRAs)
    Bevel2: TBevel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    ActionList1: TActionList;
    ImageList1: TImageList;
    ActSelecionar: TAction;
    ActCancelar: TAction;
    ActAjuda: TAction;
    FmeFocos1: TFmeFocos;
    procedure ActCancelarExecute(Sender: TObject);
    procedure ActSelecionarExecute(Sender: TObject);
    procedure ActSelecionarUpdate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }

    function GetSelectedElement: TCustomFocus;

  protected
    function GetShowMenu: boolean;
    procedure SetShowMenu(value: boolean);

    function ExecuteSearch(Listagem: TTipoListagem; EnabledTypes: TTipoFocoSet;
      ListarFocosRA: boolean): TCustomFocus;

    property SelectedElement: TCustomFocus read GetSelectedElement;
    property ShowMenu: boolean read GetShowMenu write SetShowMenu;

  public
    { Public declarations }

  end;

var
  FrmPesquisarFocos: TFrmPesquisarFocos;

implementation

{$R *.dfm}

procedure TFrmPesquisarFocos.ActCancelarExecute(Sender: TObject);
begin
  inherited;
  ModalResult := mrCancel;
end;

procedure TFrmPesquisarFocos.ActSelecionarExecute(Sender: TObject);
begin
  inherited;
  ModalResult := mrOk;
end;

procedure TFrmPesquisarFocos.ActSelecionarUpdate(Sender: TObject);
begin
  inherited;
  TAction(Sender).Enabled := (FmeFocos1.SelectedType in FmeFocos1.EnabledTypes);
end;

function TFrmPesquisarFocos.ExecuteSearch(Listagem: TTipoListagem;
 EnabledTypes: TTipoFocoSet; ListarFocosRA: boolean): TCustomFocus;
begin
 Result := nil;

 FmeFocos1.ListType := tlNoneFocus; //default.
 FmeFocos1.ListFocosRa := ListarFocosRA;
 FmeFocos1.ListType := Listagem;
 FmeFocos1.EnabledTypes := EnabledTypes;

 if ShowModal = mrOk then
   Result := self.FmeFocos1.SelectedElement;
end;

procedure TFrmPesquisarFocos.FormCreate(Sender: TObject);
begin
  inherited;
  FmeFocos1.ShowMenu := False;
end;

function TFrmPesquisarFocos.GetSelectedElement: TCustomFocus;
begin
 Result := FmeFocos1.SelectedElement;
end;

function TFrmPesquisarFocos.GetShowMenu: boolean;
begin
 Result := self.FmeFocos1.ShowMenu;
end;

procedure TFrmPesquisarFocos.SetShowMenu(value: boolean);
begin
 self.FmeFocos1.ShowMenu := Value;
end;

initialization
 RegisterClass(TFrmPesquisarFocos);

finalization
 UnregisterClass(TFrmPesquisarFocos);

end.
