unit cosmos.tools.view.logs.interfaces;

interface

 uses Classes, cosmos.classes.logs, cosmos.tools.controller.logsint;

 type

  ICosmosLogsInterface = interface
   ['{9C07384E-A3D3-4EFE-9D92-08CFAB3E97FE}']

   //function PriorLog: TCosmosData; overload;
   function PriorLog: IControllerLogInfo;
   //function NextLog: TCosmosData; overload;
   function NextLog: IControllerLogInfo;
 end;

implementation

end.
