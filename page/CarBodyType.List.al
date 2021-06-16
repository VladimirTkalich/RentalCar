page 50122 tvvCarBodyType
{

    ApplicationArea = All;
    Caption = 'Car Body Type';
    PageType = List;
    SourceTable = tvvCarBodyType;
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
                field(CarBodyType; Rec.CarBodyType)
                {
                    ToolTip = 'Specifies the value of the Car Body Type field';
                    ApplicationArea = All;
                }
            }
        }
    }

}
