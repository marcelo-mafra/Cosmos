unit cosmos.focos.services.serverclass;

interface

uses System.SysUtils, Data.DBXCommon, cosmos.system.messages,Vcl.Forms,
 System.Variants, Cosmos.Framework.Interfaces.Root,
 Cosmos.Framework.Interfaces.Applications;

type
 TFocosServerClass = class(TInterfacedObject, ICosmosFocos)
   private
    function GetICosmosApp: ICosmosApplication;

   public
    constructor Create;
    destructor Destroy;

    //Regiões administrativas.
    function ChangeRegion(FocusID, NewRegion: Integer): boolean;
    function DeleteRegion(const RegionId: integer): boolean;
    function NewRegion(const NewRegion: string; ParentId: variant): variant;
    function RenameRa(const RegionId: integer; RegionName: string): boolean;
    function MoveRegion(RegionID, NewRegion: Integer): boolean;

    //Focos.
    function ChangeFocusParent(FocusID, NewParentId: Integer): boolean;
    function ChangeFocusStatus(FocusId: Integer; Status: boolean): boolean;
    function CreateFocus(DadosFoco, DadosEndereco, DadosGestao, DadosMeiosContatos: OleVariant): boolean;
    function DeleteFocus(codfoc: Integer): boolean;
    function DesactiveFocus(TargetFocus, TransferFocus: Integer; Desactivate: boolean): string;


    property ICosmosApp: ICosmosApplication read GetICosmosApp;
 end;



implementation

{ TFocosServerClass }

constructor TFocosServerClass.Create;
begin
  inherited Create;
end;

destructor TFocosServerClass.Destroy;
begin
  inherited;
end;

function TFocosServerClass.GetICosmosApp: ICosmosApplication;
begin
 Result := Application.MainForm as ICosmosApplication;
end;

function TFocosServerClass.ChangeFocusParent(FocusID,
  NewParentId: Integer): boolean;
var
 aCommand: TDBXCommand;
begin
 {Altera o foco titular de um foco.}
 ACommand := ICosmosApp.IRemoteCon.CreateCommand;

 try
  ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
  ACommand.Text := 'TDMCosmosFocosMethods.ChangeFocusParent'; //do not localize!
  ACommand.Prepare;

  ACommand.Parameters[0].Value.SetInt32(FocusId);
  ACommand.Parameters[1].Value.SetInt32(NewParentId);
  ACommand.ExecuteUpdate;

  Result := True;
  ICosmosApp.IRemoteCon.RegisterRemoteCallSucess(ACommand.Text);
  ACommand.Free;

 except
  on E: Exception do
   begin
    Result := False;
    ICosmosApp.IRemoteCon.RegisterRemoteCallFailure(E.Message, ACommand.Text);
    if Assigned(ACommand) then FreeAndNil(ACommand);
    ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, E.Message);
   end;
  end;
end;

function TFocosServerClass.ChangeFocusStatus(FocusId: integer;
  Status: boolean): boolean;
var
 aCommand: TDBXCommand;
begin
 {Altera o status (ativo, inativo) de um foco.}
 ACommand := ICosmosApp.IRemoteCon.CreateCommand;

 try
  ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
  ACommand.Text := 'TDMCosmosFocosMethods.ChangeFocusStatus'; //do not localize!
  ACommand.Prepare;

  ACommand.Parameters[0].Value.SetInt32(FocusId);
  ACommand.Parameters[1].Value.SetBoolean(Status);
  ACommand.ExecuteUpdate;

  Result := True;
  ICosmosApp.IRemoteCon.RegisterRemoteCallSucess(ACommand.Text);
  ACommand.Free;

 except
  on E: Exception do
   begin
    Result := False;
    ICosmosApp.IRemoteCon.RegisterRemoteCallFailure(E.Message, ACommand.Text);
    if Assigned(ACommand) then FreeAndNil(ACommand);
    ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, E.Message);
   end;
  end;
end;

function TFocosServerClass.ChangeRegion(FocusID, NewRegion: Integer): boolean;
var
 aCommand: TDBXCommand;
