pageextension 50120 tvvRentalCarCard extends "Item Card"
{
    Caption = 'Rental Car';

    layout
    {
        /*         addbefore(Description)
                {
                    field(Model; Rec.NameModel)
                    {
                        ApplicationArea = all;
                    }
                }
         */
        addbefore(Type)
        {
            field(Mileage; Rec.Mileage)
            {
                ApplicationArea = all;
            }
            field(NumPassengers; Rec.NumPassengers)
            {
                ApplicationArea = all;
            }
            field(RegistrationPlate; Rec.RegistrationPlate)
            {
                ApplicationArea = all;
            }
        }
        modify("Base Unit of Measure")
        {
            Visible = false;
        }
        modify(Type)
        {
            Visible = false;
        }
    }
}
