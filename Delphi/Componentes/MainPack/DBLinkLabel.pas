unit DBLinkLabel;

interface

uses
  SysUtils, Classes, Controls, StdCtrls, DBCtrls, Graphics;

type
  TDBLinkLabel = class(TDBText)
  private
    FShowLink: boolean;
    procedure SetShowLink(const Value: boolean);
    procedure DoMouseLeave(Sender: TObject);
    procedure DoMouseEnter(Sender: TObject);
    procedure DoMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    { Published declarations }
    property ShowLink: boolean read FShowLink write SetShowLink;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Cosmos', [TDBLinkLabel]);
end;

{ TDBLinkLabel }

constructor TDBLinkLabel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  TCustomLabel(Self).OnMouseLeave := DoMouseLeave;
  TCustomLabel(Self).OnMouseEnter := DoMouseEnter;
  TLabel(Self).OnMouseMove := DoMouseMove;
  TCustomLabel(Self).ControlStyle := Self.ControlStyle + [csReplicatable];
end;

destructor TDBLinkLabel.Destroy;
begin
 TCustomLabel(Self).OnMouseLeave := nil;
 TCustomLabel(Self).OnMouseEnter := nil;
 TLabel(Self).OnMouseMove := nil;
 inherited Destroy;
end;

procedure TDBLinkLabel.DoMouseLeave(Sender: TObject);
begin
 TDBText(Sender).Font.Style :=  TDBText(Sender).Font.Style - [fsUnderline]
end;

procedure TDBLinkLabel.DoMouseEnter(Sender: TObject);
begin
 if (DataSource <> nil) and (DataSource.DataSet <> nil) and (DataSource.DataSet.Active) then
  TDBText(Sender).Font.Style :=  TDBText(Sender).Font.Style + [fsUnderline]
end;

procedure TDBLinkLabel.SetShowLink(const Value: boolean);
begin
  FShowLink := Value;
end;

procedure TDBLinkLabel.DoMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 DoMouseEnter(Sender);
end;

end.
