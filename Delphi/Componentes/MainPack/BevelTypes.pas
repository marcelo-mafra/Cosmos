unit BevelTypes;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls;

const
  MaxPixelCount = 32768;

  {$IFDEF COMPILER7_UP}

  DEFAULT_SYSCOLOR_MASK = $000000FF;
  {$ELSE}
  DEFAULT_SYSCOLOR_MASK = $80000000;
  {$ENDIF}

type
  {$IFNDEF COMPILER5_UP}
  TAnchorKind = (akLeft, akTop, akRight, akBottom);
  TAnchors = set of TAnchorKind;
  {$ENDIF}
  // Classe de exceção
  EMSException = class(Exception);
  TOnLinkClick = procedure(Sender: TObject; Link: string) of object;
  TOnRegistryChangeKey = procedure(Sender: TObject; RootKey: HKEY; Path: string) of object;
  TLabelDirection = (sdLeftToRight, sdRightToLeft);
  TAngle = 0..360;
  TDirection = (drFromLeft, drFromRight, drFromTop, drFromBottom);
  TJvOutputMode = (omFile, omStream);
  TOnDoneFile = procedure(Sender: TObject; FileName: string; FileSize: Integer; Url: string) of object;
  TOnDoneStream = procedure(Sender: TObject; Stream: TStream; StreamSize: Integer; Url: string) of object;
  TOnProgress = procedure(Sender: TObject; Position: Integer; TotalSize: Integer; Url: string;
    var Continue: Boolean) of object;
  TOnFtpProgress = procedure(Sender: TObject; Position: Integer; Url: string) of object;

  PRGBArray = ^TRGBArray;
  TRGBArray = array [0..MaxPixelCount - 1] of TRGBTriple;
  TBalance = 0..100;
  TVolumeRec = record
    case Byte of
      0:
      (LongVolume: Longint);
      1:
      (LeftVolume,
        RightVolume: Word);
  end;


  TOnError = procedure(Sender: TObject; ErrorMsg: string) of object;
  TWallpaperStyle = (wpTile, wpCenter, wpStretch);
  TTransformationKind = (ttWipeLeft, ttWipeRight, ttWipeUp, ttWipeDown,
    ttTurnLeft, ttTurnRight, ttTurnUp, ttTurnDown,
    ttWipeDownRight, ttWipeDownLeft, ttWipeUpRight, ttWipeUpLeft);
  TJvWaveLocation = (frFile, frResource, frRAM);

  TPopupPosition = (ppNone, ppForm, ppApplication);
  TMSDirMask = (dmFileNameChange, dmDirnameChange, dmAttributesChange, dmSizeChange, dmLastWriteChange,
    dmSecurityChange);
  TMSDirMasks = set of TMSDirMask;
  EMSDirectoryError = class(EMSException);
  TListEvent = procedure(Sender: TObject; Title: string; Handle: THandle) of object;

  TOnPrintProgress = procedure(Sender: TObject; Current, Total: Integer) of object;
  TOnNextPage = procedure(Sender: TObject; PageNumber: Integer) of object;
  TBitmapStyle = (bsNormal, bsCentered, bsStretched);

  TOnOpened = procedure(Sender: TObject; Value: string) of object;
  TOnOpenCanceled = procedure(Sender: TObject) of object;

  TOnKeyFound = procedure(Sender: TObject; Key, Results, OriginalLine: string) of object;
  TParserInfos = TStringList;
  TParserInf = class
    StartTag: string;
    EndTag: string;
    MustBe: Integer;
    TakeText: Integer;
  end;

  const
    CrLf = #13#10;
    Cr = #13;
    Lf = #10;

