page 50103 "InT_Blob_Test_Page"
{
    Caption = 'Blob_Test_Page';
    PageType = List;
    SourceTable = InT_Blob_Test;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(PKEY; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the PKEY field.';
                }
                field(B; Rec.BLOB)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the BLOB field.';
                }
                field("File Name"; Rec."File Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the File Name field.';
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
                Image = Import;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                trigger OnAction()
                var
                    TempBlob: Codeunit "Temp Blob";
                    TestCU: Codeunit InT_XML_Data;
                    InS: InStream;
                    OutS: OutStream;
                begin
                    Rec.Init();
                    TestCU.ImportBlob(TempBlob, Rec."File Name");
                    TempBlob.CreateInStream(InS);
                    Rec.BLOB.CreateOutStream(OutS);
                    CopyStream(OutS, InS);
                    Rec.Modify();

                end;
            }

            action(Export)
            {
                Caption = 'Export';
                Image = Export;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                trigger OnAction()
                var
                    TempBlob: Codeunit "Temp Blob";
                    TestCU: Codeunit InT_XML_Data;
                    InS: InStream;
                    OutS: OutStream;
                begin
                    Rec.CalcFields(BLOB);
                    if Rec.BLOB.HasValue then begin
                        // Message('BLOB has value');
                        Rec.BLOB.CreateInStream(InS);
                        TempBlob.CreateOutStream(OutS);
                        CopyStream(OutS, InS);
                        TestCU.ExportBlob(TempBlob, Rec."File Name");
                    end else
                        Message('BLOB has not value. Please import first');
                end;
            }

            action(ClearTable)
            {
                Caption = 'Clear Table';
                Image = Delete;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = all;
                trigger OnAction()
                var
                    Data: Record InT_Blob_Test;
                begin
                    Data.DeleteAll(true);
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
