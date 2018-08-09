unit DBEditDateTimePicker;
{
Data-aware date-time picker desenhado sem a borda do TDBEdit e com um TDateTimePicker embutido.
}
interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Controls,
  Vcl.ComCtrls, Vcl.DBCtrls, Vcl.Forms, Data.DB, Winapi.CommCtrl, System.DateUtils,
  System.MaskUtils, Vcl.Dialogs;

type
  TDBEditDateTimePicker = class;

  TDateTimePickerDBEdit = class(TDBEdit)
  private
    FAutoApplyEditMask: Boolean;
    FDefaultEditMask: TEditMask;
    function GetPicker : TDBEditDateTimePicker;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
  protected
	procedure KeyPress(var Key: Char); override;
	procedure KeyDown(var Key: Word; Shift: TShiftState); override;
  public
    property DefaultEditMask : TEditMask read FDefaultEditMask write FDefaultEditMask;
    property AutoApplyEditMask : Boolean read FAutoApplyEditMask write FAutoApplyEditMask;
  end;

  TDBEditDateTimePicker = class(TDateTimePicker)
  private
    FDBEdit : TDateTimePickerDBEdit;
    FDefaultEditMask: TEditMask;
    FAutoApplyEditMask: Boolean;
    IgnoreChange : Boolean;
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(const Value: TDataSource);
    function GetReadOnly: Boolean;
    procedure SetReadOnly(const Value: Boolean);
    procedure DoDropDown;
    procedure DoCloseUp;
    procedure PrepareCalendar;
    procedure SetFieldValue;
    procedure AddStyle (Handle : HWND; Value : Integer);
    procedure CNNotify (var Message: TWMNotify); message CN_NOTIFY;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    function GetButtonWidth : Integer;
    function CanEdit : Boolean;
    procedure SetDefaultEditMask(const Value: TEditMask);
    procedure SetAutoApplyEditMask(const Value: Boolean);
  protected
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    procedure Resize; override;
    procedure Change; override;
  public
    constructor Create (AOwner : TComponent); override;
    procedure ToggleCalendar;
    property Field : TField read GetField;
    property DBEdit : TDateTimePickerDBEdit read FDBEdit;
    function Focused : Boolean; override;
    procedure SetFocus; override;
  published
    property DataField : string read GetDataField  write SetDataField;
    property DataSource : TDataSource read GetDataSource write SetDataSource;
    property ReadOnly : Boolean read GetReadOnly write SetReadOnly;
    property WeekNumbers;
    property DefaultEditMask : TEditMask read FDefaultEditMask write SetDefaultEditMask;
    property AutoApplyEditMask : Boolean read FAutoApplyEditMask write SetAutoApplyEditMask;
  end;

procedure Register;

implementation

uses Mask;

procedure Register;
begin
  RegisterComponents('Data Controls', [TDBEditDateTimePicker]);
end;

{ TDBEditDateTimePicker }

procedure TDBEditDateTimePicker.AddStyle(Handle: HWND; Value: Integer);
var
	Style : Integer;
begin
	if (Handle = 0) then
    begin
    	exit;
    end;

    Style := GetWindowLong(Handle, GWL_STYLE);
    Style := Style or Value;
    SetWindowLong(Handle, GWL_STYLE, Style);
end;

function TDBEditDateTimePicker.CanEdit: Boolean;
begin
	result := (Field <> nil)
       	and (not ReadOnly)
    	and (Field.DataSet.CanModify);
end;

procedure TDBEditDateTimePicker.CMEnter(var Message: TCMEnter);
begin
	if (FDBEdit <> nil) then
    begin
		FDBEdit.SetFocus;
    end;
	inherited;
end;

procedure TDBEditDateTimePicker.CNNotify(var Message: TWMNotify);
begin
	if Message.NMHdr.code = DTN_DROPDOWN then
    begin
		PrepareCalendar;
    end;
    inherited;
end;

constructor TDBEditDateTimePicker.Create(AOwner: TComponent);
begin
	FDefaultEditMask := '!99/99/99;1;_';
    FAutoApplyEditMask := true;
	inherited;
    FDBEdit := TDateTimePickerDBEdit.Create(Self);
    FDBEdit.BorderStyle := bsNone;
    FDBEdit.Top := 2;
    FDBEdit.Left := 2;
    FDBEdit.ParentColor := true;
    FDBEdit.Parent := Self;
    FDBEdit.AutoSize := true;

    FDBEdit.AutoApplyEditMask := AutoApplyEditMask;
    FDBEdit.DefaultEditMask := DefaultEditMask;
    FDBEdit.TabStop := false;
end;

procedure TDBEditDateTimePicker.DoCloseUp;
var
	ButtonWidth: Integer;
begin
	ButtonWidth:=GetButtonWidth;
	PostMessage(Self.Handle, WM_LBUTTONDOWN, 0,
    	Integer(SMALLPOINT(Self.ClientWidth-ButtonWidth-2, ButtonWidth)));
end;

procedure TDBEditDateTimePicker.DoDropDown;
var
	XWidht: Integer;
begin
	XWidht := GetButtonWidth div 2;
	PostMessage(Self.Handle, WM_LBUTTONDOWN, 0,
    	Integer(SMALLPOINT(Self.ClientWidth-XWidht, XWidht)));
end;

function TDBEditDateTimePicker.GetButtonWidth: Integer;
begin
	result := GetSystemMetrics(SM_CXVSCROLL);
end;

procedure TDBEditDateTimePicker.GetChildren(Proc: TGetChildProc;
  Root: TComponent);
