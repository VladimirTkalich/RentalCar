Report 50102 "InT_Vendor Detailed Aging"
{
    Caption = 'Vendor Detailed Aging';
    RDLCLayout = './report/layout/VendorDetailedAging.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Vendor Posting Group", "Currency Filter", "Payment Terms Code";
            column("UserId"; UserId)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(STRSUBSTNO_Text000_FORMAT_EndDate_; StrSubstNo(Text000, Format(EndDate)))
            {
            }
            column(TODAY_0_4; Format(Today, 0, 4))
            {
            }
            column(VendorTABLECAPTION___VendFilter; Vendor.TableCaption + ': ' + VendFilter)
            {
            }
            column(VendorLedgerEntryFIELDCAPTION_ExternalDocumentNo; "Vendor Ledger Entry".FieldCaption("External Document No."))
            {
            }
            column(VendorLedgerEntryFIELDCAPTION_OriginalAmount; "Vendor Ledger Entry".FieldCaption("Original Amount"))
            {
            }
            column(VendorLedgerEntryFIELDCAPTION_RemainingAmt_LCY_; "Vendor Ledger Entry".FieldCaption("Remaining Amt. (LCY)"))
            {
            }
            column(VendorLedgerEntryFIELDCAPTION_RemainingAmount; "Vendor Ledger Entry".FieldCaption("Remaining Amount"))
            {
            }
            column(VendorLedgerEntryFIELDCAPTION_Description; "Vendor Ledger Entry".FieldCaption(Description))
            {
            }
            column(VendorLedgerEntryFIELDCAPTION_DocumentNo; "Vendor Ledger Entry".FieldCaption("Document No."))
            {
            }
            column(VendorLedgerEntryFIELDCAPTION_PostingDate; "Vendor Ledger Entry".FieldCaption("Posting Date"))
            {
            }
            column(Vendor_Name; Name)
            {
            }
            column(Vendor_No; "No.")
            {
            }
            dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
            {
                DataItemLink = "Vendor No." = field("No."), "Global Dimension 2 Code" = field("Global Dimension 2 Filter"), "Global Dimension 1 Code" = field("Global Dimension 1 Filter"), "Currency Code" = field("Currency Filter"), "Date Filter" = field("Date Filter");
                DataItemTableView = sorting("Vendor No.", "Posting Date", "Currency Code");
                RequestFilterFields = "Vendor Posting Group";
                column(VendorLedgerEntry_ExternalDocumentNo; "External Document No.")
                {
                }
                column(VendorLedgerEntry_OriginalAmount; "Original Amount")
                {
                    AutoCalcField = true;
                }
                column(VendorLedgerEntry_RemainingAmt_LCY; "Remaining Amt. (LCY)")
                {
                    AutoCalcField = true;
                    AutoFormatType = 1;
                }
                column(CurrCode; CurrCode)
                {
                }
                column(VendorLedgerEntry_RemainingAmount; "Remaining Amount")
                {
                    AutoCalcField = true;
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }
                column(OverDueDays; OverDueDays)
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }
                column(VendorLedgerEntry_DueDate; "Due Date")
                {
                }
                column(VendorLedgerEntry_Description; Description)
                {
                }
                column(VendorLedgerEntry_DocumentNo; "Document No.")
                {
                }
                column(VendorLedgerEntry_PostingDate; "Posting Date")
                {
                }
                trigger OnPreDataItem();
                begin
                    if OnlyOpen then begin
                        SetRange(Open, true);
                        //   SETRANGE("Due Date",0D,EndDate);
                        SetRange("Posting Date", 0D, EndDate);
                    end else
                        //   SETRANGE("Due Date",0D,EndDate);
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
                    //+NMP01
                    if "Currency Code" = '' then begin
                        //+NPZS01
                        //  "Currency Code" := GLSetup."LCY Code";
                        CurrCode := GLSetup."LCY Code";
                    end else begin
                        CurrCode := "Currency Code";
                        //-NPZS01
                    end;
                    //-NMP01
                    CurrencyTotalBuffer.UpdateTotal(
                      "Currency Code", "Remaining Amount", "Remaining Amt. (LCY)", Counter);
                end;

            }
            dataitem(Integer; Integer)
            {
                DataItemTableView = sorting(Number) where(Number = filter(1 ..));
                // column(ReportForNavId_28; 28) { } // Autogenerated by ForNav - Do not delete
                column(CurrencyTotalBuffer_TotalAmount_LCY; CurrencyTotalBuffer."Total Amount (LCY)")
                {
                    AutoFormatType = 1;
                }
                column(Vendor_Name2; Vendor.Name)
                {
                }
                column(CurrencyTotalBuffer_CurrencyCode; CurrencyTotalBuffer."Currency Code")
                {
                }
                column(CurrencyTotalBuffer_TotalAmount; CurrencyTotalBuffer."Total Amount")
                {
                    AutoFormatExpression = CurrencyTotalBuffer."Currency Code";
                    AutoFormatType = 1;
                }
                column(VendorLedgerEntry_RemainingAmt_LCY2; "Vendor Ledger Entry"."Remaining Amt. (LCY)")
                {
                    AutoFormatType = 1;
                }
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
                end;

                trigger OnPostDataItem();
                begin
                    CurrencyTotalBuffer.DeleteAll;
                end;

            }
            trigger OnPreDataItem();
            begin

            end;

        }
        dataitem(Integer2; Integer)
        {
            DataItemTableView = sorting(Number) where(Number = filter(1 ..));
            // column(ReportForNavId_34; 34) { } // Autogenerated by ForNav - Do not delete
            column(CurrencyTotalBuffer2_TotalAmount_LCY; CurrencyTotalBuffer2."Total Amount (LCY)")
            {
                AutoFormatType = 1;
            }
            column(CurrencyTotalBuffer2_TotalAmount; CurrencyTotalBuffer2."Total Amount")
            {
                AutoFormatExpression = CurrencyTotalBuffer."Currency Code";
                AutoFormatType = 1;
            }
            column(CurrencyTotalBuffer2_CurrencyCode; CurrencyTotalBuffer2."Currency Code")
            {
            }
            column(VendorLedgerEntry_RemainingAmt_LCY3; "Vendor Ledger Entry"."Remaining Amt. (LCY)")
            {
                AutoFormatType = 1;
            }
            trigger OnAfterGetRecord();
            begin
                if Number = 1 then
                    OK := CurrencyTotalBuffer2.Find('-')
                else
                    OK := CurrencyTotalBuffer2.Next <> 0;
                if not OK then
                    CurrReport.Break;
            end;

            trigger OnPostDataItem();
            begin
                CurrencyTotalBuffer2.DeleteAll;
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
                    field(CreateExcel; CreateExcel)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Create Excel';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            if EndDate = 0D then
                EndDate := WorkDate;
        end;
    }

    trigger OnInitReport()
    begin
        GLSetup.Get;

    end;

    trigger OnPostReport()
    begin
        TempExcelBufTemp.CloseBook();
        TempExcelBufTemp.OpenExcel();
    end;

    trigger OnPreReport()
    begin
        VendFilter := Vendor.GetFilters;
        if CreateExcel then begin
            // Create(xlApp);
            // xlBook := xlApp.Workbooks.Add(-4167);
            // xlSheet2 := xlApp.ActiveSheet;
            // xlSheet2.Name := 'Settings';
            // xlSheet2.Range('a1').Value := 'Settings';
            // xlSheet2.Range('a1').Font.Bold := true;
            // xlSheet2.Range('a3').Value := 'End date';
            // xlSheet2.Range('a4').Value := 'Display only open items';
            // xlSheet2.Range('a10').Value := 'Significantly created';
            // xlSheet2.Range('a11').Value := 'Significant creation date';
            // xlSheet2.Range('b3').Value := EndDate;
            // xlSheet2.Range('b4').Value := OnlyOpen;
            // xlSheet2.Range('b10').Value := UserId;
            // xlSheet2.Range('b11').Value := Today;
            // xlApp.Sheets.Add;
            // xlSheet := xlApp.ActiveSheet;
            // xlSheet.Name := 'Carrier - Parts disease. list';
            // xlSheet.Range('A1').Value := StrSubstNo('%1', 'Vendor number');
            // xlSheet.Range('B1').Value := StrSubstNo('%1', 'Name of the supplier');
            // xlSheet.Range('C1').Value := StrSubstNo('%1', 'Wag the date');
            // xlSheet.Range('D1').Value := StrSubstNo('%1', 'Certification No.');
            // xlSheet.Range('E1').Value := StrSubstNo('%1', 'Megnevezs');
            // xlSheet.Range('F1').Value := StrSubstNo('%1', 'Payment deadline?');
            // xlSheet.Range('G1').Value := StrSubstNo('%1', 'Time (days)');
            // xlSheet.Range('H1').Value := StrSubstNo('%1', 'Pnznemkd');
            // xlSheet.Range('I1').Value := StrSubstNo('%1', 'Original amount');
            // xlSheet.Range('J1').Value := StrSubstNo('%1', 'Htralk');
            // xlSheet.Range('K1').Value := StrSubstNo('%1', 'Backwards (SPN)');
            // xlSheet.Range('A1..K1').Font.Bold := true;
            xlLineNo := 2;
        end;
        // TempExcelBufTemp.SetUseInfoSheet();
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
        TempExcelBufTemp.SetColumnWidth('A', 13.5);
        TempExcelBufTemp.SetColumnWidth('B', 12);
        TempExcelBufTemp.ClearNewRow();

        TempExcelBufTemp.CreateNewBook(SettingsLbl);
        TempExcelBufTemp.SetFriendlyFilename(CaptionExelBookLbl);
        TempExcelBufTemp.ClearNewRow();
        TempExcelBufTemp.WriteSheet(SettingsLbl, CompanyName, UserId);
    end;

    var
        TempExcelBufTemp: Record "Excel Buffer" temporary;
        SettingsLbl: Label 'Settings';
        CaptionExelBookLbl: label 'Vendor Detailed Aging';

        Text000: label 'As of %1';
        CurrencyTotalBuffer: Record "Currency Total Buffer" temporary;
        CurrencyTotalBuffer2: Record "Currency Total Buffer" temporary;
        EndDate: Date;
        VendFilter: Text[250];
        OverDueDays: Integer;
        OK: Boolean;
        Counter: Integer;
        Counter1: Integer;
        OnlyOpen: Boolean;
        // xlApp: Automation;
        // xlBook: Automation;
        // xlSheet: Automation;
        // xlRange: Automation;
        // xlFont: Automation;
        xlLineNo: Integer;
        CreateExcel: Boolean;
        // xlSheet2: Automation;
        // xlRange2: Automation;
        // xlFont2: Automation;
        GLSetup: Record "General Ledger Setup";
        CurrCode: Code[10];

    // local procedure OnPreSectionVendor_Header2(var Vendor: Record Vendor);
    // begin
    //     with Vendor do begin
    //         ReportForNav.ShowOutput((ReportForNav.PageNo = 1) and (VendFilter <> ''));
    //     end;
    // end;

    local procedure OnPreSectionVendorLedgerEntry_Body6(var "Vendor Ledger Entry": Record "Vendor Ledger Entry");
    begin
        with "Vendor Ledger Entry" do begin
            if CreateExcel then begin
                // xlSheet.Range('A' + Format(xlLineNo)).Value := StrSubstNo('%1', Vendor."No.");
                // xlSheet.Range('B' + Format(xlLineNo)).Value := StrSubstNo('%1', Vendor.Name);
                // xlSheet.Range('C' + Format(xlLineNo)).Value := StrSubstNo('%1', "Posting Date");
                // xlSheet.Range('D' + Format(xlLineNo)).Value := StrSubstNo('%1', "Document No.");
                // xlSheet.Range('E' + Format(xlLineNo)).Value := StrSubstNo('%1', Description);
                // xlSheet.Range('F' + Format(xlLineNo)).Value := StrSubstNo('%1', "Due Date");
                // xlSheet.Range('G' + Format(xlLineNo)).Value := StrSubstNo('%1', OverDueDays);
                // xlSheet.Range('H' + Format(xlLineNo)).Value := StrSubstNo('%1', "Currency Code");
                // xlSheet.Range('I' + Format(xlLineNo)).Value := Format("Original Amount", 0, '<Precision,2:2><Sign><Integer><Decimals>');
                // xlSheet.Range('J' + Format(xlLineNo)).Value := Format("Remaining Amount", 0, '<Precision,2:2><Sign><Integer><Decimals>');
                // xlSheet.Range('K' + Format(xlLineNo)).Value := Format("Remaining Amt. (LCY)", 0, '<Precision,2:2><Sign><Integer><Decimals>');
                xlLineNo += 1;
            end;
        end;
    end;

    local procedure OnPreSectionInteger_Body7(var Integer: Record Integer);
    begin
        with Integer do begin
            //LJJ02+
            if CreateExcel then begin
                // xlSheet.Range('A' + Format(xlLineNo)).Value := StrSubstNo('%1', Vendor."No.");
                // xlSheet.Range('A' + Format(xlLineNo)).Font.Bold := true;
                // xlSheet.Range('B' + Format(xlLineNo)).Value := StrSubstNo('%1', Vendor.Name);
                // xlSheet.Range('B' + Format(xlLineNo)).Font.Bold := true;
                // xlSheet.Range('H' + Format(xlLineNo)).Value := StrSubstNo('%1', CurrencyTotalBuffer."Currency Code");
                // xlSheet.Range('H' + Format(xlLineNo)).Font.Bold := true;
                // xlSheet.Range('J' + Format(xlLineNo)).Value := Format(CurrencyTotalBuffer."Total Amount", 0,
                // '<Precision,2:2><Sign><Integer><Decimals>');
                // xlSheet.Range('J' + Format(xlLineNo)).Font.Bold := true;
                // xlSheet.Range('K' + Format(xlLineNo)).Value := Format(CurrencyTotalBuffer."Total Amount (LCY)", 0,
                // '<Precision,2:2><Sign><Integer><Decimals>');
                // xlSheet.Range('K' + Format(xlLineNo)).Font.Bold := true;
                xlLineNo += 1;
            end;
            //LJJ02-
        end;
    end;

    local procedure OnPostSectionInteger_Footer8(var Integer: Record Integer);
    begin
        with Integer do begin
            // ReportForNav.ShowOutput(Counter <> 1);
        end;
    end;

    local procedure OnPreSectionInteger2_Body9(var Integer2: Record Integer);
    begin
        with Integer2 do begin
            //+LSM02 091127
            if CreateExcel then begin
                // xlSheet.Range('A' + Format(xlLineNo)).Value := 'Total:';
                // //LJJ02+
                // xlSheet.Range('h' + Format(xlLineNo)).Value := Format(CurrencyTotalBuffer2."Currency Code");
                // //LJJ02-
                // xlSheet.Range('J' + Format(xlLineNo)).Value := Format(CurrencyTotalBuffer2."Total Amount",
                //   0, '<Precision,2:2><Sign><Integer><Decimals>');
                // xlSheet.Range('K' + Format(xlLineNo)).Value := Format(CurrencyTotalBuffer2."Total Amount (LCY)",
                //   0, '<Precision,2:2><Sign><Integer><Decimals>');
                xlLineNo += 1;
            end;
            //-LSM02 091127
        end;
    end;
}
