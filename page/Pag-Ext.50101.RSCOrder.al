/// <summary>
/// PageExtension "RSC_Order" (ID 50101) extends Record Service Order.
/// </summary>
pageextension 50101 RSC_Order extends "Service Order"
{
    Caption = 'Rental Cars Service Order';

    layout
    {
        modify("Response Date")
        {
            Visible = false;
        }
        modify("Response Time")
        {
            Visible = false;
        }
        modify(Priority)
        {
            Visible = false;
        }
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Assigned User ID")
        {
            Visible = false;
        }

        modify(Details) //Hide group Details
        {
            Visible = false;
        }

        modify("Location Code")
        {
            Visible = false;
        }
        modify("Shipping Advice")
        {
            Visible = false;
        }
        modify("Shipment Method Code")
        {
            Visible = false;
        }
        modify("Shipping Agent Code")
        {
            Visible = false;
        }
        modify("Shipping Agent Service Code")
        {
            Visible = false;
        }
        modify("Shipping Time")
        {
            Visible = false;
        }
    }
}
