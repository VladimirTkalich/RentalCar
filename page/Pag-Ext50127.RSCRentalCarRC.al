pageextension 50127 "RSC_RentalCarRC" extends "Business Manager Role Center"
{
    Caption = 'Rental Cars';

    actions
    {
        addlast(sections)
        {
            group("RSC_Rental Cars")
            {
                action("RSC_Cars")
                {
                    RunObject = page "Item List"; //tvvRentalCarList;
                    ApplicationArea = All;
                }
                action("RSC_Rental Customers")
                {
                    RunObject = page "Customer List"; //tvvRentalCustomerList;
                    ApplicationArea = All;
                }
                action("RSC_Rental Salespersons")
                {
                    RunObject = page "Salespersons/Purchasers"; //tvvRentalSalespersons;
                    ApplicationArea = All;
                }
                action("RSC_Rental Sales Orders")
                {
                    RunObject = page "RSC_RentalSalesHeaders";
                    ApplicationArea = All;
                }
            }
        }
        addafter(Customer)
        {
            action("RSC_Rental Car")
            {
                AccessByPermission = TableData Customer = IMD;
                ApplicationArea = Basic, Suite;
                Caption = 'Rental Car';
                Image = Item;
                RunObject = Page "Item Card";
                RunPageMode = Create;
                ToolTip = 'Register a new Rental Car.';
            }
            action("RSC_Rental Salesperson")
            {
                AccessByPermission = TableData Customer = IMD;
                ApplicationArea = Basic, Suite;
                Caption = 'Rental Salesperson';
                Image = SalesPerson;
                RunObject = Page "Salesperson/Purchaser Card";
                RunPageMode = Create;
                ToolTip = 'Register a new Rental Salesperson.';
            }
        }

        addafter("Financial Statements")
        {
            group("RSC_Rental Cars Data")
            {
                Caption = 'Rental Cars Data';
                Image = Report2;
                action("RSC_Customer Profit")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customer Profit';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Report "Balance Sheet";
                    ToolTip = 'Customer Profit';
                }
                action("RSC_Car Profit")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Car Profit';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Report "Balance Sheet";
                    ToolTip = 'Car Profit';
                }
                action("RSC_Available Cars")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Available Cars';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Report "Balance Sheet";
                    ToolTip = 'Available Cars';
                }
            }
        }
    }
}
