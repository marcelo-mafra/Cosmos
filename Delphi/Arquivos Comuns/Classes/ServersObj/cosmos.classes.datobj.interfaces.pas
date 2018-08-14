unit cosmos.classes.datobj.interfaces;

interface

uses
 System.Classes, cosmos.classes.dataobjects;

type
  ICosmosDataObj = interface
    ['{63411AAE-06C7-4FFA-84F9-6DF55C49D487}']
  end;

  ICosmosConnection = interface(ICosmosDataObj)
    ['{F34D82E3-BA98-41B9-B11B-7FEA1325ABA8}']

  end;

  ICosmosCommand = interface(ICosmosDataObj)
    ['{A3472639-FD3E-4D5E-8F06-A40D2B2D0AE1}']
    function ExecuteCommand(const Command: WideString): integer;
    function ExecuteScript(Script: TStringList): boolean;

  end;

 ICosmosScript = interface(ICosmosDataObj)
   ['{0FD7700D-57AD-43F6-829B-3D02C08209C5}']
   procedure AddCommand(Command: string);
   procedure ClearCommands;
   function ExecuteScript: boolean;
 end;

  TCosmosCommand = class(TInterfacedObject, ICosmosCommand)
   private

   public
    constructor Create;
    destructor Destroy; override;

    function ExecuteCommand(const Command: WideString): integer;
    function ExecuteScript(Script: TStringList): boolean;
  end;

 TCosmosScript = class(TInterfacedObject, ICosmosScript)
  private
   FScript: TStringList;

  public
   constructor Create;
   destructor Destroy; override;

   procedure AddCommand(Command: string);
   procedure ClearCommands;
   function ExecuteScript: boolean;

 end;

implementation

{ TCosmosCommand }

constructor TCosmosCommand.Create;
begin
 inherited Create;
end;

destructor TCosmosCommand.Destroy;
begin

  inherited;
end;

function TCosmosCommand.ExecuteCommand(const Command: WideString): integer;
var
 aCommand: TSQLServerCommand;
begin
  aCommand := TSQLServerCommand.Create;

  try
    Result := aCommand.ExecuteCommand(Command);

  finally
    aCommand.Free;
  end;
end;

function TCosmosCommand.ExecuteScript(Script: TStringList): boolean;
var
 aCommand: TSQLServerCommand;
begin
  aCommand := TSQLServerCommand.Create;

  try
    Result := aCommand.ExecuteScript(Script);

  finally
    aCommand.Free;
  end;

end;

{ TCosmosScript }

procedure TCosmosScript.AddCommand(Command: string);
begin
 FScript.Append(Command);
end;

procedure TCosmosScript.ClearCommands;
begin
 FScript.Clear;
end;

constructor TCosmosScript.Create;
begin
 FScript := TStringList.Create;
end;

destructor TCosmosScript.Destroy;
begin
  FScript.Free;
  inherited;
end;

function TCosmosScript.ExecuteScript: boolean;
var
 aCommand: TSQLServerCommand;
begin
  aCommand := TSQLServerCommand.Create;

  try
    Result := aCommand.ExecuteScript(FScript);

  finally
    aCommand.Free;
  end;
end;

end.
