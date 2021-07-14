pageextension 50122 "RSC_RentalSalespersons" extends "Salespersons/Purchasers"
{
    Caption = 'Rental Salespersons';

    layout
    {
        addafter("Phone No.")
        {
            field("RSC_Cash Monthly Plan"; Rec."RSC_Cash Monthly Plan")
            {
                ApplicationArea = all;
            }
            field("RSC_Cash Monthly Total"; Rec."RSC_Cash Monthly Total")
            {
                ApplicationArea = all;
            }
            field("RSC_Cash Annual Plan"; Rec."RSC_Cash Annual Total")
            {
                ApplicationArea = all;
            }
            field("RSC_Deals Monthly Total"; Rec."RSC_Deals Monthly Total")
            {
                ApplicationArea = all;
            }
            field("RSC_Years of Experience"; Rec."RSC_Years of Experience")
            {
                ApplicationArea = all;
            }
            field("RSC_Rating"; Rec.RSC_Rating)
            {
                ApplicationArea = all;
            }
        }
    }
}
