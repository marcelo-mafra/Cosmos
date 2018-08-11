unit ValueRadioGroup;

interface

uses
  SysUtils, Classes, ExtCtrls;

type
  TValueRadioGroup = class(TRadioGroup)
  private
    { Private declarations }
    FValues: TStrings;
    procedure SetValues(Value: TStrings);
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetValue: string;
  published
    { Published declarations }
    property Align;
    property Anchors;
    property BiDiMode;
    property Caption;
    property Color;
    property Columns;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ItemIndex;
    property Items;
    property Constraints;
    property ParentBiDiMode;
    property ParentBackground default True;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnClick;
    property OnContextPopup;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnStartDock;
    property OnStartDrag;
    property Values: TStrings read FValues write SetValues;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Cosmos', [TValueRadioGroup]);
end;

constructor TValueRadioGroup.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FValues := TStringList.Create;
  Caption := Name;
end;

destructor TValueRadioGroup.Destroy;
begin
 FValues.Free;
 inherited Destroy;
end;


procedure TValueRadioGroup.SetValues(Value: TStrings);
begin
// if FValues.Text <> Value.Text then
  FValues.Assign(Value);
end;

function TValueRadioGroup.GetValue: string;
begin
 if FValues.Count <> Items.Count then
  raise exception.Create('O número de opções deve ser o mesmo do de valores!');

 Result := '';
 if ItemIndex >= 0 then
  Result := FValues.Strings[ItemIndex];
end;
end.
