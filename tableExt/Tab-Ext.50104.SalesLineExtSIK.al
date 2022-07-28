tableextension 50104 "Sales Line Ext. (SIK)" extends "sales line" //37
{
    // SWP.20190607.1.SEK Uncomment field Ready to Ship
    fields
    {
        // field(50000;"Unit Weight";Decimal)
        // {
        //     Caption = 'Unit Weight';
        // }
        // field(50002;"Weight To Ship";Decimal)
        // {
        //     Caption = 'Weight to Ship';
        // }
        field(50003; "Ready to Ship"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Ready to Ship';
            Editable = false;
        }
        // field(50004;"Shippable Amount";Decimal)
        // {
        //     Caption = 'Shippable Amount';
        //     Editable = false;
        // }
        // field(50005;"Shippable Qty";Decimal)
        // {
        //     Caption = 'Shippable Qty';
        //     Editable = false;

        //     trigger OnValidate();
        //     begin
        //         //ICS1.01
        //         "Shippable Amount" := "Shippable Qty" * "Unit Price";
        //         "Weight To Ship" := "Shippable Qty" * "Unit Weight";
        //         VALIDATE("Unit Cubage (Base)");
        //         //END ICS1.01
        //     end;
        // }
        // field(50006;"Manual Price";Boolean)
        // {
        //     Caption = 'Manual Price';
        //     Editable = false;
        // }
        // field(50007;"Reserved OH (Base)";Decimal)
        // {
        //     Caption = 'Reserved OH (Base)';
        //     Editable = false;
        // }
        // field(50008;"Reserved PO (Base)";Decimal)
        // {
        //     Caption = 'Reserved PO (Base)';
        //     Editable = false;
        // }
        // field(50009;"Reservation Status";Option)
        // {
        //     Caption = 'Reservation Status';
        //     Description = 'None,Purchase Order,Mixed,On Hand,Partial,Transfer Order';
        //     Editable = false;
        //     OptionMembers = "None","Purchase Order",Mixed,"On Hand",Partial,"Transfer Order";
        // }
        // field(50010;"Ad Dollar";Decimal)
        // {
        //     Caption = 'Ad Dollar';
        // }
        // field(50011;"Misc Dollar";Decimal)
        // {
        //     Caption = 'Misc Dollar';
        // }
        // field(50013;"Unit Cubage (Base)";Decimal)
        // {
        //     Caption = 'Unit Cubage (Base)';

        //     trigger OnValidate();
        //     begin
        //         "Cubage To Ship" := "Unit Cubage (Base)" * "Shippable Qty";
        //     end;
        // }
        // field(50014;"Cubage To Ship";Decimal)
        // {
        //     Caption = 'Cubage To Ship';
        // }
        // field(50015;"Outstanding Ctn";Decimal)
        // {
        //     Caption = 'Outstanding Ctn';
        // }
        field(50016; "Outstanding Ea"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Outstanding Ea';
        }
        field(50017; "Base Price"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Base Price';
            DecimalPlaces = 0 : 4;

            trigger OnValidate();
            begin
                VALIDATE("Unit Price"); //
            end;
        }
        field(50018; Surcharge; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Surcharge';
            DecimalPlaces = 0 : 4;

            trigger OnValidate();
            begin
                VALIDATE("Unit Price");
            end;
        }
        field(50019; "S&H/LBS"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'S&H/LBS';
            DecimalPlaces = 0 : 4;

            /* moved to table events
                trigger OnValidate();
                begin
                    "CalcTotSH&Pkg"; //SIK 2017.01.10
                end;
                */
        }
        field(50020; "Total S&H Cost"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total S&H Cost';
            Editable = false;
        }
        field(50021; "PKG per LBS"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'PKG per LBS';
            DecimalPlaces = 0 : 4;

            /* moved to table events 
            trigger OnValidate();
              begin
                  "CalcTotSH&Pkg"; //SIK 2017.01.10
              end; */
        }
        field(50022; "Total PKG Cost"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total PKG Cost';
            /* 
            moved to table events
            trigger OnValidate();
            begin
                "PKG per LBS" := "Total PKG Cost" / "Quantity (Base)"; //SIK 2017.01.10

                "CalcTotSHPkg"; //SIK 2017.01.10
            end;
            */
        }
        field(50025; "External Tracking No."; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'External Tracking No.';
            Description = 'SIK499850';
        }
        field(50026; "Material Source Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Material Source Type';
            Description = 'SIK504295';
            OptionMembers = Inventory,Purchase,Production;

            trigger OnValidate();
            begin
                if Rec."Material Source Type" <> xRec."Material Source Type" then
                    "Material Source No." := '';
            end;
        }
        field(50027; "Material Source No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Material Source No.';
            Description = 'SIK504295';

            trigger OnLookup();
            begin
                MaterialSourceNoOnLookup;
            end;
        }
        field(50028; "Sell-to Customer Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Sell-to Customer Name';
            Description = 'SIK-548845';
        }
        field(50029; "External Document No."; Code[35])
        {
            DataClassification = CustomerContent;
            Caption = 'Customer PO No.';
            Description = 'SIK-548845';
        }
        field(50082; "Salesperson Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Salesperson Name';
            Description = 'SIK-548845';
            Editable = false;
            FieldClass = Normal;
        }
        field(50085; "Original Shipping Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Original Shipping Date';
            Description = 'SIK-548845';
            Editable = false;
        }
        // field(50100; Length; Decimal)
        // {
        //     DecimalPlaces = 0 : 4;
        // }
        field(50101; "Allow Qty Change"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Allow Qty Change';
            Description = 'FP  system entered and temp';
            Editable = false;
        }
        field(50102; "Original Qty"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Original Qty';
            DecimalPlaces = 0 : 2;
            Description = 'FP  system entered';
            Editable = false;
        }
        field(50103; "Orig Unit of Measure Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Orig Unit of Measure Code';
            Description = 'FP  system entered';
            Editable = false;
            TableRelation = IF (Type = CONST(Item)) "Item Unit of Measure".Code WHERE("Item No." = FIELD("No."))
            ELSE
            "Unit of Measure";
        }
        field(50104; "Original Qty (Base)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Original Qty (Base)';
            DecimalPlaces = 0 : 2;
            Description = 'FP  system entered';
            Editable = false;
        }
        field(50105; "Outstanding Sales Amt."; Decimal)
        {
            CalcFormula = Sum("Sales Line"."Outstanding Amount (LCY)" WHERE("Document Type" = CONST(Order)));
            DecimalPlaces = 0 : 2;
            Description = 'FP 6.3';
            FieldClass = FlowField;
        }

    }
    local procedure MaterialSourceNoOnLookup()
    var
        ProdOrder: Record "Production Order";
        PurchHdr: Record "Purchase Header";
    begin
        case "Material Source Type" of
            "Material Source Type"::Production:
                begin
                    ProdOrder.RESET;
                    ProdOrder.SETRANGE(Status, ProdOrder.Status::Released);
                    ProdOrder.SETRANGE("Location Code", "Location Code");
                    ProdOrder.SETRANGE("Source No.", "No.");
                    if PAGE.RUNMODAL(PAGE::"Released Production Orders", ProdOrder) = ACTION::LookupOK then
                        "Material Source No." := ProdOrder."No.";
                end;
            "Material Source Type"::Purchase:
                begin
                    PurchHdr.SETRANGE("Document Type", PurchHdr."Document Type"::Order);
                    PurchHdr.SETRANGE(Status, PurchHdr.Status::Released);
                    PurchHdr.SETRANGE("Location Code", "Location Code");
                    if PAGE.RUNMODAL(PAGE::"Purchase Order List", PurchHdr) = ACTION::LookupOK then
                        "Material Source No." := PurchHdr."No.";
                end;
        end;
    end;
}