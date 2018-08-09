unit cosmos.framework.datanavigators.datasets;

interface

uses
 System.Classes, System.SysUtils, cosmos.system.messages, cosmos.classes.application,
 cosmos.framework.datanavigators.common, Data.DB;

type
 TDatasetDataNavigator = class(TCustomDataNavigator)

  private
   FDataset: TDataset;
   FOnUpdateData: TNotifyEvent;

  protected
   function GetActive: boolean; override;
   function GetIsBof: boolean; override;
   function GetIsEof: boolean; override;
   function GetIsEmpty: boolean; override;


  public
   constructor Create(const Dataset: TDataset);
   destructor Destroy; override;

   procedure MoveToFirst; override;
   procedure MoveToPrior; override;
   procedure MoveToNext; override;
   procedure MoveToLast; override;
   procedure UpdateData; override;
   function LocateData(const Argumments: TCosmosData): boolean; override;

   property Active: boolean read GetActive;
   property IsBof: boolean read GetIsBof;
   property IsEof: boolean read GetIsEof;
   property IsEmpty: boolean read GetIsEmpty;

   property OnUpdateData: TNotifyEvent read FOnUpdateData write FOnUpdateData;

 end;



implementation

{ TDatasetDataNavigator }

constructor TDatasetDataNavigator.Create(const Dataset: TDataset);
begin
 if Dataset <> nil then
  FDataset := Dataset;
end;

destructor TDatasetDataNavigator.Destroy;
begin
  if Assigned(FDataset) then
   FreeAndNil(FDataset);
  inherited Destroy;
end;

function TDatasetDataNavigator.GetActive: boolean;
begin
 Result := (Assigned(FDataset)) and (FDataset.Active);
end;

function TDatasetDataNavigator.GetIsBof: boolean;
begin
 Result := Assigned(FDataset) and (FDataset.Active) and (FDataset.Bof);
end;

function TDatasetDataNavigator.GetIsEmpty: boolean;
begin
 Result := (Assigned(FDataset)) and (FDataset.IsEmpty);
end;

function TDatasetDataNavigator.GetIsEof: boolean;
begin
 Result := Assigned(FDataset) and (FDataset.Active) and (FDataset.Eof);
end;

function TDatasetDataNavigator.LocateData(const Argumments: TCosmosData): boolean;
var
AField, AArgumment: string;
Options: TLocateOptions;
begin
 if Assigned(FDataset) then
  begin
   AField := Argumments.FindValue('SearchField');
   AArgumment := Argumments.FindValue('SearchArgument');

   Options := [];
   if Argumments.FindValue('CaseInsensitive') = True then
    Options := Options + [loCaseInsensitive];

   if Argumments.FindValue('PartialKey') = True then
    Options := Options + [loPartialKey];

   Result := FDataset.Locate(AField, AArgumment, Options);
  end
  else
   Result := False;
end;

procedure TDatasetDataNavigator.MoveToFirst;
begin
  inherited;
  if not Assigned(FDataset) then
   EUnCreatedInnerObject.Create(TCosmosErrorDataNavigators.UnCreatedInnerObject);
  if not FDataset.Active then
   EInactiveInnerObject.Create(TCosmosErrorDataNavigators.EInactiveInnerObject) ;

  FDataset.First;
end;

procedure TDatasetDataNavigator.MoveToLast;
begin
  inherited;
  if not Assigned(FDataset) then
   EUnCreatedInnerObject.Create(TCosmosErrorDataNavigators.UnCreatedInnerObject);
  if not FDataset.Active then
   EInactiveInnerObject.Create(TCosmosErrorDataNavigators.EInactiveInnerObject) ;

  FDataset.Last;
end;

procedure TDatasetDataNavigator.MoveToNext;
begin
  inherited;
  if not Assigned(FDataset) then
   EUnCreatedInnerObject.Create(TCosmosErrorDataNavigators.UnCreatedInnerObject);
  if not FDataset.Active then
   EInactiveInnerObject.Create(TCosmosErrorDataNavigators.EInactiveInnerObject) ;

  FDataset.Next;
end;

procedure TDatasetDataNavigator.MoveToPrior;
begin
  inherited;
  if not Assigned(FDataset) then
   EUnCreatedInnerObject.Create(TCosmosErrorDataNavigators.UnCreatedInnerObject);
  if not FDataset.Active then
   EInactiveInnerObject.Create(TCosmosErrorDataNavigators.EInactiveInnerObject) ;

  FDataset.Prior;
end;

procedure TDatasetDataNavigator.UpdateData;
begin
  inherited;
  if Assigned(FDataset) and (FDataset.Active) then
   begin
    //Dispara o evento de atualização de dados.
    if Assigned(FOnUpdateData) then
     FOnUpdateData(Self);
   end;
end;

end.
