unit FormCosmosHelpDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Cosmos.Framework.Interfaces.Root,
  Cosmos.Framework.Interfaces.DataAcess;

type
  TFrmCosmosHelpDialog = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Bevel1: TBevel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FICosmosApp: ICosmosApplication;
    FIRemoteCon: ICosmosRemoteConnection;
    { Private declarations }
  public
    { Public declarations }
    property ICosmosApp: ICosmosApplication read FICosmosApp;
    property IRemoteCon: ICosmosRemoteConnection read FIRemoteCon;
  end;

var
  FrmCosmosHelpDialog: TFrmCosmosHelpDialog;

implementation

{$R *.dfm}

procedure TFrmCosmosHelpDialog.FormCreate(Sender: TObject);
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;
 FIRemoteCon := Application.MainForm as ICosmosRemoteConnection;
end;

procedure TFrmCosmosHelpDialog.FormDestroy(Sender: TObject);
begin
 if Assigned(FIRemoteCon) then
  FIRemoteCon := nil;

 if Assigned(FICosmosApp) then
  FICosmosApp := nil;
end;

end.
