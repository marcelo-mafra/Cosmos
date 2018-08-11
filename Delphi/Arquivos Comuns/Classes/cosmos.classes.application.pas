unit cosmos.classes.application;

interface

uses
  winapi.windows, system.SysUtils, system.classes, system.Variants, Data.Db,
  cosmos.system.types, cosmos.system.messages, cosmos.system.files,
  cosmos.core.classes.xmldata, WideStrUtils, cosmos.core.classes.FieldsInfo,
  Xml.XMLDoc, System.DateUtils, Data.SqlTimSt,
  cosmos.system.winshell;

type
 {Representa uma aplicação Cosmos. Traz informações importantes sobre cada
  aplicação ou módulo do Cosmos.}
 TCosmosApplication = class
  private
   FDefaultConfigFile, FUserConfigFile: string;
   procedure CreateCosmosUserFolder(const FolderPath: string);

  public
    constructor Create;
    destructor Destroy; override;

    function GetDefaultConfigFile: string;
    function GetModuleName: string;
    function GetFullModuleName(Module: TCosmosModules): string;
    function GetModulePath: string;
    function GetFullModulepath: string;
    function GetModuleVersion: string;

    //Métodos relacionados a logs.
    function GetLogPrefix(Module: TCosmosModules): string; inline;
    procedure ReadLogInformation(Module: TCosmosModules; var Info: TStringList);

    function HasUserFiles: boolean;
    procedure CreateNewFiles;

    property DefaultConfigFile: string read FDefaultConfigFile write FDefaultConfigFile;
    property UserConfigFile: string read FUserConfigFile write FUserConfigFile;

 end;

 TSampleData = class
  private
   FCurrentIndex: integer;
   AData: variant;
   function GetDataCount: integer;

  public
   constructor Create(const LinesNo: integer); virtual;
   destructor Destroy; override;

   procedure Add(const Data: variant; Index: integer = 0);virtual;
   function Read(const Index: integer): variant; virtual;
   procedure ClearData; virtual;

   property Data: variant read AData;
   property DataCount: integer read GetDataCount;
   property CurrentIndex: integer read FCurrentIndex;
 end;

 {Implementa uma forma universal de transmissão de dados entre as camadas dos
  aplicativos Cosmos.}
 TCosmosData = class(TSampleData)
  private
   AData, AField: variant;

   function GetXMLData: string;
   function GetTaggedData: string;
   function GetVariantData: variant;

  public
   constructor Create(const LinesNo: integer); override;
   destructor Destroy; override;

   procedure Add(const FieldName: string; Data: variant); reintroduce;
   function Read(const Index: integer): variant; override;
   procedure WriteValue(const FieldName: string; Value: variant; Position: integer = 0);
   function FindIndex(const FieldName: string): integer;
   function FindValue(const FieldName: string): variant; overload;
   function FindValue(const Index: integer): variant; overload;
   function FindFieldName(const Index: integer): variant;
   procedure ClearData; override;
   procedure CopyData(Source: TCosmosData);
   procedure LoadFromData(Data: variant);
   procedure LoadFromXML(const XMLData: string);
   procedure LoadTaggedValues(const Value: string);

   property Data: variant read AData;
   property Fields: variant read AField;
   property TaggedData: string read GetTaggedData;
   property XMLData: string read GetXMLData;
   property VariantData: variant read GetVariantData;
 end;

 //Representa uma mensagem exibida pelo sistema
 TMessageData = class
  private
   FCode: integer;
   FAdditionalInfo: TStringList;
   FCosmosModule: TCosmosModules;
   FHelpContext: THelpContext;
   FMessageText: string;
   FMessageTitle: string;
   FMessageType: TMessageType;

   procedure LoadMessageInfoData;
   function GetAdditionalInfo: string;
   function GetXMLData: string; virtual;

  public
   constructor Create; virtual;
   destructor Destroy; override;
   procedure SetMessageInfo(const MessageInfo: TMessageInfo; value: variant);
   function GetMessageInfo(const MessageInfo: TMessageInfo): variant;

   property Code: integer read FCode write FCode;
   property AdditionalInfo: string read GetAdditionalInfo;
   property CosmosModule: TCosmosModules read FCosmosModule write FCosmosModule;
   property HelpContext: THelpContext read FHelpContext write FHelpContext;
   property MessageTitle: string read FMessageTitle write FMessageTitle;
   property MessageType: TMessageType read FMessageType write FMessageType;
   property MessageText: string read FMessageText write FMessageText;
   property XMLData: string read GetXMLData;

 end;


 //Representa o retorno de um método executado no servidor remoto.
 TServerReturn = class(TMessageData)
  private
   FServerData, FServerReturn: Olevariant;
   function GetXMLData: string; override;
   function GetServerReturn: Olevariant;
   procedure SetServerData(const Value: Olevariant);

  public
   constructor Create; override;
   destructor Destroy; override;
   procedure ReadServerReturn(Data: Olevariant);

   property Code;
   property AdditionalInfo;
   property CosmosModule;
   property HelpContext;
   property MessageTitle;
   property MessageType;
   property MessageText;
   property ServerData: Olevariant read FServerData write SetServerData;
   property ServerReturn: Olevariant read GetServerReturn;
   property XMLData: string read GetXMLData;
 end;


  EInvalidNumParams = Exception;

  TSQLParams = class
   private
    FParams: Olevariant;
    function GetTotalParams: integer;
    procedure DoCreateParams(NumParams: integer); inline;

   public
    constructor Create(NumParams: integer); overload;
    constructor Create; overload;
    destructor Destroy; override;
    procedure AppendData(value: Variant; Index: integer = 0);
    procedure ClearParams(NumParams: integer); overload;
    procedure ClearParams; overload;
    procedure LoadParams(value: Olevariant);
    function Read(const Index: integer): variant;

    property Params: Olevariant read FParams;
    property TotalParams: integer read GetTotalParams;
  end;

  //Classe especializada em ler informações dos campos de um arquivo XML.
  TFieldsInfoReader = class
   private
    FFileName: string;
    FIXMLFieldsInfo: IXMLFieldsInfoType;

   public
    constructor Create(const FileName: string); overload;
    constructor Create(ADocument: TXMLDocument); overload;
    destructor Destroy; override;

    function FindFieldInfo(const FieldName: string): IXMLFieldType;
    procedure ReadDatasetFieldsInfo(Dataset: TDataset);
  end;

  //Classe utilitária usada para converter dados de diversos tipos. Somente possui métodos de classe.
 TDataConverter = class(TObject)
   class function ToBolean(const value: string): boolean; inline;
   class function ToBoleanString(const value: boolean; Quoted: boolean = False): string; inline;
   class function ToBoleanSimNao(const value: string): string; inline;
   class function ToDate(const value: string): TDate; overload; inline;
   class function ToDate(const value: Extended): TDate; overload; inline;
   class function UnQuotedStr(const value: string): string; overload; inline;
   class procedure UnQuotedStr(var AList: TStringList); overload; inline;
   class function ToFormatedDateTime(const value: TDateTime): string; overload; inline;
   class function ToFormatedDateTime(const value: TSQLTimeStamp): string; overload; inline;
   class function ToFormatedDateTime(const value: TDateTime; Format: string): string;  overload; inline;
   class function ToFormatedSQLDate(const value: TDate): string; inline;
   class function ToFormatedSQLDateTime(const value: TDateTime; Quoted: boolean = True): string; inline;
   class function ToDateTime(const value: variant): TDateTime; overload; inline;
   class function ToDateTime(const value: Extended): TDateTime; overload; inline;
   class function ToInteger(const value: string): integer; inline;
   class function ToMonthName(const Month: integer): string; inline;
   class function ToTime(const value: string): TTime; inline;
   class function ToString(const value: variant): string; reintroduce; inline;
   class function ToWideString(const value: AnsiString): WideString; inline;
   class function ToAniString(const value: PWideChar): AnsiString;
   class function ToStringStream(const AStream: TStream): TStringStream;
   class function MemoryStreamToOleVariant(Strm: TMemoryStream): Olevariant;
   class function OleVariantToMemoryStream(OV: OleVariant): TMemoryStream;
   class function ToFormatedCurrency(const Value: Extended): string;
 end;


