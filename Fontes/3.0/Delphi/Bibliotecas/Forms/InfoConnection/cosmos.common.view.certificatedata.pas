unit cosmos.common.view.certificatedata;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Cosmos.Framework.Interfaces.DataAcess,
  Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.ImgList, Cosmos.System.Messages,
  Vcl.Imaging.pngimage;

type
  TFrmCertificateData = class(TForm)
    Bevel1: TBevel;
    Label2: TLabel;
    LblOwner: TLabel;
    Label4: TLabel;
    LblDateFrom: TLabel;
    Label6: TLabel;
    LblDateTo: TLabel;
    Bevel2: TBevel;
    LsvData: TListView;
    MmoData: TMemo;
    Bevel3: TBevel;
    Button1: TButton;
    ImageList1: TImageList;
    Panel1: TPanel;
    Image2: TImage;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure LsvDataSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
  private
    { Private declarations }
    procedure LoadCertificateData;
  public
    { Public declarations }
  end;

var
  FrmCertificateData: TFrmCertificateData;

implementation

{$R *.dfm}

{ TFrmCertificateData }

procedure TFrmCertificateData.FormCreate(Sender: TObject);
begin
 LoadCertificateData;
end;

procedure TFrmCertificateData.LoadCertificateData;
var
 IRemoteCon: ICosmosRemoteConnection;
 aItem: TListItem;
begin
 {Lista os dados do certificado digital caso exista algum. Os dados do certificado
  recebido do servidor são copiados, durante a conexão, para a estrutura de um
  objeto do tipo TCosmosData.}

  IRemoteCon := Application.MainForm as ICosmosRemoteConnection;

  try
    if IRemoteCon.CertificateData <> nil then
     begin
      LblOwner.Caption := IRemoteCon.CertificateData.FindValue('Owner');  //do not localize!
      LblDateFrom.Caption := IRemoteCon.CertificateData.FindValue('NotBefore');  //do not localize!
      LblDateTo.Caption := IRemoteCon.CertificateData.FindValue('NotAfter');  //do not localize!

      aItem := LsvData.Items.Add;
      aItem.Caption := TCertificateConst.CertType;
      aItem.SubItems.Add(IRemoteCon.CertificateData.FindValue('CertificateType')); //do not localize!
      aItem.ImageIndex := 0;

      aItem := LsvData.Items.Add;
      aItem.Caption := TCertificateConst.Owner;
      aItem.SubItems.Add(IRemoteCon.CertificateData.FindValue('Owner')); //do not localize!
      aItem.ImageIndex := 0;

      aItem := LsvData.Items.Add;
      aItem.Caption := TCertificateConst.Website;
      aItem.SubItems.Add(IRemoteCon.CertificateData.FindValue('Website')); //do not localize!
      aItem.ImageIndex := 0;

      aItem := LsvData.Items.Add;
      aItem.Caption := TCertificateConst.Email;
      aItem.SubItems.Add(IRemoteCon.CertificateData.FindValue('EmailAddress')); //do not localize!
      aItem.ImageIndex := 0;

      aItem := LsvData.Items.Add;
      aItem.Caption := TCertificateConst.Country;
      aItem.SubItems.Add(IRemoteCon.CertificateData.FindValue('Country')); //do not localize!
      aItem.ImageIndex := 0;

      aItem := LsvData.Items.Add;
      aItem.Caption := TCertificateConst.State;
      aItem.SubItems.Add(IRemoteCon.CertificateData.FindValue('State')); //do not localize!
      aItem.ImageIndex := 0;

      aItem := LsvData.Items.Add;
      aItem.Caption := TCertificateConst.Location;
      aItem.SubItems.Add(IRemoteCon.CertificateData.FindValue('City')); //do not localize!
      aItem.ImageIndex := 0;

      aItem := LsvData.Items.Add;
      aItem.Caption := TCertificateConst.SigAlgName;
      aItem.SubItems.Add(IRemoteCon.CertificateData.FindValue('SigAlgName')); //do not localize!
      aItem.ImageIndex := 0;

      aItem := LsvData.Items.Add;
      aItem.Caption := TCertificateConst.Assinatura;
      aItem.SubItems.Add(IRemoteCon.CertificateData.FindValue('Signature')); //do not localize!
      aItem.ImageIndex := 0;

      aItem := LsvData.Items.Add;
      aItem.Caption := TCertificateConst.Algoritm;
      aItem.SubItems.Add(IRemoteCon.CertificateData.FindValue('PublicKey')); //do not localize!
      aItem.ImageIndex := 0;

      aItem := LsvData.Items.Add;
      aItem.Caption := TCertificateConst.NotBefore;
      aItem.SubItems.Add(IRemoteCon.CertificateData.FindValue('NotBefore')); //do not localize!
      aItem.ImageIndex := 0;

      aItem := LsvData.Items.Add;
      aItem.Caption := TCertificateConst.NotAfter;
      aItem.SubItems.Add(IRemoteCon.CertificateData.FindValue('NotAfter')); //do not localize!
      aItem.ImageIndex := 0;

      aItem := LsvData.Items.Add;
      aItem.Caption := TCertificateConst.SerialNumber;
      aItem.SubItems.Add(IRemoteCon.CertificateData.FindValue('SerialNumber')); //do not localize!
      aItem.ImageIndex := 0;

     end;

  finally
   IRemoteCon := nil;
  end;
end;

procedure TFrmCertificateData.LsvDataSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
 MmoData.Clear;
 MmoData.Lines.Add(Item.SubItems.Text);
end;

end.
