tableextension 50121 "RSC_RentalSalesperson" extends "Salesperson/Purchaser"
{
    fields
    {
        field(50100; "RSC_Cash Monthly Plan"; Decimal)
        {
            Caption = 'Cash Monthly Plan';
            DataClassification = CustomerContent;
        }
        field(50101; "RSC_Cash Monthly Total"; Decimal)
        {
            Caption = 'Cash Monthly Total';
            DataClassification = CustomerContent;
        }
        field(50102; "RSC_Cash Annual Total"; Decimal)
        {
            Caption = 'Cash Annual Total';
            DataClassification = CustomerContent;
        }
        field(50103; "RSC_Deals Monthly Total"; Integer)
        {
            Caption = 'Deals Monthly Total';
            DataClassification = CustomerContent;
        }
        field(50104; "RSC_Years of Experience"; Integer)
        {
            Caption = 'Years of Experience';
            DataClassification = CustomerContent;
        }
        field(50105; "RSC_Rating"; Integer)
        {
            Caption = 'Rating';
            DataClassification = CustomerContent;
        }
    }
}
