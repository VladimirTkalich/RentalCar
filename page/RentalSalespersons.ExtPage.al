pageextension 50122 tvvRentalSalespersons extends "Salespersons/Purchasers"
{
    Caption = 'Rental Salespersons';

    layout
    {
        addafter("Phone No.")
        {
            field("Cash Monthly Plan"; Rec."Cash Monthly Plan")
            {
                ApplicationArea = all;
            }
            field("Cash Monthly Total"; Rec."Cash Monthly Total")
            {
                ApplicationArea = all;
            }
            field("Cash Annual Plan"; Rec."Cash Annual Total")
            {
                ApplicationArea = all;
            }
            field("Deals Monthly Total"; Rec."Deals Monthly Total")
            {
                ApplicationArea = all;
            }
            field("Years of Experience"; Rec."Years of Experience")
            {
                ApplicationArea = all;
            }
            field(Rating; Rec.Rating)
            {
                ApplicationArea = all;
            }
        }
    }
}
