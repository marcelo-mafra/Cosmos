unit main;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Windows, ActiveX, Classes, ComObj, fbservices_TLB, StdVcl;

type
  Tfbserv = class(TTypedComObject, Ifbserv)
  protected
    function FirebirdIsRunning: WordBool; stdcall;
    function StartGuardian: WordBool; stdcall;
    procedure StartServer; stdcall;
    procedure StopServer; stdcall;
    procedure StopGuardian; stdcall;

  end;

implementation

uses ComServ, FBManager;

function Tfbserv.FirebirdIsRunning: WordBool;
var
Manager : TFBManager;
begin
 Manager := TFBManager.Create;

 try
  Result := False;
  Result := Manager.IsFBRunning;

 finally
  if Assigned(manager) then
   Manager.Free;
 end;
end;

function Tfbserv.StartGuardian: WordBool;
var
 Manager: TFBManager;
begin
 try
  Manager := TFBManager.Create;
   if not Manager.IsFBRunning then
    Manager.StartGuardian;

  Result := True;
  if Assigned(Manager) then
   Manager.Free;

 except
  Result := False;
  if Assigned(manager) then
   Manager.Free;
 end;

end;

procedure Tfbserv.StartServer;
var
Manager : TFBManager;
begin
 try
  Manager := TFBManager.Create;
  Manager.StartServer;

 finally
  if Assigned(manager) then
   Manager.Free;
 end;

end;

procedure Tfbserv.StopServer;
var
Manager : TFBManager;
begin
 try
  Manager := TFBManager.Create;
  Manager.StopServer;

 finally
  if Assigned(manager) then
   Manager.Free;
 end;

end;

procedure Tfbserv.StopGuardian;
begin

end;

initialization
  TTypedComObjectFactory.Create(ComServer, Tfbserv, Class_fbserv,
    ciMultiInstance, tmApartment);
end.
