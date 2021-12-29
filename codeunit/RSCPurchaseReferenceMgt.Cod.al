codeunit 50103 "RSC_PurchaseReferenceMgt"
{
    EventSubscriberInstance = StaticAutomatic;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnBeforeValidateEvent', 'Item Reference No.', true, true)]
    local procedure ReferenceChanged(var Rec: Record "Purchase Line")
    var
        ItemRefNo: Text;
        ReferenceSetup: Record "Purchases & Payables Setup";
        PurchRefMgt: Codeunit RSC_PurchaseReferenceMgt;
        CreateNewItemTxt: Label 'Create a new item card for Item Reference  %1.';
        ItemNotRegisteredTxt: Label 'This item is not registered. To continue, choose one of the following options:';
        SelectItemTxt: Label 'Select an existing item.';
        ReturnValue: Code[20];
    begin
        ReferenceSetup.Get();
        if not (ReferenceSetup."RSC_Create Item from Reference") then
            exit;

        if PurchRefMgt.FindItemReferenceForPurchaseLine(Rec) then
            exit;

        ItemRefNo := Rec."Item Reference No.";

        case StrMenu(
               StrSubstNo('%1,%2', StrSubstNo(CreateNewItemTxt, ConvertStr(ItemRefNo, ',', '.')), SelectItemTxt), 1, ItemNotRegisteredTxt)
        of
            0: //Cancel
                begin
                    Error('');
                    exit;
                end;
            1: //Create New Item
                begin
                    ReturnValue := PurchRefMgt.CreateItemFromPurchLine(Rec);
                    exit;
                end;
            2: //Select existing item
                begin
                    Message('Select existing item');
                end;
        end;


    end;

    //TableNo = "Purchase Line";

    // trigger OnRun()
    // begin
    // end;

    procedure FindItemReferenceForPurchaseLine(PurchaseLine: Record "Purchase Line"): Boolean
    var
        PurchHeader: Record "Purchase Header";
        ItemRef: Record "Item Reference";
    begin
        if PurchaseLine."Item Reference No." = '' then begin
            exit(false);
        end;
        PurchHeader.Get(PurchaseLine."Document Type", PurchaseLine."Document No.");

        if PurchHeader."Buy-from Vendor No." = '' then begin
            exit(false);
        end;

        ItemRef.Reset();
        ItemRef.SetRange("Reference Type", ItemRef."Reference Type"::Vendor);
        ItemRef.SetRange("Reference Type No.", PurchHeader."Buy-from Vendor No.");
        ItemRef.SetRange("Reference No.", PurchaseLine."Item Reference No.");
        if ItemRef.FindFirst() then begin
            exit(true);
        end;
        exit(false);

    end;

    procedure CreateItemFromPurchLine(PurchLine: Record "Purchase Line"): Code[20]
    var
        Item: Record Item;
        ItemTemplMgt: Codeunit "Item Templ. Mgt.";
        ItemCard: Page "Item Card";
        PurchHeader: Record "Purchase Header";
        SelectItemErr: Label 'You must select an existing item.';
        VendorNo: Code[20];
    begin

        if not ItemTemplMgt.InsertItemFromTemplate(Item) then
            Error(SelectItemErr);

        PurchHeader.Get(PurchLine."Document Type", PurchLine."Document No.");
        Item."Vendor No." := PurchHeader."Buy-from Vendor No.";
        Item."Vendor Item No." := PurchLine."Item Reference No.";
        Item.Description := PurchLine."Item Reference No.";

        CreateReferenceForItem(Item);

        Item.Modify(true);
        Commit();

        Item.SetRange("No.", Item."No.");
        ItemCard.SetTableView(Item);
        if not (ItemCard.RunModal = ACTION::OK) then
            Error(SelectItemErr);

        exit(Item."No.");
    end;

    procedure CreateReferenceForItem(Item: Record Item)
    var
        ItemReference: Record "Item Reference";
        ItemRefMgt: Codeunit "Item Reference Management";
        ItemVend: Record "Item Vendor";
        Vends: Record Vendor;
        retVal: Boolean;
    begin
        ItemReference."Item No." := Item."No.";
        ItemReference."Reference Type No." := Item."Vendor No.";
        ItemReference."Reference Type" := "Item Reference Type"::Vendor;
        ItemReference."Reference No." := Item."Vendor Item No.";
        // ItemReference.CreateItemVendor();
        ItemReference.Insert();

    end;

    procedure retFalse(): Boolean
    begin
        exit(false);
    end;

    procedure retTrue(): Boolean
    begin
        exit(true);
    end;
}
