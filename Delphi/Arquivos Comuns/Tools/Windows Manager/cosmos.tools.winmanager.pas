unit cosmos.tools.winmanager;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Classes, System.SysUtils, System.Contnrs,
  Vcl.Forms, Vcl.Graphics, cosmos.classes.application, cosmos.framework.interfaces.root,
  cosmos.framework.interfaces.utils, cosmos.tools.FormsInfo, cosmos.framework.view.FrmDocked;

type

  //Classe especializada em ler informações sobre formulários de um arquivo XML.
  TFormsInfoWriter = class
   private
    FFileName: string;
    FIXMLFormsInfo: IXMLFormsInfoType;

   public
    constructor Create(const FileName: string);
    destructor Destroy; override;

    function FindFormInfo(const FormClassName: string): IXMLFormType;
    procedure ReadFormInfo(AData: TCosmosData);
    procedure WriteFormInfo(AData: TCosmosData);

    property FileName: string read FFileName;
  end;

  //Clase especializa em realizar diversas operações com janelas do sistema.
  TWindowsManager = class(TInterfacedObject, ICosmosWindowsManager)
  strict private
    FFileFormsInfo: string;
    FFormList: TComponentList;
    FMainForm: TCustomForm;
    FFormsInfoWriter: TFormsInfoWriter;

  private
    FActiveForm: TCustomForm;
    function GetFormCount: integer;

  protected
    procedure ActivateForm(Form: TCustomForm); overload;
    procedure ActivateForm(const ClassName: string); overload;
    function CloseRegisteredWindow(const WindowCaption: string): boolean; overload;
    function CloseRegisteredWindows(const ClassName: TClass): boolean; overload;
    function ExtractFormIcon(Form: TCustomForm): TIcon;
    function FindFormByID(const ID: integer): TCustomForm;
    function FindFormByCaption(const Caption: string): TCustomForm;
    function FindFormByClassName(const ClassName: string): TCustomForm;

  public
    constructor Create(const FileName: string);
    destructor Destroy; override;

    procedure CreateForm(Form: TComponentClass; var Reference; LibID: integer = 0);
    procedure ActivateForm(Form: TComponentClass); overload;
    procedure CloseAllRegisteredWindows;
    procedure CloseForm(Form: TCustomForm);
    function GetLastForm: TForm;
    function GetFirstForm: TForm;
    function FindFormByClass(ClassName: TClass): TCustomForm;
    procedure LoadFormInfo(Form: TCustomForm);
    procedure SaveFormInfo(Form: TCustomForm); overload;
    procedure SaveFormInfo(FormClassName: string); overload;
    procedure UpdateAllForms;
    procedure UpdateAllFormsElements;

    property ActiveForm: TCustomForm read FActiveForm write FActiveForm;
    property FileFormsInfo: string read FFileFormsInfo;
    property FormCount: integer read GetFormCount;
    property FormsInfoWriter: TFormsInfoWriter read FFormsInfoWriter;
    property MainForm: TCustomForm read FMainForm write FMainForm;
  end;

implementation

{ TWindowsManager }

procedure TWindowsManager.ActivateForm(Form: TComponentClass);
var
I: integer;
AForm: TCustomForm;
begin
 I := FFormList.FindInstanceOf(Form);
 if I >= 0 then
  begin
   AForm := TCustomForm(FFormList[I]);
   if AForm <> nil then
    begin
     AForm.Show;
     AForm.SetFocus;
    end;
  end;
end;

procedure TWindowsManager.ActivateForm(Form: TCustomForm);
begin
 if Form <> nil then
  begin
   Form.Show;
   Form.SetFocus;
  end;
end;

procedure TWindowsManager.ActivateForm(const ClassName: string);
var
I: integer;
begin
 for I := 0 to screen.FormCount - 1 do
   begin
     if screen.Forms[I].ClassName = ClassName then
      begin
       Screen.Forms[I].Show;
       Screen.Forms[I].SetFocus;
       break;
      end;
   end;
end;

