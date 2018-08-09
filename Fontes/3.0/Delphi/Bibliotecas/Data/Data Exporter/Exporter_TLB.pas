unit Exporter_TLB;

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
// File generated on 22/11/2008 10:51:33 from Type Library described below.

// ************************************************************************  //
// Type Lib: D:\Pastas Pessoais\Marcelo\LECTORIUM\Projeto Cosmos\Fontes\Delphi\Bibliotecas\Data Exporter\Exporter.tlb (1)
// LIBID: {BAAA1780-1272-11D7-8F3C-0000B43724F6}
// LCID: 0
// Helpfile: 
// HelpString: Exporter Library
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
  ExporterMajorVersion = 1;
  ExporterMinorVersion = 0;

  LIBID_Exporter: TGUID = '{BAAA1780-1272-11D7-8F3C-0000B43724F6}';

  IID_IDataExporter: TGUID = '{BAAA1781-1272-11D7-8F3C-0000B43724F6}';
  CLASS_DataExporter: TGUID = '{BAAA1783-1272-11D7-8F3C-0000B43724F6}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                    
// *********************************************************************//
// Constants for enum ExportFormats
type
  ExportFormats = TOleEnum;
const
  efPlainText = $00000000;
  efCSV = $00000001;
  efHTML = $00000002;
  efXML = $00000003;
  efBinary = $00000004;
  efRTF = $00000005;
  efSQL = $00000006;
  efXLS = $00000007;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IDataExporter = interface;
  IDataExporterDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  DataExporter = IDataExporter;


// *********************************************************************//
// Interface: IDataExporter
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {BAAA1781-1272-11D7-8F3C-0000B43724F6}
// *********************************************************************//
  IDataExporter = interface(IDispatch)
    ['{BAAA1781-1272-11D7-8F3C-0000B43724F6}']
    procedure ExportToFile(Data: OleVariant; const FileName: WideString; Format: Integer); safecall;
    procedure ExportToSQL(Data: OleVariant; const FileName: WideString; 
                          const TableName: WideString; const DateTimeFormat: WideString; 
                          CreateMetadata: WordBool); safecall;
  end;

// *********************************************************************//
// DispIntf:  IDataExporterDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {BAAA1781-1272-11D7-8F3C-0000B43724F6}
// *********************************************************************//
  IDataExporterDisp = dispinterface
    ['{BAAA1781-1272-11D7-8F3C-0000B43724F6}']
    procedure ExportToFile(Data: OleVariant; const FileName: WideString; Format: Integer); dispid 1;
    procedure ExportToSQL(Data: OleVariant; const FileName: WideString; 
                          const TableName: WideString; const DateTimeFormat: WideString; 
                          CreateMetadata: WordBool); dispid 2;
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
