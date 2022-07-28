page 50105 "InT_Sales_Tepl_List"
{
    ApplicationArea = All;
    Caption = 'InT_Sales_Tepl_List';
    PageType = List;
    SourceTable = InT_Sates_Template;
    CardPageId = InT_Sales_Templ_Card;
    UsageCategory = Lists;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(InT_Template_Code; Rec.InT_Template_Code)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the InT_Template_Code field.';
                }
                field(InT_Template_Description; Rec.InT_Template_Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the InT_Template_Description field.';
                }
            }
        }
    }
}