procedure TWindowsManager.CloseAllRegisteredWindows;
var
 ADockedForm: TCustomForm;
begin
 {Fecha todas as janelas de dados do Cosmos que estão abertas.}
 while self.FormCount > 0 do
  begin
   ADockedForm := self.GetFirstForm;
   if ADockedForm is TFrmCosmosDocked then
    self.CloseForm(ADockedForm);
  end;
end;

procedure TWindowsManager.CloseForm(Form: TCustomForm);
var
I: integer;
AForm: TForm;
begin
 AForm := nil;
 I := FFormList.FindInstanceOf(Form.ClassType);
 if I >= 0 then
  AForm := TForm(FFormList[I]);

 if AForm <> nil then
  begin
   AForm.Close;
   FFormList.Delete(I);
  end;
end;

function TWindowsManager.CloseRegisteredWindow(
  const WindowCaption: string): boolean;
var
Form: TCustomForm;
begin
 Result := False;
 Form := self.FindFormByCaption(WindowCaption);
 if Form <> nil then
  begin
   self.CloseForm(Form);
   Result := True;
  end;
end;

function TWindowsManager.CloseRegisteredWindows(
  const ClassName: TClass): boolean;
var
Form: TCustomForm;
begin
 Result := False;
 Form := self.FindFormByClass(ClassName);
 if Form <> nil then
  begin
   self.CloseForm(Form);
   Result := True;
  end;
end;

constructor TWindowsManager.Create(const FileName: string);
begin
 inherited Create;
 FFormList := TComponentList.Create(True);
 FFileFormsInfo :=  FileName;

 FFormsInfoWriter := TFormsInfoWriter.Create(FFileFormsInfo);
end;

procedure TWindowsManager.CreateForm(Form: TComponentClass; var Reference; LibID: integer);
begin
 if not Assigned(TForm(Reference)) then
  begin
   Application.CreateForm(Form, Reference);
   FFormList.Add(TForm(Reference));
   TForm(Reference).Tag := LibID;
  end;
end;

destructor TWindowsManager.Destroy;
begin
  FFormList.Free;
  FFormsInfoWriter.Free;
  inherited Destroy;
end;

function TWindowsManager.ExtractFormIcon(Form: TCustomForm): TIcon;
var
I: integer;
AForm: TForm;
begin
 I := FFormList.FindInstanceOf(Form.ClassType);

 if I >= 0 then
  begin
   AForm := TForm(FFormList[I]);
   if AForm <> nil then
    Result := AForm.Icon
   else
    Result := nil;
  end
 else
  Result := nil;
end;

function TWindowsManager.FindFormByCaption(const Caption: string): TCustomForm;
var
I: integer;
AForm: TCustomForm;
begin
 AForm := nil;

 for I := 0 to Pred(FFormList.Count) do
  begin
   AForm := TForm(FFormList[I]);
   if (AForm <> nil) and (AForm.Caption = Caption) then
    break;
  end;

 Result := AForm;
end;

function TWindowsManager.FindFormByClass(ClassName: TClass): TCustomForm;
var
I: integer;
begin
 Result := nil;
 I := FFormList.FindInstanceOf(ClassName);
 if I >= 0 then
  Result := TCustomForm(FFormList[I]);
end;

function TWindowsManager.FindFormByClassName(
  const ClassName: string): TCustomForm;
var
I: integer;
begin
 for I := 0 to Pred(FFormList.Count) do
  begin
   Result := TForm(FFormList[I]);
   if (Result <> nil) and (Result.ClassName = ClassName) then
    break;
  end;
end;

function TWindowsManager.FindFormByID(const ID: integer): TCustomForm;
begin
  Result := TForm(FFormList[ID]);
end;

function TWindowsManager.GetFirstForm: TForm;
begin
 Result := TForm(FFormList.First);
end;

function TWindowsManager.GetFormCount: integer;
begin
  Result := FFormList.Count;
end;

function TWindowsManager.GetLastForm: TForm;
begin
 Result := TForm(FFormList.Last);
end;

procedure TWindowsManager.LoadFormInfo(Form: TCustomForm);
var
 AData: TCosmosData;
