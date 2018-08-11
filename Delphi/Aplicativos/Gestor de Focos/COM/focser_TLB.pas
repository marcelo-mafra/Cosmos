unit focser_TLB;

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
// File generated on 31/03/2013 21:23:57 from Type Library described below.

// ************************************************************************  //
// Type Lib: D:\Marcelo\Projeto Cosmos\Fontes\Delphi\Aplicativos\Gerenciador de Focos\Server\focser (1)
// LIBID: {742C60FB-C32C-4371-9A72-D0174D1E0323}
// LCID: 0
// Helpfile:
// HelpString: focser Library
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
  focserMajorVersion = 1;
  focserMinorVersion = 0;

  LIBID_focser: TGUID = '{742C60FB-C32C-4371-9A72-D0174D1E0323}';

  IID_IFocosManager: TGUID = '{031B8DF8-6425-4090-AD74-613CE606D9D8}';
  CLASS_FocosManager: TGUID = '{0182485F-C032-47F0-A18C-23843A7A9DCA}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary
// *********************************************************************//
  IFocosManager = interface;
  IFocosManagerDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library
// (NOTE: Here we map each CoClass to its Default Interface)
// *********************************************************************//
  FocosManager = IFocosManager;


// *********************************************************************//
// Interface: IFocosManager
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {031B8DF8-6425-4090-AD74-613CE606D9D8}
// *********************************************************************//
  IFocosManager = interface(IAppServer)
    ['{031B8DF8-6425-4090-AD74-613CE606D9D8}']
    function ConnectDatabase(const UserName: WideString; const Password: WideString;
                             const RoleName: WideString; const HostName: WideString): OleVariant; safecall;
    function GetSequenceValue(const SequenceName: WideString): OleVariant; safecall;
    function Get_ActiveUser: OleVariant; safecall;
    function Get_ServerComputer: OleVariant; safecall;
    function Get_StartTime: OleVariant; safecall;
    function ListRegions(codreg: Integer): OleVariant; safecall;
    function RenameAr(codreg: Integer; const NewName: WideString): OleVariant; safecall;
    function ListFocusSequencial(Inactives: WordBool): OleVariant; safecall;
    function ListFocusByType(Inactives: WordBool): OleVariant; safecall;
    function NewAR(const ARName: WideString; ARParent: OleVariant): OleVariant; safecall;
    function ListFocusRegion(RegionID: Integer; Inactives: WordBool; OnlyTop: WordBool): OleVariant; safecall;
    function DeleteRegion(RegionID: Integer): OleVariant; safecall;
    function MoveRegion(RegionID: Integer; NewRegion: Integer): OleVariant; safecall;
    function ChangeFocusRegion(FocusID: Integer; NewRegion: Integer): OleVariant; safecall;
    function ChangeFocusParent(FocusID: Integer; NewParent: Integer): OleVariant; safecall;
    function ListDependentsFocus(TitularFocus: Integer; Inactives: WordBool): OleVariant; safecall;
    function ListFocusByTitular(Inactives: WordBool): OleVariant; safecall;
    function ChangeFocusStatus(FocusID: Integer; Status: WordBool): OleVariant; safecall;
    function Get_ServerDateTime: OleVariant; safecall;
    function CriarFoco(DadosFoco: OleVariant; DadosEndereco: OleVariant; DadosGestao: OleVariant;
                       DadosMeiosContatos: OleVariant): OleVariant; safecall;
    function GetLogradouro(const Cep: WideString): OleVariant; safecall;
    function GetFocusData(indsed: WordBool; indcco: WordBool; indncc: WordBool; indnuc: WordBool;
                          indstp: WordBool; indltp: WordBool; indnac: WordBool; inativos: WordBool): OleVariant; safecall;
    function DesactiveFocus(TargetFocus: Integer; TransferFocus: Integer; Desactivate: WordBool): OleVariant; safecall;
    function DeleteFocus(codfoc: Integer): OleVariant; safecall;
    procedure BufferData(const SchemmaName: WideString; out DataPackage: OleVariant); safecall;
    function ListOrgaos(codsup: OleVariant): OleVariant; safecall;
    function AlterarSubordinacao(codorg: Integer; NewParent: Integer): OleVariant; safecall;
    function ListOrgaosByName(codsup: OleVariant): OleVariant; safecall;
    function ListOrgaosByEsfera(indnac: WordBool; indati: WordBool): OleVariant; safecall;
    function DeleteOrgao(codorg: Integer): OleVariant; safecall;
    function ListGestoesOrgao(codorg: Integer): OleVariant; safecall;
    function DeleteGestao(codges: Integer): OleVariant; safecall;
    function ListMembrosGestao(codges: Integer): OleVariant; safecall;
    function CloneDirigente(coddir: Integer; codges: Integer): OleVariant; safecall;
    function DeleteDirigente(coddir: Integer): OleVariant; safecall;
    function MoveDirigente(coddir: Integer; codges: Integer): OleVariant; safecall;
    function TerminateMandate(coddir: Integer): OleVariant; safecall;
    function TerminateMandates(codges: Integer): OleVariant; safecall;
    function DuplicarGestao(codorg: Integer; codges: Integer; datini: TDateTime; datter: TDateTime;
                            Dirigentes: OleVariant): OleVariant; safecall;
    procedure FichaCadastrado(codcad: Integer; out CoreData: OleVariant;
                              out FuncoesData: OleVariant; out ContatosData: OleVariant); safecall;
    function Get_DatabaseVersion: OleVariant; safecall;
    function Get_BetaVersion: WordBool; safecall;
    function GetPerfilData: OleVariant; safecall;
    function ExecuteDQL(SearchID: Integer; Params: OleVariant): OleVariant; safecall;
    function Get_ActiveRange: OleVariant; safecall;
    function Get_CodeKey: OleVariant; safecall;
    function IsAdministrator(const UserName: WideString): OleVariant; safecall;
    function GetTableProviderName(Table: Integer): OleVariant; safecall;
    function ExecuteCommand(CommandId: Integer; Params: OleVariant): OleVariant; safecall;
    function GetDQLCommand(SearchId: Integer; Params: OleVariant): OleVariant; safecall;
    function GetLastUpdateError: OleVariant; safecall;
    function ExecuteRegisteredSearch(SearchId: Integer; Params: OleVariant): OleVariant; safecall;
    function Echoo(const AMessage: WideString): OleVariant; safecall;
    property ActiveUser: OleVariant read Get_ActiveUser;
    property ServerComputer: OleVariant read Get_ServerComputer;
    property StartTime: OleVariant read Get_StartTime;
    property ServerDateTime: OleVariant read Get_ServerDateTime;
    property DatabaseVersion: OleVariant read Get_DatabaseVersion;
    property BetaVersion: WordBool read Get_BetaVersion;
    property ActiveRange: OleVariant read Get_ActiveRange;
    property CodeKey: OleVariant read Get_CodeKey;
  end;

