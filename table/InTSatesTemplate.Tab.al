table 50103 "InT_Sates_Template"
{
    Caption = 'Sales Header Template';
    DataCaptionFields = InT_Template_Code;
    LookupPageID = InT_Sales_Tepl_List;
    DataClassification = ToBeClassified;

    fields
    {
        field(1; InT_Template_Code; Code[20])
        {
            Caption = 'Template Code';
            DataClassification = CustomerContent;
        }
        field(2; InT_Template_Description; Text[100])
        {
            Caption = 'Template Description';
            DataClassification = CustomerContent;
        }
        field(3; "Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code';
            TableRelation = "Payment Terms";
        }
        field(4; "Tax Area Code"; Code[20])
        {
            Caption = 'Tax Area Code';
            TableRelation = "Tax Area";
        }
    }
    keys
    {
        key(PK; InT_Template_Code)
        {
            Clustered = true;
        }
    }
}
