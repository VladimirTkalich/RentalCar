pageextension 50107 "RSC_PurchAndPay_Setup" extends "Purchases & Payables Setup"
{
    layout
    {
        addafter("Create Item from Item No.")
        {
            field("RSC_Create Item from Reference No."; Rec."RSC_Create Item from Reference")
            {
                Caption = 'Create Item from Reference No.';
                ApplicationArea = all;
            }
        }
    }
}
