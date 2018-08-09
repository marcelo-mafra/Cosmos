program Project1;

{%TogetherDiagram 'ModelSupport_Project1\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_Project1\Unit1\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_Project1\Project1\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_Project1\default.txvpck'}
{%TogetherDiagram 'ModelSupport_Project1\Project1\default.txvpck'}
{%TogetherDiagram 'ModelSupport_Project1\Project1\CorePack\default.txaPackage'}
{%TogetherDiagram 'ModelSupport_Project1\Project1\CorePack\default.txvpck'}
{%TogetherDiagram 'ModelSupport_Project1\Project1\CorePack\ClassDiagram.txvcls'}
{%TogetherDiagram 'ModelSupport_Project1\Project1\ClassDiagram.txvcls'}

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  Project1.CorePack in 'Project1.CorePack.pas';

type
  IReglib = interface
  end;

  ICosmosLogin = interface
  end;

  IFBServ = interface
  end;

  Tfbserv = class(TInterfacedObject, IFBServ)
  end;

  IReg = interface
  end;

  TReg = class(TInterfacedObject, IReg)
  end;

  ISecretarias = interface
  end;

  TRDMSecretarias = class(TInterfacedObject, ISecretarias)
  end;

  TMarcelo = class
  public
    constructor Create;
  end;

{$R *.res}
constructor TMarcelo.Create;
begin
	inherited Create;
end;

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
