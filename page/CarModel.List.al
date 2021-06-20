page 50122 tvvCarModel
{

    ApplicationArea = All;
    Caption = 'Car Models';
    PageType = List;
    SourceTable = tvvCarModel;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field';
                    ApplicationArea = All;
                }
                field(NameModel; Rec.NameModel)
                {
                    ToolTip = 'Specifies the value of the NameModel field';
                    ApplicationArea = All;
                }
            }
        }
    }

}
