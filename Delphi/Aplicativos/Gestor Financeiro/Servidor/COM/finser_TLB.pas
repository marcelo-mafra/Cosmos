unit finser_TLB;

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
// File generated on 31/03/2013 21:14:38 from Type Library described below.

// ************************************************************************  //
// Type Lib: D:\Marcelo\Projeto Cosmos\Fontes\Delphi\Aplicativos\Gerenciador Financeiro\Servidor\finser (1)
// LIBID: {4BCD2E02-490C-4B5A-A47C-FA083CEE3907}
// LCID: 0
// Helpfile:
// HelpString: finser Library
// DepndLst:
//   (1) v2.0 stdole, (C:\Windows\system32\stdole2.tlb)
//   (2) v1.0 Midas, (midas.dll)
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers.
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
{$ALIGN 4}

interface

uses Windows, ActiveX, Classes, Graphics, Midas, OleServer, StdVCL, Variants;



// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:
//   Type Libraries     : LIBID_xxxx
//   CoClasses          : CLASS_xxxx
//   DISPInterfaces     : DIID_xxxx
//   Non-DISP interfaces: IID_xxxx
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  finserMajorVersion = 1;
  finserMinorVersion = 0;

  LIBID_finser: TGUID = '{4BCD2E02-490C-4B5A-A47C-FA083CEE3907}';

  IID_IFinanceiro: TGUID = '{C587E8F8-2A27-496A-A6F5-395FEFB95230}';
  CLASS_Financeiro: TGUID = '{0477838B-8EEA-4FCA-9F4E-8121E82A964D}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary
// *********************************************************************//
  IFinanceiro = interface;
  IFinanceiroDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library
// (NOTE: Here we map each CoClass to its Default Interface)
// *********************************************************************//
  Financeiro = IFinanceiro;


// *********************************************************************//
// Interface: IFinanceiro
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {C587E8F8-2A27-496A-A6F5-395FEFB95230}
// *********************************************************************//
  IFinanceiro = interface(IAppServer)
    ['{C587E8F8-2A27-496A-A6F5-395FEFB95230}']
    function Get_ActiveUser: OleVariant; safecall;
    function Get_BetaVersion: WordBool; safecall;
    function Get_CodeKey: OleVariant; safecall;
    function Get_DatabaseVersion: OleVariant; safecall;
    function Get_ServerComputer: OleVariant; safecall;
    function Get_ServerDateTime: OleVariant; safecall;
    procedure BufferData(const SchemmaName: WideString; out DataPackage: OleVariant); safecall;
    function ConnectDatabase(const UserName: WideString; const Password: WideString;
                             const RoleName: WideString; const HostName: WideString): OleVariant; safecall;
    function GetPerfilData: OleVariant; safecall;
    function IsAdministrator(const UserName: WideString): OleVariant; safecall;
    function ExecuteDQL(SearchID: Integer; Params: OleVariant): OleVariant; safecall;
    function GetAcessedFocus(const UserName: WideString): OleVariant; safecall;
    function GetContas: OleVariant; safecall;
    function GetSubcontas(codcon: Integer): OleVariant; safecall;
    function GetSequenceValue(const SequenceName: WideString): OleVariant; safecall;
    function MoverConta(Conta: Integer; Parent: Integer): OleVariant; safecall;
    function ExcluirConta(Conta: Integer): OleVariant; safecall;
    function GetTableProviderName(Table: Integer): OleVariant; safecall;
    function Get_ActiveRange: OleVariant; safecall;
    property ActiveUser: OleVariant read Get_ActiveUser;
    property BetaVersion: WordBool read Get_BetaVersion;
    property CodeKey: OleVariant read Get_CodeKey;
    property DatabaseVersion: OleVariant read Get_DatabaseVersion;
    property ServerComputer: OleVariant read Get_ServerComputer;
    property ServerDateTime: OleVariant read Get_ServerDateTime;
    property ActiveRange: OleVariant read Get_ActiveRange;
  end;

// *********************************************************************//
// DispIntf:  IFinanceiroDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {C587E8F8-2A27-496A-A6F5-395FEFB95230}
// *********************************************************************//
  IFinanceiroDisp = dispinterface
    ['{C587E8F8-2A27-496A-A6F5-395FEFB95230}']
    property ActiveUser: OleVariant readonly dispid 301;
    property BetaVersion: WordBool readonly dispid 302;
    property CodeKey: OleVariant readonly dispid 303;
    property DatabaseVersion: OleVariant readonly dispid 305;
    property ServerComputer: OleVariant readonly dispid 306;
    property ServerDateTime: OleVariant readonly dispid 307;
    procedure BufferData(const SchemmaName: WideString; out DataPackage: OleVariant); dispid 309;
    function ConnectDatabase(const UserName: WideString; const Password: WideString;
                             const RoleName: WideString; const HostName: WideString): OleVariant; dispid 310;
    function GetPerfilData: OleVariant; dispid 311;
    function IsAdministrator(const UserName: WideString): OleVariant; dispid 312;
    function ExecuteDQL(SearchID: Integer; Params: OleVariant): OleVariant; dispid 313;
    function GetAcessedFocus(const UserName: WideString): OleVariant; dispid 315;
    function GetContas: OleVariant; dispid 316;
    function GetSubcontas(codcon: Integer): OleVariant; dispid 317;
    function GetSequenceValue(const SequenceName: WideString): OleVariant; dispid 318;
    function MoverConta(Conta: Integer; Parent: Integer): OleVariant; dispid 320;
    function ExcluirConta(Conta: Integer): OleVariant; dispid 321;
    function GetTableProviderName(Table: Integer): OleVariant; dispid 322;
    property ActiveRange: OleVariant readonly dispid 323;
    function AS_ApplyUpdates(const ProviderName: WideString; Delta: OleVariant; MaxErrors: Integer;
                             out ErrorCount: Integer; var OwnerData: OleVariant): OleVariant; dispid 20000000;
    function AS_GetRecords(const ProviderName: WideString; Count: Integer; out RecsOut: Integer;
                           Options: Integer; const CommandText: WideString; var Params: OleVariant;
                           var OwnerData: OleVariant): OleVariant; dispid 20000001;
    function AS_DataRequest(const ProviderName: WideString; Data: OleVariant): OleVariant; dispid 20000002;
    function AS_GetProviderNames: OleVariant; dispid 20000003;
    function AS_GetParams(const ProviderName: WideString; var OwnerData: OleVariant): OleVariant; dispid 20000004;
    function AS_RowRequest(const ProviderName: WideString; Row: OleVariant; RequestType: Integer;
                           var OwnerData: OleVariant): OleVariant; dispid 20000005;
    procedure AS_Execute(const ProviderName: WideString; const CommandText: WideString;
                         var Params: OleVariant; var OwnerData: OleVariant); dispid 20000006;
  end;

// *********************************************************************//
// The Class CoFinanceiro provides a Create and CreateRemote method to
// create instances of the default interface IFinanceiro exposed by
// the CoClass Financeiro. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFinanceiro = class
    class function Create: IFinanceiro;
    class function CreateRemote(const MachineName: string): IFinanceiro;
  end;

implementation

uses ComObj;

class function CoFinanceiro.Create: IFinanceiro;
begin
  Result := CreateComObject(CLASS_Financeiro) as IFinanceiro;
end;

class function CoFinanceiro.CreateRemote(const MachineName: string): IFinanceiro;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Financeiro) as IFinanceiro;
end;

end.

