unit SQLScript;

{*************************************************************}
{*                 Freeware dbExpress Plus                   *}
{* Copyright (c) Business Software Systems, Inc. 1995 - 2002 *}
{*                   All rights reserved.                    *}
{*************************************************************}

{$N+,P+,S-,R-}
                                
interface

uses
  System.SysUtils, System.Classes, Vcl.Clipbrd, Data.SqlExpr, Data.DBXCommon;

type

  TOnExecuteStatement = procedure(Sender: Tobject; SQLStatement: string) of object;

  TdbxSQLScript = class(TComponent)
  private
    FAbout: String;
    FCommitEach: Boolean;
    FCurrentSQL: String;
    FDebug: Boolean;
    FSQLProc: Boolean;
    FRecordsAffected: LongWord;
    FSQL: TStrings;
    FSQLConnection: TSQLConnection;
    FSQLCount: Integer;
    FSQLCurrentLine: Integer;
    FSQLCurrentPos: Integer;
    FTransDesc: TDBXTransaction;
    FOnExecuteStatement: TOnExecuteStatement;

    procedure SetQuery(Value: TStrings);
    procedure SetSQLProc(Value: Boolean);
    procedure SetSQLCount;
    function GetSQLStatement: String;
    { Private declarations }
  protected
    { Protected declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property CurrentSQL: String read FCurrentSQL;
    property TransDesc: TDBXTransaction read FTransDesc;
    property RecordsAffected: LongWord read FRecordsAffected;
    function ExecuteDirect: LongWord;
    { Public declarations }
  published
    property About: String read FAbout;
    property CommitEach: Boolean read FCommitEach write FCommitEach;
    property Debug: Boolean read FDebug write FDebug;
    property Name;
    property OnExecuteStatement: TOnExecuteStatement read FOnExecuteStatement
        write FOnExecuteStatement;    
    property SQLProc: Boolean read FSQLProc write SetSQLProc;
    property SQLConnection: TSQLConnection read FSQLConnection write FSQLConnection;
    property SQL: TStrings read FSQL write SetQuery;
    property Tag;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('dbExpress', [TdbxSQLScript]);
end;

constructor TdbxSQLScript.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAbout := 'Ver 0.8.0.7';
  FSQL := TStringList.Create;
end;

destructor TdbxSQLScript.Destroy;
begin
  FSQL.Free;
  inherited Destroy;
end;

procedure TdbxSQLScript.SetQuery(Value: TStrings);
begin
  if SQL.Text <> Value.Text then SQL.Assign(Value);
end;

procedure TdbxSQLScript.SetSQLProc(Value: Boolean);
begin
  if Value <> FSQLProc then begin
    FSQLProc := Value;
    FCommitEach := False;
  end;
end;

procedure TdbxSQLScript.SetSQLCount;
var
  SQLLineNum, SQLPos : Integer;
  SQLTestStr : String;
  IsStringExp: Boolean;
begin
  IsStringExp := False;
  for SQLLineNum := 0 to SQL.Count-1 do begin
    SQLTestStr := Trim(SQL[SQLLineNum]);
    for SQLPos := 1 to Length(SQLTestStr) do begin
      if SQLTestStr[SQLPos] = '''' then IsStringExp := not(IsStringExp);
      if (SQLTestStr[SQLPos] = ';') and (IsStringExp = False) then
         FSQLCount := FSQLCount+1;
    end;
  end;
  if SQLTestStr > #32 then begin
    if SQLTestStr[Length(SQLTestStr)] <> ';' then FSQLCount := FSQLCount+1;
  end;
end;

function TdbxSQLScript.GetSQLStatement : String;
var
  SQLLineNum, SQLPos : Integer;
  TempSQL, SQLTestStr : String;
  BreakStatement, IsStringExp: Boolean;
begin
  BreakStatement := False;
  IsStringExp := False;
  SQLTestStr := '';
  TempSQL := '';
  for SQLLineNum := FSQLCurrentLine to SQL.Count-1 do begin
    TempSQL := TempSQL + ' ';
    SQLTestStr := Trim(SQL[SQLLineNum]);
    for SQLPos := 1 to Length(SQLTestStr) do begin
      if ((SQLLineNum = FSQLCurrentLine) and (SQLPos > FSQLCurrentPos)) or
         (SQLLineNum > FSQLCurrentLine) then begin
        if SQLTestStr[SQLPos] = '''' then IsStringExp := not(IsStringExp);
        if (SQLTestStr[SQLPos] = ';') and (IsStringExp = False) then begin
          FSQLCurrentLine := SQLLineNum;
          FSQLCurrentPos := SQLPos;
          TempSQL := Trim(TempSQL);
          BreakStatement := True;
          Break;
          end
        else begin
          TempSQL := TempSQL + SQLTestStr[SQLPos];
        end;
      end;
    end;
    if BreakStatement = True then Break;
  end;
  Result := TempSQL;
end;

function TdbxSQLScript.ExecuteDirect: LongWord;
var
  SQLStatementNum: Integer;
begin
  Result := 0;
  if SQL.Count > 0 then
   begin

    if SQLConnection = nil then
       raise Exception.Create('SQLConnection unassigned.');

    FSQLCount := 0;
    FSQLCurrentLine := 0;
    FSQLCurrentPos := 0;
    SetSQLCount;

    if FSQLProc = True then
     begin
      try
        FCurrentSQL := SQL.Text;
        if FDebug = True then
         begin
          Clipboard.SetTextBuf(PChar(FCurrentSQL));
          //OutputDebugString(PAnsiChar(FCurrentSQL));
         end;

        if Assigned(FOnExecuteStatement) then
         FOnExecuteStatement(Self, FCurrentSQL);

        FTransDesc := SQLConnection.BeginTransaction;
        Result := SQLConnection.ExecuteDirect(FCurrentSQL);
        if (SQLConnection.InTransaction = True) then
          SQLConnection.CommitFreeAndNil(FTransDesc);

      except
        on E: Exception do
         begin
          if (SQLConnection.InTransaction = True) then
           SQLConnection.RollbackFreeAndNil(FTransDesc);
          raise;
         end;
      end;
     end
    else
                    begin
      if (FCommitEach = False) then
       FTransDesc := SQLConnection.BeginTransaction;

      try
        for SQLStatementNum := 1 to FSQLCount do
         begin
          FCurrentSQL := GetSQLStatement;
          if FDebug = True then
           begin
            Clipboard.SetTextBuf(PChar(FCurrentSQL));
            //OutputDebugString(PAnsiChar(FCurrentSQL));
           end;

          if Assigned(FOnExecuteStatement) then
           FOnExecuteStatement(Self, FCurrentSQL);

          if (FCommitEach = True) then
            FTransDesc := SQLConnection.BeginTransaction;

          Result := SQLConnection.ExecuteDirect(FCurrentSQL);
          if (FCommitEach = True) and (SQLConnection.InTransaction = True) then
            SQLConnection.CommitFreeAndNil(FTransDesc);
         end;

        if (FCommitEach = False) and (SQLConnection.InTransaction = True) then
         SQLConnection.CommitFreeAndNil(FTransDesc);

      except
        on E: Exception do
         begin
          if (SQLConnection.InTransaction = True) then
           SQLConnection.RollbackFreeAndNil(FTransDesc);
          raise;
         end;
     else
      raise;
      end;
    end;
   end;
end;

end.


