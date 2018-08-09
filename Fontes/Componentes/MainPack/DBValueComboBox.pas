unit DBValueComboBox;

interface

uses
  Winapi.Windows, System.SysUtils, Winapi.Messages, System.Classes, Vcl.Controls,
  Vcl.StdCtrls, Data.DB, Vcl.DBCtrls, ValueComboBox;

type
  TDBValueComboBox = class(TValueComboBox)
  private
    { Private declarations }
    FDataLink: TFieldDataLink;
    function GetDataField: string;
    procedure SetDataField(const Value: string);
    function GetDataSource: TDataSource;
    procedure SetDataSource(value: TDataSource);
    function GetComboValue: string;
    procedure DataChange(Sender: TObject);
    procedure UpdateData(Sender: TObject);
    procedure SetEditReadOnly;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;

  protected
    { Protected declarations }
    procedure Change; override;
    procedure Click; override;
    procedure DropDown; override;
    procedure ComboWndProc(var Message: TMessage; ComboWnd: HWnd;
      ComboProc: Pointer); override;
    procedure CreateWnd; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure SetItems(const Value: TStrings); override;
    procedure WndProc(var Message: TMessage); override;


  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
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
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property Values;//: TStrings read FValues write SetValues;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Cosmos', [TDBValueComboBox]);
end;

{ TDBValueComboBox }

constructor TDBValueComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDataLink := TFieldDataLink.Create;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnUpdateData := UpdateData;
end;

destructor TDBValueComboBox.Destroy;
begin
 FDataLink.OnDataChange := nil;
 FDataLink.Free;
 inherited Destroy;
end;

function TDBValueComboBox.GetDataField: string;
begin
 Result := FDataLink.FieldName;
end;

function TDBValueComboBox.GetDataSource: TDataSource;
begin
 Result := FDataLink.DataSource;
end;

procedure TDBValueComboBox.SetDataField(const Value: string);
begin
 FDataLink.FieldName := Value;
end;

procedure TDBValueComboBox.SetDataSource(Value: TDataSource);
begin
 if value <> FDataLink.DataSource then
  FDataLink.DataSource := Value;
end;

procedure TDBValueComboBox.DataChange(Sender: TObject);
var
I: integer;
begin
 if FDataLink = nil then
  Text := TComponent(Sender).Name
 else
  begin
   if FDataLink.Field <> nil then
    begin
     I := Values.IndexOf(FDataLink.Field.AsString);
     ItemIndex := I;
    end;
  end;
end;

function TDBValueComboBox.GetComboValue: string;
var
  I: Integer;
begin
 I := ItemIndex;
 if I < 0 then Result := ''
 else
  Result := Values[I];
end;

procedure TDBValueComboBox.UpdateData(Sender: TObject);
begin
  FDataLink.Field.Text := GetComboValue;
end;

procedure TDBValueComboBox.Change;
begin
  FDataLink.Edit;
  inherited Change;
  FDataLink.Modified;
end;

procedure TDBValueComboBox.Click;
begin
  FDataLink.Edit;
  inherited Click;
  FDataLink.Modified;;
end;

procedure TDBValueComboBox.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  if (CharInSet(Key, [#32..#255])) and (FDataLink.Field <> nil) and
    not FDataLink.Field.IsValidChar(Key) then
  begin
    MessageBeep(0);
    Key := #0;
  end;
  case Key of
    ^H, ^V, ^X, #32..#255:
      FDataLink.Edit;
    #27:
      begin
        FDataLink.Reset;
        SelectAll;
      end;
  end;
end;

procedure TDBValueComboBox.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  if Key in [VK_BACK, VK_DELETE, VK_UP, VK_DOWN, 32..255] then
  begin
    if not FDataLink.Edit and (Key in [VK_UP, VK_DOWN]) then
      Key := 0;
  end;
end;

procedure TDBValueComboBox.DropDown;
begin
  inherited DropDown;
end;

procedure TDBValueComboBox.ComboWndProc(var Message: TMessage; ComboWnd: HWnd;
  ComboProc: Pointer);
begin
  if not (csDesigning in ComponentState) then
    case Message.Msg of
      WM_LBUTTONDOWN:
        if (Style = csSimple) and (ComboWnd <> EditHandle) then
          if not FDataLink.Edit then Exit;
    end;
  inherited ComboWndProc(Message, ComboWnd, ComboProc);

end;

procedure TDBValueComboBox.CreateWnd;
begin
  inherited CreateWnd;
  SetEditReadOnly;

end;

procedure TDBValueComboBox.SetEditReadOnly;
begin
  if (Style in [csDropDown, csSimple]) and HandleAllocated then
    SendMessage(EditHandle, EM_SETREADONLY, Ord(not FDataLink.Editing), 0);
end;

procedure TDBValueComboBox.Loaded;
begin
  inherited Loaded;
  if (csDesigning in ComponentState) then DataChange(Self);
end;

procedure TDBValueComboBox.WndProc(var Message: TMessage);
begin
  if not (csDesigning in ComponentState) then
    case Message.Msg of
      WM_COMMAND:
        if TWMCommand(Message).NotifyCode = CBN_SELCHANGE then
          if not FDataLink.Edit then
          begin
            if Style <> csSimple then
              PostMessage(Handle, CB_SHOWDROPDOWN, 0, 0);
            Exit;
          end;
      CB_SHOWDROPDOWN:
        if Message.WParam <> 0 then FDataLink.Edit else
          if not FDataLink.Editing then DataChange(Self); {Restore text}
    end;
  inherited WndProc(Message);;

end;

procedure TDBValueComboBox.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

procedure TDBValueComboBox.SetItems(const Value: TStrings);
begin
  inherited SetItems(Value);
  DataChange(Self);
end;


procedure TDBValueComboBox.CMEnter(var Message: TCMEnter);
begin
  inherited;
  if SysLocale.FarEast and FDataLink.CanModify then
    SendMessage(EditHandle, EM_SETREADONLY, Ord(False), 0);
end;

procedure TDBValueComboBox.CMExit(var Message: TCMExit);
begin
  try
    FDataLink.UpdateRecord;
  except
    SelectAll;
    SetFocus;
    raise;
  end;
  inherited;
end;

procedure TDBValueComboBox.CMGetDataLink(var Message: TMessage);
begin
   Message.Result := Integer(FDataLink);
end;

end.
