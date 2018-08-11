unit cosmos.common.control.splash;

interface

uses
 System.Classes, System.SysUtils, cosmos.classes.application, cosmos.framework.interfaces.root,
 cosmos.framework.interfaces.dialogs, cosmos.system.messages, cosmos.business.focos,
 Vcl.Forms, cosmos.system.types, Vcl.Imaging.pngimage;


type
  TLogoType = (ltSplash, ltAbout);

  TSplashControler = class(TInterfacedPersistent, ICosmosSplash)

  private
    ASplash: TPNGImage;
    procedure LoadCosmosLogos(CosmosModule: TCosmosModules; LogoType: TLogoType);

   protected
    procedure ShowAppSplash(CosmosModule: TCosmosModules);
    procedure ShowAppAbout(CosmosModule: TCosmosModules);

   public
    { Public declarations }
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TSplashControler }

uses cosmos.common.view.frmsplash, cosmos.common.view.frmaboutsplash;

constructor TSplashControler.Create;
begin
 ASplash := TPNGImage.Create;
end;

destructor TSplashControler.Destroy;
begin
  ASplash.Free;
  inherited;
end;

procedure TSplashControler.LoadCosmosLogos(CosmosModule: TCosmosModules;
  LogoType: TLogoType);
begin
 if not Assigned(ASplash) then
  ASplash := TPNGImage.Create;

 if LogoType = ltSplash then
  begin
    case CosmosModule of
      cmFocos: ASplash.LoadFromResourceName(hInstance, 'GFOC_SPL');
      cmSecretarias: ASplash.LoadFromResourceName(hInstance, 'GSEC_SPL');
      cmFinanceiro: ASplash.LoadFromResourceName(hInstance, 'GFIN_SPL');
      cmConferencias: ASplash.LoadFromResourceName(hInstance, 'GCON_SPL');
      cmUsuarios: ASplash.LoadFromResourceName(hInstance, 'GUSU_SPL');
    end;
  end
 else
  ASplash.LoadFromResourceName(hInstance, 'COSMOS_ABOUT');
end;

procedure TSplashControler.ShowAppAbout(CosmosModule: TCosmosModules);
begin
 LoadCosmosLogos(CosmosModule, ltAbout);

 FrmAbout := TFrmAbout.Create(nil);

 try
  FrmAbout.ImgMainLogo.Picture.Assign(ASplash);
  FrmAbout.ShowAppAbout;

 finally
  if Assigned(FrmAbout) then FreeAndNil(FrmAbout);
 end;
end;

procedure TSplashControler.ShowAppSplash(CosmosModule: TCosmosModules);
begin
 LoadCosmosLogos(CosmosModule, ltSplash);

 FrmSplash := TFrmSplash.Create(nil);

 try
  FrmSplash.ImgSplash.Picture.Assign(ASplash);
  FrmSplash.TransparentColor := False;
  FrmSplash.BorderStyle := bsNone;

  FrmSplash.ImgSplash.Update;

  FrmSplash.Show;
  FrmSplash.Update;
  Sleep(5000);

 finally
  if Assigned(FrmSplash) then FreeAndNil(FrmSplash);
 end;
end;

initialization
 RegisterClass(TSplashControler);

finalization
 UnRegisterClass(TSplashControler);

end.
