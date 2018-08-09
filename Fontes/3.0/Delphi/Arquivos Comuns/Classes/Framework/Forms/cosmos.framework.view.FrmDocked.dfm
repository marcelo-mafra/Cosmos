object FrmCosmosDocked: TFrmCosmosDocked
  Left = 0
  Top = 0
  Caption = 'FrmCosmosDocked'
  ClientHeight = 311
  ClientWidth = 437
  Color = clBtnFace
  DragKind = dkDock
  DragMode = dmAutomatic
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  ShowHint = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ImageList1: TImageList
    Height = 18
    Width = 18
    Left = 88
    Top = 8
  end
  object ActionList1: TActionList
    Images = ImageList1
    Left = 56
    Top = 8
  end
end