implementation

{ TMessageData }

constructor TMessageData.Create;
begin
 inherited Create;
 FAdditionalInfo := TStringList.Create;
 self.LoadMessageInfoData;
end;

destructor TMessageData.Destroy;
begin
 FAdditionalInfo.Free;
 inherited Destroy;
end;

function TMessageData.GetAdditionalInfo: string;
begin
 Result := FAdditionalInfo.CommaText;
end;

procedure TMessageData.LoadMessageInfoData;
begin
  FAdditionalInfo.Append('SourceName=');
  FAdditionalInfo.Append('InstallationID=');
  FAdditionalInfo.Append('MethodName=');
  FAdditionalInfo.Append('MethodParameters=');
  FAdditionalInfo.Append('InnerMessage=');
  FAdditionalInfo.Append('UserName=');
  FAdditionalInfo.Append('RoleName=');
  FAdditionalInfo.Append('Command=');
  FAdditionalInfo.Append('CustomInfo=');
end;

procedure TMessageData.SetMessageInfo(const MessageInfo: TMessageInfo;
  value: variant);
begin
 case MessageInfo of
   miInnerMessage: FAdditionalInfo.Values['SourceName'] := Value;
   miInstallationID: FAdditionalInfo.Values['InstallationID'] := Value;
   miMethodName: FAdditionalInfo.Values['MethodName'] := Value;
   miMethodParameters: FAdditionalInfo.Values['MethodParameters'] := Value;
   miRoleName: FAdditionalInfo.Values['InnerMessage'] := Value;
   miSourceName: FAdditionalInfo.Values['UserName'] := Value;
   miUserName: FAdditionalInfo.Values['RoleName'] := Value;
   miCommand: FAdditionalInfo.Values['Command'] := Value;
   miExceptionClassName: FAdditionalInfo.Values['ExceptionClass'] := Value;
   miCustomInfo: FAdditionalInfo.Values['CustomInfo'] := Value;
 end;
end;

function TMessageData.GetMessageInfo(const MessageInfo: TMessageInfo): variant;
begin
 case MessageInfo of
   miInnerMessage: Result := FAdditionalInfo.Values['SourceName'];
   miInstallationID: Result := FAdditionalInfo.Values['InstallationID'];
   miMethodName: Result := FAdditionalInfo.Values['MethodName'];
   miMethodParameters: Result := FAdditionalInfo.Values['MethodParameters'];
   miRoleName: Result := FAdditionalInfo.Values['InnerMessage'];
   miSourceName: Result := FAdditionalInfo.Values['UserName'];
   miUserName: Result := FAdditionalInfo.Values['RoleName'];
   miCommand: Result := FAdditionalInfo.Values['Command'];
   miExceptionClassName: Result := FAdditionalInfo.Values['ExceptionClass'];
   miCustomInfo: Result := FAdditionalInfo.Values['CustomInfo'];
 end;
end;

