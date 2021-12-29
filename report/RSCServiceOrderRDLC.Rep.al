/// <summary>
/// Report "RSC_Service_Order_RDLC" (ID 50103).
/// </summary>
report 50103 RSC_Service_Order_RDLC
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './report/layout/RSC_Order.rdlc';
    Caption = 'RSC_Service_Order_RDLC';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(ServiceHeader; "Service Header")
        {
            DataItemTableView = SORTING("Document Type", "No.") WHERE("Document Type" = CONST(Order));
            RequestFilterFields = "Document Type", "No.", "Customer No.";
            column(No; ServiceHeader."No.")
            {
            }
            column(NoLbl; ServiceHeader.FieldCaption("No."))
            {
            }
            column(DocumentType; ServiceHeader."Document Type")
            {
            }
            column(DocumentTypeLbl; ServiceHeader.FieldCaption("Document Type"))
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    column(OutputNo; OutputNo)
                    {
                    }


                    // column(Rental_Order_Caption; Rental_Order_CaptionLbl)
                    column(Rental_Order_Caption; StrSubstNo(Rental_Order_CaptionLbl, CopyText))
                    {
                    }
                    column(DocumentDate; ServiceHeader."Document Date")
                    {
                    }
                    column(DocumentDateLbl; ServiceHeader.FieldCaption("Document Date"))
                    {
                    }
                    column(Description; ServiceHeader.Description)
                    {
                    }
                    column(DescriptionLbl; ServiceHeader.FieldCaption(Description))
                    {
                    }
                    column(ServiceOrderType; ServiceHeader."Service Order Type")
                    {
                    }
                    column(ServiceOrderTypeLbl; ServiceHeader.FieldCaption("Service Order Type"))
                    {
                    }


                    //Customer Info
                    column(CustomerNo; ServiceHeader."Customer No.")
                    {
                    }
                    column(CustomerNoLbl; ServiceHeader.FieldCaption("Customer No."))
                    {
                    }
                    column(ContactNo; ServiceHeader."Contact No.")
                    {
                    }
                    column(ContactNoLbl; ServiceHeader.FieldCaption("Contact No."))
                    {
                    }
                    column(Name; ServiceHeader.Name)
                    {
                    }
                    column(NameLbl; ServiceHeader.FieldCaption(Name))
                    {
                    }
                    column(Address; ServiceHeader.Address)
                    {
                    }
                    column(AddressLbl; ServiceHeader.FieldCaption(Address))
                    {
                    }
                    column(City; ServiceHeader.City)
                    {
                    }
                    column(CityLbl; ServiceHeader.FieldCaption(City))
                    {
                    }
                    column(County; ServiceHeader.County)
                    {
                    }
                    column(CountyLbl; ServiceHeader.FieldCaption(County))
                    {
                    }
                    column(PostCode; ServiceHeader."Post Code")
                    {
                    }
                    column(PostCodeLbl; ServiceHeader.FieldCaption("Post Code"))
                    {
                    }
                    column(ContactName; ServiceHeader."Contact Name")
                    {
                    }
                    column(ContactNameLbl; ServiceHeader.FieldCaption("Contact Name"))
                    {
                    }
                    column(EMail; ServiceHeader."E-Mail")
                    {
                    }
                    column(EMailLbl; ServiceHeader.FieldCaption("E-Mail"))
                    {
                    }

                    //Compani Info
                    column(CompanyName; CompanyInfo.Name)
                    {
                    }
                    column(CompanyAddr; CompanyInfo.Address)
                    {
                    }
                    column(CompanyCity; CompanyInfo.City)
                    {
                    }
                    column(CompanyState; CompanyInfo.County)
                    {
                    }
                    column(PageCaption; PageCaptionLbl)
                    {
                    }
                    column(PageFooterTotal; PageFooterTotalLbl)
                    {
                    }

                    dataitem("Service Item Line"; "Service Item Line")
                    {
                        DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                        DataItemLinkReference = ServiceHeader;
                        DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");
                        column(Service_Item_LinesCaption; Service_Item_LinesCaptionLbl)
                        {
                        }
                        column(Service_Item_Line___Line_No_; "Service Item Line"."Line No.")
                        {
                        }
                        column(Service_Item_Line__Service_Item_No; "Service Item No.")
                        {
                        }
                        column(Service_Item_Line__Service_Item_NoLbl; FieldCaption("Service Item No."))
                        {
                        }
                        column(ServItemGroupCode_ServItemLine; "Service Item Group Code")
                        {
                        }
                        column(Service_Item_Line__Service_Item_Group_CodeLbl; FieldCaption("Service Item Group Code"))
                        {
                        }
                        column(Service_Item_Line_Description; Description)
                        {
                        }
                        column(Service_Item_Line_DescriptionLbl; FieldCaption(Description))
                        {
                        }
                        column(Service_Item_Line__Response_Date; Format("Response Date"))
                        {
                        }
                        column(Service_Item_Line__Response_DateLbl; Service_Item_Line__Response_Date_CaptionLbl)
                        {
                        }

                    }
                    dataitem("Service Line"; "Service Line")
                    {
                        // DataItemLink = "Document No." = FIELD("Document No."), "Service Item No." = FIELD("Service Item No.");
                        DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                        DataItemLinkReference = ServiceHeader;
                        DataItemTableView = SORTING("Document No.", "Service Item No.", "Line No.");

                        column(OrderAmount; OrderAmount)
                        {
                        }
                        column(Service_LinesCaption; Service_LinesCaptionLbl)
                        {
                        }
                        column(Service_Line_Line_No; "Service Line"."Line No.")
                        {
                        }
                        column(Service_Line_Line_NoLbl; FieldCaption("Service Line"."Line No."))
                        {
                        }
                        column(Service_Line_Type; Type)
                        {
                        }
                        column(Service_Line_TypeLbl; FieldCaption(Type))
                        {
                        }
                        column(Service_Line_No; "No.")
                        {
                        }
                        column(Service_Line_NoLbl; FieldCaption("No."))
                        {
                        }
                        column(Service_Line_Description; Description)
                        {
                        }
                        column(Service_Line_DescriptionLbl; FieldCaption(Description))
                        {
                        }
                        column(Service_Line_Quantity; Quantity)
                        {
                        }
                        column(Service_Line_QuantityLbl; FieldCaption(Quantity))
                        {
                        }
                        column(Service_Line_Unit_of_Measure; "Unit of Measure")
                        {
                        }
                        column(Service_Line_Unit_of_MeasureLbl; FieldCaption("Unit of Measure"))
                        {
                        }
                        column(Service_Line_UnitPrice; "Unit Price")
                        {
                        }
                        column(Service_Line_UnitPriceLbl; FieldCaption("Unit Price"))
                        {
                        }
                        column(Service_Line_Line_Discount; "Line Discount %")
                        {
                        }
                        column(Service_Line_Line_DiscountLbl; FieldCaption("Line Discount %"))
                        {
                        }
                        column(Service_Line_Line_Amount; "Line Amount")
                        {
                        }
                        column(Service_Line_Line_AmountLbl; FieldCaption("Line Amount"))
                        {
                        }
                        trigger OnAfterGetRecord()
                        begin
                            OrderAmount := "Line Amount";
                        end;
                    }

                }
                trigger OnAfterGetRecord()
                begin
                    if Number > 1 then begin
                        CopyText := FormatDocument.GetCOPYText;
                        CopyText := CopyText + ' № ' + System.Format(OutputNo);
                        OutputNo += 1;
                    end;
                    // OrderAmount := 20;
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := Abs(NoOfCopies) + 1;
                    if NoOfLoops <= 0 then
                        NoOfLoops := 1;
                    CopyText := '';
                    SetRange(Number, 1, NoOfLoops);
                    OutputNo := 1;
                end;
            }
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
                    field(NoOfCopies; NoOfCopies)
                    {
                        ApplicationArea = Service;
                        Caption = 'No. of Copies';
                        ToolTip = 'Specifies how many copies of the document to print.';
                    }
                }
            }
        }
        actions
        {
        }
        // trigger OnInit()
        // begin

        // end;
    }

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
    end;

    var
        CompanyInfo: Record "Company Information";
        Rental_Order_CaptionLbl: Label 'Rental Car Order %1';
        Service_Item_LinesCaptionLbl: Label 'Rental Item Lines';
        Service_Item_Line__Response_Date_CaptionLbl: Label 'Date';
        Service_LinesCaptionLbl: Label 'Rental Lines';
        PageCaptionLbl: Label 'Page:';
        PageFooterTotalLbl: Label 'Order total:';
        OrderAmount: Decimal;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        OutputNo: Integer;
        FormatDocument: Codeunit "Format Document";
        CopyText: Text[30];



}
