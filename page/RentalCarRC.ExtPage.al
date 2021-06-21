pageextension 50127 RentalCarRC extends "Business Manager Role Center"
{
    Caption = 'Rental Cars';

    actions
    {
        addlast(sections)
        {
            group("Rental Cars")
            {
                action("Cars")
                {
                    RunObject = page "Item List"; //tvvRentalCarList;
                    ApplicationArea = All;
                }
                action("Rental Customers")
                {
                    RunObject = page "Customer List"; //tvvRentalCustomerList;
                    ApplicationArea = All;
                }
                action("Rental Salespersons")
                {
                    RunObject = page "Salespersons/Purchasers"; //tvvRentalSalespersons;
                    ApplicationArea = All;
                }
            }
        }
        addafter(Customer)
        {
            action("Rental Car")
            {
                AccessByPermission = TableData Customer = IMD;
                ApplicationArea = Basic, Suite;
                Caption = 'Rental Car';
                Image = Item;
                RunObject = Page "Item Card";
                RunPageMode = Create;
                ToolTip = 'Register a new Rental Car.';
            }
            action("Rental Salesperson")
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
            group("Rental Cars Data")
            {
                Caption = 'Rental Cars Data';
                Image = Report2;
                action("Customer Profit")
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
                action("Car Profit")
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
                action("Available Cars")
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
