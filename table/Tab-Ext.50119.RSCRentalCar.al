/// <summary>
/// TableExtension RSC_RentalCar (ID 50119) extends Record Item.
/// </summary>
tableextension 50119 "RSC_RentalCar" extends Item
{
    fields
    {
        field(50109; "RSC_IsRentalCar"; Boolean)
        {
            DataClassification = CustomerContent;
            InitValue = true;
        }
        field(50110; "RSC_ModelNo"; Code[10])
        {
            Caption = 'Model code';
            DataClassification = CustomerContent;
        }
        field(50111; "RSC_NameModel"; Text[20])
        {
            Caption = 'Model Name';
            FieldClass = FlowField;
            CalcFormula = lookup(RSC_CarModel.NameModel where(NameModel = field("No.")));
            Editable = false;
        }
        field(50112; "RSC_Mileage"; Integer)
        {
            Caption = 'Mileage';
            DataClassification = CustomerContent;
        }
        field(50113; "RSC_NumPassengers"; Integer)
        {
            Caption = 'Number of passangers';
            DataClassification = CustomerContent;
        }
        field(50114; "RSC_RegistrationPlate"; Text[17])
        {
            Caption = 'Registration plate';
            DataClassification = CustomerContent;
        }


        //TODO Add to attributes: Manufacturer, Car Body Type, Fuel, Transmission, Number of Passengers, Options Set?, Class?

        //TODO Add field Availability wich related to the table with dates already reserved

        //TODO Add fields VIN, Registration Plate, Technical Condition (rating from 1 to 10)

        //TODO Add field Inshurance wich related to the table with the inshurance plicy information 
    }

    // trigger OnAfterInsert()
    // begin
    //     SetUpRentalCar();
    // end;

    // local procedure SetUpRentalCar()
    // var
    //     ItemType: Enum "Item Type";
    // begin
    //     Rec."Base Unit of Measure" := 'DAY';
    //     Rec.Type := ItemType::Service;
    // end;

}
