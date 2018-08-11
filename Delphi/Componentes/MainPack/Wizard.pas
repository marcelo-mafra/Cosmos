unit Wizard;

interface

uses
  SysUtils, Classes, StdCtrls, ComCtrls, Graphics;

type

 TBeforeChangePage = procedure(Sender: TObject; CurrentPage: integer) of Object;
 TBeforeNextPage = procedure(Sender: TObject; CurrentPage: integer) of Object;
 TBeforePriorPage = procedure(Sender: TObject; CurrentPage: integer) of Object;

 TWizardPage = class(TCollectionItem)
  private
    FTitle: string;
    FDescription: string;
    FVisible: boolean;

  public
   constructor Create(Collection: TCollection); override;
   destructor Destroy; override;

  published
   property Title: string read FTitle write FTitle;
   property Description: string read FDescription write FDescription;
   property Visible: boolean read FVisible write FVisible;

 end;

 TWizardPages = class(TCollection)
  private
    function GetItem(Index: integer): TWizardPage;
    procedure SetItem(Index: integer; const Value: TWizardPage);

  public
   constructor Create(AOwner: TComponent);
   function Add: TWizardPage;

   property Items[Index: integer]: TWizardPage read GetItem write SetItem; default;
 end;


  TWizard = class(TComponent)
  private
    { Private declarations }
    FHelpLabel: TLabel;
    FHelpPage: string;
    FTitle: string;
    FPageControl: TPageControl;
   // FHelpList: TStrings;
    FIcon: TIcon;
    FOnFinishWizard: TNotifyEvent;
    FHelpID: integer;
    FTitleLabel: TLabel;
    FPages: TWizardPages;
    FIsFinalPage: boolean;
    FOnBeforeChangePage: TBeforeChangePage;
    FOnBeforeNextPage: TBeforeNextPage;
    FOnBeforePriorPage: TBeforePriorPage;
    FCurrentPage : TWizardPage;
    procedure SetHelpPage(const Value: string);
    procedure RepaintWizard;
    procedure SetPageControl(const Value: TPageControl);
    procedure SetIcon(const Value: TIcon);
    function GetActivePageIndex: integer;
    procedure SetTitleLabel(const Value: TLabel);
    function GetStartPage: boolean;
    function GetFinalPage: boolean;
    function IsFinalPage: boolean;

  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property HelpPage: string read FHelpPage write SetHelpPage;
    property StartPage: boolean read GetStartPage;
    property FinalPage: boolean read GetFinalPage;
    procedure NextPage;
    procedure PriorPage;
    procedure StartWizard;
    procedure FinishWizard;

    property CurrentPage: TWizardPage read FCurrentPage;
    property ActivePageIndex: integer read GetActivePageIndex;

  published
    { Published declarations }
    property HelpLabel: TLabel read FHelpLabel write FHelpLabel;
  //  property HelpList: TStrings read FHelpList write SetHelpList;
    property Icon: TIcon read FIcon write SetIcon;
    property PageControl: TPageControl read FPageControl write SetPageControl;
    property Pages: TWizardPages read FPages write FPages;
    property HelpID: integer read FHelpID write FHelpID;
    property Title: string read FTitle write FTitle;
    property TitleLabel: TLabel read FTitleLabel write SetTitleLabel;
    property OnBeforeChangePage: TBeforeChangePage read FOnBeforeChangePage write FOnBeforeChangePage;
    property OnBeforeNextPage: TBeforeNextPage read FOnBeforeNextPage write FOnBeforeNextPage;
    property OnBeforePriorPage: TBeforePriorPage read FOnBeforePriorPage write FOnBeforePriorPage;
    property OnFinishWizard: TNotifyEvent read FOnFinishWizard write FOnFinishWizard;
    property Tag;

  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Cosmos', [TWizard]);
end;

{ TWizard }

constructor TWizard.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  //FHelpList := TStringList.Create;
  FPages := TWizardPages.Create(self);
  if FPages.Count > 0 then
   FCurrentPage := FPages.GetItem(0)
  else
   FCurrentPage := nil;

 FIsFinalPage := False;
end;

procedure TWizard.PriorPage;
var
I, FNewPage: integer;
begin
 if Assigned(FPageControl) then
   begin
    if Assigned(FOnBeforePriorPage) then
     FOnBeforePriorPage(Self, FCurrentPage.Index);

    if Assigned(FOnBeforeChangePage) then
     FOnBeforeChangePage(Self, FCurrentPage.Index);


    for I := FCurrentPage.Index downto 0 do
     begin
      FNewPage := FCurrentPage.Index - 1;
      FCurrentPage := FPages.GetItem(FNewPage);
      if (FCurrentPage <> nil) and (FCurrentPage.Visible) then
       Break
      else
       if (FCurrentPage = nil) then
        FCurrentPage := FPages.GetItem(0);
     end;

    FIsFinalPage := False;
    FPageControl.ActivePageIndex := FCurrentPage.Index;
   end;

 RepaintWizard;
