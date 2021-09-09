/// <summary>
/// PageExtension RSC_Item_Worksheet_Subform (ID 50105) extends Record Service Item Worksheet Subform.
/// </summary>
pageextension 50105 RSC_Item_Worksheet_Subform extends "Service Item Worksheet Subform"
{
    layout
    {
        modify("Fault Reason Code")
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