begin
 AData := TCosmosData.Create(10);

 try
  //Carrega os valores "padrões" dos dados do objeto AData.
  AData.WriteValue('FormClassName', Form.ClassName);
  AData.WriteValue('Height', Form.Height,  1);
  AData.WriteValue('Width', Form.Width, 2);
  AData.WriteValue('Position', Form.Top, 3);
  AData.WriteValue('Docked', False, 4);
  AData.WriteValue('LeftPosition', Form.Left, 5);

  //Chama o método do objeto que lê o arquivo XML para capturar os dados reais.
  FormsInfoWriter.ReadFormInfo(AData);
  Form.Height :=  AData.FindValue('Height');
  Form.Width :=  AData.FindValue('Width');
  Form.Top := AData.FindValue('Position');
  Form.Left := AData.FindValue('LeftPosition');

 finally
  if Assigned(AData) then
   FreeAndNil(AData);
 end;
end;

procedure TWindowsManager.SaveFormInfo(FormClassName: string);
var
 AForm: TCustomForm;
 FormValues: TCosmosData;
begin
  AForm := self.FindFormByClassName(FormClassName);

  if AForm <> nil then
   begin
    try
     FormValues := TCosmosData.Create(10);
     FormValues.WriteValue('FormClassName', AForm.ClassName);
     FormValues.WriteValue('Height', AForm.Height, 1);
     FormValues.WriteValue('Width', AForm.Width, 2);
     FormValues.WriteValue('Position', AForm.Top, 3);
     FormValues.WriteValue('Docked', False, 4);
     FormValues.WriteValue('LeftPosition', AForm.Left, 5);

     FormsInfoWriter.WriteFormInfo(FormValues);

    finally
     if Assigned(FormValues) then
      FreeAndNil(FormValues);
    end;
   end;
end;

procedure TWindowsManager.SaveFormInfo(Form: TCustomForm);
var
FormValues: TCosmosData;
begin
//Lê os dados do form e repassa para o objeto que salva os dados...
 if Form = nil then
  Exit;

 FormValues := TCosmosData.Create(10);

 try
  FormValues.WriteValue('FormClassName', Form.ClassName);
  FormValues.WriteValue('Height', Form.Height, 1);
  FormValues.WriteValue('Width', Form.Width, 2);
  FormValues.WriteValue('Position', Form.Top, 3);
  FormValues.WriteValue('Docked', False, 4);
  FormValues.WriteValue('LeftPosition', Form.Left, 5);

  FormsInfoWriter.WriteFormInfo(FormValues);

 finally
  if Assigned(FormValues) then
   FreeAndNil(FormValues);
 end;
end;

procedure TWindowsManager.UpdateAllForms;
var
I: integer;
Form: TCustomForm;
begin
 {Atualiza os dados exibidos em todas as janelas descendendetes de TDockedForm
   que se encontram abertas.}
 for I := 0 to Pred(Screen.FormCount) do
  begin
   Form := Screen.Forms[I];
   if Form is TFrmCosmosDocked then //É um form descendente de TFrmCosmosDocked
    begin
     TFrmCosmosDocked(Form).DataNavigator.UpdateData;
    end;
  end;
end;

procedure TWindowsManager.UpdateAllFormsElements;
var
I: integer;
IDockedForm: ICosmosDockedForm;
Form: TCustomForm;
begin
 {Atualiza as configurações visuais em todas as janelas descendendetes de TDockedForm
   que se encontram abertas.}
 try
  for I := 0 to Pred(Screen.FormCount) do
  begin
   Form := Screen.Forms[I];

   if Form is TFrmCosmosDocked then //É um form descendente de TFrmCosmosDocked
    begin
     IDockedForm := TFrmCosmosDocked(Form) as  ICosmosDockedForm;
     IDockedForm.UpdateVisualElements;
    end;
  end;

 finally
  if Assigned(IDockedForm) then IDockedForm := nil;
 end;
end;

{ TFormsInfoReader }