begin
 {Altera a vinculação de um foco para outra região administrativa.}
 ACommand := ICosmosApp.IRemoteCon.CreateCommand;

 try
  ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
  ACommand.Text := 'TDMCosmosFocosMethods.ChangeRegion'; //do not localize!
  ACommand.Prepare;

  ACommand.Parameters[0].Value.SetInt32(FocusId);
  ACommand.Parameters[1].Value.SetInt32(NewRegion);
  ACommand.ExecuteUpdate;

  Result := True;
  ICosmosApp.IRemoteCon.RegisterRemoteCallSucess(ACommand.Text);
  ACommand.Free;

 except
  on E: Exception do
   begin
    Result := False;
    ICosmosApp.IRemoteCon.RegisterRemoteCallFailure(E.Message, ACommand.Text);
    if Assigned(ACommand) then FreeAndNil(ACommand);
    ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, E.Message);
   end;
  end;
end;

function TFocosServerClass.CreateFocus(DadosFoco, DadosEndereco, DadosGestao,
  DadosMeiosContatos: OleVariant): boolean;
var
 aCommand: TDBXCommand;
begin
 {Cria um novo foco.}
 ACommand := ICosmosApp.IRemoteCon.CreateCommand;

 try
  ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
  ACommand.Text := 'TDMCosmosFocosMethods.CreateFocus'; //do not localize!
  ACommand.Prepare;

  ACommand.Parameters[0].Value.AsVariant := DadosFoco;
  ACommand.Parameters[1].Value.AsVariant := DadosEndereco;
  ACommand.Parameters[2].Value.AsVariant := DadosGestao;
  ACommand.Parameters[3].Value.AsVariant := DadosMeiosContatos;
  ACommand.ExecuteUpdate;

  Result := ACommand.Parameters[4].Value.AsBoolean;
  ICosmosApp.IRemoteCon.RegisterRemoteCallSucess(ACommand.Text);
  ACommand.Free;

 except
  on E: Exception do
   begin
    Result := False;
    ICosmosApp.IRemoteCon.RegisterRemoteCallFailure(E.Message, ACommand.Text);
    if Assigned(ACommand) then FreeAndNil(ACommand);
    ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, E.Message);
   end;
  end;
end;

function TFocosServerClass.DeleteFocus(codfoc: Integer): boolean;
var
 aCommand: TDBXCommand;
begin
 {Exclui um foco.}
 ACommand := ICosmosApp.IRemoteCon.CreateCommand;

 try
  ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
  ACommand.Text := 'TDMCosmosFocosMethods.DeleteFocus'; //do not localize!
  ACommand.Prepare;

  ACommand.Parameters[0].Value.SetInt32(codfoc);
  ACommand.ExecuteUpdate;

  Result := ACommand.Parameters[1].Value.AsBoolean;
  ICosmosApp.IRemoteCon.RegisterRemoteCallSucess(ACommand.Text);
  ACommand.Free;

 except
  on E: Exception do
   begin
    Result := False;
    ICosmosApp.IRemoteCon.RegisterRemoteCallFailure(E.Message, ACommand.Text);
    if Assigned(ACommand) then FreeAndNil(ACommand);
    ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, E.Message);
   end;
  end;
end;

function TFocosServerClass.DeleteRegion(const RegionId: integer): boolean;
var
 aCommand: TDBXCommand;
begin
 {Exclui uma região administrativa.}
 ACommand := ICosmosApp.IRemoteCon.CreateCommand;

 try
  ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
  ACommand.Text := 'TDMCosmosFocosMethods.DeleteRegion'; //do not localize!
  ACommand.Prepare;

  ACommand.Parameters[0].Value.SetInt32(RegionId);
  ACommand.ExecuteUpdate;

  Result := True;
  ICosmosApp.IRemoteCon.RegisterRemoteCallSucess(ACommand.Text);
  ACommand.Free;

 except
  on E: Exception do
   begin
    Result := False;
    ICosmosApp.IRemoteCon.RegisterRemoteCallFailure(E.Message, ACommand.Text);
    if Assigned(ACommand) then FreeAndNil(ACommand);
    ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, E.Message);
   end;
  end;
end;

function TFocosServerClass.DesactiveFocus(TargetFocus, TransferFocus: Integer;
  Desactivate: boolean): string;
var
 aCommand: TDBXCommand;
