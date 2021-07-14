table 50129 "RSC_RentalSalesLine"
{
    Caption = 'Rental Sales Line';
    DataClassification = CustomerContent;
    LookupPageId = RSC_RentalSalesLines;
    DrillDownPageId = RSC_RentalSalesLines;

    fields
    {
        field(1; "Order No."; Code[20])
        {
            Caption = 'Order No.';
            DataClassification = CustomerContent;
            TableRelation = RSC_RentalSalesHeader;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "Car No."; Code[20])
        {
            Caption = 'Car No.';
            DataClassification = CustomerContent;
            TableRelation = Item;

            trigger OnValidate()
            begin
                CopyDataFromItem();
            end;
        }
        field(4; "Car Description"; Text[100])
        {
            Caption = 'Car Description';
            FieldClass = FlowField;
            CalcFormula = lookup(item.Description where("No." = field("Car No.")));
            Editable = false;
        }
        field(5; "Daily Price"; Decimal)
        {
            Caption = 'Daily Price';
            DataClassification = CustomerContent;
            // FieldClass = FlowField;
            // CalcFormula = lookup(Item."Unit Price" where("No." = field("Car No.")));
            // Editable = false;
        }
        field(6; "Pick up Location No."; Code[10])
        {
            Caption = 'Pick up Location No.';
            DataClassification = CustomerContent;
            TableRelation = Location;
        }
        field(15; "Pick up Location"; Text[100])
        {
            Caption = 'Pick up Location';
            FieldClass = FlowField;
            CalcFormula = lookup(Location.Name where("Code" = field("Pick up Location No.")));
            Editable = false;
        }
        field(7; "Drop off Location No."; Code[10])
        {
            Caption = 'Drop off Location No.';
            DataClassification = CustomerContent;
            TableRelation = Location;
        }
        field(16; "Drop off Location"; Text[100])
        {
            Caption = 'Drop off Location';
            FieldClass = FlowField;
            CalcFormula = lookup(Location.Name where("Code" = field("Drop off Location No.")));
            Editable = false;
        }
        field(8; "Rental Days"; Integer)
        {
            Caption = 'Rental Days';
            DataClassification = CustomerContent;
            InitValue = 0;
            Editable = false;
        }
        field(18; "Start Date"; Date)
        {
            Caption = 'Start Date';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                CalcRentalDays();
                CalcLineAmount();
                CalcOrderAmount();
            end;
        }
        field(19; "End Date"; Date)
        {
            Caption = 'End Date';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                CalcRentalDays();
                CalcLineAmount();
                CalcOrderAmount();
            end;
        }
        field(9; "Additional Drivers"; Integer)
        {
            Caption = 'Additional Drivers';
            DataClassification = CustomerContent;
        }
        field(10; "Surcharge for Add Drivers"; Decimal)
        {
            Caption = 'Surcharge for Add Drivers';
            DataClassification = CustomerContent;
        }
        field(11; "Age Main Driver"; Integer)
        {
            Caption = 'Age Main Driver';
            DataClassification = CustomerContent;
        }
        field(12; "Surcharge for Age Driver"; Decimal)
        {
            Caption = 'Surcharge for Age Driver';
            DataClassification = CustomerContent;
        }
        field(13; "Car Discount %"; Integer)
        {
            Caption = 'Car Discount %';
            DataClassification = CustomerContent;
        }
        field(14; Deposit; Decimal)
        {
            Caption = 'Deposit';
            DataClassification = CustomerContent;
        }
        field(17; "Line Amount"; Decimal)
        {
            Caption = 'Line Amount';
            DataClassification = CustomerContent;
            Editable = false;
        }

    }
    keys
    {
        key(PK; "Order No.", "Line No.")
        {
            Clustered = true;
        }
    }
    local procedure CalcRentalDays()
    var
        TDay: Integer;
    begin
        TDay := 0;
        if (Rec."Start Date" < TODAY()) then begin
            Rec."Rental Days" := TDay;
            Message('Start Date cannot be less than today');
            exit;
        end;
        if (Rec."End Date" <> 0D) AND (Rec."Start Date" <> 0D) then begin
            TDay := Rec."End Date" - Rec."Start Date";
            if (TDay < 0) then begin
                TDay := 0;
                Message('End Date cannot be less than Start Date');
            end;
            if (TDay = 0) then begin
                TDay := 0;
                Message('End Date cannot be e Start Date');
            end;
            Rec."Rental Days" := TDay;
        end;
    end;

    local procedure CalcLineAmount()
    var
        TempSum: Decimal;
        CustomerDiscount: Integer;
    begin
        TempSum := 0;
        CustomerDiscount := 0;
        if ("Rental Days" > 0) AND ("Daily Price" > 0) then begin
            TempSum := "Daily Price" * "Rental Days";
            if (GetCustomerDiscountIfExist(CustomerDiscount)) then begin
                TempSum := TempSum - (TempSum * CustomerDiscount) / 100;
            end;
            Rec."Line Amount" := Round(TempSum, 0.01, '>');
        end
        else
            "Line Amount" := 0;
    end;

    local procedure GetCustomerDiscountIfExist(var CustDiscount: Integer): Boolean
    begin
        CustDiscount := 0;
        if RentalHeader.Get("Order No.") then
            CustDiscount := RentalHeader."Customer Discount"
        else
            exit(false);
        if (CustDiscount = 0) then
            exit(false)
        else
            exit(true);
    end;

    local procedure CalcOrderAmount()
    var
        RentalLines: Record RSC_RentalSalesLine;
        TempAmount: Decimal;
    begin
        TempAmount := 0;
        if RentalHeader.Get("Order No.") then begin
            RentalLines.SetRange("Order No.", RentalHeader."Order No.");
            if RentalLines.FindFirst() then begin
                repeat
                    TempAmount := TempAmount + RentalLines."Line Amount";
                until RentalLines.Next() = 0;
            end;
            RentalHeader."Order Amount" := TempAmount;
            RentalHeader.Modify();
        end;
    end;

    local procedure CopyDataFromItem()
    var
        Car: Record Item;
    begin
        if ("Car No." = '') then
            exit;
        Car.Get("Car No.");
        Rec."Daily Price" := Car."Unit Price";
    end;

    var
        RentalHeader: Record RSC_RentalSalesHeader;
}
