table 50122 tvvCarModel //All models of car
{
    Caption = 'Car Body Type';
    DataClassification = CustomerContent;
    LookupPageId = tvvCarModel;
    DrillDownPageId = tvvCarModel;

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
