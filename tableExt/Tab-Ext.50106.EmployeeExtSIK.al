tableextension 50106 "Employee Ext_SIK" extends Employee //5200
{
    fields
    {
        field(50000; "Phone Ext_SIK"; Text[100])
        {
            Caption = 'Phone Ext.';
            DataClassification = EndUserIdentifiableInformation;
        }

        field(50010; Location_SIK; Code[10])
        {
            Caption = 'Location';
            TableRelation = Location;
        }

        field(50020; Department_SIK; Code[20])
        {
            Caption = 'Department';
            //TableRelation = Lookup_SIK.Code where (Type = const ('DEPARTMENT'));
        }
        field(50030; "User ID_SIK"; Text[50])
        {
            TableRelation = "User Setup";
            ValidateTableRelation = false;
            Caption = 'User ID';
            DataClassification = EndUserIdentifiableInformation;

            trigger OnValidate()
            var
                MyStrPos: Integer;
                MyUsername: Code[30];
            begin
                MyStrPos := StrPos("User ID_SIK", '\');
                if (MyStrPos > 0) then begin //if there is a domain
                    MyUsername := CopyStr("User ID_SIK", MyStrPos + 1, StrLen("User ID_SIK") - MyStrPos); //extract the user id
                    if ("no." <> CopyStr("User ID_SIK", MyStrPos + 1, StrLen("User ID_SIK") - MyStrPos)) then begin //set the PK
                        if ("no." = '') then
                            "no." := MyUsername
                        else
                            Rename(MyUsername);
                    end;
                end else
                    "no." := "User ID_SIK";
            end;
        }
        field(50040; "Product Manager_SIK"; boolean)
        {
            Caption = 'Product Manager';
            //FieldClass = FlowField;
            //CalcFormula = lookup ("User Setup"."Product Manager" where ("User ID" = field ("User Id_SIK")));
        }
        field(50081; "Purchase Approver_SIK"; boolean)
        {
            Caption = 'Purchase Approver';
            FieldClass = FlowField;
            //CalcFormula = lookup ("User Setup"."Purchase Approver SIK" where ("User ID" = field ("User Id_SIK")));
        }
    }

    keys
    {
        key(UserID_SIK; "User ID_SIK")
        {

        }
    }

    fieldgroups
    {
        addlast(DropDown; "Company E-Mail", "Phone No.", "Phone Ext_SIK", Location_SIK, Department_SIK)
        { }
    }

    trigger OnModify()
    begin
        TestField("User ID_SIK");
    end;
}