// *********************************************************************//
// DispIntf:  IFocosManagerDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {031B8DF8-6425-4090-AD74-613CE606D9D8}
// *********************************************************************//
  IFocosManagerDisp = dispinterface
    ['{031B8DF8-6425-4090-AD74-613CE606D9D8}']
    function ConnectDatabase(const UserName: WideString; const Password: WideString;
                             const RoleName: WideString; const HostName: WideString): OleVariant; dispid 301;
    function GetSequenceValue(const SequenceName: WideString): OleVariant; dispid 305;
    property ActiveUser: OleVariant readonly dispid 306;
    property ServerComputer: OleVariant readonly dispid 307;
    property StartTime: OleVariant readonly dispid 308;
    function ListRegions(codreg: Integer): OleVariant; dispid 309;
    function RenameAr(codreg: Integer; const NewName: WideString): OleVariant; dispid 310;
    function ListFocusSequencial(Inactives: WordBool): OleVariant; dispid 311;
    function ListFocusByType(Inactives: WordBool): OleVariant; dispid 312;
    function NewAR(const ARName: WideString; ARParent: OleVariant): OleVariant; dispid 313;
    function ListFocusRegion(RegionID: Integer; Inactives: WordBool; OnlyTop: WordBool): OleVariant; dispid 314;
    function DeleteRegion(RegionID: Integer): OleVariant; dispid 315;
    function MoveRegion(RegionID: Integer; NewRegion: Integer): OleVariant; dispid 316;
    function ChangeFocusRegion(FocusID: Integer; NewRegion: Integer): OleVariant; dispid 317;
    function ChangeFocusParent(FocusID: Integer; NewParent: Integer): OleVariant; dispid 318;
    function ListDependentsFocus(TitularFocus: Integer; Inactives: WordBool): OleVariant; dispid 319;
    function ListFocusByTitular(Inactives: WordBool): OleVariant; dispid 320;
    function ChangeFocusStatus(FocusID: Integer; Status: WordBool): OleVariant; dispid 321;
    property ServerDateTime: OleVariant readonly dispid 322;
    function CriarFoco(DadosFoco: OleVariant; DadosEndereco: OleVariant; DadosGestao: OleVariant;
                       DadosMeiosContatos: OleVariant): OleVariant; dispid 324;
    function GetLogradouro(const Cep: WideString): OleVariant; dispid 326;
    function GetFocusData(indsed: WordBool; indcco: WordBool; indncc: WordBool; indnuc: WordBool;
                          indstp: WordBool; indltp: WordBool; indnac: WordBool; inativos: WordBool): OleVariant; dispid 327;
    function DesactiveFocus(TargetFocus: Integer; TransferFocus: Integer; Desactivate: WordBool): OleVariant; dispid 328;
    function DeleteFocus(codfoc: Integer): OleVariant; dispid 329;
    procedure BufferData(const SchemmaName: WideString; out DataPackage: OleVariant); dispid 331;
    function ListOrgaos(codsup: OleVariant): OleVariant; dispid 333;
    function AlterarSubordinacao(codorg: Integer; NewParent: Integer): OleVariant; dispid 334;
    function ListOrgaosByName(codsup: OleVariant): OleVariant; dispid 335;
    function ListOrgaosByEsfera(indnac: WordBool; indati: WordBool): OleVariant; dispid 336;
    function DeleteOrgao(codorg: Integer): OleVariant; dispid 337;
    function ListGestoesOrgao(codorg: Integer): OleVariant; dispid 338;
    function DeleteGestao(codges: Integer): OleVariant; dispid 339;
    function ListMembrosGestao(codges: Integer): OleVariant; dispid 340;
    function CloneDirigente(coddir: Integer; codges: Integer): OleVariant; dispid 341;
    function DeleteDirigente(coddir: Integer): OleVariant; dispid 342;
    function MoveDirigente(coddir: Integer; codges: Integer): OleVariant; dispid 343;
    function TerminateMandate(coddir: Integer): OleVariant; dispid 344;
    function TerminateMandates(codges: Integer): OleVariant; dispid 345;
    function DuplicarGestao(codorg: Integer; codges: Integer; datini: TDateTime; datter: TDateTime;
                            Dirigentes: OleVariant): OleVariant; dispid 346;
    procedure FichaCadastrado(codcad: Integer; out CoreData: OleVariant;
                              out FuncoesData: OleVariant; out ContatosData: OleVariant); dispid 347;
    property DatabaseVersion: OleVariant readonly dispid 349;
    property BetaVersion: WordBool readonly dispid 350;
    function GetPerfilData: OleVariant; dispid 352;
    function ExecuteDQL(SearchID: Integer; Params: OleVariant): OleVariant; dispid 303;
    property ActiveRange: OleVariant readonly dispid 348;
    property CodeKey: OleVariant readonly dispid 325;
    function IsAdministrator(const UserName: WideString): OleVariant; dispid 302;
    function GetTableProviderName(Table: Integer): OleVariant; dispid 304;
    function ExecuteCommand(CommandId: Integer; Params: OleVariant): OleVariant; dispid 323;
    function GetDQLCommand(SearchId: Integer; Params: OleVariant): OleVariant; dispid 330;
    function GetLastUpdateError: OleVariant; dispid 351;
    function ExecuteRegisteredSearch(SearchId: Integer; Params: OleVariant): OleVariant; dispid 353;
    function Echoo(const AMessage: WideString): OleVariant; dispid 354;
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
// The Class CoFocosManager provides a Create and CreateRemote method to
// create instances of the default interface IFocosManager exposed by
// the CoClass FocosManager. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFocosManager = class
    class function Create: IFocosManager;
    class function CreateRemote(const MachineName: string): IFocosManager;
  end;

implementation

uses ComObj;

class function CoFocosManager.Create: IFocosManager;
begin
  Result := CreateComObject(CLASS_FocosManager) as IFocosManager;
end;

class function CoFocosManager.CreateRemote(const MachineName: string): IFocosManager;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FocosManager) as IFocosManager;
end;

end.

