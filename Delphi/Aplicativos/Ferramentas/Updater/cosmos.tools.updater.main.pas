unit cosmos.tools.updater.main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls,
  IdBaseComponent, IdAntiFreezeBase, Vcl.IdAntiFreeze, cosmos.core.winshell;

type
  TFrmUpdateStatus = class(TForm)
    PBar: TProgressBar;
    LblStatus: TLabel;
    LblPercentProgress: TLabel;
    LblProgressKb: TLabel;
    TrayIcon: TTrayIcon;
    IdAntiFreeze1: TIdAntiFreeze;
    GroupBox1: TGroupBox;
    LblUpdateLink: TLinkLabel;
    BtnUpdate: TButton;
    procedure TrayIconDblClick(Sender: TObject);
    procedure LblUpdateLinkClick(Sender: TObject);
    procedure BtnUpdateClick(Sender: TObject);
  private
    { Private declarations }
    FCurrentUpdateFile: string;
    FUpdating: boolean;
    procedure CalculateProgress(ValorMaximo, ValorAtual: real); overload;
    procedure CalculateProgress( const ValorAtual: real); overload;

  public
    { Public declarations }
    procedure SetProgressPosition(const Position: integer);
    procedure Prepare(const MaxPosition: Int64);
    procedure FinishUpdate(const FileName, UpdateDesc: string);
    procedure WriteMessage(const Message: string);

    property CurrentUpdateFile: string read FCurrentUpdateFile;
    property Updating: boolean read FUpdating write FUpdating;
  end;

var
  FrmUpdateStatus: TFrmUpdateStatus;

implementation

{$R *.dfm}

{ TFrmUpdateStatus }

procedure TFrmUpdateStatus.CalculateProgress(ValorMaximo, ValorAtual: real);
var
 AValue: Real;
begin
 AValue := ((ValorAtual * 100) / ValorMaximo);
 LblPercentProgress.Caption := FormatFloat('0%', AValue);
 TrayIcon.Hint := Format('Obtendo nova atualização ... %s', [LblPercentProgress.Caption]);
end;

procedure TFrmUpdateStatus.BtnUpdateClick(Sender: TObject);
begin
 TWinShell.ExecuteFile(self.CurrentUpdateFile ,'','', SW_SHOWNORMAL);
end;

procedure TFrmUpdateStatus.CalculateProgress(const ValorAtual: real);
var
 AValue : real;
begin
 AValue := ((ValorAtual / 1024) / 1024);
 LblProgressKb.Caption := FormatFloat('0.000 KBs', AValue);
end;

procedure TFrmUpdateStatus.FinishUpdate(const FileName, UpdateDesc: string);
begin
  FCurrentUpdateFile := FileName;
  LblUpdateLink.Caption := UpdateDesc;
  LblUpdateLink.Visible := True;
  BtnUpdate.Visible := True;
  FrmUpdateStatus.Show;
end;

procedure TFrmUpdateStatus.LblUpdateLinkClick(Sender: TObject);
begin
 TWinShell.ExecuteFile(self.CurrentUpdateFile ,'','', SW_SHOWNORMAL);
end;

procedure TFrmUpdateStatus.Prepare(const MaxPosition: Int64);
begin
  PBar.Max := MaxPosition;
  PBar.Visible := True;
  TrayIcon.Visible := True;
end;

procedure TFrmUpdateStatus.SetProgressPosition(const Position: integer);
begin
 Updating := True;
 PBar.Position := Position;
 CalculateProgress(PBar.Max, Position);
 CalculateProgress(Position);
 Application.ProcessMessages;
end;

procedure TFrmUpdateStatus.TrayIconDblClick(Sender: TObject);
begin
 Show;
end;

procedure TFrmUpdateStatus.WriteMessage(const Message: string);
begin
 LblStatus.Caption := Message;
 self.Update;
 if not self.Visible then
  Show;

 Application.ProcessMessages;
end;

end.
