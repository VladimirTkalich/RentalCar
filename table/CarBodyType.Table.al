table 50122 tvvCarBodyType
{
    Caption = 'Car Body Type';
    DataClassification = CustomerContent;
    LookupPageId = tvvCarBodyType;
    DrillDownPageId = tvvCarBodyType;

    fields
    {
        field(1; "No."; Code[10])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
        }
        field(2; CarBodyType; Text[20])
        {
            Caption = 'Car Body Type';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

}
