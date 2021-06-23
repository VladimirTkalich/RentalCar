page 50122 tvvCarModel
{
    //TODO The table for names of car's models. For uniform writing model names 

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
