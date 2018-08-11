unit cosmos.usuarios.clientconnections;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cosmos.common.services.clientconnections, Data.DBXDataSnap,
  IPPeerClient, Data.DBXCommon, Data.FMTBcd, Xml.xmldom, Xml.XMLIntf,
  Xml.Win.msxmldom, Xml.XMLDoc, Datasnap.DBClient, Datasnap.DSConnect,
  Data.SqlExpr, Data.DB, Vcl.AppEvnts, Vcl.ExtCtrls, Datasnap.Provider;

type
  TDMCon = class(TDMBase)
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ListCosmosRoles(AList: TStringList);
  end;

var
  DMCon: TDMCon;

implementation

{$R *.dfm}

{ TDMCon }

procedure TDMCon.ListCosmosRoles(AList: TStringList);
var
ACommand: TDBXCommand;
begin
 ACommand := CreateCommand;

 try
  //Lista todas as roles disponibilizadas pelo Cosmos.
  ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
  ACommand.Text := 'TDMUserMethods.GetRoles'; //do not localize!
  ACommand.Prepare;

  ACommand.ExecuteUpdate;
  AList.CommaText := ACommand.Parameters[0].Value.GetWideString();

  ICosmosApp.MainLog.RegisterRemoteCallSucess(ACommand.Text, self.ConnectionParamsInfo);
  if Assigned(ACommand) then FreeAndNil(ACommand);

  except
    on E: Exception do
    begin
      ICosmosApp.MainLog.RegisterRemoteCallFailure(ACommand.Text, self.ConnectionParamsInfo);
      if Assigned(ACommand) then FreeAndNil(ACommand);
    end;
  end;

end;

end.
