/// <summary>
/// Table Test RSC_RentalSalesHeader (ID 50128).
/// </summary>
table 50128 "RSC_RentalSalesHeader"
{
    Caption = 'Rental Sales Header';
    DataClassification = CustomerContent;
    LookupPageId = RSC_RentalSalesHeaders;
    DrillDownPageId = RSC_RentalSalesHeaders;

    fields
    {
        field(1; "Order No."; Code[20])
        {
            Caption = 'Order No.';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = CustomerContent;
            TableRelation = Customer;
            trigger OnValidate()
            var
                TempCustomer: Record Customer;
            begin
                if (Rec."Customer No." <> '') AND (TempCustomer.Get(Rec."Customer No.")) then begin
                    Rec."Customer Discount" := TempCustomer.RSC_Discount;
                end;
            end;

        }
        field(4; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Customer.Name where("No." = field("Customer No.")));
            Editable = false;
        }
        field(10; "Customer Discount"; Integer)
        {
            Caption = 'Customer Discount';
            DataClassification = CustomerContent;
            InitValue = 0;
        }
        field(5; "Salesperson No."; Code[20])
        {
            Caption = 'Salesperson No.';
            DataClassification = CustomerContent;
            TableRelation = "Salesperson/Purchaser";
        }
        field(6; "Salesperson Name"; Text[50])
        {
            Caption = 'Salesperson Name';
            FieldClass = FlowField;
            CalcFormula = lookup("Salesperson/Purchaser".Name where("Code" = field("Salesperson No.")));
            Editable = false;
        }
        field(8; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = CustomerContent;
        }
        field(9; "Order Date"; Date)
        {
            Caption = 'Order Date';
            DataClassification = CustomerContent;
        }
        field(11; "Order Amount"; Decimal)
        {
            Caption = 'Order Amount';
            DataClassification = CustomerContent;
            InitValue = 0;
        }
    }
    keys
    {
        key(PK; "Order No.")
        {
            Clustered = true;
        }
    }

}
