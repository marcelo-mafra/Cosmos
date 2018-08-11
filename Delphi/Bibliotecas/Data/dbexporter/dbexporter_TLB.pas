unit dbexporter_TLB;

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
// File generated on 30/11/2008 12:45:10 from Type Library described below.

// ************************************************************************  //
// Type Lib: D:\Pastas Pessoais\Marcelo\LECTORIUM\Projeto Cosmos\Fontes\Delphi\Bibliotecas\dbexporter\dbexporter.tlb (1)
// LIBID: {79902CF9-C10A-4024-9F3A-3285538DB23A}
// LCID: 0
// Helpfile: 
// HelpString: dbexporter Library
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
  dbexporterMajorVersion = 1;
  dbexporterMinorVersion = 0;

  LIBID_dbexporter: TGUID = '{79902CF9-C10A-4024-9F3A-3285538DB23A}';

  IID_IDataExporter: TGUID = '{86712B6B-DFF7-401C-BC98-4FA1A8BFFBED}';
  CLASS_DataExporter: TGUID = '{2EA98F3E-FEC9-4D2E-8D26-EAF07398E68F}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IDataExporter = interface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  DataExporter = IDataExporter;


// *********************************************************************//
// Declaration of structures, unions and aliases.                         
// *********************************************************************//
  POleVariant1 = ^OleVariant; {*}


// *********************************************************************//
// Interface: IDataExporter
// Flags:     (256) OleAutomation
// GUID:      {86712B6B-DFF7-401C-BC98-4FA1A8BFFBED}
// *********************************************************************//
  IDataExporter = interface(IUnknown)
    ['{86712B6B-DFF7-401C-BC98-4FA1A8BFFBED}']
    function ToXML(var Data: OleVariant; const FileName: WideString): WordBool; stdcall;
    function ToXSL(var Data: OleVariant; const FileName: WideString): WordBool; stdcall;
    function ToHTM(var Data: OleVariant; const FileName: WideString): WordBool; stdcall;
    function ToDOC(var Data: OleVariant; const FileName: WideString): WordBool; stdcall;
    function ToText(var Data: OleVariant; const FileName: WideString): WordBool; stdcall;
  end;

// *********************************************************************//
// The Class CoDataExporter provides a Create and CreateRemote method to          
// create instances of the default interface IDataExporter exposed by              
// the CoClass DataExporter. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoDataExporter = class
    class function Create: IDataExporter;
    class function CreateRemote(const MachineName: string): IDataExporter;
  end;

implementation

uses ComObj;

class function CoDataExporter.Create: IDataExporter;
begin
  Result := CreateComObject(CLASS_DataExporter) as IDataExporter;
end;

class function CoDataExporter.CreateRemote(const MachineName: string): IDataExporter;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_DataExporter) as IDataExporter;
end;

end.
