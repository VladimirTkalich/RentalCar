page 50103 "InT_Blob_Test_Page"
{
    Caption = 'Blob_Test_Page';
    PageType = Card;
    SourceTable = InT_Blob_Test;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(PKEY; Rec.PKEY)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the PKEY field.';
                }
                field(B; Rec.BLOB)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the BLOB field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Import)
            {
                Caption = 'Import';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                trigger OnAction()
                var
                    InS: InStream;
                    OutS: OutStream;
                    Filename: Text;
                begin
                    if UploadIntoStream('Select file to import', '', '', Filename, InS) then begin
                        TempBlob.CreateOutStream(OutS);
                        CopyStream(OutS, InS);


                        Rec.CalcFields(BLOB);
                        Rec.BLOB.CreateOutStream(OutS);
                        TempBlob.CreateInStream(InS);
                        CopyStream(OutS, InS);
                    end;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        if Rec.IsEmpty then
            Rec.Insert();
    end;

    var
        TempBlob: Codeunit "Temp Blob";
        BlobList: Codeunit "Temp Blob List";


}
