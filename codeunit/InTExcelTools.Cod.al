codeunit 50104 "InT_Excel Tools"
{
    procedure GetText(var Buffer: Record "Excel Buffer" temporary; Col: Integer; Row: Integer): Text
    begin
        if Buffer.Get(Row, Col) then
            exit(Buffer."Cell Value as Text");
    end;

    procedure GetDecimal(var Buffer: Record "Excel Buffer" temporary; Col: Integer; Row: Integer): Decimal
    var
        Numb: Decimal;
    begin
        if Buffer.Get(Row, Col) then begin
            Evaluate(Numb, Buffer."Cell Value as Text");
            exit(Numb);
        end;
    end;

    procedure GetType(var Buffer: Record "Excel Buffer" temporary; Col: Integer; Row: Integer): Enum "Item Type"
    var
        TypeVal: Enum "Item Type";
        Index: Integer;
        OrdinalValue: Integer;
        TypeName: Text;
    begin
        if Buffer.Get(Row, Col) then begin
            TypeName := Buffer."Cell Value as Text";
            Index := TypeVal.Names.IndexOf(TypeName);
            OrdinalValue := TypeVal.Ordinals.Get(Index);
            TypeVal := Enum::"Item Type".FromInteger(OrdinalValue);
            exit(TypeVal);
        end;
    end;
    // procedure GetTypeOrdinalValue(var Buffer: Record "Excel Buffer" temporary; Col: Integer; Row: Integer): Integer
    // var
    //     TypeVal: Enum "Item Type";
    //     Index: Integer;
    //     OrdinalValue: Integer;
    //     TypeName: Text;
    // begin
    //     OrdinalValue := -1;
    //     if Buffer.Get(Row, Col) then begin
    //         TypeName := Buffer."Cell Value as Text";
    //         Index := TypeVal.Names.IndexOf(TypeName);
    //         OrdinalValue := TypeVal.Ordinals.Get(Index);
    //         exit(OrdinalValue);
    //     end;
    // end;
}