end;

procedure TWizard.SetHelpPage(const Value: string);
begin

end;

procedure TWizard.StartWizard;
var
 I: integer;
begin
 FCurrentPage := FPages.GetItem(0);//novo
  if Assigned(FPageControl) then
   begin
    for I := 0 to PRed(FPageControl.PageCount) do
     FPageControl.Pages[I].TabVisible := False;
    FPageControl.ActivePageIndex := 0;
    FPageControl.ActivePageIndex := FCurrentPage.Index;//novo
   end;

  RepaintWizard;
end;

procedure TWizard.NextPage;
var
I, FNewPage: integer;
begin
 if Assigned(FPageControl) then
   begin
    if Assigned(FOnBeforeNextPage) then
     FOnBeforeNextPage(Self, FCurrentPage.Index);
    if Assigned(FOnBeforeChangePage) then
     FOnBeforeChangePage(Self, FCurrentPage.Index);

    for I := FCurrentPage.Index to Pred(FPages.Count) do
     begin
      FNewPage := FCurrentPage.Index + 1;
      FCurrentPage := FPages.GetItem(FNewPage);
      if (FCurrentPage <> nil) and (FCurrentPage.Visible) then
       Break
      else
       if (FCurrentPage = nil) then
        FCurrentPage := FPages.GetItem(Pred(FPages.Count));

     end;

    FIsFinalPage := IsFinalPage;
    FPageControl.ActivePageIndex := FCurrentPage.Index;
   end;

 RepaintWizard;
end;

destructor TWizard.Destroy;
begin
 FIcon.Free;
 inherited Destroy;
end;

procedure TWizard.RepaintWizard;
begin
 if Assigned(FHelpLabel) then
  FHelpLabel.Caption := CurrentPage.Description;
 if Assigned(FTitleLabel) then
  FTitleLabel.Caption := CurrentPage.Title;
end;

procedure TWizard.SetPageControl(const Value: TPageControl);
begin
  FPageControl := Value;
  if Value <> nil then
   Value.FreeNotification(Self);
end;

procedure TWizard.SetIcon(const Value: TIcon);
begin
 FIcon.Assign(Value);
end;

procedure TWizard.FinishWizard;
begin
 FOnFinishWizard(self);
end;

function TWizard.GetActivePageIndex: integer;
begin
 if FCurrentPage <> nil then
  Result := FCurrentPage.Index
 else
  Result := -1;
end;

procedure TWizard.SetTitleLabel(const Value: TLabel);
begin
  FTitleLabel := Value;
  if FTitleLabel <> nil then
   Value.FreeNotification(Self);
end;

function TWizard.GetStartPage: boolean;
begin
 Result := (FCurrentPage <> nil) and (FCurrentPage.Index = 0);
end;

function TWizard.IsFinalPage: boolean;
var
FNewPage: integer;
APage : TWizardPage;
begin
 Result := FCurrentPage.Index = Pred(FPages.Count);

 if not Result then
  begin
   for FNewPage := Pred(FPages.Count) downto 0 do
    begin
     APage := FPages.GetItem(FNewPage);
     if (APage <> nil) and (APage.Visible) then
      begin
       Result := FCurrentPage.Index = APage.Index;
       Break;
      end
     else
      Result := False;
    end;
   end;
end;

function TWizard.GetFinalPage: boolean;
begin
 Result := (FCurrentPage <> nil) and (FIsFinalPage = True);
end;

{ TWizardPage }

constructor TWizardPage.Create(Collection: TCollection);
begin
 inherited Create(Collection);
end;

destructor TWizardPage.Destroy;
begin
 inherited Destroy;
end;

{ TWizardPages }

constructor TWizardPages.Create(AOwner: TComponent);
begin
 inherited Create(TWizardPage);
end;

function TWizardPages.Add: TWizardPage;
begin
 Result := TWizardPage(inherited Add);
end;

function TWizardPages.GetItem(Index: integer): TWizardPage;
begin
 Result := TWizardPage(inherited GetItem(Index));
end;

procedure TWizardPages.SetItem(Index: integer; const Value: TWizardPage);
begin
 inherited SetItem(Index, Value);
end;


end.
