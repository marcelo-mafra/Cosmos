unit OpenOffice;

interface

uses
   Windows, Messages, SysUtils, Classes, ComObj, Variants;

   type
   TOpenOffice = class
      function Connect: boolean;
      procedure Disconnect;
      function CreateDocument: boolean;
      function OpenDocument(const aFileUrl:string): boolean;
      procedure SaveDocument(const aFileUrl:string);
      procedure InsertText(const aText: String);
   private
      StarOffice: Variant;
      Document: Variant;
      function MakePropertyValue(PropName, PropValue:string):variant;
   end;

implementation


function TOpenOffice.Connect: boolean;
begin
   if VarIsEmpty(StarOffice) then
      StarOffice := CreateOleObject('com.sun.star.ServiceManager');
   Result := not (VarIsEmpty(StarOffice) or VarIsNull(StarOffice));
end;

procedure TOpenOffice.Disconnect;
begin
   StarOffice := Unassigned;
end;

function TOpenOffice.CreateDocument: boolean;
var
   StarDesktop: Variant;
begin
   StarDesktop := StarOffice.createInstance('com.sun.star.frame.Desktop');
   Document := StarDesktop.LoadComponentFromURL(
                  'private:factory/swriter', '_blank', 0,
                  VarArrayCreate([0, -1], varVariant));
   Result := not (VarIsEmpty(Document) or VarIsNull(Document));
end;

function TOpenOffice.MakePropertyValue(PropName, PropValue:string):variant;
var Struct: variant;
begin
    Struct := StarOffice.Bridge_GetStruct('com.sun.star.beans.PropertyValue');
    Struct.Name := PropName;
    Struct.Value := PropValue;
    Result := Struct;
end;


function TOpenOffice.OpenDocument(const aFileUrl:string): boolean;
var
   StarDesktop: Variant;
   VariantArr: variant;
begin
   StarDesktop := StarOffice.CreateInstance('com.sun.star.frame.Desktop');
   VariantArr := VarArrayCreate([0, 0], varVariant);
   VariantArr[0] := MakePropertyValue('FilterName', 'HTML (StarWriter)');
   Document := StarDesktop.LoadComponentFromURL(
                  aFileUrl, '_blank', 0,
                  VariantArr);
   Result := not (VarIsEmpty(Document) or VarIsNull(Document));
end;

procedure TOpenOffice.SaveDocument(const aFileUrl:string);
var
   StarDesktop: Variant;
   VariantArr: variant;
begin
   StarDesktop := StarOffice.createInstance('com.sun.star.frame.Desktop');
   VariantArr := VarArrayCreate([0, 0], varVariant);
   VariantArr[0] := MakePropertyValue('FilterName', 'MS Word 97');
//VariantArr[0] := MakePropertyValue('FilterName', 'Rich Text Format'); ???? ????-?? ??????????? ;-)
   Document.StoreToURL(aFileUrl, VariantArr);
end;


procedure TOpenOffice.InsertText(const aText: String);
var
   oCursor: Variant;
   oText: Variant;
begin
//get document text object
   oText := Document.GetText;
//create cursor
   oCursor := oText.CreateTextCursor;
//set some text properties
   oCursor.SetPropertyValue('CharColor', 255);
   oCursor.SetPropertyValue('CharShadowed', True);
//insert string
   oText.InsertString(oCursor, aText, false);
//insert line break character
   oText.InsertControlCharacter(oCursor, 0, false);
end;

end.
