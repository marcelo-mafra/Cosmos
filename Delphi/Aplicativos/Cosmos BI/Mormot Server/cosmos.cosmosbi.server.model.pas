unit cosmos.cosmosbi.server.model;

interface

uses
  System.SysUtils, System.Classes, cosmos.bi.interfaces, SynCommons, SynDB,
  SynDBFireDac, FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef,
  FireDAC.Stan.Intf, FireDAC.Phys.IBBase, FireDAC.Phys.IBDef, FireDAC.Phys.IB,
  System.IniFiles, mORMot;

type
  TServiceCosmosSystem = class(TInterfacedObject, ICosmosSystem)
  private

  public
    function ServerDateTime: TDateTime;
  end;


  TServiceCosmosBi = class(TInterfacedObject, ICosmosBi)
  private
    DatabasePath: string;
    RoleName: string;
    ServerName: string;
    UserName, Password: string;

    function CreateFirebirdProperties: TSQLDBFireDACConnectionProperties;
    procedure LoadDatabaseParams;

  public
    function ListActiveFocus: RawUTF8;
    function ListPupils(const FocusId: integer): RawUTF8;
    function GetPhoto(const PeopleId: integer): TSQLRawBlob;
  end;





  TDModel = class(TDataModule)
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    FDPhysIBDriverLink1: TFDPhysIBDriverLink;
  private
    { Private declarations }


  public
    { Public declarations }
  end;

var
  DModel: TDModel;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TServiceCosmosBi }

function TServiceCosmosBi.CreateFirebirdProperties: TSQLDBFireDACConnectionProperties;
begin
 if DatabasePath = '' then
  LoadDatabaseParams;

 Result := TSQLDBFireDACConnectionProperties.Create(FIREDAC_PROVIDER[dFirebird], ServerName + ':' + DatabasePath, UserName, Password);
 Result.Parameters.Append('RoleName=' + RoleName);
 // aConn := fbProp.ThreadSafeConnection;
// aConn.NewStatement.ExecutePreparedAndFetchAllAsJSON(True, Result);
end;

function TServiceCosmosBi.GetPhoto(const PeopleId: integer): TSQLRawBlob;
var
 fbProp: TSQLDBFireDACConnectionProperties;
 IData: ISQLDBRows;
begin
 fbProp := CreateFirebirdProperties;
 IData := fbProp.Execute('select fotcad from cadastrados where codcad = ?', [PeopleId]);
 Result := IData.ColumnBlob(0);
end;

function TServiceCosmosBi.ListActiveFocus: RawUTF8;
var
 fbProp: TSQLDBFireDACConnectionProperties;
 IData: ISQLDBRows;
begin
 fbProp := CreateFirebirdProperties;

 IData := fbProp.Execute('select * from viw_focos where indati = ? order by nomfoc', ['S']);
 Result := IData.FetchAllAsJSON(True);
end;

function TServiceCosmosBi.ListPupils(const FocusId: integer): RawUTF8;
var
 fbProp: TSQLDBFireDACConnectionProperties;
 IData: ISQLDBRows;
begin
 fbProp := CreateFirebirdProperties;

 IData := fbProp.Execute('select * from viw_cadastrados where codfoc = ? and indati = ? and camdis = ? order by nomcad', [FocusId, 'S', 'LEC']);
 Result := IData.FetchAllAsJSON(True);
end;

procedure TServiceCosmosBi.LoadDatabaseParams;
var
 aFile: TIniFile;
 sPath: string;
begin
 sPath := GetModuleName(HInstance);
 sPath := ExtractFilePath(sPath);
 sPath := sPath + 'serverparams.ini';

 aFile := TIniFile.Create(sPath);

 try
   DatabasePath := aFile.ReadString('DBPARAMS', 'DatabasePath', '');
   ServerName := aFile.ReadString('DBPARAMS', 'ServerName', '');
   UserName := aFile.ReadString('DBPARAMS', 'UserName', '');
   Password := aFile.ReadString('DBPARAMS', 'Password', '');
   RoleName := aFile.ReadString('DBPARAMS', 'RoleName', '');


 finally
  aFile.Free;
 end;
end;

{ TServiceCosmosSystem }

function TServiceCosmosSystem.ServerDateTime: TDateTime;
begin
 Result := Now;
end;

end.
