unit cosmos.tools.view.logs.interfaces;

interface

 uses Classes, cosmos.classes.application;

 type
  ICosmosLogsInterface = interface
   ['{9C07384E-A3D3-4EFE-9D92-08CFAB3E97FE}']

   function PriorLog: TCosmosData;
   function NextLog: TCosmosData;
 end;

implementation

end.