function TMessageData.GetXMLData: string;
var
AXML: TStringList;
begin
//Monta um XML representando a mensagem de retorno do servidor.
 AXML := TStringList.Create;

 try
  //Escreve a estrutura principal, contendo os dados sobre a mensagem de retorno.
  AXML.Append('<?xml version="1.0" encoding="utf-8"?>'); //do not localize!
  AXML.Append('<CosmosMessageData>'); //do not localize!
  AXML.Append('<Message>'); //do not localize!
  AXML.Append(Format('<MessageCode>%d</MessageCode>', [self.Code]));//do not localize!

  case self.MessageType of
    mtpSucess: AXML.Append('<MessageType>Sucess</MessageType>'); //do not localize!
    mtpError: AXML.Append('<MessageType>Error</MessageType>'); //do not localize!
    mtpWarning: AXML.Append('<MessageType>Warning</MessageType>'); //do not localize!
    mtpConfirmation: AXML.Append('<MessageType>Confirmation</MessageType>'); //do not localize!
    mtpInformation: AXML.Append('<MessageType>Inforrmation</MessageType>'); //do not localize!
  end;

  case self.CosmosModule of
    cmFocos: AXML.Append('<CosmosModule>cmFocos</CosmosModule>'); //do not localize!
    cmSecretarias: AXML.Append('<CosmosModule>cmSecretarias</CosmosModule>'); //do not localize!
    cmFinanceiro: AXML.Append('<CosmosModule>cmFinanceiro</CosmosModule>'); //do not localize!
    cmConferencias: AXML.Append('<CosmosModule>cmConferencias</CosmosModule>'); //do not localize!
    cmUsuarios: AXML.Append('<CosmosModule>cmUsuarios</CosmosModule>'); //do not localize!
    cmSincMestre: AXML.Append('<CosmosModule>cmSincMestre</CosmosModule>'); //do not localize!
    cmSincEscravo: AXML.Append('<CosmosModule>cmSincEscravo</CosmosModule>'); //do not localize!
  end;

  AXML.Append(Format('<MessageText>%s</MessageText>', [self.MessageText])); //do not localize!
  AXML.Append('</Message>'); //do not localize!

  //Escreve os dados adicionais.
  AXML.Append('<AdittionalInfo>'); //do not localize!
  AXML.Append(Format('<SourceName>%s</SourceName>', [self.GetMessageInfo(miSourceName)])); //do not localize!
  AXML.Append(Format('<InstallationID>%s</InstallationID>', [self.GetMessageInfo(miInstallationID)])); //do not localize!
  AXML.Append(Format('<MethodName>%s</MethodName>', [self.GetMessageInfo(miMethodName)])); //do not localize!
  AXML.Append(Format('<MethodParameters>%s</MethodParameters>', [self.GetMessageInfo(miMethodParameters)])); //do not localize!
  AXML.Append(Format('<InnerMessage>%s</InnerMessage>', [self.GetMessageInfo(miInnerMessage)])); //do not localize!
  AXML.Append(Format('<UserName>%s</UserName>', [self.GetMessageInfo(miUserName)])); //do not localize!
  AXML.Append(Format('<RoleName>%s</RoleName>', [self.GetMessageInfo(miRoleName)])); //do not localize!
  AXML.Append(Format('<Command>%s</Command>', [self.GetMessageInfo(miCommand)])); //do not localize!
  AXML.Append(Format('<ExceptionClass>%s</ExceptionClass>', [self.GetMessageInfo(miExceptionClassName)])); //do not localize!
  AXML.Append(Format('<CustomInfo>%s</CustomInfo>', [self.GetMessageInfo(miCustomInfo)])); //do not localize!
  AXML.Append(Format('<DateTime>%s</DateTime>', [FormatDateTime('dd/mm/yyyy hh:nn:ss', Now)])); //do not localize!
  AXML.Append('</AdittionalInfo>'); //do not localize!
  AXML.Append('</CosmosMessageData>'); //do not localize!

 finally
  if Assigned(AXML) then
   begin
    Result := AXML.Text;
    AXML.Free;
   end;
 end;
end;

{ TServerReturn }

function TServerReturn.GetServerReturn: Olevariant;
begin
   FServerReturn[0] := self.Code;
   FServerReturn[1] := self.MessageType;
   FServerReturn[2] := self.MessageText;
   FServerReturn[3] := self.CosmosModule;
   FServerReturn[4] := self.AdditionalInfo;
   FServerReturn[5] := self.MessageTitle;
   FServerReturn[6] := self.HelpContext;
   FServerReturn[7] := self.FServerData;

   Result := FServerReturn;
end;

function TServerReturn.GetXMLData: string;
var
AXML: TStringList;
begin
//Monta um XML representando a mensagem de retorno do servidor.
 AXML := TStringList.Create;

 try
  //Escreve a estrutura principal, contendo os dados sobre a mensagem de retorno.
  AXML.Append('<?xml version="1.0" encoding="utf-16"?>'); //do not localize!
  AXML.Append('<CosmosServerReturn>'); //do not localize!
  AXML.Append('<Message>'); //do not localize!
  AXML.Append(Format('<ReturnCode>%d</ReturnCode>', [self.Code]));//do not localize!

  case self.FMessageType of
    mtpSucess: AXML.Append('<ReturnType>Sucess</ReturnType>'); //do not localize!
    mtpError: AXML.Append('<ReturnType>Error</ReturnType>'); //do not localize!
    mtpWarning: AXML.Append('<ReturnType>Warning</ReturnType>'); //do not localize!
    mtpConfirmation: AXML.Append('<ReturnType>Confirmation</ReturnType>'); //do not localize!
    mtpInformation: AXML.Append('<ReturnType>Information</ReturnType>'); //do not localize!
  end;

  case self.CosmosModule of
    cmFocos: AXML.Append('<CosmosModule>cmFocos</CosmosModule>'); //do not localize!
    cmSecretarias: AXML.Append('<CosmosModule>cmSecretarias</CosmosModule>'); //do not localize!
    cmFinanceiro: AXML.Append('<CosmosModule>cmFinanceiro</CosmosModule>'); //do not localize!
    cmConferencias: AXML.Append('<CosmosModule>cmConferencias</CosmosModule>'); //do not localize!
    cmUsuarios: AXML.Append('<CosmosModule>cmUsuarios</CosmosModule>'); //do not localize!
    cmSincMestre: AXML.Append('<CosmosModule>cmSincMestre</CosmosModule>'); //do not localize!
    cmSincEscravo: AXML.Append('<CosmosModule>cmSincEscravo</CosmosModule>'); //do not localize!
  end;

  AXML.Append(Format('<MessageText>%s</MessageText>', [self.MessageText])); //do not localize!
  AXML.Append('</Message>'); //do not localize!

  //Escreve os dados adicionais.
  AXML.Append('<AdittionalInfo>'); //do not localize!
  AXML.Append(Format('<SourceName>%s</SourceName>', [self.GetMessageInfo(miSourceName)])); //do not localize!
  AXML.Append(Format('<InstallationID>%s</InstallationID>', [self.GetMessageInfo(miInstallationID)])); //do not localize!
  AXML.Append(Format('<MethodName>%s</MethodName>', [self.GetMessageInfo(miMethodName)])); //do not localize!
  AXML.Append(Format('<MethodParameters>%s</MethodParameters>', [self.GetMessageInfo(miMethodParameters)])); //do not localize!
  AXML.Append(Format('<InnerMessage>%s</InnerMessage>', [self.GetMessageInfo(miInnerMessage)])); //do not localize!
  AXML.Append(Format('<UserName>%s</UserName>', [self.GetMessageInfo(miUserName)])); //do not localize!
  AXML.Append(Format('<RoleName>%s</RoleName>', [self.GetMessageInfo(miRoleName)])); //do not localize!
  AXML.Append(Format('<Command>%s</Command>', [self.GetMessageInfo(miCommand)])); //do not localize!
  AXML.Append(Format('<CustomInfo>%s</CustomInfo>', [self.GetMessageInfo(miCustomInfo)])); //do not localize!
  AXML.Append(Format('<DateTime>%s</DateTime>', [FormatDateTime('dd/mm/yyyy hh:nn:ss', Now)])); //do not localize!
  AXML.Append('</AdittionalInfo>'); //do not localize!
  AXML.Append('</CosmosServerReturn>'); //do not localize!

 finally
  if Assigned(AXML) then
   begin
    Result := AXML.Text;
    AXML.Free;
   end;
 end;
