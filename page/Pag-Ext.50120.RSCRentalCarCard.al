/// <summary>
/// PageExtension RSC_RentalCarCard (ID 50120) extends Record Item Card.
/// </summary>
pageextension 50120 "RSC_RentalCarCard" extends "Item Card"
{
    Caption = 'Rental Car';

    layout
    {
        addbefore(Type)
        {
            field("RSC_Mileage"; Rec.RSC_Mileage)
            {
                ApplicationArea = all;
            }
            field("RSC_NumPassengers"; Rec.RSC_NumPassengers)
            {
                ApplicationArea = all;
            }
            field("RSC_RegistrationPlate"; Rec.RSC_RegistrationPlate)
            {
                ApplicationArea = all;
            }
        }
        // modify("Base Unit of Measure")
        // {
        //     Visible = false;
        // }
        // modify(Type)
        // {
        //     Visible = false;
        // }
    }

}
