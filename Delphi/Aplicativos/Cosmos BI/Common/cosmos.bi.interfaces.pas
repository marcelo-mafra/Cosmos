unit cosmos.bi.interfaces;

interface

uses
  mORMot, SynCommons;

type
  ICosmosSystem = interface(IInvokable)
    ['{CCC690EC-05F7-4ECF-AA98-B24912E8BF8D}']

    function ServerDateTime: TDateTime;

  end;

  ICosmosBi = interface(IInvokable)
    ['{4269BF10-E7C2-4A68-847A-D7B5FBD8A598}']

    function ListActiveFocus: RawUTF8;
    function ListPupils(const FocusId: integer): RawUTF8;
    function GetPhoto(const PeopleId: integer): TSQLRawBlob;
  end;

const
  ROOT_NAME = 'cosmosbi';
  PORT_NAME = '44501';
  APPLICATION_NAME = 'RestService';

implementation



initialization
  // so that we could use directly ICosmosBi instead of TypeInfo(ICosmosBi)
  TInterfaceFactory.RegisterInterfaces([TypeInfo(ICosmosSystem)]);
  TInterfaceFactory.RegisterInterfaces([TypeInfo(ICosmosBi)]);
end.
