object DMServerDataAcess: TDMServerDataAcess
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 297
  Width = 408
  object SQLCon: TSQLConnection
    DriverName = 'FIREBIRD'
    LoginPrompt = False
    Params.Strings = (
      'DriverUnit=Data.DBXFirebird'
      
        'DriverPackageLoader=TDBXDynalinkDriverLoader,DbxCommonDriver210.' +
        'bpl'
      
        'DriverAssemblyLoader=Borland.Data.TDBXDynalinkDriverLoader,Borla' +
        'nd.Data.DbxCommonDriver,Version=18.0.0.0,Culture=neutral,PublicK' +
        'eyToken=91d62ebb5b0d1b1b'
      
        'MetaDataPackageLoader=TDBXFirebirdMetaDataCommandFactory,DbxFire' +
        'birdDriver210.bpl'
      
        'MetaDataAssemblyLoader=Borland.Data.TDBXFirebirdMetaDataCommandF' +
        'actory,Borland.Data.DbxFirebirdDriver,Version=18.0.0.0,Culture=n' +
        'eutral,PublicKeyToken=91d62ebb5b0d1b1b'
      'GetDriverFunc=getSQLDriverINTERBASE'
      'LibraryName=dbxfb.dll'
      'LibraryNameOsx=libsqlfb.dylib'
      'VendorLib=fbclient.dll'
      'VendorLibWin64=fbclient.dll'
      'VendorLibOsx=/Library/Frameworks/Firebird.framework/Firebird'
      'MaxBlobSize=-1'
      'TrimChar=False'
      'ErrorResourceFile='
      'RoleName=RoleName'
      'drivername=FIREBIRD'
      'blobsize=-1'
      'commitretain=False'
      
        'Database=localhost:D:\Marcelo\Cosmos\Implanta'#231#245'es\Rio de Janeiro' +
        '\COSMOSDB.FDB'
      'localecode=0000'
      'Password=galaad'
      'Role=RoleName'
      'sqldialect=3'
      'isolationlevel=ReadCommitted'
      'user_name=sysdba'
      'waitonlocks=True'
      'trim char=False'
      'hostname=localhost'
      'servercharset=ISO8859_1')
    Left = 18
    Top = 10
  end
  object SQLCommand: TSQLDataSet
    BeforeOpen = SQLCommandBeforeOpen
    MaxBlobSize = -1
    Params = <>
    SQLConnection = SQLCon
    Left = 88
    Top = 11
  end
  object SQLSearch: TSQLDataSet
    BeforeOpen = SQLCommandBeforeOpen
    CommandText = 
      'select codcad, matcadint, matcad, nomcad, sigdis, sigfoc from vi' +
      'w_cadastrados where codfoc = 6895'
    MaxBlobSize = -1
    Params = <>
    SQLConnection = SQLCon
    Left = 24
    Top = 72
  end
  object DspSearch: TDataSetProvider
    DataSet = SQLSearch
    Options = [poIncFieldProps, poReadOnly, poAllowCommandText, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    Left = 88
    Top = 73
  end
end