end;

constructor TServerReturn.Create;
begin
 {Cria um array de variant que representa o retorno de um método remoto.}
 inherited Create;
 FServerReturn := varArrayCreate([0,7], varVariant);
end;

destructor TServerReturn.Destroy;
begin

 FServerData := unassigned;
 FServerReturn := unassigned;
 inherited Destroy;
end;

procedure TServerReturn.ReadServerReturn(Data: Olevariant);
begin
//Preenche os atributos da classe que representa uma mensagem retornada ao cliente.
{ Essa estrutura tem a seguinte composição:
     TServerReturn[0] := Código do retorno (inteiro);
     TServerReturn[1] := Tipo do retorno (TMethodResult);
     TServerReturn[2] := Mensagem do retorno (string);
     TServerReturn[3] := Módulo do Cosmos que gerou o retorno;
     TServerReturn[4] := Informações adicionais (string);
     TServerReturn[5] := Título da taskbar que será exibida no cliente;
     TServerReturn[6] := HelpContext
     TServerReturn[7] := Dados retornados de um dataset}
 if (not VarIsEmpty(Data)) and (VarIsArray(Data)) then
  begin
   self.FServerReturn := Data;
   //Agora, preenche os atributos da classe
   self.Code := FServerReturn[0];
   self.MessageType := FServerReturn[1];
   self.MessageText :=  FServerReturn[2];
   self.CosmosModule := TCosmosModules(FServerReturn[3]);
   self.FAdditionalInfo.CommaText := FServerReturn[4];
   self.MessageTitle :=  FServerReturn[5];
   self.HelpContext :=  FServerReturn[6];
   self.FServerData :=  FServerReturn[7];
  end;
end;



procedure TServerReturn.SetServerData(const Value: Olevariant);
begin
  FServerData := Value;
end;


{ TSQLParamsList }

procedure TSQLParams.AppendData(value: Variant; Index: integer);
begin
 if (Index >= 0) and (Index <= 30) then
  FParams[Index] := Value
 else
  raise EInvalidNumParams.Create(TCosmosErrorMsg.InvalidNumParams);
end;

procedure TSQLParams.ClearParams(NumParams: integer);
begin
 FParams := unassigned;
 if NumParams > 0 then
  DoCreateParams(NumParams);
end;

procedure TSQLParams.ClearParams;
begin
 FParams := unassigned;
end;

constructor TSQLParams.Create;
begin
 inherited Create;
 FParams := unassigned;
end;

constructor TSQLParams.Create(NumParams: integer);
begin
 inherited Create;
 DoCreateParams(NumParams);
end;

destructor TSQLParams.Destroy;
begin
 FParams := unassigned;
 inherited Destroy;
end;

procedure TSQLParams.DoCreateParams(NumParams: integer);
begin
 if ((NumParams >= 1) and (NumParams <= 30)) then
   FParams := varArrayCreate([0, NumParams - 1], varVariant)
 else
  begin
   FParams := varArrayCreate([0,29], varVariant);
   raise EInvalidNumParams.Create(TCosmosErrorMsg.InvalidNumParams);
  end;
end;

function TSQLParams.GetTotalParams: integer;
begin
 if varIsArray(FParams) then
  Result := VarArrayHighBound(FParams, 1) + 1
 else
  Result := 0;
end;

procedure TSQLParams.LoadParams(value: Olevariant);
begin
 if varIsArray(Value) then
  FParams := Value;
end;

function TSQLParams.Read(const Index: integer): variant;
begin
 if Index <= varArrayHighBound(self.FParams, 1) then
  Result := FParams[Index]
 else
  Result := unassigned;
end;

{ TCosmosData }

procedure TCosmosData.Add(const FieldName: string; Data: variant);
begin
 VarArrayPut(AField, FieldName, CurrentIndex);
 VarArrayPut(AData, Data, CurrentIndex);
 Inc(FCurrentIndex);
end;

procedure TCosmosData.ClearData;
var
I: integer;
begin
 FCurrentIndex := 0;
 I := 0;

 while I <= varArrayHighBound(AData, 1) do
  begin
   AField[I] := null;
   AData[I] := null;
   Inc(I);
  end;
end;

procedure TCosmosData.CopyData(Source: TCosmosData);
var
I: integer;
begin
 if Assigned(Source) then
  begin
   I := 0;

   while I <= varArrayHighBound(AData, 1) do
    begin
     AField[I] := Source.AField[I];
     AData[I] := Source.AData[I];
     Inc(I);
    end;
  end;
