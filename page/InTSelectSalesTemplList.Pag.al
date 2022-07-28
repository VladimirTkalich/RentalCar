page 50107 "InT_Select_Sales_Templ_List"
{
    ApplicationArea = All;
    Caption = 'InT_Select_Sales_Templ_List';
    PageType = List;
    SourceTable = InT_Sates_Template;
    UsageCategory = Lists;

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
