unit xmlcon_TLB;

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
// File generated on 30/11/2008 01:03:14 from Type Library described below.

// ************************************************************************  //
// Type Lib: D:\Pastas Pessoais\Marcelo\LECTORIUM\Projeto Cosmos\Fontes\Delphi\Bibliotecas\XmlIni\xmlcon.tlb (1)
// LIBID: {AF2928BF-6375-43E7-BD82-915DE159E3E4}
// LCID: 0
// Helpfile: 
// HelpString: xmlcon Library
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\system32\stdole2.tlb)
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
  xmlconMajorVersion = 1;
  xmlconMinorVersion = 0;

  LIBID_xmlcon: TGUID = '{AF2928BF-6375-43E7-BD82-915DE159E3E4}';

  IID_IXmlconf: TGUID = '{061FD1DB-45DB-434C-947B-9EE8F119B9E7}';
  CLASS_Xmlconf: TGUID = '{EBCC6EC3-BCAA-4A7A-ACE6-B1AE48D28F78}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IXmlconf = interface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  Xmlconf = IXmlconf;


// *********************************************************************//
// Interface: IXmlconf
// Flags:     (256) OleAutomation
// GUID:      {061FD1DB-45DB-434C-947B-9EE8F119B9E7}
// *********************************************************************//
  IXmlconf = interface(IUnknown)
    ['{061FD1DB-45DB-434C-947B-9EE8F119B9E7}']
  end;

// *********************************************************************//
// The Class CoXmlconf provides a Create and CreateRemote method to          
// create instances of the default interface IXmlconf exposed by              
// the CoClass Xmlconf. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoXmlconf = class
    class function Create: IXmlconf;
    class function CreateRemote(const MachineName: string): IXmlconf;
  end;

implementation

uses ComObj;

class function CoXmlconf.Create: IXmlconf;
begin
  Result := CreateComObject(CLASS_Xmlconf) as IXmlconf;
end;

class function CoXmlconf.CreateRemote(const MachineName: string): IXmlconf;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Xmlconf) as IXmlconf;
end;

end.
