/// <summary>
/// PageExtension "RSC_Item_Worksheet" (ID 50104) extends Record Service Item Worksheet.
/// </summary>
pageextension 50104 RSC_Item_Worksheet extends "Service Item Worksheet"
{
    Caption = 'Rental Car Service Item Worksheet';
    layout
    {
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
        modify("Fault Reason Code")
        {
            Visible = false;
        }
        modify("Loaner No.")
        {
            Visible = false;
        }
        modify("Service Shelf No.")
        {
            Visible = false;
        }
        modify("Fault Area Code")
        {
            Visible = false;
        }
        modify("Symptom Code")
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
        modify("Repair Status Code")
        {
            Visible = false;
        }

    }
}
