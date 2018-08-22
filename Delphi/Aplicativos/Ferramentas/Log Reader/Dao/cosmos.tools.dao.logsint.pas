unit cosmos.tools.dao.logsint;

interface

 uses
  cosmos.classes.logs;

 type

  IDAOLogInfo = interface
    ['{A6E98317-7F60-401F-91C4-FF427326BC07}']
    function GetIndex: integer;
    procedure SetIndex(value: integer);
    function GetContext: string;
    procedure SetContext(const value: string);
    function GetData: TDateTime;
    procedure SetData(const value: TDateTime);
    function GetInfo: string;
    procedure SetInfo(const value: string);
    function GetSource: string;
    procedure SetSource(const value: string);
    function GetLogType: TLogEvent;
    procedure SetLogType(const value: TLogEvent);

    property Index: integer read GetIndex write SetIndex;
    property Context: string read GetContext write SetContext;
    property Data: TDateTime read GetData write SetData;
    property Info: string read GetInfo write SetInfo;
    property Source: string read GetSource write SetSource;
    property LogType: TLogEvent read GetLogType write SetLogType;
  end;

  IDAOCosmosLogs = interface
   ['{0135D31F-D04B-4537-ABD9-5D78D0316586}']

   function GetCount: integer;
   function GetCurrent: IDAOLogInfo;
   function GetEOF: boolean;
   function GetFileName: string;
   function Prior: IDAOLogInfo;
   function Next: IDAOLogInfo;
   function FindData(const Index: integer): IDAOLogInfo;

   property Count: integer read GetCount;
   property Current: IDAOLogInfo read GetCurrent;
   property EOF: boolean read GetEOF;
   property FileName: string read GetFileName;

 end;

implementation

end.
