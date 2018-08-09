unit cosmos.financeiro.clienconnections;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cosmos.common.services.clientconnections, Data.DBXDataSnap,
  IPPeerClient, Data.DBXCommon, Data.FMTBcd, Xml.xmldom, Xml.XMLIntf,
  Xml.Win.msxmldom, Xml.XMLDoc, Datasnap.DBClient, Datasnap.DSConnect,
  Data.SqlExpr, Data.DB, Vcl.AppEvnts, cosmos.classes.Application,
  cosmos.system.messages, Datasnap.Provider, Vcl.ExtCtrls,
  cosmos.tools.printer;

type
  TDMCon = class(TDMBase)
  private
    { Private declarations }
  public
    { Public declarations }
    procedure DoCancelarRecebimento(const codrec: integer; Motivo: integer);
    procedure DoImprimirRecibo(const RecebimentoId: integer);
  end;

var
  DMCon: TDMCon;

implementation

{$R *.dfm}

{ TDMCon }

procedure TDMCon.DoCancelarRecebimento(const codrec: integer; Motivo: integer);
var
 ACommand: TDBXCommand;
begin
  inherited;

  ACommand := CreateCommand;

  try
   ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
   ACommand.Text := 'TDMFinanceiroMethods.CancelarRecebimento'; //do not localize!
   ACommand.Prepare;

   ACommand.Parameters.Parameter[0].Value.SetInt32(codrec);
   ACommand.Parameters.Parameter[1].Value.SetInt32(Motivo);
   ACommand.Parameters.Parameter[2].Value.SetString(CurrentUser.Login);
   ACommand.ExecuteUpdate;

   ICosmosApp.MainLog.RegisterRemoteCallSucess(ACommand.Text, ConnectionParamsInfo);

   if ACommand.Parameters.Parameter[3].Value.GetBoolean then
    begin
      self.ActiveDataNavigator.UpdateData;
      ICosmosApp.DlgMessage.InfoMessage(TCosmosTitles.Recebimentos, TCosmosInfoMsg.RecebimentoCancelado);
    end;

  finally
    ACommand.Free;
  end;
end;

procedure TDMCon.DoImprimirRecibo(const RecebimentoId: integer);
var
 aPrinter: TFinancialPrinter;
begin
 {Imprime um recibo relativo a um pagamento registrado no sistema.}
 aPrinter := TFinancialPrinter.Create;

 try
  aPrinter.Device := '';
  aPrinter.PrintReceipt;

 finally
  aPrinter.Free;
 end;
end;

end.
