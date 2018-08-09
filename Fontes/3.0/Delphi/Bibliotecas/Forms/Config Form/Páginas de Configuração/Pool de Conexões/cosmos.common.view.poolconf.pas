unit cosmos.common.view.poolconf;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  GroupHeader, Vcl.ImgList, cosmos.system.messages, Vcl.Buttons,
  cosmos.framework.forms.pages, Cosmos.Framework.Interfaces.Dialogs, cosmos.system.formsconst,
  Xml.XMLDoc, Xml.XMLIntf, cosmos.classes.security,  Vcl.Samples.Spin;

type
  TFrmPoolOptions = class(TFrmCosmosPages)
    GrpOptions: TMSGroupHeader;
    ImageList1: TImageList;
    GrpModel: TMSGroupHeader;
    RdbOnDemand: TRadioButton;
    Label2: TLabel;
    RdbCreateFull: TRadioButton;
    RdbCreateDestroy: TRadioButton;
    Label3: TLabel;
    Label4: TLabel;
    Label1: TLabel;
    EdtPoolSize: TSpinEdit;
    Label5: TLabel;
    EdtCleanup: TSpinEdit;
    EdtTimeout: TSpinEdit;
    Label6: TLabel;
    RdbNoPool: TRadioButton;
    Label7: TLabel;
    procedure EdtPoolSizeChange(Sender: TObject);
    procedure RdbOnDemandClick(Sender: TObject);
  private
    { Private declarations }
    FChanged: boolean;
    function LoadBitmap: TBitmap;

  protected
   function GetChanged: boolean; override;
   function GetEnabled: boolean; override;
   function GetPageInfo: TPageInfo; override;

   function SaveOptions: boolean; override;
   procedure LoadOptions; override;

   function ValidateFields: boolean; override;

   property Changed: boolean read GetChanged;
   property Enabled: boolean read GetEnabled;
   property PageInfo: TPageInfo read GetPageInfo;

  public
    { Public declarations }

  end;

var
  FrmPoolOptions: TFrmPoolOptions;

implementation

{$R *.dfm}


procedure TFrmPoolOptions.EdtPoolSizeChange(Sender: TObject);
begin
 FChanged := True;
end;

function TFrmPoolOptions.GetChanged: boolean;
begin
 Result := FChanged;
end;

function TFrmPoolOptions.GetEnabled: boolean;
begin
 Result := True;
end;

function TFrmPoolOptions.GetPageInfo: TPageInfo;
begin
 Result.CodePage := 'Cosmos.ConnectionsPool';
 Result.PageTitle := Caption;
 Result.PageDesc := TConfigurationPagesDesc.ConfConnectionsPool;
 Result.PageTreeRoot := TCosmosTitles.ConfConexoes;
 Result.PageTreeItem := TCosmosTitles.ConfPool;
 Result.PageIndex := 1;
 Result.PageImage := LoadBitmap;
 Result.HelpFile := Application.CurrentHelpFile;
 Result.HelpContext := self.HelpContext;
end;

function TFrmPoolOptions.LoadBitmap: TBitmap;
begin
 Result := TBitMap.Create;
 ImageList1.GetBitmap(0, Result);
end;

procedure TFrmPoolOptions.LoadOptions;
var
 I: integer;
 AXMLDoc: TXMLDocument;
 ANode, AChildNode: IXMLNode;
