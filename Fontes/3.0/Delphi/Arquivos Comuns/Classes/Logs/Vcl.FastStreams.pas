{ sdStreams.pas

  - TsdFastMemStream with improved capacity setting
  - TsdStringStream
  - TsdBufferWriter

  Author: Nils Haeck M.Sc.
  copyright (c) 2002 - 2011 SimDesign BV (www.simdesign.nl)
}
unit Vcl.FastStreams;

{$ifdef lcl}{$MODE Delphi}{$endif}

{$define simdesign.inc}

interface

uses
  Classes, SysUtils;//, sdDebug;

type

  // TsdFastMemStream deals differently with capacity compared to a normal
  // TMemoryStream; it increases the capacity with the natural growing function
  // (fibonacci) each time, and has an initial capacity of $1000. The initial
  // capacity is configurable with the create parameter.
  TFastMemStream = class(TStream)
  private
    FMemory: Pointer;
    FPosition: NativeInt;
    FFib1: NativeInt;
    FCapacity: NativeInt;
    FSize: NativeInt;
  protected
    procedure SetCapacity(Value: NativeInt);
    procedure SetSize(NewSize: NativeInt);
  public
    constructor Create(InitialCapacity: NativeInt = $1000);
    destructor Destroy; override;
    procedure Clear;
    function Read(var Buffer; Count: NativeInt): NativeInt;
    function Write(const Buffer; Count: NativeInt): NativeInt;
    function Seek(Offset: NativeInt; Origin: TSeekOrigin): NativeInt;
    procedure LoadFromFile(AFilename: string);
    procedure LoadFromStream(Stream: TStream);
    procedure SaveToFile(AFilename: string);
    procedure SaveToStream(Stream: TStream);

    property Memory: Pointer read FMemory;
    property Size: NativeInt read FSize write SetSize;
  end;

  // Delphi's implementation of TStringStream is severely flawed, it does a SetLength
  // on each write, which slows down everything to a crawl. This implementation over-
  // comes this issue.
  TFastStringStream = class(TFastMemStream)
  public
    constructor Create(const S: Utf8String);
    function DataString: Utf8String;
  end;

  // TsdBufferWriter is a buffered stream that takes another stream (ASource)
  // and writes only buffer-wise to it, and writes to the stream are first
  // done to the buffer. This stream type can only support writing.
  TBufferWriter = class(TFastMemStream)
  private
    FSource: TStream;
    FChunkSize: NativeInt;
    FRawBuffer: array of byte;
    FRawPosition: NativeInt;
  protected
    procedure WriteChunk(Count: NativeInt);
  public
    // Create the buffered writer stream by passing the destination stream in ASource,
    // this destination stream must already be initialized.
    constructor Create(ASource: TStream; AChunkSize: NativeInt);
    destructor Destroy; override;
    function Read(var Buffer; Count: NativeInt): NativeInt;
    function Write(const Buffer; Count: NativeInt): NativeInt;
  end;

implementation

{ TsdFastMemStream }

procedure TFastMemStream.Clear;
begin
  SetCapacity(0);
  FSize := 0;
  FPosition := 0;
end;

constructor TFastMemStream.Create(InitialCapacity: NativeInt);
begin
  inherited Create;
  FFib1 := InitialCapacity div 2;
  FCapacity := InitialCapacity;
  if FFib1 < 4 then
    FFib1 := 4;
  if FCapacity < 4 then
    FCapacity := 4;
  ReallocMem(FMemory, FCapacity);
end;

destructor TFastMemStream.Destroy;
begin
  ReallocMem(FMemory, 0);
  inherited;
end;

procedure TFastMemStream.LoadFromFile(AFilename: string);
var
  Stream: TStream;
begin
  Stream := TFileStream.Create(AFileName, fmOpenRead or fmShareDenyWrite);
  try
    LoadFromStream(Stream);
  finally
    Stream.Free;
  end;
end;

procedure TFastMemStream.LoadFromStream(Stream: TStream);
var
  Count: NativeInt;
begin
  Stream.Position := 0;
  Count := Stream.Size;
  SetSize(Count);
  if Count <> 0 then Stream.ReadBuffer(FMemory^, Count);
end;

function TFastMemStream.Read(var Buffer; Count: NativeInt): NativeInt;
begin
  if (FPosition >= 0) and (Count >= 0) then
  begin
    Result := FSize - FPosition;
    if Result > 0 then
    begin
      if Result > Count then
        Result := Count;
      Move(Pointer(NativeInt(FMemory) + FPosition)^, Buffer, Result);
      Inc(FPosition, Result);
      Exit;
    end;
  end;
  Result := 0;
