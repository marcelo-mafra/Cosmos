{*************************************************************************}
{ TRaveJPEGImage Rave Component version 1.0                               }
{ Copyright (c), 1999, Nevrona Designs, all rights reserved               }
{*************************************************************************}

unit NDCsJPEG;

interface

uses
  Messages, WinProcs, WinTypes, vcl.Controls, Classes, SysUtils, vcl.Graphics,
  RVDefine, RVUtil, RVClass, RPDefine, RPBase, RVCsStd, Vcl.Imaging.jpeg;

type
  TRaveJPEGImage = class(TRaveGraphicImage)
  protected
    function CreateGraphic: TGraphic; override;
    function ImageValid: boolean; override;
    procedure PrintImage(Report: TBaseReport;
                        X1,Y1,X2,Y2: TRaveUnits); override;
  public
    function ImageName: string; override;
    function ImageFilter: string; override;
  end; { TRaveJPEGImage }

  procedure RaveRegister;

implementation

{$IFDEF DESIGNER}
{$R *.RES}
{$ENDIF}

  procedure RaveRegister;

  begin { RaveRegister }
    RegisterRaveGroup('Standard','Standard Components');
    RegisterRaveComponents('Standard',[TRaveJPEGImage]);

    RegisterRaveProperties(TRaveJPEGImage,
     {Beginner}     'Image',
     {Intermediate} 'DataField;DataView;MatchSide',
     {Developer}    '',
     {Hidden}       '');

    SetPropDesc(TRaveJPEGImage,'Image',Trans(''));
  end; { RaveRegister }

(*****************************************************************************}
( class TFixedJPEGImage
(*****************************************************************************)

type
  TFixedJPEGImage = class(TJPEGImage)
  protected
    function GetEmpty: boolean; override;
  public
    procedure Assign(Source: TPersistent); override;
  end; { TFixedJPEGImage }

  procedure TFixedJPEGImage.Assign(Source: TPersistent);

  var
    TempImg: TBitmap;

  begin { Assign }
    If not Assigned(Source) then begin
      TempImg := TBitmap.Create;
      try
        inherited Assign(TempImg);
      finally
        TempImg.Free;
      end; { tryf }
    end else begin
      inherited Assign(Source);
    end; { else }
  end;  { Assign }

  function TFixedJPEGImage.GetEmpty: Boolean;

  begin { GetEmpty }
    Result := (Width = 0);
  end;  { GetEmpty }

(*****************************************************************************}
( class TRaveJPEGImage
(*****************************************************************************)

  function TRaveJPEGImage.CreateGraphic: TGraphic;

  begin { CreateGraphic }
    Result := TFixedJPEGImage.Create;
  end;  { CreateGraphic }

  function TRaveJPEGImage.ImageValid: boolean;

  begin { ImageValid }
    Result := (ActiveImage <> nil){ and (ActiveImage.Width <> 0)}
     and not (ActiveImage as TFixedJPEGImage).Empty;
  end;  { ImageValid }

  procedure TRaveJPEGImage.PrintImage(Report: TBaseReport;
                                      X1,Y1,X2,Y2: TRaveUnits);

  begin { PrintImage }
    Report.PrintBitmapRect(X1,Y1,X2,Y2,TFixedJPEGImage(ActiveImage).Bitmap);
  end;  { PrintImage }

  function TRaveJPEGImage.ImageName: string;

  begin { ImageName }
    Result := 'JPEG Image';
  end;  { ImageName }

  function TRaveJPEGImage.ImageFilter: string;

  begin { ImageFilter }
    Result := Trans('JPEG Files (*.jpg;*.jpeg)|*.jpg;*.jpeg');
  end;  { ImageFilter }

end.