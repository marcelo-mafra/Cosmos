unit ValueComboBox;

interface

uses
  SysUtils, Classes, Controls, StdCtrls;

type
  TValueComboBox = class(TComboBox)
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
    procedure ClearValues;
  published
    { Published declarations }
    property AutoComplete default True;
    property AutoDropDown default False;
    property AutoCloseUp default False;
    property BevelEdges;
    property BevelInner;
    property BevelKind default bkNone;
    property BevelOuter;
    property Style; {Must be published before Items}
    property Anchors;
    property BiDiMode;
    property CharCase;
    property Color;
    property Constraints;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property DropDownCount;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property ItemHeight;
    property ItemIndex default -1;
    property MaxLength;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Sorted;
    property TabOrder;
    property TabStop;
    property Text;
    property Visible;
    property OnChange;
    property OnClick;
    property OnCloseUp;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDrawItem;
    property OnDropDown;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMeasureItem;
    property OnSelect;
    property OnStartDock;
    property OnStartDrag;
    property Items; { Must be published after OnMeasureItem }    
    property Values: TStrings read FValues write SetValues;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Cosmos', [TValueComboBox]);
end;

{ TValueComboBox }

procedure TValueComboBox.ClearValues;
begin
 Values.Clear;
end;

constructor TValueComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FValues := TStringList.Create;
end;

destructor TValueComboBox.Destroy;
begin
 FValues.Free;
 inherited Destroy;
end;

function TValueComboBox.GetValue: string;
begin
 if FValues.Count <> Items.Count then
  raise exception.Create('O número de opções deve ser o mesmo do de valores!');

 Result := '';
 if ItemIndex >= 0 then
  Result := FValues.Strings[ItemIndex];
end;

procedure TValueComboBox.SetValues(Value: TStrings);
begin
 if FValues.Text <> Value.Text then
  FValues.Assign(Value);
end;

end.
