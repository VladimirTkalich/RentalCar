page 50106 "InT_Sales_Templ_Card"
{
    Caption = 'Sales Template Card';
    PageType = Card;
    SourceTable = InT_Sates_Template;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Template Code"; Rec.InT_Template_Code)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Template Code field.';
                }
                field("Template Description"; Rec.InT_Template_Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Template Description field.';
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies a formula that calculates the payment due date, payment discount date, and payment discount amount.';
                }
                field("Tax Area Code"; Rec."Tax Area Code")
                {
                    ApplicationArea = SalesTax;
                    ToolTip = 'Specifies the tax area that is used to calculate and post sales tax.';

                }
            }
        }
    }
}