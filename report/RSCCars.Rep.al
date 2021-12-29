/// <summary>
/// Report "RSC_Cars" (ID 50100).
/// </summary>
report 50100 RSC_Cars
{
    ApplicationArea = All;
    Caption = 'Rental Cars';
    UsageCategory = ReportsAndAnalysis;
    WordLayout = './report/layout/RSC_Rental_Cars.docx';
    DefaultLayout = Word;

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = where("RSC_IsRentalCar" = const(true));
            column(No; "No.")
            {
            }
            column(NoLbl; NoLbl)
            {
            }
            column(Description; Description)
            {
            }
            column(DescriptionLbl; DescriptionLbl)
            {
            }
            column(UnitPrice; "Unit Price")
            {
                DecimalPlaces = 2 : 3;
            }

            column(Unit_Price_CaptionLbl; DailyPriveCaptionLbl)
            //column(Unit_Price_CaptionLbl; FieldCaption("Unit Price"))
            {

            }
            column(RSC_RegistrationPlate; RSC_RegistrationPlate)
            {
            }
            column(RSC_RegistrationPlateLbl; RSC_RegistrationPlateLbl)
            {
            }
            column(RSC_NumPassengers; RSC_NumPassengers)
            {
            }
            column(RSC_NumPassengersLbl; RSC_NumPassengersLbl)
            {
            }
            column(RSC_Mileage; RSC_Mileage)
            {

            }
            column(RSC_MileageLbl; RSC_MileageLbl)
            {

            }
            column(RepCaption; MyCaption)
            {
            }
            column(PageCaption; CurrReportPageNoCaptiomLbl)
            {
            }

        }
    }
    var
        MyCaption: Label 'Rental Cars';
        CurrReportPageNoCaptiomLbl: Label 'Page No - ';
        NoLbl: Label 'No.';
        DescriptionLbl: Label 'Description';
        DailyPriveCaptionLbl: Label 'Daily Price';
        RSC_RegistrationPlateLbl: Label 'Registration Plate';
        RSC_NumPassengersLbl: Label 'Number of Passengers';
        RSC_MileageLbl: Label 'Mileage';
}

