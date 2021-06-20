pageextension 50125 tvvRentalCustomerList extends "Customer List"
{
    Caption = 'Rental Customers';

    layout
    {
        addafter(Name)
        {
            field(Discount; Rec.Discount)
            {
                ApplicationArea = all;
            }
            field(DriverBirthday; Rec.DriverBirthday)
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