constructor TFormsInfoWriter.Create(const FileName: string);
begin
 try
  if FileExists(FileName) then
   FIXMLFormsInfo := LoadFormsInfo(FileName)
  else
   begin//Cria o arquivo agora, caso ele ainda não tenha sido criado.
    FIXMLFormsInfo := NewFormsInfo;
    FIXMLFormsInfo.OwnerDocument.SaveToFile(FileName);
   end;

  FFileName := FileName;

 except
  raise;
 end;

end;

destructor TFormsInfoWriter.Destroy;
begin
  if Assigned(FIXMLFormsInfo) then
   FIXMLFormsInfo := nil;

  inherited Destroy;
end;

function TFormsInfoWriter.FindFormInfo(
  const FormClassName: string): IXMLFormType;
var
I: integer;
begin
 Result := nil;

 if FIXMLFormsInfo <> nil then
  begin
   for I := 0 to Pred(FIXMLFormsInfo.Info.Count) do
     begin
      if FIXMLFormsInfo.Info[I].FormClassName = FormClassName then
       begin
         Result := FIXMLFormsInfo.Info[I];
         Break;
       end;
     end;
  end;
end;

procedure TFormsInfoWriter.ReadFormInfo(AData: TCosmosData);
var
AFormClassName: string;
IFormInfo: IXMLFormType;
begin
 {Lê do arquivo XML as propriedades de um form. Caso não encontre os dados
  formulário no arquivo, usa os valore padrões recebidos no objeto AData.}
 AFormClassName := Adata.FindValue('FormClassName');

 try
  IFormInfo := FindFormInfo(AFormClassName);
  if IFormInfo <> nil then
   begin
    AData.WriteValue('Height', IFormInfo.Height, 1);
    AData.WriteValue('Width', IFormInfo.Width, 2);
    AData.WriteValue('Position', IFormInfo.Position, 3);
    AData.WriteValue('Docked', IFormInfo.Docked, 4);
    AData.WriteValue('LeftPosition', IFormInfo.LeftPosition, 5);
   end;

 finally
  if Assigned(IFormInfo) then
   IFormInfo := nil;
 end;
end;

procedure TFormsInfoWriter.WriteFormInfo(AData: TCosmosData);
var
 AFormClassName: string;
 IFormsInfoType: IXMLFormsInfoType;
 IFormType: IXMLFormType;
 IFormInfoValues: IXMLFormType;
begin
//Salva as propriedades de formulários em um arquivo XML.
 try
  AFormClassName := AData.FindValue('FormClassName');
  IFormInfoValues := FindFormInfo(AFormClassName);

  if IFormInfoValues = nil then //O arquivo XML ainda não contém informações do form corrente.
   begin
    IFormsInfoType := LoadFormsInfo(FileName);
    IFormType := IFormsInfoType.Info.Add;
    IFormType.FormClassName := AData.FindValue('FormClassName');
    IFormType.Height := AData.FindValue('Height');
    IFormType.Width := AData.FindValue('Width');
    IFormType.Position := AData.FindValue('Position');
    IFormType.Docked := AData.FindValue('Docked');
    IFormType.LeftPosition := AData.FindValue('LeftPosition');
    IFormType.OwnerDocument.SaveToFile(FileName);
   end
   else
    begin //O nó do referente ao form corrente foi encontrado.
     IFormInfoValues.FormClassName := AData.FindValue('FormClassName');
     IFormInfoValues.Height := AData.FindValue('Height');
     IFormInfoValues.Width := AData.FindValue('Width');
     IFormInfoValues.Position := AData.FindValue('Position');
     IFormInfoValues.Docked := AData.FindValue('Docked');
     IFormInfoValues.LeftPosition := AData.FindValue('LeftPosition');
     IFormInfoValues.OwnerDocument.SaveToFile(FileName);
    end;



 finally
  if Assigned(IFormType) then  IFormType := nil;
  if Assigned(IFormsInfoType) then  IFormsInfoType := nil;
  if Assigned(IFormInfoValues) then  IFormInfoValues := nil;
 end;
end;


end.
