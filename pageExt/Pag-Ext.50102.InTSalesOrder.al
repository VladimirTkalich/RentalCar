pageextension 50102 "InT_Sales_Order" extends "Sales Order"
{
    actions
    {
        addlast("F&unctions")
        {
            action(Templates)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Templates';
                Image = Template;
                //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                Promoted = true;
                PromotedIsBig = true;
                ToolTip = 'View or edit vendor templates.';

                trigger OnAction()
                begin
                    Page.Run(Page::InT_Sales_Tepl_List);
                end;
            }
            action(ApplyTemplate)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Apply Template';
                Image = ApplyTemplate;
                ToolTip = 'Apply a template to update the entity with your standard settings for a certain type of entity.';

                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    SalesTemplMgt: Codeunit InT_Sales_Templ_Mgt;
                begin
                    SalesTemplMgt.UpdateFromTemplate(Rec);
                end;
            }
            action(SaveAsTemplate)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Save as Template';
                Image = Save;
                ToolTip = 'Save the Sales Order card as a template that can be reused to create new Sales Order cards.';

                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    SalesTemplMgt: Codeunit InT_Sales_Templ_Mgt;
                begin
                    SalesTemplMgt.SaveAsTemplate(Rec);
                end;
            }

        }
    }
}
