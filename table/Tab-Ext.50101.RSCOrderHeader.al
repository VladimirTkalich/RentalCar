/// <summary>
/// TableExtension "RSC_Order_Header" (ID 50101) extends Record Service Header.
/// </summary>
tableextension 50101 RSC_Order_Header extends "Service Header"
{
    fields
    {
        field(50010; "RSC_Customer Discount"; Integer)
        {
            Caption = 'Customer Discount';
            DataClassification = CustomerContent;
            InitValue = 0;
        }
        field(50020; "RSC_Salesperson No."; Code[20])
        {
            Caption = 'Salesperson No.';
            DataClassification = CustomerContent;
            TableRelation = "Salesperson/Purchaser";
        }
        field(50030; "RSC_Salesperson Name"; Text[50])
        {
            Caption = 'Salesperson Name';
            FieldClass = FlowField;
            CalcFormula = lookup("Salesperson/Purchaser".Name where("Code" = field("RSC_Salesperson No.")));
            Editable = false;
        }



    }

    trigger OnInsert()
    begin
        SetUpOrder();
    end;

    local procedure SetUpOrder()
    begin
        Rec."Service Order Type" := 'RENTALCAR';
    end;

}
