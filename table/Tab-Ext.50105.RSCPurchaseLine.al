tableextension 50105 "RSC_PurchaseLine" extends "Purchase Line"
{
    fields
    {
        // modify("Item Reference No.")
        // {
        //     trigger OnBeforeValidate()
        //     var
        //         ItemRefNo: Text;
        //         ReferenceSetup: Record "Purchases & Payables Setup";
        //         PurchRefMgt: Codeunit RSC_PurchaseReferenceMgt;
        //         CreateNewItemTxt: Label 'Create a new item card for Item Reference  %1.';
        //         ItemNotRegisteredTxt: Label 'This item is not registered. To continue, choose one of the following options:';
        //         SelectItemTxt: Label 'Select an existing item.';
        //         ReturnValue: Code[20];
        //     begin
        //         if PurchRefMgt.retFalse() and PurchRefMgt.retTrue() then
        //             exit;


        //         ReferenceSetup.Get();
        //         if not (ReferenceSetup."RSC_Create Item from Reference") then
        //             exit;

        //         if (rec."Item Reference No." = '') or (PurchRefMgt.FindItemReferenceForPurchaseLine(Rec)) then
        //             exit;

        //         ItemRefNo := Rec."Item Reference No.";

        //         case StrMenu(
        //                StrSubstNo('%1,%2', StrSubstNo(CreateNewItemTxt, ConvertStr(ItemRefNo, ',', '.')), SelectItemTxt), 1, ItemNotRegisteredTxt)
        //         of
        //             0: //Cancel
        //                 begin
        //                     Error('');
        //                     exit;
        //                 end;
        //             1: //Create New Item
        //                 begin
        //                     ReturnValue := PurchRefMgt.CreateItemFromPurchLine(Rec);
        //                     exit;
        //                 end;
        //             2: //Select existing item
        //                 begin
        //                     Message('Select existing item');
        //                 end;
        //         end;


        //     end;
        // }
    }
}
