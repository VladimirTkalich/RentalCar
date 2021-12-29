/// <summary>
/// Report RSC_Cars_RDLC (ID 50102).
/// </summary>
report 50102 "RSC_Cars_RDLC"
{
    ApplicationArea = All;
    Caption = 'Rental Cars RDLS';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './report/layout/RSC_Rental_Cars.rdlc';

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

            column(Last_Date_Modified; Format("Last Date Modified"))
            {

            }
            column(Last_Date_ModifiedLbl; Last_Date_ModifiedLbl)
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
        Last_Date_ModifiedLbl: Label 'Lfst Date Modied';
}