type
  TGradStyle = (grFilled, grEllipse, grHorizontal, grVertical, grPyramid, grMount);
  TOnDelete = procedure(Sender: TObject; Path: string) of object;
  TOnParent = procedure(Sender: TObject; ParentWindow: THandle) of object;
  TOnImage = procedure(Sender: TObject; Image: TBitmap) of object;
  TOnText = procedure(Sender: TObject; Text: string) of object;
  TMSRestart = (rsLogoff, rsShutdown, rsReboot, rsRestart, rsRebootSystem, rsExitAndExecApp);
  TMSRunOption = (roNoBrowse, roNoDefault, roCalcDirectory, roNoLabel, roNoSeparateMem);
  TMSRunOptions = set of TMSRunOption;
  TMSFileKind = (ftFile, ftPrinter);

  TSHFormatDrive = function(Handle: HWND; Drive, ID, Options: Word): LongInt; stdcall;
  TFormatOption = (shQuickFormat, shFull, shSystemFilesOnly);
  TButtonStyle = (bsAbortRetryIgnore, bsOk, bsOkCancel, bsRetryCancel, bsYesNo, bsYesNoCancel);
  TButtonDisplay = (bdIconExclamation, bdIconWarning, bdIconInformation, bdIconAsterisk,
    bdIconQuestion, bdIconStop, bdIconError, bdIconHand);
  TDefault = (dbButton1, dbButton2, dbButton3, dbButton4);
  TModality = (bmApplModal, bmSystemModal, bmTaskModal);
  TButtonOption = (boDefaultDesktopOnly, boHelp, boRight, boRtlReading, boSetForeground, boTopMost);
  TButtonOptions = set of TButtonOption;
  TButtonResult = (brAbort, brCancel, brIgnore, brNo, brOk, brRetry, brYes);
  TMsgStyle = (msBeep, msIconAsterisk, msIconExclamation, msIconHand, msIconQuestion, msOk);
  TDiskRes = (dsSuccess, dsCancel, dsSkipfile, dsError);
  TDiskStyle = (idfCheckFirst, idfNoBeep, idfNoBrowse, idfNoCompressed, idfNoDetails,
    idfNoForeground, idfNoSkip, idfOemDisk, idfWarnIfSkip);
  TDiskStyles = set of TDiskStyle;
  TDeleteStyle = (idNoBeep, idNoForeground);
  TDeleteStyles = set of TDeleteStyle;
  TOnOk = procedure(Sender: TObject; Password: string; var Accept: Boolean) of object;

  TCoordChanged = procedure(Sender: TObject; Coord: string) of object;
  TNotifyEventParams = procedure(Sender: TObject; params: Pointer) of object;
  TFileInformation = record
    Attributes: DWORD;
    DisplayName: string;
    ExeType: Integer;
    Icon: HICON;
    Location: string;
    TypeName: string;
    SysIconIndex: Integer;
  end;
  TMSAnimations = (anLeftRight, anRightLeft, anRightAndLeft, anLeftVumeter, anRightVumeter);
  TMSAnimation = set of TMSAnimations;
  TDropEvent = procedure(Sender: TObject; Pos: TPoint; Value: TStringList) of object;
  TOnFound = procedure(Sender: TObject; Path: string) of object;
  TOnChangedDir = procedure(Sender: TObject; Directory: string) of object;
  TOnAlarm = procedure(Sender: TObject; Keyword: string) of object;
  TAlarm = record
    Keyword: string;
    DateTime: TDateTime;
  end;

  TFourCC = array [0..3] of Char;

  PAniTag = ^TAniTag;
  TAniTag = packed record
    ckID: TFourCC;
    ckSize: Longint;
  end;

  TAniHeader = record
    dwSizeof: Longint;
    dwFrames: Longint;
    dwSteps: Longint;
    dwCX: Longint;
    dwCY: Longint;
    dwBitCount: Longint;
    dwPlanes: Longint;
    dwJIFRate: Longint;
    dwFlags: Longint;
  end;

  TOnChangeColor = procedure(Sender: TObject; Foreground, Background: TColor) of object;

  TMSLayout = (lTop, lCenter, lBottom);
  TMSBevelStyle = (bsShape, bsLowered, bsRaised);

  TMSFocusChangeEvent = procedure(const ASender: TObject;
    const AFocusControl: TWinControl) of object;

implementation

end.

