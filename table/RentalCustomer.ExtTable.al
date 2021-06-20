tableextension 50125 tvvRentalCustomer extends Customer
{
    fields
    {
        field(50100; Discount; Integer)
        {
            Caption = 'Discount';
            DataClassification = CustomerContent;
        }
        field(50101; "Driver License No"; Text[20])
        {
            Caption = 'Driver License No';
            DataClassification = CustomerContent;
        }
        field(50102; DriverLicense_IssuingAutority; Text[50])
        {
            Caption = 'Driver License Issuing Autority';
            DataClassification = CustomerContent;
        }
        field(50103; DriverBirthday; Date)
        {
            Caption = 'Driver Birthday';
            DataClassification = CustomerContent;
        }
        field(50104; DriverAge; Text[20])
        {
            Caption = 'Driver Age';
            FieldClass = FlowField;
            //TODO Add calculation the current age of the driver 
        }
        field(50105; "Passport No"; Text[20])
        {
            Caption = 'Passport No';
            DataClassification = CustomerContent;
        }
        field(50106; "Rating for Campaign"; Integer)
        {
            Caption = 'Rating for Campaign';
            DataClassification = CustomerContent;
        }
    }
}
