unit cosmos.framework.datanavigators.listview;

interface

uses
 System.Classes, System.SysUtils, cosmos.system.messages, cosmos.classes.application,
 cosmos.framework.datanavigators.common, Vcl.ComCtrls;

type
 TListviewDataNavigator = class(TCustomDataNavigator)

  private
   FSource: TCustomListview;
   FLastPosition: boolean;
   FOnUpdateData: TNotifyEvent;

  protected
   function GetActive: boolean; override;
   function GetIsBof: boolean; override;
   function GetIsEof: boolean; override;
   function GetIsEmpty: boolean; override;


  public

   constructor Create(const Source: TCustomListview);
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

{ TListviewDataNavigator }

constructor TListviewDataNavigator.Create(const Source: TCustomListview);
begin
 inherited Create;
 if Source <> nil then
  FSource := Source;
end;

destructor TListviewDataNavigator.Destroy;
begin
  if Assigned(FSource) then
   FSource := nil;
  inherited Destroy;
end;

function TListviewDataNavigator.GetActive: boolean;
begin
 Result := True; //Não cabível neste tipo de DataNavigator.
end;

function TListviewDataNavigator.GetIsBof: boolean;
begin
 Result := Assigned(FSource) and (FSource.Selected <> nil) and (FSource.Selected = FSource.TopItem);
end;

function TListviewDataNavigator.GetIsEmpty: boolean;
begin
 Result := Assigned(FSource) and (FSource.Items.Count = 0);
end;

function TListviewDataNavigator.GetIsEof: boolean;
begin
 Result := Assigned(FSource) and (self.FLastPosition = True);
end;

function TListviewDataNavigator.LocateData(const Argumments: TCosmosData): boolean;
var
AItem: TListItem;
vPartialKey: boolean;
begin
 if Assigned(FSource) then
  begin
   vPartialKey := Argumments.FindValue('PartialKey');
   AItem := FSource.FindCaption(0, Argumments.FindValue('TextValue'), vPartialKey, True, True);
   if AItem <> nil then
    FSource.Selected := AItem;
  end
  else
   AItem := nil;

 Result := AItem <> nil;
end;

procedure TListviewDataNavigator.MoveToFirst;
begin
  inherited;
  FSource.Selected := FSource.TopItem;
  FLastPosition := False;
end;

procedure TListviewDataNavigator.MoveToLast;
var
LastItem, CurrentItem: TListItem;
begin
  inherited;
  LastItem := nil;

  if not Assigned(FSource) then
   EUnCreatedInnerObject.Create(TCosmosErrorDataNavigators.UnCreatedInnerObject);

  try
   TListView(FSource).Items.BeginUpdate;

   CurrentItem := FSource.Selected;
   if CurrentItem = nil then
    CurrentItem := FSource.TopItem;

   LastItem := CurrentItem;

   while CurrentItem <> nil do
    begin
     CurrentItem := FSource.GetNextItem(CurrentItem, sdBelow, []);
     if CurrentItem <> nil then
      LastItem := CurrentItem;
    end;

  finally
   FSource.Selected := LastItem;
   FLastPosition := True;
   TListview(FSource).Items.EndUpdate;
  end;
end;

procedure TListviewDataNavigator.MoveToNext;
var
AItem: TListItem;
begin
  inherited;
 AItem := FSource.GetNextItem(FSource.Selected, sdBelow, []);
 if AItem <> nil then
  begin
   FSource.Selected := AItem;
   self.FLastPosition := False
  end
 else
   self.FLastPosition := True;
end;

procedure TListviewDataNavigator.MoveToPrior;
var
AItem: TListItem;
begin
  inherited;
 AItem := FSource.GetNextItem(FSource.Selected, sdAbove, []);
 if AItem <> nil then
  FSource.Selected := AItem;

  self.FLastPosition := False
end;



procedure TListviewDataNavigator.UpdateData;
begin
  inherited;
  if self.Active then
   begin
    //Dispara o evento de atualização de dados.
    if Assigned(FOnUpdateData) then
     FOnUpdateData(Self);
   end;
end;

end.