end;

constructor TCosmosData.Create(const LinesNo: integer);
begin
 inherited Create(LinesNo);

 if LinesNo > 0 then
  begin
   AData := varArrayCreate([0, LinesNo - 1], varVariant);
   AField := varArrayCreate([0,LinesNo - 1], varVariant);
  end
 else //Cria com um tamanho-padrão de 10 valores
  begin
   AData := varArrayCreate([0, 9], varVariant);
   AField := varArrayCreate([0,9], varVariant);
  end
end;

destructor TCosmosData.Destroy;
begin
  AData := unassigned;
  AField := unassigned;
  inherited Destroy;
end;

function TCosmosData.FindFieldName(const Index: integer): variant;
begin
//Retorna o nome de um campo cujo índice é passado em parâmetro.
 Result := null;

 if Index <= varArrayHighBound(AField, 1) then
   Result := AField[Index];
end;

function TCosmosData.FindIndex(const FieldName: string): integer;
var
I: integer;
begin
//Retorna o índice de um campo, caso ele exista na estrutura de dados.
 I := 0;
 Result := -1;

 while I <= varArrayHighBound(AData, 1) do
  begin
   if AField[I] = FieldName then
    begin
     Result := I;
     Break;
    end;

   Inc(I);
  end;
end;

function TCosmosData.FindValue(const Index: integer): variant;
begin
//Retorna o valor de um campo, caso ele exista na estrutura de dados.
 Result := null;

 if Index <= varArrayHighBound(AData, 1) then
   Result := AData[Index];
end;

function TCosmosData.GetTaggedData: string;
var
 I: integer;
 AList: TStringList;
 AFieldName, AFieldValue: string;
begin
 AList := TStringList.Create;
 AList.NameValueSeparator := '¦';//Alt + 0166

 try

  I := 0;

  while I <= varArrayHighBound(AData, 1) do
   begin
    if (self.FindFieldName(I) <> null) or (self.FindValue(I) <> null) then
     begin
      AFieldName := varToStr(self.FindFieldName(I));
      AFieldValue := varToStr(self.FindValue(I));
      AList.Append(Format('%s¦%s', [AFieldName, AFieldValue]));//do not localize!
     end;

    Inc(I);
   end;

 finally
  Result := AList.CommaText;
  AList.Free;
 end;
end;

function TCosmosData.GetVariantData: variant;
begin
 Result := varArrayCreate([0, 1], varVariant);
 Result[0] := Fields;
 Result[1] := Data;
end;

function TCosmosData.GetXMLData: string;
var
AXML: TStringList;
I: integer;
AFieldName, AFieldValue: string;
begin
//Monta um XML representando a mensagem de retorno do servidor.
 AXML := TStringList.Create;

 try
  //Escreve a estrutura principal, contendo os dados sobre a mensagem de retorno.
  AXML.Append('<?xml version="1.0" encoding="UTF-16"?>'); //do not localize!
  AXML.Append('<CosmosData>'); //do not localize!
  AXML.Append('<Fields>'); //do not localize!

  I := 0;

  while I <= varArrayHighBound(AData, 1) do
   begin
    if (self.FindFieldName(I) <> null) or (self.FindValue(I) <> null) then
     begin
      AFieldName := varToStr(self.FindFieldName(I));
      AFieldValue := varToStr(self.FindValue(I));
      AXML.Append(Format('<Field FieldIndex="%d" FieldName="%s" FieldValue="%s"/>', [I, AFieldName, AFieldValue]));//do not localize!
     end;

    Inc(I);
   end;

  AXML.Append('</Fields>'); //do not localize!
  AXML.Append('</CosmosData>'); //do not localize!

 finally
  if Assigned(AXML) then
   begin
    Result := AXML.Text;
    AXML.Free;
   end;
 end;
end;

procedure TCosmosData.LoadFromData(Data: variant);
var
 I: integer;
begin
 I := 0;

 if varIsArray(Data) then
  begin
   while I <= varArrayHighBound(AField, 1) do
    begin
     self.WriteValue(AField[I], AData[I], I);
     Inc(I);
    end;
  end;
end;

procedure TCosmosData.LoadTaggedValues(const Value: string);
var
 I: integer;
 AList: TStringList;
 AField, AValue: string;
begin
 AList := TSTringList.Create;
 AList.NameValueSeparator := '¦';
 AList.CommaText := Value;

 for I := 0 to Pred(AList.Count) do
   begin
     AField := AList.Names[I];
     AValue := AList.ValueFromIndex[I];
     WriteValue(AField, AValue, I);
   end;
end;

procedure TCosmosData.LoadFromXML(const XMLData: string);
var
I: integer;
ICosmosData: IXMLCosmosData;
IFields: IXMLCosmosDataFields;
begin
 try
  ICosmosData := LoadXMLCosmosData(XMLData);
  IFields := ICosmosData.Fields;

  for I := 0 to IFields.Count - 1 do
   self.WriteValue(IFields.Field[I].FieldName, IFields.Field[I].FieldValue, IFields.Field[I].FieldIndex);

  if Assigned(IFields) then
   IFields := nil;

  if Assigned(ICosmosData) then
   ICosmosData := nil;

 except
  if Assigned(IFields) then
   IFields := nil;

  if Assigned(ICosmosData) then
   ICosmosData := nil;

  raise;
 end;
end;

function TCosmosData.FindValue(const FieldName: string): variant;
var
I: integer;
begin
//Retorna o valor de um campo, caso ele exista na estrutura de dados.
 I := 0;
 Result := null;

 while I <= varArrayHighBound(AData, 1) do
  begin
   if AField[I] <> null then
    begin
     if UpperCase(AField[I]) = UpperCase(FieldName) then
       begin
        Result := AData[I];
        Break;
       end;
    end;

   Inc(I);
  end;
end;

