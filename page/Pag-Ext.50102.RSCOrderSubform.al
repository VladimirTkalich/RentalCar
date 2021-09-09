/// <summary>
/// PageExtension "RSC_Order_Subform" (ID 50102) extends Record Service Order Subform.
/// </summary>
pageextension 50102 RSC_Order_Subform extends "Service Order Subform"
{
    layout
    {
        addafter(Description)
        {
            // field("RSC_Daily Price"; Rec."RSC_Daily Price")
            // {
            //     ApplicationArea = all;
            // }
            // field("RSC_Rental Days"; Rec."RSC_Rental Days")
            // {
            //     ApplicationArea = all;
            // }
            // field("RSC_Start Date"; Rec."RSC_Start Date")
            // {
            //     ApplicationArea = all;
            // }
            // field("RSC_End Date"; Rec."RSC_End Date")
            // {
            //     ApplicationArea = all;
            // }
            // field("Car Discount %"; Rec."RSC_Car Discount %")
            // {
            //     ApplicationArea = all;
            // }
            // field("RSC_Line Amount"; Rec."RSC_Line Amount")
            // {
            //     ApplicationArea = all;
            // }
        }
        modify("Item No.")
        {
            Visible = false;
        }
        modify("Service Item Group Code")
        {
            Visible = false;
        }
        modify("Serial No.")
        {
            Visible = false;
        }
        modify("Repair Status Code")
        {
            Visible = false;
        }
        modify(Warranty)
        {
            Visible = false;
        }
        modify("Contract No.")
        {
            Visible = false;
        }
        modify("Fault Code")
        {
            Visible = false;
        }
        modify("Resolution Code")
        {
            Visible = false;
        }
        modify(Priority)
        {
            Visible = false;
        }
        modify("Response Time (Hours)")
        {
            Visible = false;
        }
        modify("Response Date")
        {
            Visible = false;
        }
        modify("Response Time")
        {
            Visible = false;
        }
        modify("Loaner No.")
        {
            Visible = false;
        }
        modify("No. of Previous Services")
        {
            Visible = false;
        }
    }
}
