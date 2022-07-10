report 50104 "InT_Excel_Export"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Customer; Customer)
        {
            trigger OnAfterGetRecord()
            begin
                MakeExcelCustomerLine();
                DataitemNo += 1;
                if (DataitemNo = MaxItems) then begin
                    DataitemNo := 0;
                    CurrReport.Break();
                end;
            end;

            trigger OnPreDataItem()
            begin
                if not IsCustomerShow then
                    CurrReport.Break();
                MakeExcelCustomerHeader();
                if DateFilter <> 0D then
                    Customer.SetFilter("Last Date Modified", '%1', DateFilter);

            end;

            trigger OnPostDataItem()
            begin
                if IsCustomerShow then
                    WriteExcelbook(CustomersLbl);
            end;
        }

        dataitem(Vendor; Vendor)
        {
            trigger OnAfterGetRecord()
            begin
                MakeExcelVendorLine();
                DataitemNo += 1;
                if (DataitemNo = MaxItems) then begin
                    DataitemNo := 0;
                    CurrReport.Break();
                end;
            end;

            trigger OnPreDataItem()
            begin
                if not IsVendorShow then
                    CurrReport.Break();
                MakeExcelVendorHeader();
                if DateFilter <> 0D then
                    Vendor.SetFilter("Last Date Modified", '%1', DateFilter);
            end;

            trigger OnPostDataItem()
            begin
                if IsVendorShow then
                    WriteExcelbook(VendorsLbl);
            end;
        }

        dataitem(Item; Item)
        {
            trigger OnAfterGetRecord()
            begin
                MakeExcelItemLine();
                DataitemNo += 1;
                if (DataitemNo = MaxItems) then begin
                    DataitemNo := 0;
                    CurrReport.Break();
                end;
            end;

            trigger OnPreDataItem()
            begin
                if not IsItemShow then
                    CurrReport.Break();
                MakeExcelItemHeader();
                if DateFilter <> 0D then
                    Item.SetFilter("Last Date Modified", '%1', DateFilter);
            end;

            trigger OnPostDataItem()
            begin
                if IsItemShow then
                    WriteExcelbook(ItemsLbl);
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
                    field(IsCustomerShow; IsCustomerShow)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customers';
                        ToolTip = 'Specifies if the Customers will be shown in the report.';
                    }
                    field(IsVendorShow; IsVendorShow)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vendors';
                        ToolTip = 'Specifies if the Vendors will be shown in the report.';
                    }
                    field(IsItemShow; IsItemShow)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Items';
                        ToolTip = 'Specifies if the Items will be shown in the report.';
                    }
                    field(MaxItems; MaxItems)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'The max lines in the report.';
                        ToolTip = 'Specifies the max lines in the report.';
                    }
                    field(DateFilter; DateFilter)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'The Last Date Modified.';
                        ToolTip = 'Specifies the Last Date Modified.';
                    }
                }
            }
        }
    }



    trigger OnPreReport()
    begin
        //CompanyInformation.Get();
        DataitemNo := 0;
        //DateFilter := 0D;
        IsCreated := false;
    end;

    trigger OnPostReport()
    begin
        OnlyReadExcelbook();
    end;


    var
        CompanyInformation: Record "Company Information";
        TempExcelBufTemp: Record "Excel Buffer" temporary;
        CaptionExelBookLbl: label 'Excel Export';
        GeneralInfoLbl: Label 'Customers, Vendors, Items';
        CustomersLbl: Label 'Customers';
        VendorsLbl: Label 'Vendors';
        ItemsLbl: Label 'Items';
        CompanyNameLbl: Label 'Company Name';
        UserNameLbl: Label 'User Name';
        DateTimeLbl: Label 'Date / Time';
        MaxItems: Integer;
        IsCustomerShow: Boolean;
        IsVendorShow: Boolean;
        DateFilter: Date;
        IsItemShow: Boolean;
        DataitemNo: Integer;
        IsCreated: Boolean;




    local procedure WriteExcelbook(SheetName: Text[250])
    begin
        if not IsCreated then begin
            TempExcelBufTemp.CreateNewBook(SheetName);
            TempExcelBufTemp.SetFriendlyFilename(CaptionExelBookLbl);

            TempExcelBufTemp.WriteSheet(SheetName, CompanyName, UserId);
            IsCreated := true;

        end else begin
            TempExcelBufTemp.SelectOrAddSheet(SheetName);
            TempExcelBufTemp.WriteSheet(SheetName, CompanyName, UserId);
        end;
        ChangeColumnWeigth();

        TempExcelBufTemp.DeleteAll();
        TempExcelBufTemp.SetCurrent(0, 0);
    end;

    local procedure OnlyReadExcelbook()
    begin
        TempExcelBufTemp.CloseBook();
        TempExcelBufTemp.OpenExcel();
    end;

    local procedure ChangeColumnWeigth()
    begin
        TempExcelBufTemp.SetColumnWidth('A', 12);
        TempExcelBufTemp.SetColumnWidth('B', 25);
        TempExcelBufTemp.SetColumnWidth('C', 12);
        TempExcelBufTemp.SetColumnWidth('D', 20);
        TempExcelBufTemp.SetColumnWidth('E', 20);
        TempExcelBufTemp.SetColumnWidth('F', 12);
    end;

    local procedure MakeExcelCustomerHeader()
    begin
        TempExcelBufTemp.NewRow();
        TempExcelBufTemp.AddColumn(Customer.FieldCaption("No."), false, '', true, false, true, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn(Customer.FieldCaption(Name), false, '', true, false, true, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn(Customer.FieldCaption(City), false, '', true, false, true, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn(Customer.FieldCaption(Contact), false, '', true, false, true, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn(Customer.FieldCaption("E-Mail"), false, '', true, false, true, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn(Customer.FieldCaption("Last Date Modified"), false, '', true, false, true, '', TempExcelBufTemp."Cell Type"::Text);
    end;

    local procedure MakeExcelCustomerLine()
    begin
        TempExcelBufTemp.NewRow();
        TempExcelBufTemp.AddColumn(Customer."No.", false, '', false, false, false, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn(Customer.Name, false, '', false, false, false, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn(Customer.City, false, '', false, false, false, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn(Customer.Contact, false, '', false, false, false, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn(Customer."E-Mail", false, '', false, false, false, '#,##0.00', TempExcelBufTemp."Cell Type"::Number);
        TempExcelBufTemp.AddColumn(Customer."Last Date Modified", false, '', false, false, false, '', TempExcelBufTemp."Cell Type"::Date);
    end;

    local procedure MakeExcelVendorHeader()
    begin
        TempExcelBufTemp.NewRow();
        TempExcelBufTemp.AddColumn(Vendor.FieldCaption("No."), false, '', true, false, true, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn(Vendor.FieldCaption(Name), false, '', true, false, true, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn(Vendor.FieldCaption(City), false, '', true, false, true, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn(Vendor.FieldCaption(Contact), false, '', true, false, true, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn(Vendor.FieldCaption("Search Name"), false, '', true, false, true, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn(Vendor.FieldCaption("Last Date Modified"), false, '', true, false, true, '', TempExcelBufTemp."Cell Type"::Text);
    end;

    local procedure MakeExcelVendorLine()
    begin
        TempExcelBufTemp.NewRow();
        TempExcelBufTemp.AddColumn(Vendor."No.", false, '', false, false, false, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn(Vendor.Name, false, '', false, false, false, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn(Vendor.City, false, '', false, false, false, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn(Vendor.Contact, false, '', false, false, false, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn(Vendor."Search Name", false, '', false, false, false, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn(Vendor."Last Date Modified", false, '', false, false, false, '', TempExcelBufTemp."Cell Type"::Date);
    end;

    local procedure MakeExcelItemHeader()
    begin
        TempExcelBufTemp.NewRow();
        TempExcelBufTemp.AddColumn(Item.FieldCaption("No."), false, '', true, false, true, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn(Item.FieldCaption(Description), false, '', true, false, true, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn(Item.FieldCaption("Base Unit of Measure"), false, '', true, false, true, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn(Item.FieldCaption(Type), false, '', true, false, true, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn(Item.FieldCaption("Unit Cost"), false, '', true, false, true, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn(Item.FieldCaption("Item Category Code"), false, '', true, false, true, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn(Item.FieldCaption("Last Date Modified"), false, '', true, false, true, '', TempExcelBufTemp."Cell Type"::Text);
    end;

    local procedure MakeExcelItemLine()
    begin
        TempExcelBufTemp.NewRow();
        TempExcelBufTemp.AddColumn(Item."No.", false, '', false, false, false, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn(Item.Description, false, '', false, false, false, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn(Item."Base Unit of Measure", false, '', false, false, false, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn(Item.Type, false, '', false, false, false, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn(Item."Unit Cost", false, '', false, false, false, '', TempExcelBufTemp."Cell Type"::Number);
        TempExcelBufTemp.AddColumn(Item."Item Category Code", false, '', false, false, false, '', TempExcelBufTemp."Cell Type"::Text);
        TempExcelBufTemp.AddColumn(Item."Last Date Modified", false, '', false, false, false, '', TempExcelBufTemp."Cell Type"::Date);
    end;
}