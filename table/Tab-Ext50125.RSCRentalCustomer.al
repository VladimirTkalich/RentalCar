/// <summary>
/// TableExtension RSC_RentalCustomer (ID 50125) extends Record Customer.
/// </summary>
tableextension 50125 "RSC_RentalCustomer" extends Customer
{
    fields
    {
        field(50100; "RSC_Discount"; Integer)
        {
            Caption = 'Discount';
            DataClassification = CustomerContent;
        }
        field(50101; "RSC_Driver License No"; Text[20])
        {
            Caption = 'Driver License No';
            DataClassification = CustomerContent;
        }
        field(50102; "RSC_DrvLicense_IssuingAutority"; Text[50])
        {
            Caption = 'Driver License Issuing Autority';
            DataClassification = CustomerContent;
        }
        field(50103; "RSC_DriverBirthday"; Date)
        {
            Caption = 'Driver Birthday';
            DataClassification = CustomerContent;
        }
        field(50104; "RSC_DriverAge"; Text[20])
        {
            Caption = 'Driver Age';
            DataClassification = CustomerContent;
            //FieldClass = FlowField;
            //TODO Add calculation the current age of the driver 
        }
        field(50105; "RSC_Passport No"; Text[20])
        {
            Caption = 'Passport No';
            DataClassification = CustomerContent;
        }
        field(50106; "RSC_Rating for Campaign"; Integer)
        {
            Caption = 'Rating for Campaign';
            DataClassification = CustomerContent;
        }
    }
}
