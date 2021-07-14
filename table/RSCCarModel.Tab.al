table 50122 "RSC_CarModel" //All models of car
{
    Caption = 'Car Body Type';
    DataClassification = CustomerContent;
    LookupPageId = RSC_CarModel;
    DrillDownPageId = RSC_CarModel;

    fields
    {
        field(1; "No."; Code[10])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
        }
        field(2; NameModel; Text[20])
        {
            Caption = 'Car Model';
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