begin
	inherited;
end;

function TDBEditDateTimePicker.GetDataField: string;
begin
	result := FDBEdit.DataField;
end;

function TDBEditDateTimePicker.GetDataSource: TDataSource;
begin
	result := FDBEdit.DataSource;
end;

function TDBEditDateTimePicker.GetField: TField;
begin
	result := FDBEdit.Field;
end;

function TDBEditDateTimePicker.GetReadOnly: Boolean;
begin
	result := FDBEdit.ReadOnly;
end;

procedure TDBEditDateTimePicker.PrepareCalendar;
var
	Calhandle : HWND;
  CalRect : TRect;
	ST: TSystemTime;
begin
    Calhandle := self.GetCalendarHandle;

    if Calhandle = 0 then
    begin
        exit;
    end;

    IgnoreChange := true;
    if (Field <> nil) and (Field.IsNull) then
    begin
    	DateTimeToSystemTime(System.SysUtils.Date, ST);
        Self.Date := System.SysUtils.Date;
    end
    else
    begin
    	DateTimeToSystemTime(Field.AsDateTime, ST);
        Self.Date := Field.AsDateTime;
    end;
	MonthCal_SetCurSel (CalHandle, ST);
    IgnoreChange := false;

    if Self.WeekNumbers then
    begin
        AddStyle (CalHandle, 4);
    end;

	SendMessage (Calhandle, 4105, 0, Integer(@calRect));

	MoveWindow (CalHandle, 0, 0, CalRect.Right +2, CalRect.Bottom, true);
end;

procedure TDBEditDateTimePicker.SetFieldValue;
var
	OldDateTime : TDateTime;
begin
	if CanEdit then
    begin
    	OldDateTime := Field.AsDateTime;

        Field.DataSet.Edit;
        ReplaceDate (OldDateTime, Self.Date);
        if Field.AsDateTime <> OldDateTime then
        begin
	        Field.AsDateTime := OldDateTime;
        end;
    end;

end;

procedure TDBEditDateTimePicker.SetDataField(const Value: string);
begin
	FDBEdit.DataField := Value;
end;

procedure TDBEditDateTimePicker.SetDataSource(const Value: TDataSource);
begin
	FDBEdit.DataSource := Value;
end;

procedure TDBEditDateTimePicker.SetReadOnly(const Value: Boolean);
begin
	FDBEdit.ReadOnly := Value;
end;

procedure TDBEditDateTimePicker.ToggleCalendar;
begin
	if not Self.DroppedDown then
    begin
        DoDropDown;
    end
    else
    begin
    	DoCloseUp;
    end;
end;

procedure TDateTimePickerDBEdit.CMEnter(var Message: TCMEnter);
begin
	inherited;

    if (Field <> nil) and (Field.EditMask = '')
    	and AutoApplyEditMask then
    begin
        Field.EditMask := Self.FDefaultEditMask;
    end;
end;

procedure TDateTimePickerDBEdit.CMExit(var Message: TCMExit);
var
	OriginalMask : TEditMask;
begin
	OriginalMask := Self.EditMask;

    try
    begin
	    if Self.Modified then
	    begin
		    ReformatText('');
		    if Self.Text <> '' then
    	    begin
        		ReformatText (OriginalMask);
    	    end
	        else
        	begin
	            // Deixa com máscara vazia até um update...
	        end;
	    end;
	   	inherited;
    end
	finally
    	begin
		    if EditMask <> OriginalMask then
		    begin
		        // Restaura a antiga máscara.
		        EditMask := OriginalMask;
		    end;
        end
    end;
end;

function TDateTimePickerDBEdit.GetPicker: TDBEditDateTimePicker;
begin
	if Parent is TDBEditDateTimePicker then
    begin
        result := TDBEditDateTimePicker (Parent);
    end
    else
    begin
    	result := nil;
    end;
end;

procedure TDateTimePickerDBEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
    if (Key = VK_F4) and (GetPicker <> nil) then
    begin
    	GetPicker.ToggleCalendar;
    end;

	inherited;
end;

procedure TDBEditDateTimePicker.Resize;
begin
	inherited;
    FDBEdit.Width := Self.ClientWidth - GetButtonWidth - 2;
end;

procedure TDBEditDateTimePicker.SetDefaultEditMask(const Value: TEditMask);
begin
	FDefaultEditMask := Value;
    if FDBEdit <> nil then
    begin
        FDBEdit.DefaultEditMask := Value;
    end;
end;

procedure TDateTimePickerDBEdit.KeyPress(var Key: Char);
begin
    if (Field <> nil)
    	and (Field.CanModify)
    	and (Field.IsNull)
        and (Ord (Key) >= Ord('0'))
        and (Ord (Key) <= Ord('9')) then
    begin
    	Field.DataSet.Edit;
        Field.AsDateTime := System.SysUtils.Date;
    end;
	inherited;
end;

procedure TDBEditDateTimePicker.SetAutoApplyEditMask(const Value: Boolean);
begin
	FAutoApplyEditMask := Value;
    if FDBEdit <> nil then
    begin
        FDBEdit.AutoApplyEditMask := Value;
    end;
end;

procedure TDBEditDateTimePicker.Change;
begin
	if not IgnoreChange then
    begin
		SetFieldValue;
		inherited;
    end;
end;

function TDBEditDateTimePicker.Focused: Boolean;
begin
	result := DBEdit.Focused;
end;

procedure TDBEditDateTimePicker.SetFocus;
begin
	//inherited;
    DBEdit.SetFocus;
end;

end.
