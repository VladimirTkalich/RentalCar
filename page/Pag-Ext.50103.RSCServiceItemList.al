/// <summary>
/// PageExtension "RSC_Service_Item_List" (ID 50103) extends Record Service Item List.
/// </summary>
pageextension 50103 RSC_Service_Item_List extends "Service Item List"
{
    Caption = 'Rental Cars Service Items';

    layout
    {
        modify("Item No.")
        {
            Visible = false;
        }
        modify("Item Description")
        {
            Visible = false;
        }
        modify("Serial No.")
        {
            Visible = false;
        }
        modify("Warranty Starting Date (Parts)")
        {
            Visible = false;
        }
        modify("Warranty Ending Date (Parts)")
        {
            Visible = false;
        }
        modify("Warranty Starting Date (Labor)")
        {
            Visible = false;
        }
        modify("Warranty Ending Date (Labor)")
        {
            Visible = false;
        }
        modify("Search Description")
        {
            Visible = false;
        }

    }
}
