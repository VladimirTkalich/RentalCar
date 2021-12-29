/// <summary>
/// Report "RSC_Service_Order_Excel" (ID 50101).
/// </summary>
report 50101 RSC_Service_Order_Excel
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Service Header"; "Service Header")
        {

            dataitem("Service Line"; "Service Line")
            {
                DataItemLink = "Document No." = field("No."),
                    "Document Type" = field("Document Type");

                trigger OnAfterGetRecord()
                begin
                    MakeExcelDataServiceLine();
                end;

            }
            trigger OnAfterGetRecord()
            var
                ServiceDocumentType: Enum "Service Document Type";
            begin
                if "Service Header"."Document Type" = ServiceDocumentType::Order then
                    MakeExcelDataHeaderLine()
                else
                    CurrReport.Skip();
            end;

            trigger OnPostDataItem()
            begin
                OnlyCreateExcelbook(BookName, BookName, false);
            end;

        }

    }


    trigger OnPreReport()
    begin
        CompanyInformation.Get;
        MakeExcelInfo();
    end;

    trigger OnPostReport()
    begin
        // CreateExcelbook();
        OnlyReadExcelbook();
    end;


    var
        CompanyInformation: Record "Company Information";
        ExcelBuff: Record "Excel Buffer" temporary;
        BookName: Label 'Service Orders';
        CaptionReport: Label 'Export Service Orders';
        CompanyNameLbl: Label 'Company Name';
        UserNameLbl: Label 'User Name';
        DateTimeLbl: Label 'Date / Time';


    // local procedure CreateExcelbook()
    // begin
    //     ExcelBuff.CreateNewBook(BookName);
    //     Error('');
    // end;

    local procedure OnlyCreateExcelbook(SheetName: Text[250]; ReportHeader: Text; IsCreated: Boolean)
    begin
        if not IsCreated then begin
            ExcelBuff.CreateNewBook(SheetName);
            ExcelBuff.SetFriendlyFilename(BookName);
        end else
            ExcelBuff.SelectOrAddSheet(SheetName);
        ChangeColumnWeigth();
        ExcelBuff.ClearNewRow();
        ExcelBuff.WriteSheet(ReportHeader, CompanyName, UserId);
        ExcelBuff.SetColumnWidth('A', 20);
        ExcelBuff.SetColumnWidth('B', 17);
    end;

    local procedure OnlyReadExcelbook()
    begin
        ExcelBuff.CloseBook();
        ExcelBuff.OpenExcel();
    end;

    local procedure ChangeColumnWeigth()
    begin
        ExcelBuff.SetColumnWidth('A', 15);
        ExcelBuff.SetColumnWidth('B', 14);
        ExcelBuff.SetColumnWidth('C', 10);
        ExcelBuff.SetColumnWidth('D', 35);
        ExcelBuff.SetColumnWidth('E', 8);
        ExcelBuff.SetColumnWidth('F', 8);
        ExcelBuff.SetColumnWidth('G', 6.5);
        ExcelBuff.SetColumnWidth('H', 8);
        ExcelBuff.SetColumnWidth('I', 10);
        ExcelBuff.SetColumnWidth('J', 8);
        ExcelBuff.SetColumnWidth('K', 10.5);
    end;

    local procedure MakeExcelInfo()
    begin
        ExcelBuff.SetUseInfoSheet;
        ExcelBuff.AddInfoColumn(Format(CaptionReport), false, true, false, false, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.NewRow;
        ExcelBuff.NewRow;
        ExcelBuff.AddInfoColumn(Format(CompanyNameLbl), false, true, false, false, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddInfoColumn(CompanyInformation.Name, false, false, false, false, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.NewRow;
        ExcelBuff.AddInfoColumn(Format(UserNameLbl), false, true, false, false, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddInfoColumn(UserId, false, false, false, false, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.NewRow;
        ExcelBuff.AddInfoColumn(Format(DateTimeLbl), false, true, false, false, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddInfoColumn(Today, false, false, false, false, 'MM/dd/yyyy h:mm', ExcelBuff."Cell Type"::Date);
        ExcelBuff.ClearNewRow;
        MakeExcelDataHeader();
    end;

    local procedure MakeExcelDataHeader()
    begin
        // ExcelBuff.NewRow;
        ExcelBuff.AddColumn("Service Header".FieldCaption("Document Type"), false, '', true, false, true, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn("Service Header".FieldCaption("No."), false, '', true, false, true, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn("Service Header".FieldCaption(Description), false, '', true, false, true, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn("Service Header".FieldCaption(Name), false, '', true, false, true, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn("Service Header".FieldCaption(Address), false, '', true, false, true, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn("Service Header".FieldCaption(City), false, '', true, false, true, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn("Service Header".FieldCaption("Contact Name"), false, '', true, false, true, '', ExcelBuff."Cell Type"::Date);
    end;

    local procedure MakeExcelDataHeaderLine()
    begin
        ExcelBuff.NewRow;
        ExcelBuff.NewRow;
        ExcelBuff.AddColumn("Service Header"."Document Type", false, '', true, false, true, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn("Service Header"."No.", false, '', true, false, true, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn("Service Header".Description, false, '', true, false, true, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn("Service Header".Name, false, '', true, false, true, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn("Service Header".Address, false, '', true, false, true, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn("Service Header".City, false, '', true, false, true, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn("Service Header"."Contact Name", false, '', true, false, true, '', ExcelBuff."Cell Type"::Text);
        MakeExcelDataHeaderServiceLine();

    end;


    local procedure MakeExcelDataHeaderServiceLine()
    begin
        ExcelBuff.NewRow;
        ExcelBuff.AddColumn('', false, '', true, false, true, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn("Service Line".FieldCaption(Type), false, '', true, false, true, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn("Service Line".FieldCaption("No."), false, '', true, false, true, '', ExcelBuff."Cell Type"::Number);
        ExcelBuff.AddColumn("Service Line".FieldCaption("Description"), false, '', true, false, true, '', ExcelBuff."Cell Type"::Number);
        ExcelBuff.AddColumn("Service Line".FieldCaption("Location Code"), false, '', true, false, true, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn("Service Line".FieldCaption(Quantity), false, '', true, false, true, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn("Service Line".FieldCaption("Unit of Measure Code"), false, '', true, false, true, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn("Service Line".FieldCaption("Unit Price"), false, '', true, false, true, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn("Service Line".FieldCaption("Line Amount"), false, '', true, false, true, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn("Service Line".FieldCaption("Line Discount %"), false, '', true, false, true, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn("Service Line".FieldCaption("Needed by Date"), false, '', true, false, true, '', ExcelBuff."Cell Type"::Text);
    end;

    local procedure MakeExcelDataServiceLine()
    begin
        ExcelBuff.NewRow;
        ExcelBuff.AddColumn('', false, '', true, false, false, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn("Service Line".Type, false, '', true, false, false, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn("Service Line"."No.", false, '', true, false, false, '', ExcelBuff."Cell Type"::Number);
        ExcelBuff.AddColumn("Service Line"."Description", false, '', true, false, false, '', ExcelBuff."Cell Type"::Number);
        ExcelBuff.AddColumn("Service Line"."Location Code", false, '', true, false, false, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn("Service Line".Quantity, false, '', true, false, false, '', ExcelBuff."Cell Type"::Number);
        ExcelBuff.AddColumn("Service Line"."Unit of Measure Code", false, '', true, false, false, '', ExcelBuff."Cell Type"::Text);
        ExcelBuff.AddColumn("Service Line"."Unit Price", false, '', true, false, false, '#,0.00;(#,0.00)', ExcelBuff."Cell Type"::Number);
        ExcelBuff.AddColumn("Service Line"."Line Amount", false, '', true, false, false, '#,0.00;(#,0.00)', ExcelBuff."Cell Type"::Number);
        ExcelBuff.AddColumn("Service Line"."Line Discount %", false, '', true, false, false, '#,0.00;(#,0.00)', ExcelBuff."Cell Type"::Number);
        ExcelBuff.AddColumn("Service Line"."Needed by Date", false, '', true, false, false, '', ExcelBuff."Cell Type"::Date);
    end;

}