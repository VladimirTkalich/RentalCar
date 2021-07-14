pageextension 50125 "RSC_RentalCustomerList" extends "Customer List"
{
    Caption = 'Rental Customers';

    layout
    {
        addafter(Name)
        {
            field("RSC_Discount"; Rec.RSC_Discount)
            {
                ApplicationArea = all;
            }
            field("RSC_DriverBirthday"; Rec.RSC_DriverBirthday)
            {
                ApplicationArea = all;
            }
        }
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Location Code")
        {
            Visible = false;
        }
    }

    //TODO Add to factbox the Age of Driver with highlighting by red color if age of driver less than 30 and more than 70
}