begin
 {Desativa um foco ativo.}
 ACommand := ICosmosApp.IRemoteCon.CreateCommand;

 try
  ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
  ACommand.Text := 'TDMCosmosFocosMethods.DesactiveFocus'; //do not localize!
  ACommand.Prepare;

  ACommand.Parameters[0].Value.SetInt32(TargetFocus);
  ACommand.Parameters[1].Value.SetInt32(TransferFocus);
  ACommand.ExecuteUpdate;

  Result := ACommand.Parameters[2].Value.AsString;
  ICosmosApp.IRemoteCon.RegisterRemoteCallSucess(ACommand.Text);
  ACommand.Free;

 except
  on E: Exception do
   begin
    Result := '';
    ICosmosApp.IRemoteCon.RegisterRemoteCallFailure(E.Message, ACommand.Text);
    if Assigned(ACommand) then FreeAndNil(ACommand);
    ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, E.Message);
   end;
  end;
end;

function TFocosServerClass.MoveRegion(RegionID, NewRegion: Integer): boolean;
var
 aCommand: TDBXCommand;
begin
 {Vincula uma região administrativa a outra.}
 ACommand := ICosmosApp.IRemoteCon.CreateCommand;

 try
  ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
  ACommand.Text := 'TDMCosmosFocosMethods.MoveRegion'; //do not localize!
  ACommand.Prepare;

  ACommand.Parameters[0].Value.SetInt32(RegionId);
  ACommand.Parameters[1].Value.SetInt32(NewRegion);
  ACommand.ExecuteUpdate;

  Result := True;
  ICosmosApp.IRemoteCon.RegisterRemoteCallSucess(ACommand.Text);
  ACommand.Free;

 except
  on E: Exception do
   begin
    Result := False;
    ICosmosApp.IRemoteCon.RegisterRemoteCallFailure(E.Message, ACommand.Text);
    if Assigned(ACommand) then FreeAndNil(ACommand);
    ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, E.Message);
   end;
  end;
end;

function TFocosServerClass.NewRegion(const NewRegion: string; ParentId: variant): variant;
var
 aCommand: TDBXCommand;
begin
 {Cria uma nova região administrativa no servidor remoto. O retorno é o código
  exclusivo da região administrativa. Caso o valor de "ParentId" seja deiferente de "null",
  indica que a região não é uma subregião. Retorno igual a "null" indica que ela não
  pode ser criada por algum erro.}
 ACommand := ICosmosApp.IRemoteCon.CreateCommand;

 try
  ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
  ACommand.Text := 'TDMCosmosFocosMethods.NewRegion'; //do not localize!
  ACommand.Prepare;

  ACommand.Parameters[0].Value.SetWideString(NewRegion);
  ACommand.Parameters[1].Value.AsVariant := ParentId;
  ACommand.ExecuteUpdate;

  Result := ACommand.Parameters[2].Value.AsInt32;
  ICosmosApp.IRemoteCon.RegisterRemoteCallSucess(ACommand.Text);
  ACommand.Free;

 except
  on E: Exception do
   begin
    Result := null;
    ICosmosApp.IRemoteCon.RegisterRemoteCallFailure(E.Message, ACommand.Text);
    if Assigned(ACommand) then FreeAndNil(ACommand);
    ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, E.Message);
   end;
  end;
end;

function TFocosServerClass.RenameRa(const RegionId: integer;
  RegionName: string): boolean;
var
 aCommand: TDBXCommand;
begin
 {Renomeia uma região administrativa executando o método no servidor remoto.}
 ACommand := ICosmosApp.IRemoteCon.CreateCommand;

 try
  ACommand.CommandType := TDBXCommandTypes.DSServerMethod;
  ACommand.Text := 'TDMCosmosFocosMethods.RenameRegion'; //do not localize!
  ACommand.Prepare;

  ACommand.Parameters[0].Value.SetInt32(RegionId);
  ACommand.Parameters[1].Value.SetWideString(RegionName);
  ACommand.ExecuteUpdate;

  Result := True;
  ICosmosApp.IRemoteCon.RegisterRemoteCallSucess(ACommand.Text);
  ACommand.Free;

 except
  on E: Exception do
   begin
    Result := False;
    ICosmosApp.IRemoteCon.RegisterRemoteCallFailure(E.Message, ACommand.Text);
    if Assigned(ACommand) then FreeAndNil(ACommand);
    ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, E.Message);
   end;
  end;
end;

end.
