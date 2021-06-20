pageextension 50123 tvvRentalSalespersonCard extends "Salesperson/Purchaser Card"
{
    Caption = 'Rental Salesperson';

    layout
    {
        addafter(Invoicing)
        {
            group("Additional info")
            {
                field("Cash Monthly Plan"; Rec."Cash Monthly Plan")
                {
                    ApplicationArea = all;
                }
                field("Cash Monthly Total"; Rec."Cash Monthly Total") //TODO Change to FlowField with calculation data of posted Rental Orders
                {
                    ApplicationArea = all;
                }
                field("Cash Annual Plan"; Rec."Cash Annual Total")  //TODO Change to FlowField with calculation data of posted Rental Orders
                {
                    ApplicationArea = all;
                }
                field("Deals Monthly Total"; Rec."Deals Monthly Total")  //TODO Change to FlowField with calculation data of posted Rental Orders
                {
                    ApplicationArea = all;
                }
                field("Years of Experience"; Rec."Years of Experience")
                {
                    ApplicationArea = all;
                }
                field(Rating; Rec.Rating) // //TODO Change to FlowField with calculation monthly??? rating 
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}
