pageextension 50112 "CompanyInfo" extends "Company Information"
{
    layout
    {
        addafter(Picture)
        {
            field("InT_Descartes Filename"; Rec."InT_Descartes Filename")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Descartes Filename';
                Caption = 'Descartes Filename';
            }
            field("InT_Federal Register Date"; Rec."InT_Federal Register Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Federal Register Date';
                Caption = 'Federal Register Date';
            }
        }
    }
}
