pageextension 50126 "RSC_RentalCustomerCard" extends "Customer Card"
{
    Caption = 'Rental Customer';

    layout
    {
        addafter(General)
        {
            group("RSC_Additional info")
            {
                field("RSC_Discount"; Rec.RSC_Discount)
                {
                    ApplicationArea = all;
                }
                field("RSC_Driver License No"; Rec."RSC_Driver License No")
                {
                    ApplicationArea = all;
                }
                field("RSC_DriverLicense_IssuingAutority"; Rec.RSC_DrvLicense_IssuingAutority)
                {
                    ApplicationArea = all;
                }
                field("RSC_DriverBirthday"; Rec.RSC_DriverBirthday)
                {
                    ApplicationArea = all;
                }
                field("RSC_DriverAge"; Rec.RSC_DriverAge) //TODO Make highlighting by red color if age of driver less than 30 and more than 70
                {
                    ApplicationArea = all;
                }
                field("RSC_Passport No"; Rec."RSC_Passport No")
                {
                    ApplicationArea = all;
                }
                field("RSC_Rating for Campaign"; Rec."RSC_Rating for Campaign")
                {
                    ApplicationArea = all;
                }
            }
        }

    }
}
