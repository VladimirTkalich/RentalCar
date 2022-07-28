report 50103 "Int_Sales_Statistics"
{
    Caption = 'Int_Sales_Statistics';
    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            RequestFilterFields = "No.";
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }


    var
        VATAmountText: array[3] of Text[30];
        ProfitLCY: array[3] of Decimal;
        ProfitPct: array[3] of Decimal;
        TotalAdjCostLCY: array[3] of Decimal;
        i: Integer;


    protected var
        TotalSalesLine: array[3] of Record "Sales Line";
        TotalSalesLineLCY: array[3] of Record "Sales Line";
        SalesPost: Codeunit "Sales-Post";
        TotalAmount1: array[3] of Decimal;
        TotalAmount2: array[3] of Decimal;
        VATAmount: array[3] of Decimal;

        StatQuantity: Integer;

    procedure RefreshOnAfterGetRecord()
    var
        SalesLine: Record "Sales Line";
        TempSalesLine: Record "Sales Line" temporary;
    begin
        i := 1;
        SalesPost.SumSalesLinesTemp(
          "Sales Header", TempSalesLine, i - 1, TotalSalesLine[i], TotalSalesLineLCY[i], VATAmount[i], VATAmountText[i], ProfitLCY[i], ProfitPct[i], TotalAdjCostLCY[i], false);
    end;
}
