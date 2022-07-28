Report 50106 "Vendor Detailed Aging"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
            {
                DataItemLink = "Vendor No." = field("No."), "Global Dimension 2 Code" = field("Global Dimension 2 Filter"), "Global Dimension 1 Code" = field("Global Dimension 1 Filter"), "Currency Code" = field("Currency Filter"), "Date Filter" = field("Date Filter");
                DataItemTableView = sorting("Vendor No.", "Posting Date", "Currency Code");
                RequestFilterFields = "Vendor Posting Group";

                trigger OnPreDataItem();
                begin
                    if OnlyOpen then begin
                        SetRange(Open, true);
                        SetRange("Posting Date", 0D, EndDate);
                    end else
                        SetRange("Posting Date", 0D, EndDate);

                    Counter := 0;
                end;

                trigger OnAfterGetRecord();
                begin
                    if "Due Date" = 0D then
                        OverDueDays := 0
                    else
                        OverDueDays := EndDate - "Due Date";
                    SetRange("Date Filter", 0D, EndDate);
                    CalcFields("Remaining Amount", "Remaining Amt. (LCY)");
                    if "Remaining Amount" = 0 then
                        CurrReport.Skip;

                    if "Currency Code" = '' then begin
                        CurrCode := GLSetup."LCY Code";
                    end else begin
                        CurrCode := "Currency Code";
                    end;
                    CurrencyTotalBuffer.UpdateTotal(
                      "Currency Code", "Remaining Amount", "Remaining Amt. (LCY)", Counter);

                    MakeVendorLedgerEntryLine();
                end;
            }
            dataitem(Integer; Integer)
            {
                DataItemTableView = sorting(Number) where(Number = filter(1 ..));
                trigger OnAfterGetRecord();
                begin
                    if Number = 1 then
                        OK := CurrencyTotalBuffer.Find('-')
                    else
                        OK := CurrencyTotalBuffer.Next <> 0;
                    if not OK then
                        CurrReport.Break;
                    CurrencyTotalBuffer2.UpdateTotal(
                      CurrencyTotalBuffer."Currency Code",
                      CurrencyTotalBuffer."Total Amount",
                      CurrencyTotalBuffer."Total Amount (LCY)", Counter1);

                    MakeInteger1_Line();
                end;

                trigger OnPostDataItem();
                begin
                    CurrencyTotalBuffer.DeleteAll;
                end;

            }
            trigger OnAfterGetRecord()
            begin
                // MakeVendorLedgerEntryLine()
            end;

            trigger OnPreDataItem()
            begin
                MakeVendorHeader();
            end;

            trigger OnPostDataItem()
            begin
                // CreateExcelbook(SheetLbl);
            end;
        }
        dataitem(Integer2; Integer)
        {
            DataItemTableView = sorting(Number) where(Number = filter(1 ..));
            trigger OnAfterGetRecord();
            begin
                if Number = 1 then
                    OK := CurrencyTotalBuffer2.Find('-')
                else
                    OK := CurrencyTotalBuffer2.Next <> 0;
                if not OK then
                    CurrReport.Break;

                MakeInteger2_Line();
            end;

            trigger OnPostDataItem();
            begin
                CurrencyTotalBuffer2.DeleteAll;
                CreateExcelbook(SheetLbl);
            end;

        }

    }

    requestpage
    {

        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field("Ending Date"; EndDate)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Ending Date';
                    }
                    field(OnlyOpen; OnlyOpen)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Show Open Entries Only';
                    }
                }
            }
        }
    }

    trigger OnInitReport()
    begin
        GLSetup.Get;
    end;

    trigger OnPreReport()
    begin
        CompanyInformation.Get();
        MakeExcelInfo();
    end;

    trigger OnPostReport()
    begin
        ReadExcelbook();
    end;


    var
        CompanyInformation: Record "Company Information";
        TempExcelBufTemp: Record "Excel Buffer" temporary;
        GLSetup: Record "General Ledger Setup";
        CurrencyTotalBuffer: Record "Currency Total Buffer" temporary;
        CurrencyTotalBuffer2: Record "Currency Total Buffer" temporary;
        SheetLbl: Label 'Carrier - Parts disease. list';
        SettingsLbl: Label 'Settings';
        CaptionExelBookLbl: label 'Vendor Detailed Aging';
        EndDate: Date;
        OnlyOpen: Boolean;
        OK: Boolean;
        OverDueDays: Integer;
        Counter: Integer;
        Counter1: Integer;
        CurrCode: Code[10];





    local procedure CreateExcelbook(SheetName: Text[250])
    begin
        TempExcelBufTemp.CreateNewBook(SheetName);
        TempExcelBufTemp.SetFriendlyFilename(CaptionExelBookLbl);

        TempExcelBufTemp.SetColumnWidth('A', 10);
        TempExcelBufTemp.SetColumnWidth('B', 23);
        TempExcelBufTemp.SetColumnWidth('C', 14);
        TempExcelBufTemp.SetColumnWidth('D', 15);
        TempExcelBufTemp.SetColumnWidth('E', 15);
        TempExcelBufTemp.SetColumnWidth('F', 12);
        TempExcelBufTemp.SetColumnWidth('G', 12);
        TempExcelBufTemp.SetColumnWidth('H', 10);
        TempExcelBufTemp.SetColumnWidth('I', 15);
        TempExcelBufTemp.SetColumnWidth('J', 15);
        TempExcelBufTemp.SetColumnWidth('K', 13);

        TempExcelBufTemp.ClearNewRow();
        TempExcelBufTemp.WriteSheet(CaptionExelBookLbl, CompanyName, UserId);
        TempExcelBufTemp.SetColumnWidth('A', 25);
        TempExcelBufTemp.SetColumnWidth('B', 17);
    end;

    local procedure ReadExcelbook()
    begin
        TempExcelBufTemp.CloseBook();
        TempExcelBufTemp.OpenExcel();
    end;

    local procedure MakeExcelInfo()
    begin
        TempExcelBufTemp.SetUseInfoSheet();
        TempExcelBufTemp.AddInfoColumn(Format(SettingsLbl), false, true, false, false, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.NewRow();
        TempExcelBufTemp.NewRow();
        TempExcelBufTemp.AddInfoColumn(Format('End date'), false, true, false, false, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddInfoColumn(EndDate, false, false, false, false, '', TempExcelBufTemp."Cell Type"::Date);
        TempExcelBufTemp.NewRow();
        TempExcelBufTemp.AddInfoColumn(Format('Display only open items'), false, true, false, false, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddInfoColumn(OnlyOpen, false, false, false, false, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.NewRow();
        TempExcelBufTemp.NewRow();
        TempExcelBufTemp.NewRow();
        TempExcelBufTemp.NewRow();
        TempExcelBufTemp.NewRow();
        TempExcelBufTemp.NewRow();
        TempExcelBufTemp.AddInfoColumn(Format('Significantly created'), false, true, false, false, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddInfoColumn(UserId, false, false, false, false, 'MM/dd/yyyy h:mm', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.NewRow();
        TempExcelBufTemp.AddInfoColumn(Format('Significant creation date'), false, true, false, false, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddInfoColumn(Today, false, false, false, false, 'MM/dd/yyyy h:mm', TempExcelBufTemp."Cell Type"::Date);
        TempExcelBufTemp.SetColumnWidth('A', 15);
        TempExcelBufTemp.SetColumnWidth('B', 12);
        TempExcelBufTemp.ClearNewRow();
    end;

    local procedure MakeVendorHeader()
    begin
        TempExcelBufTemp.NewRow();
        TempExcelBufTemp.AddColumn(Format('Vendor number'), false, '', true, false, true, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn(Format('Name of the supplier'), false, '', true, false, true, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn(Format('Wag the date'), false, '', true, false, true, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn(Format('Certification No.'), false, '', true, false, true, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn(Format('Megnevezs'), false, '', true, false, true, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn(Format('Payment deadline?'), false, '', true, false, true, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn(Format('Time (days)'), false, '', true, false, true, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn(Format('Pnznemkd'), false, '', true, false, true, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn(Format('Original amount'), false, '', true, false, true, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn(Format('Htralk'), false, '', true, false, true, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn(Format('Backwards (SPN)'), false, '', true, false, true, '', TempExcelBufTemp."Cell Type"::Text);
    end;

    local procedure MakeVendorLedgerEntryLine()
    begin
        TempExcelBufTemp.NewRow();
        TempExcelBufTemp.AddColumn(Vendor."No.", false, '', false, false, false, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn(Vendor.Name, false, '', false, false, false, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn("Vendor Ledger Entry"."Posting Date", false, '', false, false, false, '', TempExcelBufTemp."Cell Type"::Date);
        TempExcelBufTemp.AddColumn("Vendor Ledger Entry"."Document No.", false, '', false, false, false, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn("Vendor Ledger Entry".Description, false, '', false, false, false, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn("Vendor Ledger Entry"."Due Date", false, '', false, false, false, '', TempExcelBufTemp."Cell Type"::Date);
        TempExcelBufTemp.AddColumn(OverDueDays, false, '', false, false, false, '', TempExcelBufTemp."Cell Type"::Number);
        TempExcelBufTemp.AddColumn("Vendor Ledger Entry"."Currency Code", false, '', false, false, false, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn(Format("Vendor Ledger Entry"."Original Amount", 0, '<Precision,2:2><Sign><Integer><Decimals>'), false, '', false, false, false, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn(Format("Vendor Ledger Entry"."Remaining Amount", 0, '<Precision,2:2><Sign><Integer><Decimals>'), false, '', false, false, false, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn(Format("Vendor Ledger Entry"."Remaining Amt. (LCY)", 0, '<Precision,2:2><Sign><Integer><Decimals>'), false, '', false, false, false, '', TempExcelBufTemp."Cell Type"::Text);
    end;

    local procedure MakeInteger1_Line()
    begin
        TempExcelBufTemp.NewRow();
        TempExcelBufTemp.AddColumn(Vendor."No.", false, '', true, false, true, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn(Vendor.Name, false, '', true, false, true, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn('', false, '', true, false, true, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn('', false, '', true, false, true, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn('', false, '', true, false, true, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn('', false, '', true, false, true, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn('', false, '', true, false, true, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn(CurrencyTotalBuffer."Currency Code", false, '', true, false, true, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn('', false, '', true, false, true, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn(Format(CurrencyTotalBuffer."Total Amount", 0, '<Precision,2:2><Sign><Integer><Decimals>'), false, '', true, false, true, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn(Format(CurrencyTotalBuffer."Total Amount (LCY)", 0, '<Precision,2:2><Sign><Integer><Decimals>'), false, '', true, false, true, '', TempExcelBufTemp."Cell Type"::Text);
    end;

    local procedure MakeInteger2_Line()
    begin
        TempExcelBufTemp.NewRow();
        TempExcelBufTemp.AddColumn('Total:', false, '', false, false, false, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn('', false, '', false, false, false, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn('', false, '', false, false, false, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn('', false, '', false, false, false, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn('', false, '', false, false, false, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn('', false, '', false, false, false, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn('', false, '', false, false, false, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn(CurrencyTotalBuffer2."Currency Code", false, '', false, false, false, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn('', false, '', false, false, false, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn(Format(CurrencyTotalBuffer2."Total Amount", 0, '<Precision,2:2><Sign><Integer><Decimals>'), false, '', false, false, false, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn(Format(CurrencyTotalBuffer2."Total Amount (LCY)", 0, '<Precision,2:2><Sign><Integer><Decimals>'), false, '', false, false, false, '', TempExcelBufTemp."Cell Type"::Text);
    end;

}