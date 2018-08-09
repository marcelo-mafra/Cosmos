unit BackgroundWorker;

interface

uses
  SysUtils, Classes;

type
  TInnerThread = class(TThread)
   private
     FMethod: TNotifyEvent;

   protected
     procedure Execute; override;

   public
     constructor Create(CreateSuspended: boolean; AMethod: TNotifyEvent);
  end;


  TBackgroundWorker = class(TComponent)
  private
    { Private declarations }
    FDoWork: TNotifyEvent;
  protected
    { Protected declarations }
  public
    { Public declarations }
    procedure RunWorkerAsync;

  published
    { Published declarations }
    property DoWork: TNotifyEvent read FDoWork write FDoWork;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Cosmos', [TBackgroundWorker]);
end;

{ TInnerThread }

constructor TInnerThread.Create(CreateSuspended: boolean;
  AMethod: TNotifyEvent);
begin
 inherited Create(CreateSuspended);
 FMethod := AMethod;
end;

procedure TInnerThread.Execute;
begin
  inherited;
  FreeOnTerminate := True;
  FMethod(nil);
end;

{ TBackgroundWorker }

procedure TBackgroundWorker.RunWorkerAsync;
begin
 if Assigned(DoWork) then
  TInnerThread.Create(False, DoWork);
end;

end.
