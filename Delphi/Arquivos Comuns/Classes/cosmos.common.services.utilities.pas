unit cosmos.common.services.utilities;

interface

uses
  Windows, SysUtils, Classes, Vcl.Graphics, Vcl.Imaging.jpeg, Vcl.Imaging.pngimage,
  Vcl.Imaging.GIFImg;

type
  TGraphicUtilities = class

   class function FindImageType(ImageStream: TMemoryStream): string;
   class function LoadPictureFromStream(ImageStream: TMemoryStream): TPicture; overload;
   class procedure LoadPictureFromStream(ImageStream: TMemoryStream; APicture: TPicture); overload;
   class function GetImageGraphicClass(ImageStream: TMemoryStream): TGraphic;
  end;



implementation

{ TGraphicUtilities }

class function TGraphicUtilities.FindImageType(
  ImageStream: TMemoryStream): string;
var
 AStream: TStringStream;
 temp:string;
begin
{ Descobre o tipo da imagem existente em um stream.}
 ImageStream.Position := 0;
 AStream := TStringStream.Create('');

 try
  AStream.CopyFrom(ImageStream,5);
  temp := Uppercase(AStream.DataString);

  if (Ord(AStream.DataString[1]) = 255) and (Ord(AStream.DataString[2]) = 216) then Result :='JPG'
  else
  if Pos('BM',temp) > 0 then Result := 'BMP'
  else
  if Pos('GIF',temp) > 0 then Result := 'GIF'
  else
  if Pos('PNG',temp) > 0 then Result := 'PNG'
  else
  if (Ord(AStream.DataString[1]) = 215) and (Ord(AStream.DataString[2]) = 205) and
     (Ord(AStream.DataString[3]) = 198) then Result := 'WMF'
  else
 //O formato EMF não é testado realmente.
  if Pos('X',temp) > 0 then Result := 'EMF'
  else
  if (Ord(AStream.DataString[1]) = 0) and (Ord(AStream.DataString[2]) = 0) then Result := 'ICO'
  else
  if (Ord(AStream.DataString[1]) = 0) and (Ord(AStream.DataString[2]) = 1) then Result := 'ICO'
  else
  Result:='Unknow';

  AStream.Free;

 except
  if Assigned(AStream) then FreeAndNil(AStream);
  raise;
 end;
end;

class function TGraphicUtilities.LoadPictureFromStream(
  ImageStream: TMemoryStream): TPicture;
var
 ImageType: string;
 APicture: TPicture;
begin
 APicture := TPicture.Create;
 ImageType := FindImageType(ImageStream);
 ImageStream.Position := 0;

 try
 if (ImageType = 'JPG') or (ImageType = 'JPEG') then
  begin
   APicture.Graphic := TJpegImage.Create;
   TJpegImage(APicture.Graphic).LoadFromStream(ImageStream);
  end
 else
 if ImageType = 'PNG' then
  begin
   APicture.Graphic := TPNGImage.Create;
   APicture.Graphic.LoadFromStream(ImageStream);
  end
 else
 if ImageType = 'BMP' then
  begin
   APicture.Graphic := TBitmap.Create;
   APicture.Graphic.LoadFromStream(ImageStream);
  end
 else
 if (ImageType = 'WMF') or (ImageType = 'EMF') then
  begin
   APicture.Graphic := TMetafile.Create;
   APicture.Graphic.LoadFromStream(ImageStream);
  end
 else
 if ImageType = 'ICO' then
  begin
   APicture.Graphic := Ticon.Create;
   APicture.Graphic.LoadFromStream(ImageStream);
  end
 else
 if ImageType = 'GIF' then
  begin
   APicture.Graphic := TGIFImage.Create;
   APicture.Graphic.LoadFromStream(ImageStream);
  end
 else
   APicture := nil;

 Result := APicture;

 except
  raise;
 end;
end;


class function TGraphicUtilities.GetImageGraphicClass(
  ImageStream: TMemoryStream): TGraphic;
var
 ImageType: string;
begin
 ImageType := FindImageType(ImageStream);
 ImageStream.Position := 0;

 try
 if (ImageType = 'JPG') or (ImageType = 'JPEG') then
   Result := TJpegImage.Create
 else
 if ImageType = 'PNG' then
   Result := TPNGImage.Create
 else
 if ImageType = 'BMP' then
   Result := TBitmap.Create
 else
 if (ImageType = 'WMF') or (ImageType = 'EMF') then
   Result := TMetafile.Create
 else
 if ImageType = 'ICO' then
  Result := Ticon.Create
 else
 if ImageType = 'GIF' then
  Result := TGIFImage.Create
 else
  Result := nil;

 except
  raise;
 end;
end;

class procedure TGraphicUtilities.LoadPictureFromStream(
  ImageStream: TMemoryStream; APicture: TPicture);
var
 ImageType: string;
begin
 ImageType := FindImageType(ImageStream);
 ImageStream.Position := 0;

 try
 if (ImageType = 'JPG') or (ImageType = 'JPEG') then
  begin
   APicture.Graphic := TJpegImage.Create;
   TJpegImage(APicture.Graphic).LoadFromStream(ImageStream);
  end
 else
 if ImageType = 'PNG' then
  begin
   APicture.Graphic := TPNGImage.Create;
   APicture.Graphic.LoadFromStream(ImageStream);
  end
 else
 if ImageType = 'BMP' then
  begin
   APicture.Graphic := TBitmap.Create;
   APicture.Graphic.LoadFromStream(ImageStream);
  end
 else
 if (ImageType = 'WMF') or (ImageType = 'EMF') then
  begin
   APicture.Graphic := TMetafile.Create;
   APicture.Graphic.LoadFromStream(ImageStream);
  end
 else
 if ImageType = 'ICO' then
  begin
   APicture.Graphic := Ticon.Create;
   APicture.Graphic.LoadFromStream(ImageStream);
  end
 else
 if ImageType = 'GIF' then
  begin
   APicture.Graphic := TGIFImage.Create;
   APicture.Graphic.LoadFromStream(ImageStream);
  end;

 except
  raise;
 end;

end;

end.


