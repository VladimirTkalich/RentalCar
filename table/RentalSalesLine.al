table 50129 tvvRentalSalesLine
{
    Caption = 'Rental Sales Line';
    DataClassification = CustomerContent;
    LookupPageId = tvvRentalSalesLines;
    DrillDownPageId = tvvRentalSalesLines;

    fields
    {
        field(1; "Order No."; Code[20])
        {
            Caption = 'Order No.';
            DataClassification = CustomerContent;
            TableRelation = tvvRentalSalesHeader;
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
            FieldClass = FlowField;
            CalcFormula = lookup(Item."Unit Price" where("No." = field("Car No.")));
            Editable = false;
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
            InitValue = 1;
        }
        field(18; "Start Date"; Date)
        {
            Caption = 'Start Date';
            DataClassification = CustomerContent;
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
        }

    }
    keys
    {
        key(PK; "Order No.", "Line No.")
        {
            Clustered = true;
        }
    }

}