function TCosmosData.Read(const Index: integer): variant;
begin
{Retorna uma informação da estrutura em memória a partir de uma posição informada no parâmetro desse método.}
 if Index <= varArrayHighBound(AData, 1) then
  begin
   Result := varArrayCreate([0,1], varVariant);
   Result[0] := varArrayGet(AField, [Index]);
   Result[1] := varArrayGet(AData, [Index]);
  end
 else
  Result := unassigned;
end;

procedure TCosmosData.WriteValue(const FieldName: string; Value: variant;
    Position: integer = 0);
var
Index: integer;
begin
{Escreve dados na estrutura em memória. Primeiro tenta encontrar o valor na
 estrutura e escrevê-lo no índice correto. Caso não o encontre, insere os
 valores na posição indicada pelo parâmetro "Position".}

 Index := self.FindIndex(FieldName);
 if Index >= 0 then
  VarArrayPut(AData, Value, Index)
 else
  begin
   VarArrayPut(AField, FieldName, Position);
   VarArrayPut(AData, Value, Position);
  end;
end;

{ TDataConverter }

class function TDataConverter.MemoryStreamToOleVariant(
  Strm: TMemoryStream): Olevariant;
var
Data: PByteArray;
begin
 Result := VarArrayCreate ([0, Strm.Size - 1], varByte);
 Data := VarArrayLock(Result);
 try
  Strm.Position := 0;
  Strm.ReadBuffer(Data^, Strm.Size);
 finally
  VarArrayUnlock(Result);
 end;
end;

class function TDataConverter.OleVariantToMemoryStream(
  OV: OleVariant): TMemoryStream;
var
Data: PByteArray;
Size: integer;
begin
 Result := TMemoryStream.Create;
 try
  Size := VarArrayHighBound (OV, 1) - VarArrayLowBound(OV, 1) + 1;
  Data := VarArrayLock(OV);

  try
   Result.Position := 0;
   Result.WriteBuffer(Data^, Size);
  finally
   VarArrayUnlock(OV);
  end;

 except
  Result.Free;
  Result := nil;
 end;
end;


class function TDataConverter.ToAniString(const value: PWideChar): AnsiString;
begin
 OleStrToStrVar(Value, Result);
end;

class function TDataConverter.ToBolean(const value: string): boolean;
begin
//Converte uma string para um boolean. "S" é interpretado como True e qualquer outro valor é False.
 Result := UpperCase(value) = 'S';
end;

class function TDataConverter.ToBoleanSimNao(const value: string): string;
begin
 if Value = 'S' then
  Result := 'Sim' //do not localize!
 else
  Result := 'Não';//do not localize!
end;

class function TDataConverter.ToBoleanString(const value: boolean;
    Quoted: boolean = False): string;
begin
 if Value = True then
  Result := 'S'
 else
  Result := 'N';

 if Quoted then
  Result := Result.QuotedString;
end;

class function TDataConverter.ToDate(const value: string): TDate;
begin
 try
  Result := StrToDate(value);

 except
  on E: Exception do
   begin
    E.Message := Format(TConverterErrorMsg.StringDateConvert, [value]);
    raise;
   end;
 end;
end;

class function TDataConverter.ToDate(const value: Extended): TDate;
begin
 Result := DateOf(Value);
end;

class function TDataConverter.ToDateTime(const value: Extended): TDateTime;
begin
 Result := Value;
end;

class function TDataConverter.ToDateTime(const value: variant): TDateTime;
begin
 Result := varToDateTime(value);
end;

class function TDataConverter.ToFormatedDateTime(
  const value: TDateTime): string;
begin
 Result := FormatDateTime('dd/mm/yyyy hh:nn:ss', value); //do not localize!
end;

class function TDataConverter.ToFormatedCurrency(const Value: Extended): string;
begin
 Result := FloatToStrF(Value, ffCurrency, 15, 2);
end;

class function TDataConverter.ToFormatedDateTime(const value: TDateTime;
  Format: string): string;
begin
 Result := FormatDateTime(Format, value);
end;

class function TDataConverter.ToFormatedDateTime(
  const value: TSQLTimeStamp): string;
begin
 Result := SQLTimeStampToStr('dd/mm/yyyy hh:nn:ss', Value);//do not localize!
end;

class function TDataConverter.ToFormatedSQLDate(const value: TDate): string;
begin
 Result := FormatDateTime('yyyy/mm/dd', Value);//do not localize!
end;

class function TDataConverter.ToFormatedSQLDateTime(
  const value: TDateTime; Quoted: boolean): string;
begin
 Result := FormatDateTime('yyyy/mm/dd hh:nn:ss', Value);//do not localize!
 if Quoted then
  Result := Result.QuotedString;
end;

class function TDataConverter.ToInteger(const value: string): integer;
begin
 try
  Result := StrToInt(value);

 except
  on E: Exception do
   begin
    E.Message := Format(TConverterErrorMsg.StringIntegerConvert, [value]);
    raise;
   end;
 end;
end;

class function TDataConverter.ToMonthName(const Month: integer): string;
begin
//Retorna os nomes dos meses...
 case Month of
  1: Result := TCosmosMiscellaneous.JAN;
  2: Result := TCosmosMiscellaneous.FEV;
  3: Result := TCosmosMiscellaneous.MAR;
  4: Result := TCosmosMiscellaneous.ABR;
  5: Result := TCosmosMiscellaneous.MAI;
  6: Result := TCosmosMiscellaneous.JUN;
  7: Result := TCosmosMiscellaneous.JUL;
  8: Result := TCosmosMiscellaneous.AGO;
  9: Result := TCosmosMiscellaneous.SETM;
  10: Result := TCosmosMiscellaneous.OUTU;
  11: Result := TCosmosMiscellaneous.NOV;
  12: Result := TCosmosMiscellaneous.DEZ
  else
   Result := '';
 end;
end;

class function TDataConverter.ToString(const value: variant): string;
begin
 Result := '';
 if (Value <> null) and (Value <> unassigned) then
  Result := VarToStr(Value);
end;