end;

procedure TFastMemStream.SaveToFile(AFilename: string);
var
  Stream: TStream;
begin
  Stream := TFileStream.Create(AFileName, fmCreate);
  try
    SaveToStream(Stream);
  finally
    Stream.Free;
  end;
end;

procedure TFastMemStream.SaveToStream(Stream: TStream);
begin
  if FSize <> 0 then Stream.WriteBuffer(FMemory^, FSize);
end;

function TFastMemStream.Seek(Offset: NativeInt; Origin: TSeekOrigin): NativeInt;
begin
  case Origin of
    soBeginning: FPosition := Offset;
    soCurrent: Inc(FPosition, Offset);
    soEnd: FPosition := FSize + Offset;
  end;
  Result := FPosition;
end;

procedure TFastMemStream.SetCapacity(Value: NativeInt);
// Fibonacci 0,1,1,2,3,5,8,...  FCapacity is Fib2.
// Fibonacci is a natural growing function where
// 0 + 1 = 1; 1 + 1 = 2; 1 + 2 = 3; 2 + 3 = 5; etc
var
  Fib3: NativeInt;
begin
  while FCapacity < Value do
  begin
    Fib3 := FFib1 + FCapacity;
    FFib1 := FCapacity;
    FCapacity := Fib3;
  end;
  ReallocMem(FMemory, FCapacity);
end;

procedure TFastMemStream.SetSize(NewSize: NativeInt);
var
  OldPosition: NativeInt;
begin
  OldPosition := FPosition;
  SetCapacity(NewSize);
  FSize := NewSize;
  if OldPosition > NewSize then
    Seek(0, soEnd);
end;

function TFastMemStream.Write(const Buffer; Count: NativeInt): NativeInt;
var
  NewPos: NativeInt;
begin
  if (FPosition >= 0) and (Count >= 0) then
  begin
    NewPos := FPosition + Count;
    if NewPos > 0 then
    begin
      if NewPos > FSize then
      begin
        if NewPos > FCapacity then
          SetCapacity(NewPos);
        FSize := NewPos;
      end;
      System.Move(Buffer, Pointer(NativeInt(FMemory) + FPosition)^, Count);
      FPosition := NewPos;
      Result := Count;
      Exit;
    end;
  end;
  Result := 0;
end;

{ TsdStringStream }

constructor TFastStringStream.Create(const S: Utf8String);
begin
  inherited Create;
  SetSize(length(S));
  if Size > 0 then
  begin
    Write(S[1], Size);
    Position := 0;
  end;
end;

function TFastStringStream.DataString: Utf8String;
begin
  SetLength(Result, Size);
  if Size > 0 then
  begin
    Position := 0;
    Read(Result[1], length(Result));
  end;
end;

{ TsdBufferWriter }

constructor TBufferWriter.Create(ASource: TStream; AChunkSize: NativeInt);
begin
  inherited Create;
  FSource := ASource;
  FChunkSize := AChunkSize;
  SetLength(FRawBuffer, FChunkSize);
end;

destructor TBufferWriter.Destroy;
begin
  // write the last chunk, if any
  WriteChunk(FRawPosition);
  // free the rawbuffer
  SetLength(FRawBuffer, 0);
  inherited;
end;

function TBufferWriter.Read(var Buffer; Count: NativeInt): NativeInt;
begin
  // not implemented
  raise Exception.Create('not implemented');
end;

function TBufferWriter.Write(const Buffer; Count: NativeInt): NativeInt;
var
  Idx, Siz: NativeInt;
begin
  // index in the source buffer
  Idx := 0;
  // remaining size
  Siz := Count;

  // surplus
  while FRawPosition + Siz >= FChunkSize do
  begin
    Move(TByteArray(Buffer)[Idx], FRawBuffer[FRawPosition], FChunkSize - FRawPosition);
    WriteChunk(FChunkSize);
    dec(Siz, FChunkSize - FRawPosition);
    inc(Idx, FChunkSize - FRawPosition);
    FRawPosition := 0;
  end;

  // copy the raw buffer
  Move(TByteArray(Buffer)[Idx], FRawBuffer[FRawPosition], Siz);
  inc(FRawPosition, Siz);

  Result := Count;
end;

procedure TBufferWriter.WriteChunk(Count: NativeInt);
begin
  if Count > 0 then
  begin
    FSource.WriteBuffer(FRawBuffer[0], Count);
  end;
end;

end.
