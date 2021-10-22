codeunit 50102 "RSC_Single_Instance"
{
    SingleInstance = true;

    var
        StatusCounter: Integer;

    procedure SetCounter(NewValue: Integer)
    begin
        StatusCounter := NewValue;
    end;

    procedure GetCounter() CounterValue: Integer;
    begin
        exit(StatusCounter);
    end;

    procedure IncreaseCounter()
    begin
        StatusCounter := StatusCounter + 1;
    end;
}