class function TDataConverter.ToStringStream(
  const AStream: TStream): TStringStream;
begin
 Result := TStringStream.Create();

 try
  Result.LoadFromStream(AStream);

 except
  Result := nil;
 end;
end;

class function TDataConverter.ToTime(const value: string): TTime;
begin
 try
  Result := StrToTime(value);

 except
  on E: Exception do
   begin
    E.Message := Format(TConverterErrorMsg.StringTimeConvert, [value]);
    raise;
   end;
 end;
end;

class function TDataConverter.ToWideString(const value: AnsiString): WideString;
begin
 Result := WideString(Value);
end;

class function TDataConverter.UnQuotedStr(const value: string): string;
var
sFirstChar, sLastChar: string;
begin
 Result := value;

 sFirstChar := Copy(TrimLeft(value), 1, 1);
 sLastChar := Copy(TrimRight(value), Length(value), 1);
 if (sFirstChar = '''') and  (sLastChar = '''') then
  begin
    Delete(Result, 1, 1);
    Delete(Result, Length(Result), 1);
  end;
end;

class procedure TDataConverter.UnQuotedStr(var AList: TStringList);
var
AIndex: integer;
sValue: string;
begin
 if AList = nil then
  Exit;

 AList.Delimiter := ',';
 AList.QuoteChar := ' ';

 for AIndex := 0 to Pred(AList.Count) do
   begin
     sValue := AList.Strings[AIndex];
     sValue := TDataConverter.UnQuotedStr(sValue);
     AList.Strings[AIndex] := sValue;
   end;
end;

{ TSampleData }

procedure TSampleData.Add(const Data: variant; Index: integer);
begin
 VarArrayPut(AData, Data, CurrentIndex);
 Inc(FCurrentIndex);
end;

procedure TSampleData.ClearData;
var
I: integer;
begin
 FCurrentIndex := 0;
 I := 0;

 while I <= varArrayHighBound(AData, 1) do
  begin
   AData[I] := null;
   Inc(I);
  end;
end;

constructor TSampleData.Create(const LinesNo: integer);
begin
 inherited Create;
 FCurrentIndex := 0;

 if LinesNo > 0 then
  AData := varArrayCreate([0, LinesNo - 1], varVariant)
 else //Cria com um tamanho-padrão de 10 valores
  AData := varArrayCreate([0, 9], varVariant);
end;

destructor TSampleData.Destroy;
begin
  AData := unassigned;
  inherited Destroy;
end;

function TSampleData.GetDataCount: integer;
begin
 Result := varArrayHighBound(AData, 1)
end;

function TSampleData.Read(const Index: integer): variant;
begin
 if Index <= varArrayHighBound(AData, 1) then
  begin
   Result := AData[Index];
  end
 else
  Result := unassigned;

end;

{ TFieldsInfoReader }

constructor TFieldsInfoReader.Create(const FileName: string);
begin
 try
  FIXMLFieldsInfo := LoadFieldsInfo(FileName);
  FFileName := FileName;

 except
  raise;
 end;
end;

constructor TFieldsInfoReader.Create(ADocument: TXMLDocument);
begin
 try
  FIXMLFieldsInfo := GetFieldsInfo(ADocument.DocumentElement.OwnerDocument);

 except
  raise;
 end;
end;

destructor TFieldsInfoReader.Destroy;
begin
  if Assigned(FIXMLFieldsInfo) then
   FIXMLFieldsInfo := nil;

  inherited Destroy;
end;

function TFieldsInfoReader.FindFieldInfo(const FieldName: string): IXMLFieldType;
var
I: integer;
begin
 Result := nil;

 if FIXMLFieldsInfo <> nil then
  begin
   for I := 0 to Pred(FIXMLFieldsInfo.Info.Count) do
     begin
      if FIXMLFieldsInfo.Info[I].FieldName = FieldName then
       begin
         Result := FIXMLFieldsInfo.Info[I];
         Break;
       end;
     end;
  end;
end;

procedure TFieldsInfoReader.ReadDatasetFieldsInfo(Dataset: TDataset);
var
I: integer;
AFieldName: string;
IFieldsInfo: IXMLFieldType;
begin
//Formata e altera os nomes dos campos para nomes "legíveis pelo usuário.

 try
  if Dataset <> nil then
   begin
    for I := 0 to Pred(Dataset.Fields.Count) do
     begin
       AFieldName := UpperCase(Dataset.Fields.Fields[I].FieldName);
       IFieldsInfo := FindFieldInfo(AFieldName);
       if IFieldsInfo <> nil then
        begin
          //Outputdebugstring(PWideChar(AFieldName));
          Dataset.Fields.Fields[I].Alignment := TAlignment(IFieldsInfo.Alignment);
          Dataset.Fields.Fields[I].DisplayLabel := IFieldsInfo.DisplayLabel;
          Dataset.Fields.Fields[I].Visible := IFieldsInfo.IsVisible;

          case IFieldsInfo.FieldType of
           0: Dataset.Fields.Fields[I].DisplayWidth := IFieldsInfo.DisplayWidth; //string
           1: ;//integer
           2: //Float
             begin
              TFloatField(Dataset.Fields.Fields[I]).currency := False;
              TFloatField(Dataset.Fields.Fields[I]).Precision := 2;
             end;
           3: ;//Date
           4: ;//Time
           5: ;//DateTime
           6: TFloatField(Dataset.Fields.Fields[I]).currency := True; //Currency
          end;

        end;
     end;
   end;

 finally
  if Assigned(IFieldsInfo) then  IFieldsInfo := nil;
 end;
end;

{ TCosmosApplication }

constructor TCosmosApplication.Create;
begin
  inherited Create;
end;

procedure TCosmosApplication.CreateCosmosUserFolder(const FolderPath: string);
begin
//Cria a pasta passada em parâmetro.
 try
   TShellFolders.CreateFolder(FolderPath);

 except
  raise;
 end;
end;

procedure TCosmosApplication.CreateNewFiles;
var
 AFile: TStringList;
 ACosmosUserFolder: string;
begin
{ Cria o arquivo de configuração do usuário caso ele não exista. Isto pode ser
 feito sem problemas de privilégio, pois a pasta criada será debaixo da pasta
 local de arquivos do usuário.}
 AFile :=  TStringList.Create;

 try
   FDefaultConfigFile := GetDefaultConfigFile;
   ACosmosUserFolder := ExtractFilePath(UserConfigFile);

  if not TShellFolders.FolderExists(ACosmosUserFolder) then
    CreateCosmosUserFolder(ACosmosUserFolder);

  AFile.LoadFromFile(DefaultConfigFile);
  AFile.SaveToFile(UserConfigFile);

 finally
  if Assigned(AFile) then FreeAndNil(AFile);
 end;
end;

destructor TCosmosApplication.Destroy;
begin
 inherited Destroy;
end;

function TCosmosApplication.GetDefaultConfigFile: string;
begin
 {Recupera o caminho completo do arquivo de configurações "padrão". Esse arquivo
 é uma cópia matrix de "ConfigurationsUse.xml" que deve ser usada apenas quando
 for necessário criar uma cópia para um novo usuário. Tipicamente, isso acontece
 quando um usuário do S.O. acessa o Cosmos pela primeira vez e ainda não possui
 o seu arquivo de configurações.}
 Result := GetModulepath + TCosmosFiles.ConfigUserDefault;
end;

function TCosmosApplication.GetFullModuleName(Module: TCosmosModules): string;
begin
//Retorna o nome completo de um módulo do Cosmos.
 case Module of
   cmSecretarias, cmSecretariasServer: Result := TCosmosAppName.CosmosSecretarias;
   cmFinanceiro, cmFinanceiroServer: Result := TCosmosAppName.CosmosFinanceiro;
   cmConferencias, cmConferenciasServer: Result := TCosmosAppName.CosmosConferencias;
   cmUsuarios, cmUsuariosServer: Result := TCosmosAppName.CosmosUsuarios;
 end;
end;

function TCosmosApplication.GetFullModulepath: string;
var
Buffer: array[0..260] of Char;
begin
//Recupera o caminho completo da aplicação ou módulo.
 GetModuleFileName(0, Buffer, SizeOf(Buffer));
 Result := Buffer;
end;

function TCosmosApplication.GetLogPrefix(Module: TCosmosModules): string;
begin
//Retorna o prefixo do nome do arquivo de logs de um módulo do Cosmos.
 case Module of
   cmFocos, cmFocosServer: Result := TCosmosAppName.CosmosFocosShort;
   cmSecretarias, cmSecretariasServer: Result := TCosmosAppName.CosmosSecretariasShort;
   cmFinanceiro, cmFinanceiroServer: Result := TCosmosAppName.CosmosFinanceiroShort;
   cmConferencias, cmConferenciasServer: Result := TCosmosAppName.CosmosConferenciasShort;
   cmUsuarios, cmUsuariosServer: Result := TCosmosAppName.CosmosUsuariosShort;
 end;

 if Result <> '' then
  Result := Result + '_';
end;

function TCosmosApplication.GetModuleName: string;
var
Buffer: array[0..260] of Char;
sCosmosFolder: string;
begin
//Recupera a pasta onde se encontra a aplicação ou módulo.
 GetModuleFileName(0, Buffer, SizeOf(Buffer));
 sCosmosFolder := Buffer;
 Result := ExtractFileName(sCosmosFolder);
end;

function TCosmosApplication.GetModulePath: string;
var
Buffer: array[0..260] of Char;
sCosmosFolder: string;
begin
//Recupera a pasta onde se encontra a aplicação ou módulo.
 GetModuleFileName(0, Buffer, SizeOf(Buffer));
 sCosmosFolder := Buffer;
 Result := ExtractFilePath(sCosmosFolder);
end;

function TCosmosApplication.GetModuleVersion: string;
begin
//To do.
end;

function TCosmosApplication.HasUserFiles: boolean;
begin
 Result := TShellFiles.FileExists(UserConfigFile);
end;

procedure TCosmosApplication.ReadLogInformation(Module: TCosmosModules;
  var Info: TStringList);
begin
 //Lista as informações de configuração do objeto de escrita de logs.
 Info.Append('CategoryMessageFile=events.dll'); //do not localize!
 Info.Append('DisplayEventFile=events.dll'); //do not localize!
 Info.Append('DisplayNameFile=events.dll'); //do not localize!
 Info.Append('DisplayEventID=452'); //do not localize!
 Info.Append('EventFile=cosmos.evt'); //do not localize!
 Info.Append('PrimaryModule=Cosmos'); //do not localize!
 Info.Append('LogName=Cosmos'); //do not localize!
 Info.Append('CategoryCount=6'); //do not localize!
 Info.Append('DisplayNameID=150'); //do not localize!
 Info.Append('TypesSupported=2'); //do not localize!

 case Module of
   cmFocos: Info.Append('Source=Cosmos Gestor de Focos'); //do not localize!
   cmFocosServer: Info.Append('Source=Cosmos Gestor de Focos Server'); //do not localize!
   cmSecretarias: Info.Append('Source=Cosmos Gestor de Secretarias'); //do not localize!
   cmSecretariasServer: Info.Append('Source=Cosmos Gestor de Secretarias Server'); //do not localize!
   cmFinanceiro: Info.Append('Source=Cosmos Gestor Financeiro'); //do not localize!
   cmFinanceiroServer: Info.Append('Source=Cosmos Gestor Financeiro Server'); //do not localize!
   cmConferencias: Info.Append('Source=Cosmos Gestor de Conferências'); //do not localize!
   cmConferenciasServer: Info.Append('Source=Cosmos Gestor de Conferências Server'); //do not localize!
   cmUsuarios: Info.Append('Source=Cosmos Gestor de Usuários'); //do not localize!
   cmUsuariosServer: Info.Append('Source=Cosmos Gestor de Usuários Server'); //do not localize!
 end;
end;




end.
