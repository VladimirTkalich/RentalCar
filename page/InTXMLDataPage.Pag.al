page 50104 "InT_XML_Data_Page"
{
    Caption = 'XML_Data_Page';
    PageType = List;
    SourceTable = InT_XML_Data;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(RowID; Rec.RowID)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the RowID field.';
                }
                field(FirstName; Rec.FirstName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the FirstName field.';
                }
                field(LastName; Rec.LastName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the LastName field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ReadXML)
            {
                Caption = 'ReadXML';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                trigger OnAction()
                var
                    Import: Codeunit InT_XML_Data;
                begin
                    Import.Import();
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
                    Data: Record "InT_XML_Data";
                begin
                    Data.DeleteAll(true);
                end;
            }
        }
    }
}
