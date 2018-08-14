unit cosmos.classes.datobj.interfaces;

interface

uses
 System.Classes, DataSnap.DBClient;

type
  ICosmosDataObj = interface
    ['{63411AAE-06C7-4FFA-84F9-6DF55C49D487}']
  end;

  ICosmosCommand = interface(ICosmosDataObj)
    ['{A3472639-FD3E-4D5E-8F06-A40D2B2D0AE1}']
    function ExecuteCommand(const Command: WideString): integer;
    procedure ExecuteDQL(const DQL: WideString; Dataset: TClientDataset);
  end;

 ICosmosScript = interface(ICosmosDataObj)
   ['{0FD7700D-57AD-43F6-829B-3D02C08209C5}']
   procedure AddCommand(Command: string);
   procedure ClearCommands;
   function ExecuteScript: boolean; overload;
   function ExecuteScript(Script: TStringList): boolean; overload;
 end;



implementation



end.
