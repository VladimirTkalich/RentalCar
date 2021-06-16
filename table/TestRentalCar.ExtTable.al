tableextension 50119 TestRentalCar extends Item
{
    fields
    {
        field(50110; BodyType; Code[20])
        {
            Caption = 'Body Type';
            DataClassification = CustomerContent;
        }
        field(50111; CarTransmission; Enum CarTransmission)
        {
            Caption = 'Transmission';
            DataClassification = CustomerContent;
        }
    }
}
