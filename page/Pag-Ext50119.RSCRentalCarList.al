pageextension 50119 "RSC_RentalCarList" extends "Item List"
{
    Caption = 'Rental Cars';

    layout
    {
        /*         addbefore(Description)
                {
                    field("RSC_Model"; Rec.NameModel)
                    {
                        ApplicationArea = all;
                    }
                }
         */
        addafter(Description)
        {
            /*             field("RSC_DateManufacture"; Rec.DateManufacture)
                        {
                            ApplicationArea = all;
                        }
             */
            field("RSC_Mileage"; Rec.RSC_Mileage)
            {
                ApplicationArea = all;
            }
            field("RSC_NumPassengers"; Rec.RSC_NumPassengers)
            {
                ApplicationArea = all;
            }
            field("RSC_RegistrationPlate"; Rec.RSC_RegistrationPlate)
            {
                ApplicationArea = all;
            }
            field("RSC_IsRentalCar"; Rec.RSC_IsRentalCar)
            {
                ApplicationArea = all;
            }
        }
        modify("Unit Price") //TODO Change Unit Price back, add a separate field for 'Unit Price per Day' and accumulate the cache total from all posted Rental Orders in field Unit Price
        {
            Caption = 'Unit Price per Day';
        }
        modify("Assembly BOM")
        {
            Visible = false;
        }
        modify(Type)
        {
            Visible = false;
        }
        modify(InventoryField)
        {
            Visible = false;
        }
        modify("Substitutes Exist")
        {
            Visible = false;
        }
        modify("Base Unit of Measure")
        {
            Visible = false;
        }
        modify("Cost is Adjusted")
        {
            Visible = false;
        }
        modify("Vendor No.")
        {
            Visible = false;
        }
        modify("Default Deferral Template Code")
        {
            Visible = false;
        }
    }

    /*     trigger OnOpenPage()
        var
            RentalCar: Record Item;
        begin
            RentalCar.SetRange(IsRentalCar, true);
        end;
     */
}

