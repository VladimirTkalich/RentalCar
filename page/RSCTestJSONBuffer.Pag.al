/// <summary>
/// Page RSC_RSC_Test JSON Buffer (ID 50101).
/// </summary>
page 50101 "Test JSON Buffer"
{

    ApplicationArea = All;
    Caption = 'JSON Buffer';
    PageType = List;
    SourceTable = "JSON Buffer";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field';
                    ApplicationArea = All;
                }
                field(Path; Rec.Path)
                {
                    ToolTip = 'Specifies the value of the Path field';
                    ApplicationArea = All;
                }
                field(Depth; Rec.Depth)
                {
                    ToolTip = 'Specifies the value of the Depth field';
                    ApplicationArea = All;
                }
                field(Value; Rec."Value")
                {
                    ToolTip = 'Specifies the value of the Value field';
                    ApplicationArea = All;
                }
                field("Value Type"; Rec."Value Type")
                {
                    ToolTip = 'Specifies the value of the Value Type field';
                    ApplicationArea = All;
                }
                field("Value BLOB"; Rec."Value BLOB")
                {
                    ToolTip = 'Specifies the value of the Value BLOB field';
                    ApplicationArea = All;
                }
                field("Token type"; Rec."Token type")
                {
                    ToolTip = 'Specifies the value of the Token type field';
                    ApplicationArea = All;
                }
            }
        }
    }

}
