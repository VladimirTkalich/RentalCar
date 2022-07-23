report 50107 "InT_ImportSalesQuote"
{
    ApplicationArea = All;
    Caption = 'Import Sales Quote from Excel File';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;

    // dataset
    // {
    //     dataitem(SalesHeader; "Sales Header")
    //     {
    //     }
    // }

    requestpage
    {
        // SaveValues = true;
        layout
        {
            area(content)
            {
                group(Option)
                {
                    field(Filename; Filename)
                    {
                        ApplicationArea = All;
                        Caption = 'Name of Excel file';

                        trigger OnAssistEdit()
                        begin
                            if UploadIntoStream('Select Excel file', '', '', Filename, InS) then
                                isFileselected := true;
                            //TODO Make disable button "OK" if file was not be selected
                        end;

                    }
                    // field(FilenameLbl; FilenameLbl)
                    // {
                    //     ApplicationArea = All;
                    //     ShowCaption = false;
                    //     Editable = false;

                    //     trigger OnDrillDown()
                    //     begin
                    //         if UploadIntoStream('Select Excel file', '', '', Filename, InS) then
                    //             isFileselected := true;
                    //     end;
                    // }

                    // field(Filename; Filename)
                    // {
                    //     ApplicationArea = All;
                    //     ShowCaption = false;
                    // }
                    field(isCreateNewItem; isCreateNewItem)
                    {
                        ApplicationArea = All;
                        Caption = 'Create new Item';
                    }
                }
            }
        }
    }


    trigger OnInitReport()
    begin
        isFileselected := false;
        isCreateNewItem := false;
    end;

    trigger OnPreReport()
    var
        SLineNoMax: Integer;
        SLineNo: Integer;

    begin
        if not isFileselected then begin
            if not UploadIntoStream('Select Excel file', '', '', Filename, InS) then begin
                CurrReport.Quit();
            end;
        end;

        Buffer.OpenBookStream(InS, 'Sheet1');
        Buffer.ReadSheet();
        //Message('Total cells %1', Buffer.Count);
        Buffer.SetRange("Column No.", 2);
        //Message(Format(Buffer));
        Buffer.FindLast();
        LastRow := Buffer."Row No.";
        Buffer.Reset();

        //SalesHeader.FindFirst(); //for Report.Run(report::InT_ImportSalesQuote, true, false, Rec);

        SHeader.Reset();
        SHeader.SetFilter("No.", SalesHeaderNo);
        if not SHeader.FindFirst() then begin
            Message('Sales Header not found');
            exit;
        end;

        SalesLine.Reset();
        SalesLine.SetFilter("Document No.", SHeader."No.");
        SLineNoMax := 0;
        SalesLine.SetCurrentKey("Line No.");
        SalesLine.FindLast();
        SlineNo := SalesLine."Line No.";

        // repeat
        //     SlineNo := SalesLine."Line No.";
        //     if SLineNo > SLineNoMax then
        //         SLineNoMax := SLineNo;
        // until SalesLine.Next() = 0;

        CountInserted := 0;

        for Row := 7 to LastRow do begin
            Quantity := x.GetDecimal(Buffer, 5, Row);
            ItemNo := x.GetText(Buffer, 2, Row);
            if (Quantity > 0) and (StrLen(ItemNo) > 0) then begin
                UnitPrice := x.GetDecimal(Buffer, 3, Row);
                UnitCost := x.GetDecimal(Buffer, 4, Row);
                ItemDescription := x.GetText(Buffer, 8, Row);
                Items.Reset();
                Items.SetFilter("No.", ItemNo);
                if not Items.FindFirst() and isCreateNewItem then begin
                    Items.Init();
                    Items."No." := ItemNo;
                    Items.Insert(true);
                    Items.Validate("Gen. Prod. Posting Group", 'RETAIL');
                    Items.Validate("Inventory Posting Group", 'RESALE');
                    Items.Validate(Description, ItemDescription);
                    Items.Validate("Unit Price", UnitPrice);
                    Items.Validate("Unit Cost", UnitCost);
                    Items.Modify();
                end;
                if Items.FindFirst() then begin
                    SalesLine.Init();
                    SalesLine."Document Type" := SHeader."Document Type";
                    SalesLine."Document No." := SHeader."No.";
                    SLineNoMax += 10000;
                    SalesLine."Line No." := SLineNoMax;
                    if SalesLine.Insert(true) then
                        CountInserted += 1;
                    SalesLine.Validate(Type, "Sales Line Type"::Item);
                    SalesLine.Validate("No.", ItemNo);
                    SalesLine.Validate(Description, ItemDescription);
                    SalesLine.Validate(Quantity, Quantity);
                    SalesLine.Validate("Unit Price", UnitPrice);
                    SalesLine.Validate("Unit Cost", UnitCost);
                    SalesLine.Modify();
                end;
            end;
        end;

        Message('%1 Sales Lines were inserted', CountInserted);
        // CurrReport.Quit();
    end;

    procedure SetSalesHeaderNo(SHeaderNo: Code[20])
    begin
        SalesHeaderNo := SHeaderNo;
    end;

    var
        x: Codeunit "InT_Excel Tools";
        Buffer: Record "Excel Buffer" temporary;
        SHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        Items: Record Item;
        Row: Integer;
        LastRow: Integer;
        Quantity: Decimal;
        ItemNo: Text;
        UnitPrice: Decimal;
        UnitCost: Decimal;
        ItemDescription: Text;
        CountInserted: Integer;
        ChooseFileLbl: Label 'Choose File';
        InS: InStream;
        Filename: Text;
        FilenameLbl: Label 'File Name:';
        isFileselected: Boolean;
        isCreateNewItem: Boolean;
        SalesHeaderNo: Code[20];

}
