tableextension 50104 "RSC_PurchAndPay_Setup" extends "Purchases & Payables Setup"
{
    fields
    {
        field(50100; "RSC_Create Item from Reference"; Boolean)
        {
            Caption = 'Create Item from Cross-reference No.';
            DataClassification = CustomerContent;
            InitValue = true;
        }
    }
}
