pageextension 50114 "SalesOrderStatistics_TSM" extends "Sales Order Statistics" // 402
{
    layout
    {
        modify("TotalSalesLineLCY[1].Amount")
        {
            Caption = 'Total Sales';
            Importance = Standard;
        }
        modify("TotalSalesLineLCY[1].""Unit Cost (LCY)""")
        {
            Caption = 'Original Cost';
            Importance = Standard;
        }

        addafter("TotalSalesLineLCY[1].""Unit Cost (LCY)""")
        {
            group(VarCosts)
            {
                Caption = 'Variable Costs';
                field(FrtAmt; lFrtCost)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Importance = Additional;
                    Caption = 'Freight Cost';
                }
                field(TotalPK; lTotalPK)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Importance = Additional;
                    Caption = 'Total PK';
                }
                field(TotalSH; lTotalSH)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Importance = Additional;
                    Caption = 'Total SH';
                }
            }
            field(TotVarCost; lTotVarCost)
            {
                ApplicationArea = All;
                Editable = false;
                Caption = 'Total Variable Costs';
            }

            field(TotalCost; lTotalCost)
            {
                ApplicationArea = All;
                Editable = false;
                Importance = Standard;
                Caption = 'Total Costs';
            }
            field(totalprofit; ltotalprofit)
            {
                ApplicationArea = All;
                Editable = false;
                Importance = Standard;
                Caption = 'Total Profit';
            }
            field(totalprofitpct; lTotalProfitPct)
            {
                ApplicationArea = All;
                Editable = false;
                Importance = Standard;
                Caption = 'Total Profit %';
            }
        }
        modify(LineAmountGeneral)
        {
            Importance = Additional;
        }
        modify(InvDiscountAmount_General)
        {
            Importance = Additional;
        }
        modify("TotalAmount1[1]")
        {
            Importance = Additional;
        }
        modify(VATAmount)
        {
            Importance = Additional;
        }
        modify("TotalAmount2[1]")
        {
            Importance = Additional;
        }
        modify("ProfitLCY[1]")
        {
            Importance = Additional;
        }
        modify("AdjProfitLCY[1]")
        {
            Importance = Additional;
        }
        modify("ProfitPct[1]")
        {
            Importance = Additional;
        }
        modify("AdjProfitPct[1]")
        {
            Importance = Additional;
        }
        modify("TotalSalesLine[1].""Units per Parcel""")
        {
            Importance = Additional;
        }
        modify("TotalSalesLine[1].""Net Weight""")
        {
            Importance = Additional;
        }
        modify("TotalSalesLine[1].""Gross Weight""")
        {
            Importance = Additional;
        }
        modify("TotalSalesLine[1].""Unit Volume""")
        {
            Importance = Additional;
        }
        modify("TotalAdjCostLCY[1]")
        {
            Importance = Additional;
        }
        modify("TotalAdjCostLCY[1] - TotalSalesLineLCY[1].""Unit Cost (LCY)""")
        {
            Importance = Additional;
        }
        modify(NoOfVATLines_General)
        {
            Importance = Additional;
        }
    }

    actions
    {
        addfirst(Navigation)
        {
            action(InT_Vendor_Detailed_Aging)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Vendor Detailed Aging to Excel (T3)';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Report "InT_Vendor Detailed Aging";
                ToolTip = 'Excel Report';
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        SalesLine: Record "Sales Line";
        TempSalesLine: Record "Sales Line" temporary;
    begin
        lTotalPK := 0;
        lTotalSH := 0;
        lTotSalesLineCost := 0;
        lTotalCost := 0;
        lFrtCost := "VCost Amt 1";

        SalesLine.Reset();
        SalesLine.SetRange("Document No.", "No.");
        SalesLine.SetRange("Document Type", "Document Type");
        if SalesLine.FindSet(false, false) then
            repeat
                //lTotalPK += SalesLine."Total PKG Cost";
                //lTotalSH += SalesLine."Total S&H Cost";
                lTotalPK += SalesLine."Unit Cost";
                lTotalSH += SalesLine."Total S&H Cost";

                lTotSalesLineCost += Round(SalesLine."Unit Cost (LCY)" * SalesLine.Quantity, 0.0001);
            until SalesLine.Next() = 0;

        lTotVarCost := lFrtCost + lTotalPK + lTotalSH;
        lTotalCost := lTotSalesLineCost + lTotVarCost;
        // TotalProfit := "Total Line Amt Excl. Tax" - TotalCost;

        TempSalesLine.DELETEALL;
        CLEAR(TempSalesLine);
        CLEAR(lSalesPost);
        lSalesPost.GetSalesLines(Rec, TempSalesLine, 0);
        CLEAR(lSalesPost);
        lSalesPost.SumSalesLinesTemp(
            Rec, TempSalesLine, 0, lTotalSalesLine, lTotalSalesLineLCY,
            lVATAmount, lVATAmountText, lProfitLCY, lProfitPct, lTotalAdjCostLCY);

        //Calc Total Profit and Total Profit %
        lTotalProfit := lTotalSalesLineLCY.Amount - lTotalCost;
        if lTotalSalesLineLCY.Amount <> 0 then
            lTotalProfitPct := Round(100 * (1 - (lTotalCost / lTotalSalesLineLCY.Amount)), 0.01)
        else
            lTotalProfitPct := 0;

    end;

    var
        lTotalSH: Decimal;
        lTotalPK: Decimal;
        lFrtCost: Decimal;
        lTotVarCost: Decimal;
        lTotSalesLineCost: Decimal;
        lTotalCost: Decimal;
        ltotalprofit: Decimal;
        lTotalSalesLineLCY: Record "Sales Line";
        lTotalSalesLine: Record "Sales Line";
        lSalesPost: Codeunit "Sales-Post";
        lVATAmountText: Text[30];
        lProfitLCY: Decimal;
        lProfitPct: Decimal;
        lVATAmount: Decimal;
        lTotalAdjCostLCY: Decimal;
        lTotalProfitPct: Decimal;
}