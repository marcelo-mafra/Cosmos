unit cosmos.framework.tools.datalocate;

interface

uses
  SysUtils, Classes, cosmos.framework.interfaces.dialogs, Forms, DB,
  cosmos.framework.interfaces.DataAcess, cosmos.framework.datanavigators.datasets,
  cosmos.framework.datanavigators.treeview, cosmos.framework.datanavigators.listview;


type
  TDataLocateControler = class(TInterfacedPersistent, ICosmosLocateData)

   private

   protected
   //ICosmosLocateData
    procedure Execute; overload;
    procedure Execute(Dataset: TDataset); overload;

   public
    { Public declarations }
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses cosmos.common.view.FormLocate, cosmos.common.view.LocateTask;

{ TDataLocateControler }

constructor TDataLocateControler.Create;
begin
 inherited Create;
end;

destructor TDataLocateControler.Destroy;
begin
 inherited Destroy;
end;

procedure TDataLocateControler.Execute;
var
IRemoteCon: ICosmosRemoteConnection;
begin
 IRemoteCon := Application.MainForm as ICosmosRemoteConnection;

 try
  //Localização em um dataset...
  if IRemoteCon.ActiveDataNavigator is TDatasetDataNavigator then
   begin
    FrmLocate := TFrmLocate.Create(Application);

    try
     FrmLocate.Dataset := IRemoteCon.ActiveDataset;
     FrmLocate.ShowModal;

    finally
     if Assigned(FrmLocate) then
      FreeAndNil(FrmLocate);
    end;
   end;

  //Localização em um treeview...
  if IRemoteCon.ActiveDataNavigator is TTreeviewDataNavigator then
   begin
    FrmLocate := TFrmLocate.Create(Application);

    try
     with FrmLocate do
      begin
       Dataset := nil;
       CBXFields.Enabled := False;
       ChkPartialKey.Checked := False;
       ChkPartialKey.Enabled := False;
       ShowModal;
      end;

    finally
     if Assigned(FrmLocate) then
      FreeAndNil(FrmLocate);
    end;
   end;

  //Localização em um listview...
  if IRemoteCon.ActiveDataNavigator is TListviewDataNavigator then
   begin
    FrmLocateTask := TFrmLocateTask.Create(Application);

    try
     FrmLocateTask.ShowModal;

    finally
     if Assigned(FrmLocateTask) then
      FreeAndNil(FrmLocateTask);
    end;
   end;

 finally
  if Assigned(IRemoteCon) then
   IRemoteCon := nil;
 end;
end;

procedure TDataLocateControler.Execute(Dataset: TDataset);
begin
   FrmLocate := TFrmLocate.Create(Application);

   try
    FrmLocate.Dataset := Dataset;
    FrmLocate.ShowModal;

   finally
    if Assigned(FrmLocate) then
     FreeAndNil(FrmLocate);
   end;
end;

initialization
 RegisterClass(TDataLocateControler);

finalization
 UnRegisterClass(TDataLocateControler);

end.