begin
 //Lê as opções de configuração salvas.
 AXMLDoc := self.CreateXMLDocument(ICosmosApp.IApplicationPaths.GetUserConfigurationsFile);

 try
  ANode := AXMLDoc.DocumentElement;
  ANode := ANode.ChildNodes.FindNode('ConnectionsPool'); //do not localize!
  ANode := ANode.ChildNodes.FindNode('PoolInfo');  //do not localize!

  if ANode <> nil then
   begin
    for I := 0 to Pred(ANode.ChildNodes.Count) do
     begin
      AChildNode := ANode.ChildNodes.Get(I);

      if (AChildNode <> nil) and (AChildNode.Attributes['CosmosApp'] = ICosmosApp.CosmosModuleShortName) then  //do not localize!
       begin
        EdtPoolSize.Value := AChildNode.Attributes['PoolSize'];  //do not localize!
        EdtCleanup.Value :=  AChildNode.Attributes['CleanupMinutes'];  //do not localize!
        EdtTimeout.Value := AChildNode.Attributes['PoolTimeout'];  //do not localize!

        case AChildNode.Attributes['ConnectionType'] of
         0: RdbOnDemand.Checked := True;
         1: RdbCreateFull.Checked := True;
         2: RdbCreateDestroy.Checked := True;
         3: RdbNoPool.Checked
         else
          RdbCreateFull.Checked := True;
        end;

        Break;
      end;
     end;

    FChanged := False; //default

    if Assigned(AXMLDoc) then
     FreeAndNil(AXMLDoc);
   end;

  if IRemoteCon.Connected then
   DisableControls;

 except
  on E: Exception do
   begin
    ICosmosApp.DlgMessage.ErrorMessage(TCosmosTitles.SystemFailure, TCosmosErrorMsg.LoadConfigurations);

    ICosmosApp.MainLog.RegisterError(E.Message);

    if Assigned(AXMLDoc) then
     FreeAndNil(AXMLDoc);
   end;
 end;
end;

procedure TFrmPoolOptions.RdbOnDemandClick(Sender: TObject);
begin
  FChanged := True;
end;

function TFrmPoolOptions.SaveOptions: boolean;
var
 I: integer;
 AXMLDoc: TXMLDocument;
 ANode,AChildNode: IXMLNode;
begin
 {Salva as opções de configuração. Somente salva se houver um usuário autenticado
  e se o mesmo for administrador do Cosmos.}
 Result := ValidateFields;
 if not Result then
  begin
   ICosmosApp.DlgMessage.WarningMessage(TCosmosTitles.Atenttion, TCosmosWarningMsg.IncompletedFields);
   Exit;
  end;

 AXMLDoc := self.CreateXMLDocument(ICosmosApp.IApplicationPaths.GetUserConfigurationsFile);

 try
  ANode := AXMLDoc.DocumentElement;
  ANode := ANode.ChildNodes.FindNode('ConnectionsPool'); //do not localize!
  ANode := ANode.ChildNodes.FindNode('PoolInfo');  //do not localize!

  if ANode <> nil then
   begin
    for I := 0 to Pred(ANode.ChildNodes.Count) do
     begin
      AChildNode := ANode.ChildNodes.Get(I);

      if (AChildNode <> nil) and (AChildNode.Attributes['CosmosApp'] = ICosmosApp.CosmosModuleShortName) then  //do not localize!
       begin
        AChildNode.Attributes['PoolSize'] := EdtPoolSize.Value;  //do not localize!
        AChildNode.Attributes['CleanupMinutes'] := EdtCleanup.Value;  //do not localize!
        AChildNode.Attributes['PoolTimeout'] := EdtTimeout.Value;  //do not localize!

        if RdbOnDemand.Checked then AChildNode.Attributes['ConnectionType'] := 0;
        if RdbCreateFull.Checked then AChildNode.Attributes['ConnectionType'] := 1;
        if RdbCreateDestroy.Checked then AChildNode.Attributes['ConnectionType'] := 2;
        if RdbNoPool.Checked then AChildNode.Attributes['ConnectionType'] := 3;

        Break;
      end;
     end;

    AXMLDoc.SaveToFile(AXMLDoc.FileName);
    Result := True;
   end;

 finally
  if Assigned(AXMLDoc) then
    FreeAndNil(AXMLDoc);
 end;
end;

function TFrmPoolOptions.ValidateFields: boolean;
begin
  Result := True; //Validação desnecessária nessa página.
end;

initialization
 RegisterClass(TFrmPoolOptions);

finalization
 UnRegisterClass(TFrmPoolOptions);

end.
