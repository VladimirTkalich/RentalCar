tableextension 50101 "InT_CompanyInfo" extends "Company Information"
{
    fields
    {
        field(50100; "InT_Descartes Filename"; Text[30])
        {
            Caption = 'Descartes Filename';
            DataClassification = CustomerContent;
        }
        field(50101; "InT_Federal Register Date"; Date)
        {
            Caption = 'Federal Register Date';
            DataClassification = CustomerContent;
        }
    }
}
