report 50100 "Sales Order to Excel"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document No." = field("No.");

                trigger OnAfterGetRecord()
                begin
                    MakeExcelDataDocLine_SalesLine();
                end;

            }
            trigger OnAfterGetRecord()
            var
                SalesDocumentType: Enum "Sales Document Type";
            begin
                if "Sales Header"."Document Type" = SalesDocumentType::Order then
                    MakeExcelDataHeaderLine_SalesHeader()
                else
                    CurrReport.Skip();
            end;

            trigger OnPreDataItem()
            begin
                MakeExcelDataHeader_SalesHeader();
            end;

            trigger OnPostDataItem()
            begin
                OnlyCreateExcelbook(SalesOrdersLbl, CaptionExelBookLbl, false);
            end;
        }


    }

    trigger OnPreReport()
    begin
        CompanyInformation.Get();
        MakeExcelInfo();
    end;

    trigger OnPostReport()
    begin
        OnlyReadExcelbook();
    end;


    var
        CompanyInformation: Record "Company Information";
        TempExcelBufTemp: Record "Excel Buffer" temporary;
        SalesOrdersLbl: Label 'Sales Orders';
        ExportSalesOrdersLbl: Label 'Export Sales Orders';
        CaptionExelBookLbl: label 'Sales Orders';
        CompanyNameLbl: Label 'Company Name';
        UserNameLbl: Label 'User Name';
        DateTimeLbl: Label 'Date / Time';




    local procedure OnlyCreateExcelbook(SheetName: Text[250]; ReportHeader: Text; IsCreated: Boolean)
    begin
        if not IsCreated then begin
            TempExcelBufTemp.CreateNewBook(SheetName);
            TempExcelBufTemp.SetFriendlyFilename(CaptionExelBookLbl);
        end else
            TempExcelBufTemp.SelectOrAddSheet(SheetName);
        ChangeColumnWeigth();
        TempExcelBufTemp.ClearNewRow();
        TempExcelBufTemp.WriteSheet(ReportHeader, CompanyName, UserId);
        TempExcelBufTemp.SetColumnWidth('A', 17);
        TempExcelBufTemp.SetColumnWidth('B', 15.5);
    end;

    local procedure OnlyReadExcelbook()
    begin
        TempExcelBufTemp.CloseBook();
        TempExcelBufTemp.OpenExcel();
    end;

    local procedure ChangeColumnWeigth()
    begin
        TempExcelBufTemp.SetColumnWidth('A', 14);
        TempExcelBufTemp.SetColumnWidth('B', 12);
        TempExcelBufTemp.SetColumnWidth('C', 18);
        TempExcelBufTemp.SetColumnWidth('D', 22);
        TempExcelBufTemp.SetColumnWidth('E', 19);
        TempExcelBufTemp.SetColumnWidth('F', 10);
        TempExcelBufTemp.SetColumnWidth('G', 19);
        TempExcelBufTemp.SetColumnWidth('H', 16);
        TempExcelBufTemp.SetColumnWidth('I', 19.5);
        TempExcelBufTemp.SetColumnWidth('J', 13.5);
        TempExcelBufTemp.SetColumnWidth('K', 13);
    end;

    local procedure MakeExcelInfo()
    begin
        TempExcelBufTemp.SetUseInfoSheet();
        TempExcelBufTemp.AddInfoColumn(Format(ExportSalesOrdersLbl), false, true, false, false, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.NewRow();
        TempExcelBufTemp.NewRow();
        TempExcelBufTemp.AddInfoColumn(Format(CompanyNameLbl), false, true, false, false, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddInfoColumn(CompanyInformation.Name, false, false, false, false, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.NewRow();
        TempExcelBufTemp.AddInfoColumn(Format(UserNameLbl), false, true, false, false, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddInfoColumn(UserId, false, false, false, false, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.NewRow();
        TempExcelBufTemp.AddInfoColumn(Format(DateTimeLbl), false, true, false, false, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddInfoColumn(Today, false, false, false, false, 'MM/dd/yyyy h:mm', TempExcelBufTemp."Cell Type"::Date);
        TempExcelBufTemp.SetColumnWidth('A', 13.5);
        TempExcelBufTemp.SetColumnWidth('B', 12);
        TempExcelBufTemp.ClearNewRow();
    end;

    local procedure MakeExcelDataHeader_SalesHeader()
    begin
        TempExcelBufTemp.NewRow();
        TempExcelBufTemp.AddColumn("Sales Header".FieldCaption("Document Type"), false, '', true, false, true, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn("Sales Header".FieldCaption("No."), false, '', true, false, true, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn("Sales Header".FieldCaption("Sell-to Customer No."), false, '', true, false, true, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn("Sales Header".FieldCaption("Sell-to Customer Name"), false, '', true, false, true, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn("Sales Header".FieldCaption("Sell-to Address"), false, '', true, false, true, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn("Sales Header".FieldCaption("Sell-to City"), false, '', true, false, true, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn("Sales Header".FieldCaption("Posting Description"), false, '', true, false, true, '', TempExcelBufTemp."Cell Type"::Text);
    end;

    local procedure MakeExcelDataHeaderLine_SalesHeader()
    begin
        TempExcelBufTemp.NewRow();
        TempExcelBufTemp.NewRow();
        TempExcelBufTemp.AddColumn("Sales Header"."Document Type", false, '', false, false, false, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn("Sales Header"."No.", false, '', false, false, false, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn("Sales Header"."Sell-to Customer No.", false, '', false, false, false, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn("Sales Header"."Sell-to Customer Name", false, '', false, false, false, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn("Sales Header"."Sell-to Address", false, '', false, false, false, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn("Sales Header"."Sell-to City", false, '', false, false, false, '', TempExcelBufTemp."Cell Type"::Number);
        TempExcelBufTemp.AddColumn("Sales Header"."Posting Description", false, '', false, false, false, '', TempExcelBufTemp."Cell Type"::Text);
        MakeExcelDataHeaderDocLine_SalesLine();
    end;

    local procedure MakeExcelDataHeaderDocLine_SalesLine()
    begin
        TempExcelBufTemp.NewRow();
        TempExcelBufTemp.AddColumn('', false, '', false, false, false, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn("Sales Line".FieldCaption(Type), false, '', true, false, true, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn("Sales Line".FieldCaption("No."), false, '', true, false, true, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn("Sales Line".FieldCaption(Description), false, '', true, false, true, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn("Sales Line".FieldCaption("Location Code"), false, '', true, false, true, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn("Sales Line".FieldCaption(Quantity), false, '', true, false, true, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn("Sales Line".FieldCaption("Unit of Measure Code"), false, '', true, false, true, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn("Sales Line".FieldCaption("Unit Price"), false, '', true, false, true, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn("Sales Line".FieldCaption("Line Amount"), false, '', true, false, true, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn("Sales Line".FieldCaption("Line Discount %"), false, '', true, false, true, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn("Sales Line".FieldCaption("Shipment Date"), false, '', true, false, true, '', TempExcelBufTemp."Cell Type"::Text);
    end;

    local procedure MakeExcelDataDocLine_SalesLine()
    begin
        TempExcelBufTemp.NewRow();
        TempExcelBufTemp.AddColumn('', false, '', false, false, false, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn("Sales Line".Type, false, '', false, false, false, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn("Sales Line"."No.", false, '', false, false, false, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn("Sales Line".Description, false, '', false, false, false, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn("Sales Line"."Location Code", false, '', false, false, false, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn("Sales Line".Quantity, false, '', false, false, false, '', TempExcelBufTemp."Cell Type"::Number);
        TempExcelBufTemp.AddColumn("Sales Line"."Unit of Measure Code", false, '', false, false, false, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn("Sales Line"."Unit Price", false, '', false, false, false, '', TempExcelBufTemp."Cell Type"::Number);
        TempExcelBufTemp.AddColumn("Sales Line"."Line Amount", false, '', false, false, false, '', TempExcelBufTemp."Cell Type"::Number);
        TempExcelBufTemp.AddColumn("Sales Line"."Line Discount %", false, '', false, false, false, '', TempExcelBufTemp."Cell Type"::Number);
        TempExcelBufTemp.AddColumn("Sales Line"."Shipment Date", false, '', false, false, false, '', TempExcelBufTemp."Cell Type"::Date);
    end;

}