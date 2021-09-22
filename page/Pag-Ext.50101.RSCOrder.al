/// <summary>
/// PageExtension "RSC_Order" (ID 50101) extends Record Service Order.
/// </summary>
pageextension 50101 RSC_Order extends "Service Order"
{
    Caption = 'Rental Cars Service Order';

    layout
    {
        modify("Response Date")
        {
            Visible = false;
        }
        modify("Response Time")
        {
            Visible = false;
        }
        modify(Priority)
        {
            Visible = false;
        }
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Assigned User ID")
        {
            Visible = false;
        }

        modify(Details) //Hide group Details
        {
            Visible = false;
        }

        modify("Location Code")
        {
            Visible = false;
        }
        modify("Shipping Advice")
        {
            Visible = false;
        }
        modify("Shipment Method Code")
        {
            Visible = false;
        }
        modify("Shipping Agent Code")
        {
            Visible = false;
        }
        modify("Shipping Agent Service Code")
        {
            Visible = false;
        }
        modify("Shipping Time")
        {
            Visible = false;
        }
    }

    // trigger OnOpenPage()
    // var
    //     TempJSONBuffer: Record "JSON Buffer" temporary;
    //     JsonDataText: Text;
    // begin
    //     JsonDataText := '{"version":"0.2.0","configurations":[{"name":"Microsoftcloudsandbox","request":"launch","type":"al","environmentType":"Sandbox","environmentName":"auto","startupObjectId":9022,"startupObjectType":"Page","schemaUpdateMode":"ForceSync","breakOnError":true,"launchBrowser":true,"enableLongRunningSqlStatements":true,"enableSqlInformationDebugger":true,"tenant":"48663930-37a7-4483-8d6e-57454fe6b2a6"}]}';
    //     TempJSONBuffer.ReadFromText(JsonDataText);
    //     Page.RunModal(Page::"Test JSON Buffer", TempJSONBuffer);
    // end;
}
