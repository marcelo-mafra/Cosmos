unit cosmos.common.view.FormSelectCadastrados;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, Cosmos.Framework.Interfaces.Root, cosmos.classes.security,
  Cosmos.Framework.Interfaces.DataAcess, Cosmos.Framework.Interfaces.Dialogs,
  StdCtrls, Buttons, ImgList, ActnList, cosmos.frames.gridsearch, cosmos.classes.application,
  cosmos.business.focos, cosmos.system.messages, cosmos.classes.ServerInterface,
  cosmos.Framework.forms.datadialogs, System.Actions;

type
  TFrmSelectCadastrados = class(TForm, IPesquisaCadastradosMultiplos)
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
    { Private declarations }
    FICosmosApp: ICosmosApplication;
    FCampoTrabalho: TCampoTrabalho;
    function GetCampoTrabalho: TCampoTrabalho;
    procedure SetCampoTrabalho(value: TCampoTrabalho);

  public
    { Public declarations }
    property CampoTrabalho: TCampoTrabalho read GetCampoTrabalho write SetCampoTrabalho default ctLectorium;
    property ICosmosApp: ICosmosApplication read FICosmosApp;


    function Execute: boolean;
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
 AData: TCosmosData;
begin
 inherited;
 AData := TCosmosCadastradosDialogs.SelecionarCadastrado(self.CampoTrabalho, scTodos, True);

 try
  if AData <> nil then
   begin
    if not CdsCadastrados.Locate('codcad', AData.FindValue('codcad'), []) then
      begin
        CdsCadastrados.Insert;
        with CdsCadastrados.Fields do
         begin
          FieldByName('codcad').Value := AData.FindValue('codcad');
          FieldByName('matcad').Value := AData.FindValue('matcad');
          FieldByName('nomcad').Value := AData.FindValue('nomcad');
          FieldByName('sigdis').Value := AData.FindValue('sigdis');
          FieldByName('sigfoc').Value := AData.FindValue('sigfoc');
          FieldByName('matcadint').Value := AData.FindValue('matcadint');
         end;
         CdsCadastrados.Post;
      end;
   end;

 finally
  if Assigned(AData) then
   FreeAndNil(AData);
 end;
end;

procedure TFrmSelectCadastrados.ActTodosExecute(Sender: TObject);
var
AFieldValue: string;
AParams: TCosmosData;
begin
 AParams := TCosmosData.Create(5);
 AFieldValue := TFocusTypesInfo.CampoTrabalhoToString(self.CampoTrabalho);

 AParams.WriteValue('CODFOC', ICosmosApp.ActiveFocus.FocusID);
 AParams.WriteValue('CAMDIS', QuotedStr(AFieldValue), 1);
 AParams.WriteValue('INDATI', QuotedStr('S'), 2);

//Executa a pesquisa no servidor remoto passando todos os argumentos de busca.
 CdsCadastrados.DisableControls;

 try
  if CdsCadastrados.Active then
   CdsCadastrados.Close;

  ICosmosApp.IRemoteCon.ExecuteDQL(csCadastradosFocoCampo, AParams.Data, CdsCadastrados);
  if (CdsCadastrados.Active) then
   CdsCadastrados.ReadOnly := False; //é necessário, pois os dados voltam em estado readonly.

 finally
  CdsCadastrados.EnableControls;
  if Assigned(AParams) then FreeAndNil(AParams);
 end;
end;

procedure TFrmSelectCadastrados.FormCreate(Sender: TObject);
begin
 FICosmosApp := Application.MainForm as ICosmosApplication;
 FmeGridSearch.SearchFields := 'nomcad';
end;

function TFrmSelectCadastrados.GetCampoTrabalho: TCampoTrabalho;
begin
 Result := FCampoTrabalho;
end;

function TFrmSelectCadastrados.GetMatriculas: string;
begin
 Result := '';

 if (CdsCadastrados.Active) and not (CdsCadastrados.IsEmpty) then
  begin
   CdsCadastrados.First;
   
   while not CdsCadastrados.Eof do
    begin
     Result := Result + TrimRight(CdsCadastrados.Fields.FieldByName('matcad').AsString) + ', ';
     CdsCadastrados.Next;
    end;

   Delete(Result, Length(Result) - 1, 2);
  end;
end;

function TFrmSelectCadastrados.Execute: boolean;
begin
 Result := ShowModal = mrOk;
end;

procedure TFrmSelectCadastrados.SetCampoTrabalho(value: TCampoTrabalho);
begin
 FCampoTrabalho := Value;
end;

initialization
 RegisterClass(TFrmSelectCadastrados);

finalization
 UnRegisterClass(TFrmSelectCadastrados);

end.
