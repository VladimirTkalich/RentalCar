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
        PurchHeader: Record "Purchase Header";
    begin
        PurchHeader.Get(Rec."Document Type", Rec."Document No.");

        if (PurchHeader."Buy-from Vendor No." = '') or (Rec."No." = '') then
            exit;

        //PurchasePrice.Get();
        PurchasePrice.Reset();
        PurchasePrice.SetRange("Vendor No.", PurchHeader."Buy-from Vendor No.");
        PurchasePrice.SetRange("Item No.", Rec."No.");
        if PurchasePrice.FindFirst() then begin
            PurchasePrice."Direct Unit Cost" := Rec."Direct Unit Cost";
            PurchasePrice.Modify(true);
            Commit();
        end else begin
            PurchasePrice."Vendor No." := PurchHeader."Buy-from Vendor No.";
            PurchasePrice."Item No." := Rec."No.";
            PurchasePrice."Direct Unit Cost" := Rec."Direct Unit Cost";
            PurchasePrice.Insert();
        end;



    end;
}
