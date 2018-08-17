unit cosmos.system.helplib_TLB;

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

// PASTLWTR : 1.2
// File generated on 17/09/2009 19:50:00 from Type Library described below.

// ************************************************************************  //
// Type Lib: E:\Marcelo\Projeto Cosmos\Fontes\Delphi\Bibliotecas\Help\helplib.tlb (1)
// LIBID: {560BDF90-942D-41F9-862E-7E78A68ACC85}
// LCID: 0
// Helpfile: 
// HelpString: helplib Library
// DepndLst: 
//   (1) v2.0 stdole, (C:\Windows\system32\stdole2.tlb)
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses Windows, ActiveX, Classes, Graphics, StdVCL, Variants;
  

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  helplibMajorVersion = 1;
  helplibMinorVersion = 0;

  LIBID_helplib: TGUID = '{560BDF90-942D-41F9-862E-7E78A68ACC85}';

  IID_ICosmosHelp: TGUID = '{A3B79693-F97B-40F2-9D42-9B1B7A82BBB7}';
  CLASS_CosmosHelp: TGUID = '{BF92BBC5-5DA8-4974-B9DE-79300B06609B}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  ICosmosHelp = interface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  CosmosHelp = ICosmosHelp;


// *********************************************************************//
// Interface: ICosmosHelp
// Flags:     (256) OleAutomation
// GUID:      {A3B79693-F97B-40F2-9D42-9B1B7A82BBB7}
// *********************************************************************//
  ICosmosHelp = interface(IUnknown)
    ['{A3B79693-F97B-40F2-9D42-9B1B7A82BBB7}']
    function ShowHelpTopics: HResult; stdcall;
  end;

// *********************************************************************//
// The Class CoCosmosHelp provides a Create and CreateRemote method to          
// create instances of the default interface ICosmosHelp exposed by              
// the CoClass CosmosHelp. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoCosmosHelp = class
    class function Create: ICosmosHelp;
    class function CreateRemote(const MachineName: string): ICosmosHelp;
  end;

implementation

uses ComObj;

class function CoCosmosHelp.Create: ICosmosHelp;
begin
  Result := CreateComObject(CLASS_CosmosHelp) as ICosmosHelp;
end;

class function CoCosmosHelp.CreateRemote(const MachineName: string): ICosmosHelp;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_CosmosHelp) as ICosmosHelp;
end;

end.
