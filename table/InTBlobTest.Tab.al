table 50101 "InT_Blob_Test"
{
    Caption = 'Blob_Test';

    fields
    {
        field(1; PKEY; Integer)
        {
            Caption = 'PKEY';
            DataClassification = CustomerContent;
        }
        field(2; "BLOB"; Blob)
        {
            Caption = 'BLOB';
            DataClassification = CustomerContent;
            SubType = Bitmap;
        }
    }
    keys
    {
        key(PK; PKEY)
        {
            Clustered = true;
        }
    }
}
