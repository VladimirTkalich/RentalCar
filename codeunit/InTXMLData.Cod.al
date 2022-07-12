codeunit 50103 "InT_XML_Data"
{
    procedure Import()
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
}
