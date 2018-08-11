unit FormCosmosDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Cosmos.Framework.Interfaces.Root, Cosmos.Framework.Interfaces.DataAcess;

type
  TFrmCosmosDialog = class(TForm)
  private
    function GetCosmosApp: ICosmosApplication;
    function GetRemoteConnection: ICosmosRemoteConnection;
    { Private declarations }
  public
    { Public declarations }
    property ICosmosApp: ICosmosApplication read GetCosmosApp;
    property IRemoteCon: ICosmosRemoteConnection read GetRemoteConnection ;
  end;

var
  FrmCosmosDialog: TFrmCosmosDialog;

implementation

{$R *.dfm}

{ TFrmCosmosDialog }

function TFrmCosmosDialog.GetCosmosApp: ICosmosApplication;
begin
 Result := Application.MainForm as ICosmosApplication;
end;

function TFrmCosmosDialog.GetRemoteConnection: ICosmosRemoteConnection;
begin
 Result := Application.MainForm as ICosmosRemoteConnection;
end;

end.
