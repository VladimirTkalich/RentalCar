pageextension 50126 tvvRentalCustomerCard extends "Customer Card"
{
    Caption = 'Rental Customer';

    layout
    {
        addafter(General)
        {
            group("Additional info")
            {
                field(Discount; Rec.Discount)
                {
                    ApplicationArea = all;
                }
                field("Driver License No"; Rec."Driver License No")
                {
                    ApplicationArea = all;
                }
                field(DriverLicense_IssuingAutority; Rec.DriverLicense_IssuingAutority)
                {
                    ApplicationArea = all;
                }
                field(DriverBirthday; Rec.DriverBirthday)
                {
                    ApplicationArea = all;
                }
                field(DriverAge; Rec.DriverAge) //TODO Make highlighting by red color if age of driver less than 30 and more than 70
                {
                    ApplicationArea = all;
                }
                field("Passport No"; Rec."Passport No")
                {
                    ApplicationArea = all;
                }
                field("Rating for Campaign"; Rec."Rating for Campaign")
                {
                    ApplicationArea = all;
                }
            }
        }

    }
}
