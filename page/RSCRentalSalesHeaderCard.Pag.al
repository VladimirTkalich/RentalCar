/// <summary>
/// Page "RSC_RentalSalesHeaderCard" (ID 50100).
/// </summary>
page 50100 RSC_RentalSalesHeaderCard
{

    Caption = 'Rental Sales Order';
    PageType = Card;
    SourceTable = RSC_RentalSalesHeader;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Order No."; Rec."Order No.")
                {
                    ToolTip = 'Specifies the value of the Order No. field';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field';
                    ApplicationArea = All;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Customer No. field';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CurrPage.Update(true);
                    end;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ToolTip = 'Specifies the value of the Customer Name field';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Customer Discount"; Rec."Customer Discount")
                {
                    ToolTip = 'Specifies the value of the Customer Discount field';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Salesperson No."; Rec."Salesperson No.")
                {
                    ToolTip = 'Specifies the value of the Salesperson No. field';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CurrPage.Update(true);
                    end;
                }
                field("Salesperson Name"; Rec."Salesperson Name")
                {
                    ToolTip = 'Specifies the value of the Salesperson Name field';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field';
                    ApplicationArea = All;
                }
                field("Order Date"; Rec."Order Date")
                {
                    ToolTip = 'Specifies the value of the Order Date field';
                    ApplicationArea = All;
                }
            }
            part("Ordered Cars"; RSC_RentalSalesLinesPart)
            {
                SubPageLink = "Order No." = field("Order No.");
                ApplicationArea = All;
                UpdatePropagation = Both;
            }
            // group("Rental Order Amount")
            // {
            field("Order Amount"; Rec."Order Amount")
            {
                ToolTip = 'Specifies the value of the Order Amount field';
                ApplicationArea = All;
            }

            // }
        }
    }

}
