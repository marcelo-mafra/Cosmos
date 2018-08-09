unit fbservices_TLB;

// ************************************************************************ //
// WARNING
// -------
// The types declared in this file were generated from data read from a
// Type Library. If this type library is explicitly or indirectly (via
// another type library referring to this type library) re-imported, or the
// 'Refresh' command of the Type Library Editor activated while editing the
// Type Library, the contents of this file will be regenerated and all
// manual modifications will be lost.
// ************************************************************************ //

// $Rev: 41960 $
// File generated on 05/08/2013 22:45:00 from Type Library described below.

// ************************************************************************  //
// Type Lib: D:\Marcelo\Projeto Cosmos\Fontes\Delphi\Bibliotecas\FBServices\fbservices (1)
// LIBID: {9F4D68E1-DD10-4E53-84AD-1D3AB3A56077}
// LCID: 0
// Helpfile:
// HelpString: fbservices Library
// DepndLst:
//   (1) v2.0 stdole, (C:\Windows\system32\stdole2.tlb)
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers.
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
{$ALIGN 4}

interface

uses Windows, ActiveX, Classes, Graphics, OleServer, StdVCL, Variants;


// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:
//   Type Libraries     : LIBID_xxxx
//   CoClasses          : CLASS_xxxx
//   DISPInterfaces     : DIID_xxxx
//   Non-DISP interfaces: IID_xxxx
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  fbservicesMajorVersion = 1;
  fbservicesMinorVersion = 0;

  LIBID_fbservices: TGUID = '{9F4D68E1-DD10-4E53-84AD-1D3AB3A56077}';

  IID_Ifbserv: TGUID = '{58A72020-2468-400A-B85D-92AB50A37E03}';
  CLASS_fbserv: TGUID = '{FBF3DF00-F887-42FB-9B26-5C1D1BB771AD}';
  IID_IExporter: TGUID = '{8182B82B-9E44-46C4-8A59-E5A7DD9A2178}';
  CLASS_Exporter: TGUID = '{4B888BB5-F7BF-4901-8F24-D9CD6AB89D6E}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary
// *********************************************************************//
  Ifbserv = interface;
  IExporter = interface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library
// (NOTE: Here we map each CoClass to its Default Interface)
// *********************************************************************//
  fbserv = Ifbserv;
  Exporter = IExporter;


// *********************************************************************//
// Interface: Ifbserv
// Flags:     (256) OleAutomation
// GUID:      {58A72020-2468-400A-B85D-92AB50A37E03}
// *********************************************************************//
  Ifbserv = interface(IUnknown)
    ['{58A72020-2468-400A-B85D-92AB50A37E03}']
    function FirebirdIsRunning: WordBool; stdcall;
    procedure StartServer; stdcall;
    function StartGuardian: WordBool; stdcall;
    procedure StopServer; stdcall;
    procedure StopGuardian; stdcall;
  end;

// *********************************************************************//
// Interface: IExporter
// Flags:     (256) OleAutomation
// GUID:      {8182B82B-9E44-46C4-8A59-E5A7DD9A2178}
// *********************************************************************//
  IExporter = interface(IUnknown)
    ['{8182B82B-9E44-46C4-8A59-E5A7DD9A2178}']
  end;

// *********************************************************************//
// The Class Cofbserv provides a Create and CreateRemote method to
// create instances of the default interface Ifbserv exposed by
// the CoClass fbserv. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  Cofbserv = class
    class function Create: Ifbserv;
    class function CreateRemote(const MachineName: string): Ifbserv;
  end;

// *********************************************************************//
// The Class CoExporter provides a Create and CreateRemote method to
// create instances of the default interface IExporter exposed by
// the CoClass Exporter. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoExporter = class
    class function Create: IExporter;
    class function CreateRemote(const MachineName: string): IExporter;
  end;

implementation

uses ComObj;

class function Cofbserv.Create: Ifbserv;
begin
  Result := CreateComObject(CLASS_fbserv) as Ifbserv;
end;

class function Cofbserv.CreateRemote(const MachineName: string): Ifbserv;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_fbserv) as Ifbserv;
end;

class function CoExporter.Create: IExporter;
begin
  Result := CreateComObject(CLASS_Exporter) as IExporter;
end;

class function CoExporter.CreateRemote(const MachineName: string): IExporter;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Exporter) as IExporter;
end;

end.

