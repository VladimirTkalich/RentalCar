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
}
