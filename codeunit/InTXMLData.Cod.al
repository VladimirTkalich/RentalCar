codeunit 50103 "InT_XML_Data"
{
    procedure ImportFromFile()
    var
        Data: Record InT_XML_Data;
        InS: InStream;
        Filename: Text;
        XmlDoc: XmlDocument;
        Root: XmlElement;
        Records: XmlNodeList;
        Node: XmlNode;
        e: XmlElement;
    begin
        if UploadIntoStream('Import XML', '', '', Filename, InS) then begin
            if XmlDocument.ReadFrom(InS, XmlDoc) then begin
                XmlDoc.GetRoot(Root);
                Records := Root.GetChildElements('Record');
                foreach Node in Records do begin
                    e := Node.AsXmlElement();
                    Data.Init();
                    Data.RowID := GetInteger(e, 'RowID');
                    Data.Insert(true);
                    Data.Validate(FirstName, GetText(e, 'FirstName'));
                    Data.Validate(LastName, GetText(e, 'LastName'));
                    Data.Modify(true);
                end;
            end else
                Error('Cannot parse XML');
        end;
    end;

    local procedure GetText(e: XmlElement; Name: Text): Text
    var
        FieldNode: XmlNode;
    begin
        foreach FieldNode in e.GetChildElements(Name) do
            exit(FieldNode.AsXmlElement().InnerText);
    end;

    local procedure GetInteger(e: XmlElement; Name: Text): Integer
    var
        FieldNode: XmlNode;
        val: Integer;
    begin
        foreach FieldNode in e.GetChildElements(Name) do
            if Evaluate(val, FieldNode.AsXmlElement().InnerText, 9) then
                exit(val);
    end;

    procedure ExportToFile()
    var
        Data: Record InT_XML_Data;
        xmlDoc: XmlDocument;
        xmlDec: XmlDeclaration;
        Root: XmlElement;
        Parent: XmlElement;
        Child: XmlElement;
        TempBlob: Codeunit "Temp Blob";
        outStr: OutStream;
        inStr: InStream;
        fileName: Text;
    begin
        xmlDoc := xmlDocument.Create();
        xmlDec := xmlDeclaration.Create('1.0', 'UTF-8', 'no');
        xmlDoc.SetDeclaration(xmlDec);

        Root := xmlElement.Create('XML_Data');
        Root.SetAttribute('release', '1.1');

        Data.FindFirst();
        repeat begin
            Parent := XmlElement.Create('Record');
            Child := XmlElement.Create('RowID');
            Child.Add(XmlText.Create(Format(Data.RowID)));
            Parent.Add(Child);
            Child := XmlElement.Create('FirstName');
            Child.Add(XmlText.Create(Data.FirstName));
            Parent.Add(Child);
            Child := XmlElement.Create('LastName');
            Child.Add(XmlText.Create(Data.LastName));
            Parent.Add(Child);
            Root.Add(Parent);
        end;
        until Data.Next() = 0;

        xmlDoc.Add(Root);

        // Create an outStream from the Blob, notice the encoding.
        TempBlob.CreateOutStream(outStr, TextEncoding::UTF8);

        // Write the contents of the doc to the stream
        xmlDoc.WriteTo(outStr);

        // From the same Blob, that now contains the XML document, create an inStr
        TempBlob.CreateInStream(inStr, TextEncoding::UTF8);

        // Save the data of the InStream as a file.
        File.DownloadFromStream(inStr, 'Export', '', '', fileName);
    end;

    procedure ImportBlob(var TBlob: Codeunit "Temp Blob"; var Fieldname: Text)
    var
        FileMgmt: Codeunit "File Management";
        FileName: Text;
    begin
        Fieldname := FileMgmt.BLOBImport(TBlob, FileName);
    end;

    procedure ExportBlob(var TBlob: Codeunit "Temp Blob"; var Fieldname: Text)
    var
        FileMgmt: Codeunit "File Management";
    begin
        FileMgmt.BLOBExport(TBlob, FieldName, true);
    end;
}
