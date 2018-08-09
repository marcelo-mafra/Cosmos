 library vinfo;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

{%TogetherDiagram 'ModelSupport\default.txaPackage'}
{%TogetherDiagram 'ModelSupport\vinfo\default.txaPackage'}
{%TogetherDiagram 'ModelSupport\VerInfo\default.txaPackage'}
{%TogetherDiagram 'ModelSupport\default.txvpck'}
{%TogetherDiagram 'ModelSupport\vinfo\default.txvpck'}
{%TogetherDiagram 'ModelSupport\VerInfo\default.txvpck'}

uses
  SysUtils,
  Classes,
  verinfo in 'verinfo.pas';

{$R *.res}

 function GetVersionInfo(AppPath: PChar): PChar;  stdcall;
 var
 Ver: TVerInfoRes;
 s: string;
 I: integer;
 List: TStringList;
 begin
  Result := '';
  if FileExists(AppPath) then
   try
    Ver := TVerInfoRes.Create(AppPath);
    List := TSTringList.Create;
    for I := Ord(viCompanyName) to ord(viProductVersion) do
     begin
      s := Ver.GetPreDefKeyString(TVerInfoType(I));
      if s <> '' then
       List.Add(VerTraducaoArray[TVerInfoType(I)]+ '=' + s);
     end;

    case TOSVersion.Architecture of
     arIntelX86: List.Append('Compilação=32 bits');
     arIntelX64: List.Append('Compilação=64 bits');
    end;

    Result := PChar(List.CommaText); 

   finally
    if Assigned(Ver) then
     FreeAndNil(Ver);
    if Assigned(List) then
     FreeAndNil(List);
   end;
 end;

 function GetCustomVersionInfo(AppPath, AKey: PChar): PChar; stdcall;
 var
 Ver: TVerInfoRes;
 s: string;
 begin
  Result := '';
  if FileExists(AppPath) then
   try
    Ver := TVerInfoRes.Create(AppPath);
    s := Ver.GetUserDefKeyString(Akey);
    Result := PChar(s);

   finally
    if Assigned(Ver) then
     FreeAndNil(Ver);
   end;
 end;

 function HasVersionInfo(FileName: PChar): boolean; stdcall;
 var
 Ver: TVerInfoRes;
 begin
  Result := False;
  if FileExists(FileName) then
   try
    Ver := TVerInfoRes.Create(FileName);
    Result := Ver.HasVersionInfo(FileName);

   finally
    if Assigned(Ver) then
     FreeAndNil(Ver);
   end;
 end;

exports

GetVersionInfo,
GetCustomVersionInfo,
HasVersionInfo;


begin
end.
