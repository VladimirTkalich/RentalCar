tableextension 50121 tvvRentalSalesperson extends "Salesperson/Purchaser"
{
    fields
    {
        field(50100; "Cash Monthly Plan"; Decimal)
        {
            Caption = 'Cash Monthly Plan';
            DataClassification = CustomerContent;
        }
        field(50101; "Cash Monthly Total"; Decimal)
        {
            Caption = 'Cash Monthly Total';
            DataClassification = CustomerContent;
        }
        field(50102; "Cash Annual Total"; Decimal)
        {
            Caption = 'Cash Annual Total';
            DataClassification = CustomerContent;
        }
        field(50103; "Deals Monthly Total"; Integer)
        {
            Caption = 'Deals Monthly Total';
            DataClassification = CustomerContent;
        }
        field(50104; "Years of Experience"; Integer)
        {
            Caption = 'Years of Experience';
            DataClassification = CustomerContent;
        }
        field(50105; Rating; Integer)
        {
            Caption = 'Rating';
            DataClassification = CustomerContent;
        }
    }
}
