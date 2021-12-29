codeunit 50101 "RSC_Subscribers"
{
    EventSubscriberInstance = StaticAutomatic;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"RSC_Publishers", 'RSC_OnChangeStatusCU', '', true, true)]
    local procedure ShowChangeStatusCU()
    var
        StatCounter: Codeunit "RSC_Single_Instance";
        TextMessage: Text;
    begin
        StatCounter.IncreaseCounter();
        TextMessage := 'Status was changed ' + Format((StatCounter.GetCounter())) + ' times.';
        Message(TextMessage);
    end;


    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnBeforeValidateEvent', 'Direct Unit Cost', true, true)]
    local procedure ChangeDirectUnitCost(var Rec: Record "Purchase Line")
    var
        PurchasePrice: Record "Purchase Price";
        PriceListLine: Record "Price List Line";
        PurchHeader: Record "Purchase Header";
        PriceCalculationMgt: Codeunit "Price Calculation Mgt.";
    begin
        PurchHeader.Get(Rec."Document Type", Rec."Document No.");

        if (PurchHeader."Buy-from Vendor No." = '') or (Rec."No." = '') then
            exit;

        if PriceCalculationMgt.IsExtendedPriceCalculationEnabled() then begin
            PriceListLine.Reset();
            PriceListLine.SetRange("Source Type", "Price Source Type"::Vendor);
            PriceListLine.SetRange("Source No.", PurchHeader."Buy-from Vendor No.");
            PriceListLine.SetRange("Asset No.", Rec."No.");
            if PriceListLine.FindFirst() then begin
                PriceListLine."Direct Unit Cost" := Rec."Direct Unit Cost";
                PriceListLine.Modify(true);
            end else begin
                PriceListLine."Source Type" := "Price Source Type"::Vendor;
                PriceListLine."Source No." := PurchHeader."Buy-from Vendor No.";
                PriceListLine."Asset No." := Rec."No.";
                PriceListLine."Direct Unit Cost" := Rec."Direct Unit Cost";
                PriceListLine.Insert();
            end;

            exit;
        end;
        PurchasePrice.Reset();
        PurchasePrice.SetRange("Vendor No.", PurchHeader."Buy-from Vendor No.");
        PurchasePrice.SetRange("Item No.", Rec."No.");
        if PurchasePrice.FindFirst() then begin
            PurchasePrice."Direct Unit Cost" := Rec."Direct Unit Cost";
            PurchasePrice.Modify(true);
        end else begin
            PurchasePrice."Vendor No." := PurchHeader."Buy-from Vendor No.";
            PurchasePrice."Item No." := Rec."No.";
            PurchasePrice."Direct Unit Cost" := Rec."Direct Unit Cost";
            PurchasePrice.Insert();
        end;



    end;
}
