tableextension 50103 "Sales Header Ext. (SIK)" extends "Sales Header" //36
{
    fields
    {
        // SWP.SEK-
        // Bring to Tristar Credit Management
        // field(50000; "Pick Ticket Printed"; Boolean)
        // {
        // }
        // field(50001; "Credit Status"; Option)
        // {
        //     Editable = false;
        //     OptionMembers = Untested,Fail,Pass,"Manual Override","Credit Hold";
        // }
        // field(50002; "Past Due Invoices"; Boolean)
        // {
        //     Editable = false;
        // }
        // field(50003; "Exceeded Credit Limit"; Boolean)
        // {
        //     Editable = false;
        // }
        // field(50007; "Elapsed Time Exceeded"; Boolean)
        // {
        //     Editable = false;
        // }
        // field(50009; "Max Dollar Order Size Exceeded"; Boolean)
        // {
        //     Editable = false;
        // }
        // field(50011; "Credit Over-Ride Set"; Option)
        // {
        //     Editable = false;
        //     OptionMembers = " ","Always Pass","Always Fail";
        // }
        // Bring to Tristar Credit Management
        // field(50013; "Credit Card Account"; Boolean)
        // {
        //     Editable = false;
        // }
        // field(50014; "Credit Tested Date"; Date)
        // {
        //     Editable = false;
        // }
        // field(50016; "Credit Hold Note"; Text[30])
        // {
        // }
        // SWP.SEK+
        // field(50020;"Routing Required";Boolean)
        // {
        //     Editable = false;
        // }
        // field(50021;"Routing Override";Boolean)
        // {
        // }
        field(50023; "Lines Not Reserved"; Integer)
        {
            Caption = 'Lines Not Reserved';
            CalcFormula = Count("Sales Line" WHERE("Document Type" = FIELD("Document Type"),
                                                    "Document No." = FIELD("No."),
                                                    Type = CONST(Item),
                                                    "Ready to Ship" = FILTER(<> true),
                                                    "Outstanding Quantity" = FILTER(<> 0)));
            Editable = false;
            FieldClass = FlowField;
        }
        // field(50024;"Shippable Amount";Decimal)
        // {
        //     CalcFormula = Sum("Sales Line"."Shippable Amount" WHERE ("Document Type"=FIELD("Document Type"),
        //                                                              "Document No."=FIELD("No.")));
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        field(50025; "Shipping Priority"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Shipping Priority';
            InitValue = Normal;
            OptionMembers = "Overnight - Next Day",Rush,Normal,FT,NF;
        }
        field(50026; "Booking Status"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Booking Status';
            Editable = false;
            OptionMembers = Booked,Rebooked,"Pending Approval",Approved;
        }
        field(50027; "Orig. Booking Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Orig. Booking Date';
        }
        // field(50028;"Cubage to Ship";Decimal)
        // {
        //     CalcFormula = Sum("Sales Line"."Cubage To Ship" WHERE ("Document Type"=FIELD("Document Type"),
        //                                                            "Document No."=FIELD("No.")));
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(50029;"Shippable Quantity";Decimal)
        // {
        //     CalcFormula = Sum("Sales Line"."Shippable Qty" WHERE ("Document Type"=FIELD("Document Type"),
        //                                                           "Document No."=FIELD("No."),
        //                                                           Type=CONST(Item)));
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(50030;"Whs Shipment Created";Boolean)
        // {
        //     CalcFormula = Exist("Warehouse Shipment Line" WHERE ("Source No."=FIELD("No.")));
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(50031;"Collection Contact";Code[20])
        // {
        //     TableRelation = Contact;

        //     trigger OnLookup();
        //     var
        //         ContBusRel : Record "Contact Business Relation";
        //         Cont : Record Contact;
        //     begin
        //         ContBusRel.SETCURRENTKEY("Link to Table","No.");
        //         ContBusRel.SETRANGE("Link to Table",ContBusRel."Link to Table"::Customer);
        //         ContBusRel.SETRANGE("No.","Bill-to Customer No.");
        //         if ContBusRel.FINDFIRST then
        //           Cont.SETRANGE("Company No.",ContBusRel."Contact No.")
        //         else
        //           Cont.SETRANGE("No.",'');

        //         if PAGE.RUNMODAL(0,Cont) = ACTION::LookupOK then
        //           VALIDATE("Collection Contact",Cont."No.");
        //     end;
        // }
        field(50032; "VCost Code 1"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Cost Code 1';
            Editable = false;
            InitValue = 'FREIGHT';
            // TableRelation = "Variable Cost Codes";
        }
        field(50033; "VCost Amt 1"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cost Amount 1';
        }
        // field(50034;"VCost Code 2";Code[10])
        // {
        //     Caption = 'Cost Code 2';
        //     TableRelation = "Variable Cost Codes";
        // }
        // field(50035;"VCost Amt 2";Decimal)
        // {
        //     Caption = 'Cost Amount 2';
        // }
        // field(50036;"VCost Code 3";Code[10])
        // {
        //     Caption = 'Cost Code 3';
        //     TableRelation = "Variable Cost Codes";
        // }
        // field(50037;"VCost Amt 3";Decimal)
        // {
        //     Caption = 'Cost Amount 3';
        // }
        field(50038; "VCost Code 1 Text"; Text[7])
        {
            DataClassification = CustomerContent;
            Caption = 'VCost Code 1 Text';
            Editable = false;
            InitValue = 'FREIGHT';
        }
        // field(50040;"Whs Shipment No.";Code[20])
        // {
        //     CalcFormula = Min("Warehouse Shipment Line"."No." WHERE ("Source No."=FIELD("No.")));
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(50041;"Department Store";Boolean)
        // {
        // }
        field(50045; "External Tracking No."; Code[30])
        {
            Caption = 'External Tracking No.';
            CalcFormula = Lookup("Sales Line"."External Tracking No." WHERE("Document Type" = FIELD("Document Type"),
                                                                             "Document No." = FIELD("No."),
                                                                             "External Tracking No." = FILTER(<> '')));
            FieldClass = FlowField;
        }
        // field(50050;"Authorization #";Code[10])
        // {

        //     trigger OnValidate();
        //     begin
        //         TESTFIELD(Status,Status::Open);
        //     end;
        // }
        // field(50051;"Authorization Date";Date)
        // {
        // }
        // SWP.SEK-
        // Bring to Tristar Credit Management
        // field(50054; "Total Line Amt Excl. Tax"; Decimal)
        // {
        //     CalcFormula = Sum ("Sales Line"."Line Amount" WHERE ("Document Type" = FIELD ("Document Type"),
        //                                                         "Document No." = FIELD ("No.")));
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // SWP.SEK+
        // field(50055;"Authorization Amount";Decimal)
        // {
        // }
        field(50056; "Posted Shipment No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Posted Shipment No.';
            Description = 'SIK-447719';
        }
        field(50057; "Posted Invoice No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Posted Invoice No.';
            Description = 'SIK-447719';
        }
        // SWP.SEK-
        // Bring to Tristar Credit Management
        // field(50058; "Acknowledgement Sent"; Option)
        // {
        //     Description = 'SIK-496731';
        //     OptionCaption = ',Sent by Email,Sent by Fax,Sent by Mail,Print to PDF';
        //     OptionMembers = ,"Sent by Email","Sent by Fax","Sent by Mail","Print to PDF";
        // }
        // field(50059; "Acknowledgement Sent Date"; Date)
        // {
        //     Description = 'SIK-496731';
        // }
        // field(50060; Revision; Integer)
        // {
        //     Description = 'SIK-496731';
        // }
        // SWP.SEK+
        field(50061; "Check For Surcharge"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Check For Surcharge';
            TableRelation = Customer."Check For Surcharge" WHERE("No." = FIELD("Sell-to Customer No."));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(50062; "Check For Tariff"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Check For Tariff';
            TableRelation = Customer."Check For Tariff" WHERE("No." = FIELD("Sell-to Customer No."));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(50071; "Ship-for Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Ship-for Code';
            TableRelation = "Ship-to Address".Code WHERE("Customer No." = FIELD("Sell-to Customer No."));

            trigger OnValidate();
            begin
                // if "Ship-for Code" <> '' then begin
                //   ShipToAddr.GET("Sell-to Customer No.","Ship-for Code");
                //   "External Ship-for No." := ShipToAddr."External No.";
                //   if ShipToAddr."Dist. Center Ship-to Code" <> '' then
                //     VALIDATE("Ship-to Code",ShipToAddr."Dist. Center Ship-to Code")
                //   else
                //     VALIDATE("Ship-to Code","Ship-for Code");
                // end else
                //   "External Ship-for No." := '';
            end;
        }
        field(50079; "Total Qty. Outstd (Base)"; Decimal)
        {
            Caption = 'Total Qty. Outstd (Base';
            CalcFormula = Sum("Sales Line"."Outstanding Qty. (Base)" WHERE("Document Type" = FIELD("Document Type"),
                                                                            "Document No." = FIELD("No."),
                                                                            Type = CONST(Item)));
            FieldClass = FlowField;
        }
        // field(50080;"Order Comment";Text[80])
        // {
        // }
        field(50081; "Pick Created"; Boolean)
        {
            Caption = 'Pick Created';
            CalcFormula = Exist("Warehouse Activity Header" WHERE("Source No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50082; "Salesperson Name"; Text[50])
        {
            Caption = 'Salesperson Name';
            CalcFormula = Lookup("Salesperson/Purchaser".Name WHERE(Code = FIELD("Salesperson Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50085; "Original Shipping Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Original Shipping Date';
            Description = 'SIK';
            Editable = false;

            trigger OnValidate();
            begin
                UpdateSalesLines(FIELDCAPTION("Original Shipping Date"), false); //SIK-548845
            end;
        }
        field(50086; "WH Notes"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'WH Notes';
        }
        field(50087; "Shipping Date Change Reason Cd"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Shipping Date Change Reason Cd';
            TableRelation = "Reason Code".Code;

            trigger OnValidate();
            var
                ReasonCode: Record "Reason Code";
            begin
                if "Shipping Date Change Reason Cd" <> '' then begin
                    ReasonCode.GET("Shipping Date Change Reason Cd");
                    "Change Reason Entry Error" := ReasonCode."Entry Error";
                end;
            end;
        }
        field(50089; "Change Reason Entry Error"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Change Reason Entry Error';
            Description = 'SIK';
        }
        field(50090; "Last Shipment Post Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Actual First Shipment Date';
            // Caption = 'Last Shipment Post Date';
        }
        // SWP.SEK-
        // Bring to Tristar Credit Management
        // field(70000; "Lines Shipped Not Invoiced"; Integer)
        // {
        //     CalcFormula = Count ("Sales Line" WHERE ("Document Type" = CONST (Order),
        //                                             "Document No." = FIELD ("No."),
        //                                             "Qty. Shipped Not Invoiced" = FILTER (<> 0)));
        //     Description = 'FP';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // SWP.SEK+
        field(50091; "Ready for Shipping"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Ready for Shipping';
            Description = 'FP';
        }
        field(50092; "No. Pick Printed"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. Pick Printed';
            Description = 'FP6';
        }
        field(50093; "Orig. Invoice No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Orig. Invoice No.';
            Description = 'FP6.2.08';
            TableRelation = "Sales Invoice Header"."No." WHERE("Sell-to Customer No." = FIELD("Sell-to Customer No."));
        }
        field(50098; "Approver ID_SIK"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Approver ID';
            TableRelation = Employee."User ID_SIK" WHERE("Product Manager_SIK" = const(true));
            trigger OnValidate()
            begin
                if Status <> Status::Open then
                    error('Order Status must be Open to modify Approver ID.')
            end;
        }

        //sales order observations - 5/20/2019
        modify("External Document No.")
        {
            Caption = 'Customer PO No.';
        }
    }

    // procedure InT_Create_Revised_Version()
    // var
    //     CopySalesDocument: Report "Copy Sales Document";
    //     IsHandled: Boolean;
    // begin
    //     CopySalesDocument.SetParameters("Sales Document Type From"::Quote, Rec."No.",true,false);

    //     CopySalesDocument.SetSalesHeader(Rec);
    //     CopySalesDocument.RunModal();
    // end;
}