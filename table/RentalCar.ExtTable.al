tableextension 50119 tvvRentalCar extends Item
{
    fields
    {
        field(50109; IsRentalCar; Boolean)
        {
            DataClassification = CustomerContent;
            InitValue = true;
        }
        field(50110; ModelNo; Code[10])
        {
            Caption = 'Model code';
            DataClassification = CustomerContent;
        }
        field(50111; NameModel; Text[20])
        {
            Caption = 'Model Name';
            FieldClass = FlowField;
            CalcFormula = lookup(tvvCarModel.NameModel where(NameModel = field("No.")));
        }
        field(50112; Mileage; Integer)
        {
            Caption = 'Mileage';
            DataClassification = CustomerContent;
        }
        field(50113; NumPassengers; Integer)
        {
            Caption = 'Number of passangers';
            DataClassification = CustomerContent;
        }
        field(50114; RegistrationPlate; Text[17])
        {
            Caption = 'Registration plate';
            DataClassification = CustomerContent;
        }


        //TODO Add to attributes: Manufacturer, Car Body Type, Fuel, Transmission, Number of Passengers, Options Set?, Class?

        //TODO Add field Availability wich related to the table with dates already reserved

        //TODO Add fields VIN, Registration Plate, Technical Condition (rating from 1 to 10)

        //TODO Add field Inshurance wich related to the table with the inshurance plicy information 
    }
}
