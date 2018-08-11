unit DBDateTimePicker;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ComCtrls, Vcl.DbCtrls, Data.Db;

type
  TDBDateTimePicker = class(TDateTimePicker)
  private
    { private declarations }

    // ...
    FDataLink: TFieldDataLink;

    procedure dataChange(Sender: TObject);
    procedure updateData(Sender: TObject);

    //métodos da propriedade de link com datasource
    procedure setDataSource(Value: TDataSource);
    function  getDataSource: TDataSource;

    // métodos de link com a propriedade datafield
    procedure setDataField(const value : string);
    function  getDataField : string;

    // Retorna o TField com o qual o controle está ligado.
    function  getField : TField;

    // enter e exit
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;

  protected
    { protected declarations }

  public
    { public declarations }

    // constructor e distructor
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;

    // override do método change
    procedure Change; override;


    property Field      : TField      read getField;

  published
    { published declarations }


    property DataField  : string      read getDataField  write setDataField;
    property DataSource : TDataSource read getDataSource write setDataSource;
  end;

procedure Register;

implementation


constructor TDBDateTimePicker.create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FDataLink                 := TFieldDataLink.Create;
  FDataLink.Control         := Self;
  FDataLink.OnDataChange    := DataChange;
  FDataLink.OnUpdateData    := UpdateData;
end;

destructor TDBDateTimePicker.destroy;
begin
  FDataLink.free;
  FDataLink := nil;

  inherited destroy;
end;

procedure TDBDateTimePicker.dataChange(Sender: TObject);
begin
  // é um field válido ?
  if fDataLink.field <> nil then begin
    // recebe o valor datetime
    dateTime := fDataLink.field.asDateTime;
  end;
end;

procedure TDBDateTimePicker.UpdateData(Sender: TObject);
begin
  // é um field válido?
  if fDataLink.field <> nil then begin
     fDataLink.field.asDateTime := dateTime;
  end;
end;

function TDBDateTimePicker.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TDBDateTimePicker.SetDataSource(Value: TDataSource);
begin
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState)) then
    FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

function TDBDateTimePicker.GetDataField: string;
begin
  result := fDataLink.FieldName;
end;

procedure TDBDateTimePicker.SetDataField(const Value: string);
begin
  fDataLink.FieldName := Value;
end;

function TDBDateTimePicker.getField : TField;
begin
  result := FDataLink.field;
end;

procedure TDBDateTimePicker.change;
begin
  // uma mudança foi feita no field...
  if fDataLink.edit then begin
    // chama o método "change" herdado.
    inherited Change;

    // altera a propriedade "modifed" do data link
    fDataLink.modified;
  end;
end;

procedure TDBDateTimePicker.CMEnter(var Message: TCMEnter);
begin
  inherited;
  FDataLink.CanModify;
end;

procedure TDBDateTimePicker.CMExit(var Message: TCMExit);
begin
  try
    FDataLink.UpdateRecord;
  except
    SetFocus;
    raise;
  end;

  inherited;
end;

procedure Register;
begin
  RegisterComponents('Data Controls', [TDBDateTimePicker]);
end;

end.
