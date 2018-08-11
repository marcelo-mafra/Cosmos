unit cosmos.common.security.x509certificate;

interface

uses System.SysUtils, Data.DBXCommon, OpenSSLUtils;

{Implementa os recursos necessários ao uso de SSL em HTTPS. Esse objeto faz
uso das classes da biblioteca OpenSSL. }

type
 TDSX509Certificate = class(Data.DBXCommon.TX509Certificate)
  private
   FOpenSSLCertificate: OpenSSLUtils.TX509Certificate;

  public
    constructor Create(const CertFile, PrivateKey, RootCert: string);
    destructor Destroy; override;

    procedure CheckValidity; overload; override;
    procedure CheckValidity(ADate: TDateTime); overload; override;
    function GetBasicConstraints: Integer; override;
    function GetIssuerX500Principal: TX500Principal; override;
    function GetNotAfter: TDateTime; override;
    function GetNotBefore: TDateTime; override;
    function GetSerialNumber: string; override;
    function GetSigAlgName: string; override;
    function GetSignature: string; override;
    function GetSubjectX500Principal: TX500Principal; override;
    function GetVersion: LongInt; override;

 end;

implementation

{ TDSX509Certificate }

constructor TDSX509Certificate.Create(const CertFile, PrivateKey,
  RootCert: string);
begin
 inherited Create;
 FOpenSSLCertificate := OpenSSLUtils.TX509Certificate.Create;
 FOpenSSLCertificate.LoadFromFile(CertFile, PEM);
end;

destructor TDSX509Certificate.Destroy;
begin
 if Assigned(FOpenSSLCertificate) then
  FOpenSSLCertificate.Free;

  inherited Destroy;
end;

procedure TDSX509Certificate.CheckValidity(ADate: TDateTime);
begin
 if ADate < FOpenSSLCertificate.NotBefore then
  raise ECertificateNotYetValidException.Create('Certificate cannot be used for the moment!');
end;

procedure TDSX509Certificate.CheckValidity;
begin
 if Now < FOpenSSLCertificate.NotBefore then
  raise ECertificateNotYetValidException.Create('Certificate cannot be used for the moment!');

 if FOpenSSLCertificate.IsExpired then
  raise ECertificateExpiredException.Create('Certificate is expired!'); 
end;

function TDSX509Certificate.GetBasicConstraints: Integer;
begin

end;

function TDSX509Certificate.GetIssuerX500Principal: TX500Principal;
begin

end;

function TDSX509Certificate.GetNotAfter: TDateTime;
begin
 Result := FOpenSSLCertificate.NotAfter;
end;

function TDSX509Certificate.GetNotBefore: TDateTime;
begin
 Result := FOpenSSLCertificate.NotBefore;
end;

function TDSX509Certificate.GetSerialNumber: string;
begin

end;

function TDSX509Certificate.GetSigAlgName: string;
begin

end;

function TDSX509Certificate.GetSignature: string;
begin

end;

function TDSX509Certificate.GetSubjectX500Principal: TX500Principal;
begin

end;

function TDSX509Certificate.GetVersion: LongInt;
begin

end;

end.
