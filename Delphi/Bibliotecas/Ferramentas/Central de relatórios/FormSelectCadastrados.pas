unit FormSelectCadastrados;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, Cosmos.Framework.Interfaces.Root, SecurityModel,
  Cosmos.Framework.Interfaces.DataAcess, Cosmos.Framework.Interfaces.Dialogs,
  StdCtrls, Buttons, ImgList, ActnList, FrameGridSearch, cosmos.core.classes,
  cosmos.business.focos, cosmos.framework.forms.mydialogs, cosmos.core.ConstantesMsg,
  cosmos.core.SQLServerInterface;

type
  TFrmSelectCadastrados = class(TForm)
    CdsCadastrados: TClientDataSet;
    DsrAlunos: TDataSource;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    ActionList1: TActionList;
    ImageList1: TImageList;
    FmeGridSearch: TFmeGridSearch;
    ActTodos: TAction;
    ActSelect: TAction;
    ActDelete: TAction;
    CdsCadastradosCODCAD: TIntegerField;
    CdsCadastradosMATCAD: TStringField;
    CdsCadastradosMATCADINT: TIntegerField;
    CdsCadastradosNOMCAD: TStringField;
    CdsCadastradosSIGDIS: TStringField;
    CdsCadastradosSIGFOC: TStringField;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    procedure ActSelectExecute(Sender: TObject);
    procedure ActTodosExecute(Sender: TObject);
    procedure ActDeleteUpdate(Sender: TObject);
    procedure ActDeleteExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FIRemoteCon: ICosmosRemoteConnection;
    FICosmosApp: ICosmosApplication;
    FCampoTrabalho: TCampoTrabalho;
    { Private declarations }
  public
    { Public declarations }
    property CampoTrabalho: TCampoTrabalho read FCampoTrabalho write FCampoTrabalho default ctLectorium;
    property ICosmosApp: ICosmosApplication read FICosmosApp;
    property IRemoteCon: ICosmosRemoteConnection read FIRemoteCon;

    function ListarCadastrados: boolean;
    function GetMatriculas: string;
  end;

var
  FrmSelectCadastrados: TFrmSelectCadastrados;

implementation

{$R *.dfm}

procedure TFrmSelectCadastrados.ActDeleteExecute(Sender: TObject);
begin
 CdsCadastrados.Delete;
end;

procedure TFrmSelectCadastrados.ActDeleteUpdate(Sender: TObject);
begin
 TAction(Sender).Enabled := (CdsCadastrados.Active) and not (CdsCadastrados.IsEmpty);
end;

procedure TFrmSelectCadastrados.ActSelectExecute(Sender: TObject);
var
 AModule: HModule;
 AForm: TForm;
 IPesquisa: IPesquisaCadastrados;
begin
 inherited;
 try

  AForm := ICosmosApp.LoadDialog('pescad.bpl', 'TFrmPesquisar', AModule);

  if AModule <> 0 then
  begin
    if Supports(AForm, IPesquisaCadastrados) then
      begin
       IPesquisa := AForm as IPesquisaCadastrados;
        with IPesquisa do
         begin
          ActiveFocus := True;
          SexoCadastrado := scTodos;
          IPesquisa.CampoTrabalho := self.CampoTrabalho;
          if Execute then
           begin
            if not CdsCadastrados.Locate('codcad', Dataset.Fields.FieldByName('codcad').Value, []) then
             begin
              CdsCadastrados.Insert;
              with CdsCadastrados.Fields do
               begin
                FieldByName('codcad').Value := IPesquisa.Dataset.Fields.FieldByName('codcad').Value;
                FieldByName('matcad').Value := IPesquisa.Dataset.Fields.FieldByName('matcad').Value;
                FieldByName('nomcad').Value := IPesquisa.Dataset.Fields.FieldByName('nomcad').Value;
                FieldByName('sigdis').Value := IPesquisa.Dataset.Fields.FieldByName('sigdis').Value;
                FieldByName('sigfoc').Value := IPesquisa.Dataset.Fields.FieldByName('sigfoc').Value;
                FieldByName('matcadint').Value := IPesquisa.Dataset.Fields.FieldByName('matcadint').Value;
               end;
               CdsCadastrados.Post;
             end;
           end;
         end;
       AForm.Free;
      end;
  end;

 finally
  if Assigned(IPesquisa) then
   IPesquisa := nil;
  UnloadPackage(AModule);
 end;
end;

procedure TFrmSelectCadastrados.ActTodosExecute(Sender: TObject);
var
Campo: string;
begin
 case CampoTrabalho of
   ctLectorium: Campo := QuotedStr('LEC');
   ctTM: Campo := QuotedStr('TM');
   ctTP: Campo := QuotedStr('TP');
   ctTMB: Campo := QuotedStr('TMB');
 end;

 CdsCadastrados.Data := IRemoteCon.ConnectionBroker.AppServer.DoSearchWithParams(csListaCadastrados,
   IntToStr(ICosmosApp.ActiveFocus.FocusID), Campo, QuotedStr('S'));
 CdsCadastrados.ReadOnly := False; //é necessário, pois os dados voltam em estado readonly
end;

procedure TFrmSelectCadastrados.FormCreate(Sender: TObject);
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;
 FIRemoteCon := Application.MainForm as ICosmosRemoteConnection;
 FmeGridSearch.SearchFields := 'nomcad';
end;

function TFrmSelectCadastrados.GetMatriculas: string;
var
s: string;
begin
 Result := '';
 s := '';

 if (CdsCadastrados.Active) and not (CdsCadastrados.IsEmpty) then
  begin
   CdsCadastrados.First;
   
   while not CdsCadastrados.Eof do
    begin
     s := s + TrimRight(CdsCadastrados.Fields.FieldByName('matcad').AsString) + ', ';
     CdsCadastrados.Next;
    end;

   Delete(s, Length(s) - 1, 2);
  // ShowMessage(s);
   Result := s;
  end;
end;

function TFrmSelectCadastrados.ListarCadastrados: boolean;
begin
 Result := ShowModal = mrOk;
end;

end.
