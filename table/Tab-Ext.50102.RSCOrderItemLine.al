/// <summary>
/// TableExtension "RSC_Order_Item_Line" (ID 50102) extends Record Service Item Line.
/// </summary>
tableextension 50102 RSC_Order_Item_Line extends "Service Item Line"
{
    fields
    {
        field(50100; "RSC_Daily Price"; Decimal)
        {
            Caption = 'Daily Price';
            DataClassification = CustomerContent;
        }
        field(50101; "RSC_Rental Days"; Integer)
        {
            Caption = 'Rental Days';
            DataClassification = CustomerContent;
        }
        field(50102; "RSC_Start Date"; Date)
        {
            Caption = 'Start Date';
            DataClassification = CustomerContent;
        }
        field(50103; "RSC_End Date"; Date)
        {
            Caption = 'End Date';
            DataClassification = CustomerContent;
        }
        field(50104; "RSC_Car Discount %"; Decimal)
        {
            Caption = 'Car Discount %';
            DataClassification = CustomerContent;
        }
        field(50105; "RSC_Line Amount"; Decimal)
        {
            Caption = 'Line Amount';
            DataClassification = CustomerContent;
        }
    }
}
