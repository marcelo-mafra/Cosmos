unit Reglib_TLB;

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
// File generated on 21/4/2009 18:45:05 from Type Library described below.

// ************************************************************************  //
// Type Lib: D:\Pastas Pessoais\Marcelo\LECTORIUM\Projeto Cosmos\Fontes\Delphi\Bibliotecas\RegistryLib\Reglib.tlb (1)
// LIBID: {3B8656C5-1719-11D7-8F3C-0000B43724F6}
// LCID: 0
// Helpfile: 
// HelpString: Library with registry read/write functions 
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
  ReglibMajorVersion = 1;
  ReglibMinorVersion = 0;

  LIBID_Reglib: TGUID = '{3B8656C5-1719-11D7-8F3C-0000B43724F6}';

  IID_IReg: TGUID = '{3B8656C6-1719-11D7-8F3C-0000B43724F6}';
  CLASS_Reg: TGUID = '{3B8656C8-1719-11D7-8F3C-0000B43724F6}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IReg = interface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  Reg = IReg;


// *********************************************************************//
// Interface: IReg
// Flags:     (256) OleAutomation
// GUID:      {3B8656C6-1719-11D7-8F3C-0000B43724F6}
// *********************************************************************//
  IReg = interface(IUnknown)
    ['{3B8656C6-1719-11D7-8F3C-0000B43724F6}']
    function ReadString(const ValueName: WideString): WideString; stdcall;
    function ReadInteger(const ValueName: WideString): Integer; stdcall;
    function ReadBool(const ValueName: WideString): WordBool; stdcall;
    function ReadFloat(const ValueName: WideString): Double; stdcall;
    procedure WriteString(const ValueName: WideString; const Value: WideString); stdcall;
    procedure WriteInteger(const ValueName: WideString; Value: Integer); stdcall;
    procedure WriteBool(const ValueName: WideString; Value: WordBool); stdcall;
    procedure WriteFloat(const ValueName: WideString; Value: Double); stdcall;
    procedure WriteCurrency(const ValueName: WideString; Value: Currency); stdcall;
    procedure WriteDate(const ValueName: WideString; Value: TDateTime); stdcall;
    procedure WriteTime(const ValueName: WideString; Value: TDateTime); stdcall;
    function ReadCurrency(const ValueName: WideString): Currency; stdcall;
    function ReadDate(const ValueName: WideString): TDateTime; stdcall;
    function ReadTime(const ValueName: WideString): TDateTime; stdcall;
    function GetKeyNames: OleVariant; stdcall;
    function ValueExists(const ValueName: WideString): WordBool; stdcall;
    function KeyExists(const KeyName: WideString): WordBool; stdcall;
    function ReadDateTime(const ValueName: WideString): OleVariant; stdcall;
    procedure WriteDateTime(const ValueName: WideString; Value: OleVariant); stdcall;
    function GetValueNames: WideString; stdcall;
    function ReadSectionValues: WideString; stdcall;
    function Get_Root: Integer; stdcall;
    procedure Set_Root(Param1: Integer); stdcall;
    procedure Set_KeyName(const KeyPath: WideString; Param2: WordBool); stdcall;
    procedure CloseKey; stdcall;
    function ReadBinary(const ValueName: WideString; Buffer: Integer; BufferSize: Integer): Integer; stdcall;
    procedure WriteBinary(const ValueName: WideString; BinaryData: OleVariant; BufferSize: Integer); stdcall;
    function DeleteValue(const ValueName: WideString): WordBool; stdcall;
    function Deletekey(const KeyName: WideString): WordBool; stdcall;
    function CreateKey(const KeyName: WideString): WordBool; stdcall;
    function HasSubKeys: WordBool; stdcall;
    procedure MoveKey(const OldKeyName: WideString; const NewKeyName: WideString; 
                      Deletekey: WordBool); stdcall;
    procedure RenameValue(const OldValueName: WideString; const NewValueName: WideString); stdcall;
    function GetDataSize(const ValueName: WideString): Integer; stdcall;
    function SaveKey(const KeyName: WideString; const FileName: WideString): WordBool; stdcall;
    function RestoreKey(const KeyName: WideString; const FileName: WideString): WordBool; stdcall;
    function ReplaceKey(const KeyName: WideString; const FileName: WideString; 
                        const BkpFileName: WideString): WordBool; stdcall;
    function LoadKey(const KeyName: WideString; const FileName: WideString): WordBool; stdcall;
    function UnLoadKey(const KeyName: WideString): WordBool; stdcall;
    function RegistryConnect(const HostName: WideString): WordBool; stdcall;
    function OpenKey(const KeyName: WideString; Create: WordBool): WordBool; stdcall;
    function Get_CurrentPath: WideString; stdcall;
  end;

// *********************************************************************//
// The Class CoReg provides a Create and CreateRemote method to          
// create instances of the default interface IReg exposed by              
// the CoClass Reg. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoReg = class
    class function Create: IReg;
    class function CreateRemote(const MachineName: string): IReg;
  end;

implementation

uses ComObj;

class function CoReg.Create: IReg;
begin
  Result := CreateComObject(CLASS_Reg) as IReg;
end;

class function CoReg.CreateRemote(const MachineName: string): IReg;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Reg) as IReg;
end;

end.
