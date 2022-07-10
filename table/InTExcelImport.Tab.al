table 50100 "InT_Excel Import"
{
    Caption = 'Excel Import';

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; "Base Unit of Measure"; Code[20])
        {
            Caption = 'Base Unit of Measure';
            DataClassification = CustomerContent;
        }
        field(4; Type; Enum "Item Type")
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
        }
        field(5; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';
            DataClassification = CustomerContent;
        }
        field(6; "Etc."; Code[20])
        {
            Caption = 'Etc.';
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
