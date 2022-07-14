xmlport 50100 "InT_XMLPort_Export"
{

    Caption = 'XMLPort_Export';
    Format = Xml;
    Direction = Export;

    schema
    {
        textelement(CompanyName)
        {
            XmlName = 'CRONUS';
            textattribute(xmlns)
            {
                // XmlName = 'http://Cronus.org';
            }
            textelement(ReturnAddress)
            {
                textelement(Name)
                {
                    trigger OnBeforePassVariable()
                    begin
                        Name := UserFullName;
                    end;
                }

                textelement(Email)
                {
                    trigger OnBeforePassVariable()
                    begin
                        Email := UserEmail;
                    end;
                }
            }
            textelement(Batch)
            {
                textelement(Reference)
                {
                    trigger OnBeforePassVariable()
                    var
                        FormatString: Text;
                    begin
                        FormatString := '<Year><Month,2><Day,2><Hours24,2><Minutes,2>';
                        Reference := StrSubstNo('MK%1', Format(CurrentDateTime, 0, FormatString));
                    end;
                }
                textelement(Customers)
                {
                    tableelement(Customer; Customer)
                    {
                        fieldelement(Name; Customer.Name)
                        {
                        }
                        fieldelement(Address; Customer.Address)
                        {
                        }
                        fieldelement(Address2; Customer."Address 2")
                        {
                        }
                        fieldelement(City; Customer.City)
                        {
                        }
                        fieldelement(ISOCountry; Customer."Country/Region Code")
                        {
                        }
                    }
                }

                textelement(Vendors)
                {
                    tableelement(Vendor; Vendor)
                    {
                        fieldelement(Name; Vendor.Name)
                        {
                        }
                        fieldelement(Address; Vendor.Address)
                        {
                        }
                        fieldelement(Address2; Vendor."Address 2")
                        {
                        }
                        fieldelement(City; Vendor.City)
                        {
                        }
                        fieldelement(Region; Vendor.County)
                        {
                        }
                        fieldelement(ISOCountry; Vendor."Country/Region Code")
                        {
                        }
                    }
                }
                textelement("Ship-to-Addresses")
                {
                    tableelement(ShipToAddress; "Ship-to Address")
                    {
                        fieldelement(Name; ShipToAddress.Name)
                        {
                        }
                        fieldelement(Address; ShipToAddress.Address)
                        {
                        }
                        fieldelement(Address2; ShipToAddress."Address 2")
                        {
                        }
                        fieldelement(City; ShipToAddress.City)
                        {
                        }
                        fieldelement(Region; ShipToAddress.County)
                        {
                        }
                        fieldelement(ISOCountry; ShipToAddress."Country/Region Code")
                        {
                        }
                    }
                }
                textelement(OrderAddresses)
                {
                    tableelement(OrderAddress; "Order Address")
                    {
                        fieldelement(Name; OrderAddress.Name)
                        {
                        }
                        fieldelement(Address; OrderAddress.Address)
                        {
                        }
                        fieldelement(Address2; OrderAddress."Address 2")
                        {
                        }
                        fieldelement(City; OrderAddress.City)
                        {
                        }
                        fieldelement(Region; OrderAddress.County)
                        {
                        }
                        fieldelement(ISOCountry; OrderAddress."Country/Region Code")
                        {
                        }
                    }
                }
            }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }

    trigger OnPreXmlPort()
    var
        FormatString: Text;
        ExportFileName: Text;
    begin
        CompanyInformation.Get();

        FormatString := '<Year4><Month,2><Day,2>_<Hours24,2><Minutes,2><Seconds,2>';
        ExportFileName := StrSubstNo('%1%2.xml', CompanyInformation."InT_Descartes Filename", Format(CurrentDateTime, 0, FormatString));
        Filename(ExportFileName);

        UserSetupInfo.SetRange("InT_MK Upload Return", true);
        if UserSetupInfo.FindFirst() then begin
            UserInfo.SetFilter("User Name", UserId);
            if UserInfo.FindFirst() then begin
                UserFullName := UserInfo."Full Name";
            end else begin
                UserFullName := UserId;
            end;
            UserEmail := UserSetupInfo."E-Mail";
            exit;
        end;
        UserInfo.SetFilter("User Name", UserId);
        if UserInfo.FindFirst() then begin
            UserFullName := UserInfo."Full Name";
            UserEmail := UserInfo."Authentication Email";
        end;
    end;

    trigger OnPostXmlPort()
    begin
        CompanyInformation."InT_Federal Register Date" := Today;
        CompanyInformation.Modify();
    end;

    var
        CompanyInformation: Record "Company Information";
        UserInfo: Record User;
        UserSetupInfo: Record "User Setup";
        UserFullName: Text[80];
        UserEmail: Text[250];

}
