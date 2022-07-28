codeunit 50105 "InT_Sales_Templ_Mgt"
{
    TableNo = InT_Sates_Template;

    trigger OnRun()
    begin

    end;

    procedure SaveAsTemplate(SHeader: Record "Sales Header")
    var
        SalesTempl: Record InT_Sates_Template;
    begin

        InsertTemplateFromSalesOrder(SalesTempl, SHeader);
        SalesTempl.Get(SalesTempl.InT_Template_Code);
        ShowSalesTemplCard(SalesTempl);
    end;

    local procedure InsertTemplateFromSalesOrder(var SalesTempl: Record InT_Sates_Template; SHeader: Record "Sales Header")
    begin
        SalesTempl.Init();
        SalesTempl.InT_Template_Code := GetSalesTemplCode();
        SalesTempl."Payment Terms Code" := SHeader."Payment Terms Code";
        SalesTempl."Tax Area Code" := SHeader."Tax Area Code";
        SalesTempl.Insert();
        Commit();
    end;

    local procedure GetSalesTemplCode() SalesTemplCode: Code[20]
    var
        SalesTempl: Record InT_Sates_Template;
    begin
        if SalesTempl.FindLast() and (IncStr(SalesTempl.InT_Template_Code) <> '') then
            SalesTemplCode := SalesTempl.InT_Template_Code
        else
            SalesTemplCode := 'SOTEMPL000001';

        while SalesTempl.Get(SalesTemplCode) do
            SalesTemplCode := IncStr(SalesTemplCode);
    end;

    local procedure ShowSalesTemplCard(SalesTempl: Record InT_Sates_Template)
    var
        SalesTemplCard: Page InT_Sales_Templ_Card;
    begin
        SalesTemplCard.SetRecord(SalesTempl);
        SalesTemplCard.LookupMode := true;
        if SalesTemplCard.RunModal() = Action::LookupCancel then begin
            SalesTempl.Get(SalesTempl.InT_Template_Code);
            SalesTempl.Delete(true);
        end;
    end;

    procedure UpdateFromTemplate(var SHeader: Record "Sales Header")
    var
        SalesTempl: Record InT_Sates_Template;
        ConfirmManagement: Codeunit "Confirm Management";
        UpdateExistingValuesQst: Label 'You are about to apply the template to selected records. Data from the template will replace data for the records. Do you want to continue?';
    begin
        if not SelectSalesTemplate(SalesTempl) then
            exit;
        if not ConfirmManagement.GetResponseOrDefault(UpdateExistingValuesQst, false) then
            exit;

        ApplySalesTemplate(SHeader, SalesTempl);
    end;

    local procedure ApplySalesTemplate(var SHeader: Record "Sales Header"; SalesTempl: Record InT_Sates_Template)
    begin
        SHeader.Validate("Payment Terms Code", SalesTempl."Payment Terms Code");
        SHeader.Validate("Tax Area Code", SalesTempl."Tax Area Code");
    end;

    local procedure SelectSalesTemplate(var SalesTempl: Record InT_Sates_Template): Boolean
    var
        SelectSalesTemplList: Page InT_Select_Sales_Templ_List;
    begin
        if SalesTempl.Count = 1 then begin
            SalesTempl.FindFirst();
            exit(true);
        end;

        if (SalesTempl.Count > 1) and GuiAllowed then begin
            SelectSalesTemplList.SetTableView(SalesTempl);
            SelectSalesTemplList.LookupMode(true);
            if SelectSalesTemplList.RunModal() = Action::LookupOK then begin
                SelectSalesTemplList.GetRecord(SalesTempl);
                exit(true);
            end;
        end;

        exit(false);
    end;


}
