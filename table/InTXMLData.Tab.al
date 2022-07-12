table 50102 "InT_XML_Data"
{
    Caption = 'XML_Data';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; RowID; Integer)
        {
            Caption = 'RowID';
            DataClassification = CustomerContent;
        }
        field(2; FirstName; Text[25])
        {
            Caption = 'FirstName';
            DataClassification = CustomerContent;
        }
        field(3; LastName; Text[25])
        {
            Caption = 'LastName';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; RowID)
        {
            Clustered = true;
        }
    }
}
