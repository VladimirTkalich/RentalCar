tableextension 50102 "Customer Extension (SIK)" extends "Customer" //18
{
    fields
    {
        // SWP.SEK-
        // Bring this to Tristar Credit Management
        // field(50001; "Credit Reviewed Date"; Date)
        // {
        //     trigger OnValidate();
        //     begin
        //         if FORMAT("Inactive Time Limit") <> '' then
        //             "Next Review Date" := CALCDATE("Inactive Time Limit", "Credit Reviewed Date");
        //     end;
        // }
        // field(50002; "Days Grace Period"; Integer)
        // {
        // }
        // field(50003; "Date Opened"; Date)
        // {
        // }
        // field(50004; "Last Order Date"; Date)
        // {
        // }
        // field(50005; "DB Flag"; Boolean)
        // {
        // }
        // field(50009; "Last Order Amount"; Decimal)
        // {
        // }
        // field(50010; "High Credit Amount"; Decimal)
        // {
        //     Editable = false;
        // }
        // field(50011; "High Credit Date"; Date)
        // {
        //     Editable = false;
        // }
        // field(50013; "Credit Over-Ride"; Option)
        // {
        //     InitValue = "Always Fail";
        //     OptionMembers = " ","Always Pass","Always Fail";
        // }
        // field(50014; "Last Invoice Date"; Date)
        // {
        // }
        // field(50015; "Last Invoice Amount"; Decimal)
        // {
        // }
        // field(50016; "Inactive Time Limit"; DateFormula)
        // {
        //     InitValue = '6M';
        //     NotBlank = true;
        //     trigger OnValidate();
        //     begin
        //         if FORMAT("Inactive Time Limit") <> '' then
        //             "Next Review Date" := CALCDATE("Inactive Time Limit", "Credit Reviewed Date");
        //     end;
        // }
        // SWP.SEK+
        field(50019; "Languge Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Language Type';
            OptionMembers = English,Spanish;
            OptionCaption = 'English, Spanish';
        }
        // SWP.SEK-
        // Bring this fields to Tristar Credit Management
        // field(50020; "Payment Days Average"; Decimal)
        // {
        //     CalcFormula = Average ("Cust. Ledger Entry"."Days to Pay" WHERE ("Customer No." = FIELD ("No."),
        //                                                                      "Days to Pay" = FILTER (<> 0)));
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(50022; "Last Refresh Date"; Date)
        // {
        // }
        // SWP.SEK+
        field(50034; Exempt1; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Exempt1';
        }
        field(50036; ExemptNo1; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'ExemptNo1';
        }
        field(50037; ExemptNo2; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'ExemptNo2';
        }
        // SWP.SEK
        // Bring to Tristar Credit Management
        // field(50038; "DUNS No."; Text[30])
        // {
        // }
        // SWP.SEK+
        field(50039; "Fed ID Num"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Fed ID Num';
        }
        // SWP.SEK
        // Bring to Tristar Credit Management
        // field(50040; "SIC Code"; Text[30])
        // {
        // }
        // field(50041; "NAICS Code"; Text[30])
        // {
        // }
        // field(50049; "Collection Comment"; Boolean)
        // {
        //     // CalcFormula = Exist ("Cust. Collection Comments" WHERE ("Customer No." = FIELD ("No.")));
        //     Editable = false;
        //     FieldClass = FlowField;
        // SWP.SEK
        field(50054; "Eniteo Customer Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Eniteo Customer Code';
        }
        field(50055; "Eniteo Customer ID"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Eniteo Customer ID';
        }
        field(50056; "Industry Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Industry Code';
            TableRelation = "Industry Group".Code WHERE(Code = FIELD("Industry Code"));
        }
        field(50057; "Industry Description"; Text[50])
        {
            Caption = 'Industry Description';
            CalcFormula = Lookup("Industry Group".Description WHERE(Code = FIELD("Industry Code")));
            FieldClass = FlowField;
            TableRelation = "Industry Group".Description WHERE(Code = FIELD("Industry Code"));
        }
        // swp.sek-
        // Bring this fields to Tristar Credit Management
        // field(50058; "Next Review Date"; Date)
        // {
        // }
        // swp.sek+
        field(50059; "AP E-mail"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'AP E-mail';
            ExtendedDatatype = EMail;
        }
        field(50060; Salesperson; Text[50])
        {
            Caption = 'Salesperson';
            CalcFormula = Lookup("Salesperson/Purchaser".Name WHERE(Code = FIELD("Salesperson Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50061; "Check For Surcharge"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Check For Surcharge';
        }
        field(50062; "Check For Tariff"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Check For Tariff';
        }
        /* As per Greg, in customer card observations, these lanham fields are not needed
        field(50071; "E-Mail Rule Code"; Code[10])
        {
            Caption = 'E-Mail Rule Code';
            // TableRelation = "E-Mail Rule";
        }
        field(50072; "E-Mail Cust. Stat. Send Date"; Date)
        {
            Caption = 'E-Mail Cust. Stat. Send Date';
            Editable = false;
        }
        field(50073; "Use E-Mail Rule for ShipToAddr"; Boolean)
        {
            Caption = 'Use E-Mail Rule for ShipToAddr';
        }
        */
        field(50073; "Comment Code Filter"; Code[10])
        {
            Caption = 'Comment Code Filter';
            Description = 'FP';
            FieldClass = FlowFilter;
        }

    }
}