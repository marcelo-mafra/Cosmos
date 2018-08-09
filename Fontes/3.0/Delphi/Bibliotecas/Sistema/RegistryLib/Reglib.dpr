library Reglib;

uses
  ComServ,
  Registry,
  Windows,
  Reglib_TLB in 'Reglib_TLB.pas',
  Functions in 'Functions.pas' {Reg: CoClass};

procedure CreateRegObject;
//Cria a instância da variável global de acesso ao registro ao carregar a dll
begin
 if not Assigned(Reg) then
  Reg := TRegistry.Create;
end;

procedure DestroyRegObject;
//Destrói a instância criada ao fechar a dll
begin
 if Assigned(Reg) then
  Reg.Free;
end;


procedure DLLEntryPoint(dwReason: DWord);
begin
 case dwReason of
  DLL_PROCESS_ATTACH: CreateRegObject;
  DLL_PROCESS_DETACH: DestroyRegObject;
 end;
end;

exports
  DllGetClassObject,
  DllCanUnloadNow,
  DllRegisterServer,
  DllUnregisterServer;

{$R *.TLB}

{$R *.RES}

begin
 DLLProc := @DLLEntryPoint;
 DLLEntryPoint(DLL_PROCESS_ATTACH);
end.
