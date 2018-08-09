program cosmosbisrv;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  System.IniFiles,
  SynCommons,
  SynLog,
  mORMot,
  mORMotSQLite3,
  SynSQLite3Static,
  mORMotHttpServer,
  cosmos.bi.interfaces in '..\Common\cosmos.bi.interfaces.pas',
  cosmos.cosmosbi.server.model in 'cosmos.cosmosbi.server.model.pas' {DModel: TDataModule};

var
  aModel: TSQLModel;
  aDB: TSQLRestServer;
  aServer: TSQLHttpServer;
  aParamsFile: TIniFile;
  sPath,sPort: string;
begin
  // set the logs level to only important events (reduce .log size)
  TSQLLog.Family.Level := LOG_STACKTRACE+[sllInfo,sllServer];
  // initialize the ORM data model
  aModel := TSQLModel.Create([],ROOT_NAME);
  sPath := GetModuleName(HInstance);
  sPath := ExtractFilePath(sPath);
  sPath := sPath + 'serverparams.ini';
  aParamsFile := TIniFile.Create(sPath);

  try
    // create a fast in-memory ORM server
    sPort := aParamsFile.ReadString('CONNECTION', 'ServerPort', '');
    aDB := TSQLRestServerFullMemory.Create(aModel,'cosmosbin.json',false,false);

    try
      // register our TServiceCosmosBi implementation
      aDB.ServiceRegister(TServiceCosmosSystem, [TypeInfo(ICosmosSystem)],sicShared);
      aDB.ServiceRegister(TServiceCosmosBi,[TypeInfo(ICosmosBi)],sicShared);
      // launch the HTTP server
      aServer := TSQLHttpServer.Create(sPort, [aDB],'+',useHttpApiRegisteringURI);

      FreeAndNil(aParamsFile);

      try
        aServer.AccessControlAllowOrigin := '*'; // allow cross-site AJAX queries
        writeln('Background server is running'#10);
        write('Press [Enter] to close the server.');
        ConsoleWaitForEnterKey;
      finally
        aServer.Free;
      end;

    finally
      aDB.Free;
    end;

  finally
    aModel.Free;
    if Assigned(aParamsFile) then
     FreeAndNil(aParamsFile);
  end;
end.
