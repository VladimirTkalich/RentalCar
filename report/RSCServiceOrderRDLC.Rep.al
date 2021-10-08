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
            column(Rental_Order_Caption; Rental_Order_CaptionLbl)
            {
            }
            column(No; "No.")
            {
            }
            column(NoLbl; FieldCaption("No."))
            {
            }
            column(DocumentType; "Document Type")
            {
            }
            column(DocumentTypeLbl; FieldCaption("Document Type"))
            {
            }
            column(DocumentDate; "Document Date")
            {
            }
            column(DocumentDateLbl; FieldCaption("Document Date"))
            {
            }
            column(Description; Description)
            {
            }
            column(DescriptionLbl; FieldCaption(Description))
            {
            }
            column(ServiceOrderType; "Service Order Type")
            {
            }
            column(ServiceOrderTypeLbl; FieldCaption("Service Order Type"))
            {
            }


            //Customer Info
            column(CustomerNo; "Customer No.")
            {
            }
            column(CustomerNoLbl; FieldCaption("Customer No."))
            {
            }
            column(ContactNo; "Contact No.")
            {
            }
            column(ContactNoLbl; FieldCaption("Contact No."))
            {
            }
            column(Name; Name)
            {
            }
            column(NameLbl; FieldCaption(Name))
            {
            }
            column(Address; Address)
            {
            }
            column(AddressLbl; FieldCaption(Address))
            {
            }
            column(City; City)
            {
            }
            column(CityLbl; FieldCaption(City))
            {
            }
            column(County; County)
            {
            }
            column(CountyLbl; FieldCaption(County))
            {
            }
            column(PostCode; "Post Code")
            {
            }
            column(PostCodeLbl; FieldCaption("Post Code"))
            {
            }
            column(ContactName; "Contact Name")
            {
            }
            column(ContactNameLbl; FieldCaption("Contact Name"))
            {
            }
            column(EMail; "E-Mail")
            {
            }
            column(EMailLbl; FieldCaption("E-Mail"))
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
                dataitem("Service Line"; "Service Line")
                {
                    DataItemLink = "Document Type" = FIELD("Document Type"), "Service Item No." = FIELD("Service Item No.");
                    DataItemLinkReference = "Service Item Line";
                    DataItemTableView = SORTING("Document Type", "Service Item No.", "Line No.");

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
        }
        // trigger OnInit()
        // begin

        // end;
    }


    var
        CompanyInfo: Record "Company Information";
        Rental_Order_CaptionLbl: Label 'Rental Car Order';
        Service_Item_LinesCaptionLbl: Label 'Rental Item Lines';
        Service_Item_Line__Response_Date_CaptionLbl: Label 'Date';
        Service_LinesCaptionLbl: Label 'Rental Lines';
        PageCaptionLbl: Label 'Page:';
        PageFooterTotalLbl: Label 'Order total:';
        OrderAmount: Decimal;

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
    end;


}
