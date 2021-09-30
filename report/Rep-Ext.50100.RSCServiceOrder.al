/// <summary>
/// Unknown "RSC_Service_Order" (ID 50100) extends Record Service Order.
/// </summary>
reportextension 50100 RSC_Service_Order extends "Service Order"
{
    RDLCLayout = 'report\layout\RSC_ServiceOrder.rdlc';

    dataset
    {
        //     addafter(No_ServHeader)
        //     {
        //         column(Order_lbl; MyCaption)
        //         {

        //         }
        //     }
    }

    var
        MyCaption: Label 'Rental Car Service Order';
}
