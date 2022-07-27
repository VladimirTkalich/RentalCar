pageextension 50101 "InT_SalesQuote" extends "Sales Quote"
{
    actions
    {
        addfirst(reporting)
        {
            action(InT_ImportSalesQuote)
            {
                ApplicationArea = All;
                Caption = 'Import Sales Quote (AT 2)';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                //RunObject = Report "InT_ImportSalesQuote";
                ToolTip = 'Import Sales Quote';

                trigger OnAction()
                var
                    Rep: Report "InT_ImportSalesQuote";
                begin
                    Rep.SetSalesHeaderNo(Rec."No.");
                    Rep.RunModal();

                    // Rec.Reset();
                    // Rec.SetRange(Rec."No.", Rec."No.");
                    // Report.Run(report::InT_ImportSalesQuote, true, false, Rec);
                end;
            }
        }
        addlast(processing)
        {
            action(InT_Create_Revised_Version)
            {
                ApplicationArea = All;
                Caption = 'Create Revised Version (AT 1)';
                Image = CopyDocument;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Create Revised Version';

                trigger OnAction()
                var
                    CopySalesDocument: Report "Copy Sales Document";
                    NoSuffix: Text[20];
                    QuoteNo: Code[20];
                    QuoteNoTmp: Code[20];
                    NewFromDocNo: Text[20];
                    NewRecNo: Text;
                    NewRecNoLbl: Label '%1-R%2';
                    MessageLbl: Label 'Revised version %1 has been created';
                    Pos: Integer;
                    NewNo: Integer;
                begin
                    NewRecNo := NewRecNoLbl;
                    NewFromDocNo := Rec."No.";
                    NewNo := 1;
                    QuoteNoTmp := '';
                    Pos := NewFromDocNo.LastindexOf('-R');
                    if Pos <> 0 then begin
                        NoSuffix := CopyStr(NewFromDocNo, Pos + 2);
                        if Evaluate(NewNo, NoSuffix) then begin
                            NewNo += 1;
                            QuoteNoTmp := CopyStr(NewFromDocNo, 1, Pos - 1);
                        end;
                    end;
                    if StrLen(QuoteNoTmp) = 0 then
                        QuoteNoTmp := NewFromDocNo;

                    NoSuffix := Format(NewNo, -20, 0); //-20 - returned string will not have leading or trailing spaces.
                    QuoteNo := StrSubstNo(NewRecNo, QuoteNoTmp, NoSuffix);

                    // Check existence of rec with "No."=QuoteNo with new suffix
                    // if Pos > 0 then begin
                    //     QuoteNoTmp := CopyStr(NewFromDocNo, 1, Pos - 1);
                    // end else
                    //     QuoteNoTmp := NewFromDocNo;
                    Rec.SetFilter("No.", QuoteNo);
                    while Rec.FindFirst()
                    do begin
                        NewNo += 1;
                        // QuoteNo := CopyStr(NewFromDocNo, 1, Pos - 1);
                        NoSuffix := Format(NewNo, -20, 0);
                        QuoteNo := StrSubstNo(NewRecNo, QuoteNoTmp, NoSuffix);
                        Rec.SetFilter("No.", QuoteNo);
                    end;



                    Rec.Init();
                    Rec.TransferFields(xRec);
                    Rec."No." := QuoteNo;
                    Rec.Insert(true);
                    Commit();

                    CopySalesDocument.SetParameters("Sales Document Type From"::Quote, NewFromDocNo, true, false);
                    CopySalesDocument.SetSalesHeader(Rec);
                    CopySalesDocument.RunModal();
                    // Report.Run(Report::"Copy Sales Document", false, false, Rec);

                    if Rec.Get(Rec."Document Type", Rec."No.") then;

                    Message(MessageLbl, QuoteNo);
                end;
            }

        }
    }
}
