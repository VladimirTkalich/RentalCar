report 50101 "RSC_Export_Rental_Cars_Info"
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
                DataItemLink = "Document No." = field("No."),
                    "Document Type" = field("Document Type");

                trigger OnAfterGetRecord()
                begin
                    MakeExcelDataDocLine();
                end;

            }
            trigger OnAfterGetRecord()
            begin
                MakeExcelDataHeaderLine();
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
        CreateExcelbook();
    end;


    var
        CompanyInformation: Record "Company Information";
        ExcelBuf: Record "Excel Buffer" temporary;
        Text001: Label 'Sales Orders';
        Text002: Label 'Export Sales Orders';
        Text003: Label 'Company Name';
        Text004: Label 'User Name';
        Text005: Label 'Date / Time';


    local procedure CreateExcelbook()
    begin
        //ExcelBuf.CreateBookAndOpenExcel('', Text001, Text002, CompanyName, UserId);
        Error('');
    end;

    local procedure MakeExcelInfo()
    begin
        ExcelBuf.SetUseInfoSheet;
        ExcelBuf.AddInfoColumn(Format(Text002), false, true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(Format(Text003), false, true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(CompanyInformation.Name, false, false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(Format(Text004), false, true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(UserId, false, false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(Format(Text005), false, true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(Today, false, false, false, false, 'MM/dd/yyyy h:mm', ExcelBuf."Cell Type"::Date);
        ExcelBuf.ClearNewRow;
        MakeExcelDataHeader();
    end;

    local procedure MakeExcelDataHeader()
    begin
        ExcelBuf.NewRow;
        with "Sales Header" do begin
            ExcelBuf.AddColumn(FieldCaption("Document Type"), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn(FieldCaption("No."), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn(FieldCaption("Sell-to Customer No."), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn(FieldCaption("Sell-to Customer Name"), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn(FieldCaption("Sell-to Address"), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn(FieldCaption("Sell-to City"), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn(FieldCaption("Posting Description"), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        end;
    end;

    local procedure MakeExcelDataHeaderLine()
    begin
        ExcelBuf.NewRow;
        with "Sales Header" do begin
            ExcelBuf.AddColumn("Document Type", false, '', false, false, true, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn("No.", false, '', false, false, true, '', ExcelBuf."Cell Type"::Number);
            ExcelBuf.AddColumn("Sell-to Customer No.", false, '', false, false, true, '', ExcelBuf."Cell Type"::Number);
            ExcelBuf.AddColumn("Sell-to Customer Name", false, '', false, false, true, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn("Sell-to Address", false, '', false, false, true, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn("Sell-to City", false, '', false, false, true, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn("Posting Description", false, '', false, false, true, '', ExcelBuf."Cell Type"::Text);
        end;
        MakeExcelDataHeaderDocLine();
    end;

    local procedure MakeExcelDataHeaderDocLine()
    begin
        ExcelBuf.NewRow;
        with "Sales Line" do begin
            ExcelBuf.AddColumn('', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn(FieldCaption(Type), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn(FieldCaption("No."), false, '', true, false, true, '', ExcelBuf."Cell Type"::Number);
            ExcelBuf.AddColumn(FieldCaption("Description"), false, '', true, false, true, '', ExcelBuf."Cell Type"::Number);
            ExcelBuf.AddColumn(FieldCaption("Location Code"), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn(FieldCaption(Quantity), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn(FieldCaption("Unit of Measure Code"), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn(FieldCaption("Unit Price"), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn(FieldCaption("Line Amount"), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn(FieldCaption("Line Discount %"), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn(FieldCaption("Shipment Date"), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        end;
    end;

    local procedure MakeExcelDataDocLine()
    begin
        ExcelBuf.NewRow;
        with "Sales Line" do begin
            ExcelBuf.AddColumn('', false, '', false, false, true, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn(Type, false, '', false, false, true, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn("No.", false, '', false, false, true, '', ExcelBuf."Cell Type"::Number);
            ExcelBuf.AddColumn("Description", false, '', false, false, true, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn("Location Code", false, '', false, false, true, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn(Quantity, false, '', false, false, true, '', ExcelBuf."Cell Type"::Number);
            ExcelBuf.AddColumn("Unit of Measure Code", false, '', false, false, true, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn("Unit Price", false, '', false, false, true, '', ExcelBuf."Cell Type"::Number);
            ExcelBuf.AddColumn("Line Amount", false, '', false, false, true, '', ExcelBuf."Cell Type"::Number);
            ExcelBuf.AddColumn("Line Discount %", false, '', false, false, true, '', ExcelBuf."Cell Type"::Number);
            ExcelBuf.AddColumn("Shipment Date", false, '', false, false, true, 'MM/dd/yyyy', ExcelBuf."Cell Type"::Date);
        end;
    end;
}