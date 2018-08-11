unit cosmos.framework.datanavigators.treeview;

interface

uses
 System.Classes, System.SysUtils, cosmos.system.messages, cosmos.classes.application,
 cosmos.framework.datanavigators.common, Vcl.ComCtrls;

type
//Implementa um navegador de dados especializado em trabalhar com objetos do tipo TCustomTreeview.	
 TTreeviewDataNavigator = class(TCustomDataNavigator)

  private
   FSource: TCustomTreeview;
   FLastPosition: boolean;
   FOnUpdateData: TNotifyEvent;

  protected
   function GetActive: boolean; override;
   function GetIsBof: boolean; override;
   function GetIsEof: boolean; override;
   function GetIsEmpty: boolean; override;


  public

   constructor Create(const Source: TCustomTreeView);
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

{ TTreeviewDataNavigator }

constructor TTreeviewDataNavigator.Create(const Source: TCustomTreeView);
begin
 if Source <> nil then
  FSource := Source;
end;

destructor TTreeviewDataNavigator.Destroy;
begin
  if Assigned(FSource) then
   FreeAndNil(FSource);
  inherited Destroy;
end;

function TTreeviewDataNavigator.GetActive: boolean;
begin
 Result := True; //Não cabível neste tipo de DataNavigator.
end;

function TTreeviewDataNavigator.GetIsBof: boolean;
begin
 Result := Assigned(FSource) and (FSource.Selected <> nil) and (FSource.Selected.IsFirstNode);
end;

function TTreeviewDataNavigator.GetIsEmpty: boolean;
begin
 if Assigned(FSource) then
  Result := TTreeView(FSource).Items.Count = 0
 else
  Result := True;
end;

function TTreeviewDataNavigator.GetIsEof: boolean;
begin
 Result := Assigned(FSource) and FLastPosition;
end;

function TTreeviewDataNavigator.LocateData(const Argumments: TCosmosData): boolean;
var
AItem: TTreeNode;
begin
 Result := False;
 AItem := FSource.TopItem;

 while AItem <> nil do
  begin
   if UpperCase(AItem.Text) = UpperCase(Argumments.FindValue('TextValue')) then //do not localize!
    begin
     FSource.Selected := AItem;
     Result := True;
     AItem := nil;
    end
   else
    AItem := AItem.GetNext;
  end;

end;

procedure TTreeviewDataNavigator.MoveToFirst;
begin
  inherited;
  if not Assigned(FSource) then
   EUnCreatedInnerObject.Create(TCosmosErrorDataNavigators.UnCreatedInnerObject);

  FSource.Selected := FSource.TopItem;
  FLastPosition := False;
end;

procedure TTreeviewDataNavigator.MoveToLast;
var
LastNode, CurrentNode: TTreeNode;
begin
  inherited;
  LastNode := nil;

  if not Assigned(FSource) then
   EUnCreatedInnerObject.Create(TCosmosErrorDataNavigators.UnCreatedInnerObject);

  try
   TTreeView(FSource).Items.BeginUpdate;
   CurrentNode := FSource.Selected;
   if CurrentNode = nil then
    CurrentNode := FSource.TopItem;

   LastNode := CurrentNode;

   while CurrentNode <> nil do
    begin
     CurrentNode := CurrentNode.GetNext;
     if CurrentNode <> nil then
      LastNode := CurrentNode;
    end;

  finally
   FSource.Selected := LastNode;
   FLastPosition := True;
   TTreeView(FSource).Items.EndUpdate;
  end;
end;

procedure TTreeviewDataNavigator.MoveToNext;
var
ANode: TTreeNode;
begin
  inherited;
  if not Assigned(FSource) then
   EUnCreatedInnerObject.Create(TCosmosErrorDataNavigators.UnCreatedInnerObject);

  if FSource.Selected = nil then
   FSource.Select(FSource.TopItem);

  ANode := FSource.Selected.GetNext;
  if ANode <> nil then
   FSource.Selected := ANode
  else
   FLastPosition := True;
end;

procedure TTreeviewDataNavigator.MoveToPrior;
var
ANode: TTreeNode;
begin
  inherited;
  if not Assigned(FSource) then
   EUnCreatedInnerObject.Create(TCosmosErrorDataNavigators.UnCreatedInnerObject);

  if FSource.Selected = nil then
   FSource.Select(FSource.TopItem)
  else
   begin
    ANode := FSource.Selected.GetPrev;
    if ANode <> nil then
     begin
      FSource.Selected := ANode;
      FLastPosition := False;
     end;
   end;
end;

procedure TTreeviewDataNavigator.UpdateData;
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

