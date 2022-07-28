tableextension 50105 "Reason Code Ext. (SIK)" extends "Reason Code" //231
{
    fields
    {
        field(50000; "Late Shipment Count"; Integer)
        {
            Caption = 'Late Shipment Count';
            //CalcFormula = Count ("Sales Invoice Header" WHERE ("Shipping Date Change Reason Cd" = FIELD (Code),
            //                                                  "Late Shipment" = CONST (true),
            //                                                  "Shipment Date" = FIELD ("Date Filter"),
            //                                                  "Location Code" = FIELD ("Location Filter")));
            Description = 'SIK';
            FieldClass = FlowField;
        }
        field(50001; "Location Filter"; Code[10])
        {
            Caption = 'Location Filter';
            Description = 'SIK';
            FieldClass = FlowFilter;
        }
        field(50002; "Entry Error"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Entry Error';
            Description = 'SIK';
        }
    }
}