pageextension 50123 "RSC_RentalSalespersonCard" extends "Salesperson/Purchaser Card"
{
    Caption = 'Rental Salesperson';

    layout
    {
        addafter(Invoicing)
        {
            group("RSC_Additional info")
            {
                field("RSC_Cash Monthly Plan"; Rec."RSC_Cash Monthly Plan")
                {
                    ApplicationArea = all;
                }
                field("RSC_Cash Monthly Total"; Rec."RSC_Cash Monthly Total") //TODO Change to FlowField with calculation data of posted Rental Orders
                {
                    ApplicationArea = all;
                }
                field("RSC_Cash Annual Plan"; Rec."RSC_Cash Annual Total")  //TODO Change to FlowField with calculation data of posted Rental Orders
                {
                    ApplicationArea = all;
                }
                field("RSC_Deals Monthly Total"; Rec."RSC_Deals Monthly Total")  //TODO Change to FlowField with calculation data of posted Rental Orders
                {
                    ApplicationArea = all;
                }
                field("RSC_Years of Experience"; Rec."RSC_Years of Experience")
                {
                    ApplicationArea = all;
                }
                field("RSC_Rating"; Rec.RSC_Rating) // //TODO Change to FlowField with calculation monthly??? rating 
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}
