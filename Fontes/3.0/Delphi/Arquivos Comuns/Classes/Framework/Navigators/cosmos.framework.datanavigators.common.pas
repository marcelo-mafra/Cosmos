unit cosmos.framework.datanavigators.common;

interface

uses
 System.SysUtils, cosmos.classes.application;


type
 EUnCreatedInnerObject = Exception;
 EInactiveInnerObject = Exception;

{Esta é uma classe completamente abstrata, que serve para asbtrair um objeto
 que manipula a navegação em um tipo de dado genérico. As classes descendentes
 implementam as especificidades relativas à navegação em diferentes tipos de dados.}
 TCustomDataNavigator = class(TInterfacedObject)

  protected
   function GetActive: boolean; virtual; abstract;
   function GetIsBof: boolean; virtual; abstract;
   function GetIsEof: boolean; virtual; abstract;
   function GetIsEmpty: boolean; virtual; abstract;

  public

   constructor Create;

   procedure MoveToFirst; virtual; abstract;
   procedure MoveToPrior; virtual; abstract;
   procedure MoveToNext; virtual; abstract;
   procedure MoveToLast; virtual; abstract;
   procedure UpdateData; virtual; abstract;
   function LocateData(const Argumments: TCosmosData): boolean; virtual; abstract;

   property Active: boolean read GetActive;
   property IsBof: boolean read GetIsBof;
   property IsEof: boolean read GetIsEof;
   property IsEmpty: boolean read GetIsEmpty;


 end;

implementation

{ TCustomDataNavigator }

constructor TCustomDataNavigator.Create;
begin
 inherited Create;
end;

end.
