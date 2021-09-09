/// <summary>
/// PageExtension "RSC_Service_Lines" (ID 50106) extends Record Service Lines.
/// </summary>
pageextension 50106 RSC_Service_Lines extends "Service Lines"
{
    Caption = 'Rental Car Service Lines';
    layout
    {
        // modify("Unit Cost")
        // {
        //     Visible = false;
        // }
        modify("Qty. to Ship")
        {
            Visible = false;
        }
        modify("Quantity Shipped")
        {
            Visible = false;
        }
        modify("Qty. to Invoice")
        {
            Visible = false;
        }
        modify("Quantity Invoiced")
        {
            Visible = false;
        }
        modify("Qty. to Consume")
        {
            Visible = false;
        }
        modify("Quantity Consumed")
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
        modify("Exclude Warranty")
        {
            Visible = false;
        }
        modify("Exclude Contract Discount")
        {
            Visible = false;
        }
        modify(Warranty)
        {
            Visible = false;
        }

    }
}
