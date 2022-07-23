pageextension 50101 "InT_SalesQuote" extends "Sales Quote"
{
    actions
    {
        addfirst(reporting)
        {
            action(InT_ImportSalesQuote)
            {
                ApplicationArea = All;
                Caption = 'Import Sales Quote (AT 2)';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                //RunObject = Report "InT_ImportSalesQuote";
                ToolTip = 'Import Sales Quote';

                trigger OnAction()
                var
                    Rep: Report "InT_ImportSalesQuote";
                begin
                    Rep.SetSalesHeaderNo(Rec."No.");
                    Rep.RunModal();

                    // Rec.Reset();
                    // Rec.SetRange(Rec."No.", Rec."No.");
                    // Report.Run(report::InT_ImportSalesQuote, true, false, Rec);
                end;
            }
        }
    }
}
