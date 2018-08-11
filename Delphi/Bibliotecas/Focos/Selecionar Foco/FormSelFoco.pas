unit FormSelFoco;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, GroupHeader, ImgList,
  Cosmos.Framework.Interfaces.Dialogs,Cosmos.Framework.Interfaces.Root, DBClient;

type
  PFocus = ^TFocus;
  TFocus = record
   codfoc: integer;
   nomfoc, sigfoc: string;
  end;

  TFrmSelFoco = class(TForm, ICosmosTest)
    Image1: TImage;
    LblUserName: TLabel;
    Label2: TLabel;
    MSGroupHeader1: TMSGroupHeader;
    LsvFocos: TListView;
    Button1: TButton;
    BtnOK: TButton;
    ImageList1: TImageList;
    procedure LsvFocosChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
  private

    { Private declarations }
  protected
   function SelectFocus(UserName: string): integer;

  public
    { Public declarations }
  end;

var
  FrmSelFoco: TFrmSelFoco;

implementation

{$R *.dfm}

procedure TFrmSelFoco.LsvFocosChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
 BtnOK.Enabled := LsvFocos.Selected <> nil;
end;


function TFrmSelFoco.SelectFocus(UserName: string): integer;
var
PF: PFocus;
Cds: TClientDataset;
Item: TListItem;
begin
 try
  Result := 0;
  LblUserName.Caption := Format(LblUserName.Caption, [UserName]);
  Cds := TClientDataset.Create(self);

  ShowModal;
  exit;
  if Cds.RecordCount = 1 then
   Result := Cds.Fields.FieldByName('codfoc').AsInteger
  else
   begin
    LsvFocos.Items.BeginUpdate;
   // if Focus <> unassigned then
     begin
      while not Cds.Eof do
       begin
        New(PF);
        PF.codfoc := Cds.Fields.FieldByName('codfoc').AsInteger;
        PF.nomfoc := Cds.Fields.FieldByName('nomfoc').AsString;
        PF.sigfoc := Cds.Fields.FieldByName('sigfoc').AsString;
        Item := LsvFocos.Items.Add;
        Item.Caption := PF.nomfoc;
        Item.SubItems.Add(PF.sigfoc);
        Item.Data := PF;
        Cds.Next;
       end;
     end;
    LsvFocos.Items.EndUpdate;
    if ShowModal = mrOK then
     begin
      PF := LsvFocos.Selected.Data;
      Result :=  PF.codfoc;
     end;
   end;

 finally
  if Assigned(Cds) then
   FreeAndNil(Cds);
 end;
end;



initialization
 RegisterClass(TFrmSelFoco);

finalization
 UnRegisterClass(TFrmSelFoco);

end.
