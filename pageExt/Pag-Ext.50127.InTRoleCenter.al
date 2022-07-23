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
                action(InT_Vendor_Detailed_Aging)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendor Detailed Aging to Excel (T3)';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Report "Vendor Detailed Aging";
                    ToolTip = 'Excel Report';
                }
                action(InT_XMLPort_Export)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'XMLPort Export (T4)';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = xmlport InT_XMLPort_Export;
                    ToolTip = 'XMLPort Export';
                }
                action(InT_SalesOrder_Excel)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Order to Excel (T6)';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Report "InT_Sales Order to Excel";
                    ToolTip = 'Sales Order to Excel';
                }
                action(InT_Inventory_List)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Inventory - List (T8)';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Report "Inventory - List";
                    ToolTip = 'Inventory - List';
                }
                action(InT_XML_File)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'XML r/w File (T12)';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = page "InT_XML_Data_Page";
                    ToolTip = 'XML r/w File';
                }
                action(InT_XML_BLOB)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'XML r/w BLOB (T12)';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = page "InT_Blob_Test_Page";
                    ToolTip = 'XML r/w BLOB';
                }
                action(InT_RSC_Excel)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Excel Import (T13)';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = page "InT_Excel Import";
                    ToolTip = 'Excel Import';
                }
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
                action(InT_Import_Sales_Quote)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Import Sales Quote (AT 2)';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = page "Sales Quote";
                    ToolTip = 'Import Sales Quote';
                }
            }
        }
    }

}
