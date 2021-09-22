/// <summary>
/// PageExtension RSC_Role_Center (ID 50127) extends Record Business Manager Role Center.
/// </summary>
pageextension 50127 "RSC_Role_Center" extends "Service Dispatcher Role Center" //"Business Manager Role Center"
{
    Caption = 'Rental Cars';

    actions
    {
        addlast(sections)
        {
            group("RSC_Rental_Cars")
            {
                action("RSC_Rental Cars")
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
                action("RSC_Rental Cars Report")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Rental Cars Report';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Report RSC_Cars;
                    ToolTip = 'Available Cars';
                }
                action("RSC_Rental Cars RDLC")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Rental Cars RDLC';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Report RSC_Cars_RDLC;
                    ToolTip = 'Available Cars RDLC';
                }
                action("RSC_Excel")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Excel Report';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Report RSC_Service_Order_Excel;
                    ToolTip = 'Excel Report';

                }
            }
        }

        addafter("Tasks")
        {
            group("RSC_Rental Cars Reports")
            {
                Caption = 'Rental Cars Reports';
                Image = Report2;
                // action("RSC_Available Cars")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Available Cars';
                //     Image = "Report";
                //     Promoted = true;
                //     PromotedCategory = "Report";
                //     PromotedIsBig = true;
                //     RunObject = Report "Balance Sheet";
                //     ToolTip = 'Available Cars';
                // }
            }
        }
        // addafter(Customer)
        // {
        //     action("RSC_Rental Car")
        //     {
        //         AccessByPermission = TableData Customer = IMD;
        //         ApplicationArea = Basic, Suite;
        //         Caption = 'Rental Car';
        //         Image = Item;
        //         RunObject = Page "Item Card";
        //         RunPageMode = Create;
        //         ToolTip = 'Register a new Rental Car.';
        //     }
        //     action("RSC_Rental Salesperson")
        //     {
        //         AccessByPermission = TableData Customer = IMD;
        //         ApplicationArea = Basic, Suite;
        //         Caption = 'Rental Salesperson';
        //         Image = SalesPerson;
        //         RunObject = Page "Salesperson/Purchaser Card";
        //         RunPageMode = Create;
        //         ToolTip = 'Register a new Rental Salesperson.';
        //     }
        // }

        // addafter("Financial Statements")
        // {
        //     group("RSC_Rental Cars Data")
        //     {
        //         Caption = 'Rental Cars Data';
        //         Image = Report2;
        //         action("RSC_Customer Profit")
        //         {
        //             ApplicationArea = Basic, Suite;
        //             Caption = 'Customer Profit';
        //             Image = "Report";
        //             Promoted = true;
        //             PromotedCategory = "Report";
        //             PromotedIsBig = true;
        //             RunObject = Report "Balance Sheet";
        //             ToolTip = 'Customer Profit';
        //         }
        //         action("RSC_Car Profit")
        //         {
        //             ApplicationArea = Basic, Suite;
        //             Caption = 'Car Profit';
        //             Image = "Report";
        //             Promoted = true;
        //             PromotedCategory = "Report";
        //             PromotedIsBig = true;
        //             RunObject = Report "Balance Sheet";
        //             ToolTip = 'Car Profit';
        //         }
        //         action("RSC_Available Cars")
        //         {
        //             ApplicationArea = Basic, Suite;
        //             Caption = 'Available Cars';
        //             Image = "Report";
        //             Promoted = true;
        //             PromotedCategory = "Report";
        //             PromotedIsBig = true;
        //             RunObject = Report "Balance Sheet";
        //             ToolTip = 'Available Cars';
        //         }
        //     }
        // }
    }
}
