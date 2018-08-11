unit FormDefaultSearchs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  DB, DBClient, StdCtrls, Buttons, Dialogs, Cosmos.Framework.Interfaces.Root,
  Cosmos.Framework.Interfaces.DataAcess, ImgList, ActnList, ExtCtrls,
  System.Actions, cosmos.system.messages, cosmos.classes.persistence.registry,
  cosmos.system.files, System.ImageList;

type
  TFrmDefaultSearchs = class(TForm)
    ActionList1: TActionList;
    ActSelect: TAction;
    ActCancel: TAction;
    ActHelp: TAction;
    ImageList1: TImageList;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Bevel1: TBevel;
    Image1: TImage;
    procedure ActSelectUpdate(Sender: TObject);
    procedure ActHelpExecute(Sender: TObject);
    procedure ActCancelExecute(Sender: TObject);
    procedure ActSelectExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FActiveDataset: TDataset;
    FICosmosApp: ICosmosApplication;
    FIRemoteCon: ICosmosRemoteConnection;
    FOptionsSaver: TRegistryPersistence;

    procedure ReadOptions;
    procedure SaveOptions;

  protected
    function GetWindowsId: string; virtual; abstract;

  public
    { Public declarations }
    property ActiveDataset: TDataset read FActiveDataset write FActiveDataset;
    property ICosmosApp: ICosmosApplication read FICosmosApp;
    property IRemoteCon: ICosmosRemoteConnection read FIRemoteCon ;

    property OptionsSaver: TRegistryPersistence read FOptionsSaver;
    property WindowsId: string read GetWindowsId;
  end;

var
  FrmDefaultSearchs: TFrmDefaultSearchs;

implementation

{$R *.dfm}

{ TFrmDefaultSearchs }

procedure TFrmDefaultSearchs.ActCancelExecute(Sender: TObject);
begin
 ModalResult := mrCancel;
end;

procedure TFrmDefaultSearchs.ActHelpExecute(Sender: TObject);
begin
 if Self.HelpContext <> 0 then
  Application.HelpSystem.ShowContextHelp(Self.HelpContext, Application.CurrentHelpFile);
end;

procedure TFrmDefaultSearchs.ActSelectExecute(Sender: TObject);
begin
 if TAction(Sender).Enabled then
  ModalResult := mrOk;
end;

procedure TFrmDefaultSearchs.ActSelectUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := (ActiveDataset <> nil) and (ActiveDataset.Active)
  and not (ActiveDataset.IsEmpty);
end;

procedure TFrmDefaultSearchs.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 SaveOptions;
end;

procedure TFrmDefaultSearchs.FormCreate(Sender: TObject);
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;
 FIRemoteCon := Application.MainForm as ICosmosRemoteConnection;

 FOptionsSaver := TRegistryPersistence.Create;
 ReadOptions;
end;

procedure TFrmDefaultSearchs.ReadOptions;
var
 sMyRootKey: string;
begin
 try
  OptionsSaver.Open(TRegistryPaths.CurrentUserKey);
  sMyRootKey := TRegistryPaths.Windows + '\' + self.WindowsId;
  OptionsSaver.OpenKey(sMyRootKey, True);

  if OptionsSaver.ValueExists('WindowsHeight') then
   begin
    self.Height := OptionsSaver.ReadInteger('WindowsHeight');
    self.Width := OptionsSaver.ReadInteger('WindowsWidth');
   end;

 finally
  OptionsSaver.CloseKey;
 end;
end;

procedure TFrmDefaultSearchs.SaveOptions;
var
 sMyRootKey: string;
begin
 try
  OptionsSaver.Open(TRegistryPaths.CurrentUserKey);
  sMyRootKey := TRegistryPaths.Windows + '\' + self.WindowsId;
  OptionsSaver.OpenKey(sMyRootKey, True);

  if (self.Height > 50) and (self.Width > 100) then
   begin
    OptionsSaver.WriteInteger('WindowsHeight', self.Height);
    OptionsSaver.WriteInteger('WindowsWidth', self.Width);
   end;

 finally
  OptionsSaver.CloseKey;
 end;

end;

end.
