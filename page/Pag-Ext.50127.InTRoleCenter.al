/// <summary>
/// PageExtension InT_InT_InT_RSC_InT_Role_Center (ID 50127) extends Record Business Manager Role Center.
/// </summary>
pageextension 50127 "InT_Role_Center" extends "Business Manager Role Center" //"Service Dispatcher Role Center" //
{
    Caption = 'Intern''s Tasks';

    actions
    {
        addfirst(sections)
        {
            group("Intern's Tasks")
            {
                action("InT_Excel Export")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Excel Export (T14)';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Report InT_Excel_Export;
                    ToolTip = 'Excel Export';

                }
                action(InT_RSC_Excel)
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
                action(InT_SalesOrder_Excel)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Order to Excel';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Report "Sales Order to Excel";
                    ToolTip = 'Excel Report';

                }
                // action("InT_RSC_Rental Cars")
                // {
                //     RunObject = page "Item List"; //tvvRentalCarList;
                //     ApplicationArea = All;
                // }
            }
        }
    }

}
