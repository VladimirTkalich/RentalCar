table 50101 "InT_Blob_Test"
{
    Caption = 'Blob_Test';

    fields
    {
        field(1; "No."; Integer)
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
            // AutoIncrement = true;
        }
        field(2; "BLOB"; Blob)
        {
            Caption = 'BLOB File';
            DataClassification = CustomerContent;
            // SubType = Bitmap;
        }
        field(3; "File Name"; Text[50])
        {
            Caption = 'File Name';
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
