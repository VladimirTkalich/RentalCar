pageextension 50111 "InT_UserSetup" extends "User Setup"
{
    layout
    {
        addafter("User ID")
        {
            field("InT_MK Upload Return"; Rec."InT_MK Upload Return")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the MK Upload Return';
                Caption = 'MK Upload Return';
            }
        }
    }
}
