page 50102 "InT_Excel Import"
{
    ApplicationArea = All;
    Caption = 'Excel Import';
    PageType = List;
    SourceTable = "InT_Excel Import";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                }
                field("Base Unit of Measure"; Rec."Base Unit of Measure")
                {
                    ToolTip = 'Specifies the value of the Base Unit of Measure field.';
                    ApplicationArea = All;
                }
                field(Type; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type field.';
                    ApplicationArea = All;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ToolTip = 'Specifies the value of the Unit Price field.';
                    ApplicationArea = All;
                }
                field("Etc."; Rec."Etc.")
                {
                    ToolTip = 'Specifies the value of the Etc. field.';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            action(Import)
            {
                Caption = 'Import';
                Image = Excel;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = all;
                trigger OnAction()
                var
                    x: Codeunit "InT_Excel Tools";
                    Buffer: Record "Excel Buffer" temporary;
                    Data: Record "InT_Excel Import";
                    InS: InStream;
                    Filename: Text;
                    Row: Integer;
                    LastRow: Integer;
                // OriginalVal: Integer;
                begin
                    if UploadIntoStream('Select file to import', '', '', Filename, InS) then begin
                        Buffer.OpenBookStream(InS, 'Items');
                        Buffer.ReadSheet();
                        //Message('Total cells %1', Buffer.Count);

                        Buffer.SetRange("Column No.", 1);
                        //Message(Format(Buffer));
                        Buffer.FindLast();
                        LastRow := Buffer."Row No.";
                        Buffer.Reset();
                        Data.Reset();

                        for Row := 2 to LastRow do begin
                            Data.Init();
                            Data."No." := x.GetText(Buffer, 1, Row);
                            Data.Description := x.GetText(Buffer, 2, Row);
                            Data."Base Unit of Measure" := x.GetText(Buffer, 3, Row);
                            // OriginalVal := x.GetTypeOrdinalValue(Buffer, 4, Row);
                            // if OriginalVal <> -1 then
                            //     Data.Type := Enum::"Item Type".FromInteger(OriginalVal);
                            Data.Type := x.GetType(Buffer, 4, Row);
                            Data."Unit Price" := x.GetDecimal(Buffer, 5, Row);
                            Data."Etc." := x.GetText(Buffer, 6, Row);
                            Data.Insert();
                        end;
                    end;
                end;
            }
            action(ClearTable)
            {
                Caption = 'Cleat Table';
                Image = Excel;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = all;
                trigger OnAction()
                var
                    Data: Record "InT_Excel Import";
                begin
                    Data.DeleteAll(true);
                end;
            }

        }
    }
}
