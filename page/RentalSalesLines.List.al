page 50129 tvvRentalSalesLines
{

    ApplicationArea = All;
    Caption = 'Rental Sales Lines';
    PageType = List;
    SourceTable = tvvRentalSalesLine;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                /*                 field("Order No."; Rec."Order No.")
                                {
                                    ToolTip = 'Specifies the value of the Order No. field';
                                    ApplicationArea = All;
                                }
                 */
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field';
                    ApplicationArea = All;
                }
                field("Car No."; Rec."Car No.")
                {
                    ToolTip = 'Specifies the value of the Car No. field';
                    ApplicationArea = All;
                }
                field("Car Description"; Rec."Car Description")
                {
                    ToolTip = 'Specifies the value of the Car Description field';
                    ApplicationArea = All;
                }
                field("Daily Price"; Rec."Daily Price")
                {
                    ToolTip = 'Specifies the value of the Daily Price field';
                    ApplicationArea = All;
                }
                field("Rental Days"; Rec."Rental Days")
                {
                    ToolTip = 'Specifies the value of the Rental Days field';
                    ApplicationArea = All;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field';
                    ApplicationArea = All;
                }
                /*                 field("Pick up Location"; Rec."Pick up Location")
                                {
                                    ToolTip = 'Specifies the value of the Pick up Location field';
                                    ApplicationArea = All;
                                }
                                field("Drop off Location"; Rec."Drop off Location")
                                {
                                    ToolTip = 'Specifies the value of the Drop off Location field';
                                    ApplicationArea = All;
                                }
                 */
                field("Car Discount %"; Rec."Car Discount %")
                {
                    ToolTip = 'Specifies the value of the Car Discount % field';
                    ApplicationArea = All;
                }
                /*                 field("Age Main Driver"; Rec."Age Main Driver")
                                {
                                    ToolTip = 'Specifies the value of the Age Main Driver field';
                                    ApplicationArea = All;
                                }
                                field("Surcharge for Age Driver"; Rec."Surcharge for Age Driver")
                                {
                                    ToolTip = 'Specifies the value of the Surcharge for Age Driver field';
                                    ApplicationArea = All;
                                }
                                field("Additional Drivers"; Rec."Additional Drivers")
                                {
                                    ToolTip = 'Specifies the value of the Additional Drivers field';
                                    ApplicationArea = All;
                                }
                                field("Surcharge for Add Drivers"; Rec."Surcharge for Add Drivers")
                                {
                                    ToolTip = 'Specifies the value of the Surcharge for Add Drivers field';
                                    ApplicationArea = All;
                                }
                 */
                field(Deposit; Rec.Deposit)
                {
                    ToolTip = 'Specifies the value of the Deposit field';
                    ApplicationArea = All;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ToolTip = 'Specifies the value of the Line Amount field';
                    ApplicationArea = All;
                }
            }
        }
    }

}
