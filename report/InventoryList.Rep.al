#pragma warning disable AA0008, AA0018, AA0021, AA0072, AA0201, AA0206, AA0218, AA0228, AW0006 // ForNAV settings
Report 50105 "Inventory - List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './report/layout/Inventory - List.rdlc';
    Caption = 'Inventory - List';

    dataset
    {
        dataitem(Item; Item)
        {
            CalcFields = Inventory, "Net Change";
            DataItemTableView = sorting("No.") where(Type = const(Inventory));
            RequestFilterFields = "Location Filter", "Vendor No.", "No.", "Date Filter";
            RequestFilterHeading = 'Item Filter';
            column(ReportForNavId_8129; 8129)
            {
            }
            column(ShowLocations; ShowLocations)
            {
            }
            column(CompanyName; COMPANYNAME)
            {
            }
            column(ItemFilter; ItemFilter)
            {
            }
            column(No_Item; "No.")
            {
                IncludeCaption = true;
            }
            column(Description_Item; Description)
            {
                IncludeCaption = true;
            }
            column(Description2_Item; "Description 2")
            {
            }
            column(AssemblyBOM_Item; Format("Assembly BOM"))
            {
            }
            column(BaseUnitofMeasure_Item; "Base Unit of Measure")
            {
                IncludeCaption = true;
            }
            column(InventoryPostingGrp_Item; "Inventory Posting Group")
            {
                IncludeCaption = true;
            }
            column(ShelfNo_Item; "Shelf No.")
            {
                IncludeCaption = true;
            }
            column(VendorItemNo_Item; "Vendor Item No.")
            {
                IncludeCaption = true;
            }
            column(LeadTimeCalculation_Item; "Lead Time Calculation")
            {
                IncludeCaption = true;
            }
            column(ReorderPoint_Item; "Reorder Point")
            {
                IncludeCaption = true;
            }
            column(AlternativeItemNo_Item; "Alternative Item No.")
            {
                IncludeCaption = true;
            }
            column(Blocked_Item; Format(Blocked))
            {
            }
            column(InventoryListCaption; InventoryListCaptionLbl)
            {
            }
            column(CurrReportPageNoCaption; CurrReportPageNoCaptionLbl)
            {
            }
            column(ItemAssemblyBOMCaption; ItemAssemblyBOMCaptionLbl)
            {
            }
            column(ItemBlockedCaption; ItemBlockedCaptionLbl)
            {
            }
            column(NetChange_Item; "Net Change")
            {
                IncludeCaption = true;
            }
            column(Inventory_Item; Inventory)
            {
                IncludeCaption = true;
            }
            column(QtyOnPurch_Item; "Qty. on Purch. Order")
            {
                IncludeCaption = true;
            }
            column(PurchasePrice_Item; PurchasePrice)
            {
            }
            column(ValuePurchasePrice_Item; ValuePurchasePrice)
            {
            }
            column(CikkErtek_Item; CikkErtek)
            {
            }
            column(TotalPurchase; TotalPurchase)
            {
            }
            column(TotalFIFOertek; TotalFIFOertek)
            {
            }
            column(NyitottErtek; NyitottErtek)
            {
            }
            column(LastPurchPriceTxt; LastPurchPriceTxt)
            {
            }
            column(InvPurchValueTxt; InvPurchValueTxt)
            {
            }
            column(InvFifoValueTxt; InvFifoValueTxt)
            {
            }
            column(TotalInvPurchValueTxt; TotalInvPurchValueTxt)
            {
            }
            column(TotalInvFifoValueTxt; TotalInvFifoValueTxt)
            {
            }
            column(ShippedNotInvTxt; ShippedNotInvTxt)
            {
            }
            column(UomTxt; UomTxt)
            {
            }
            column(QtyOnPurchTxt; QtyOnPurchTxt)
            {
            }
            column(ShowOnlyItemsWithInventory; ShowOnlyItemsWithInventory)
            {
            }
            column(ShowPurchasePrice; ShowPurchasePrice)
            {
            }
            column(ShowSerialNo; ShowSerialNo)
            {
            }
            dataitem(ILESerialNo; "Item Ledger Entry")
            {
                DataItemLink = "Item No." = field("No."), "Location Code" = field("Location Filter");
                DataItemTableView = sorting("Item No.", Open, "Variant Code", Positive, "Location Code", "Posting Date", "Expiration Date", "Lot No.", "Serial No.") where("Remaining Quantity" = filter(> 0), "Lot No." = filter(<> ''));
                RequestFilterFields = "Posting Date";
                column(ReportForNavId_2; 2)
                {
                }
                column(LotNo_ILE; "Lot No.")
                {
                    IncludeCaption = true;
                }
                column(SerialNo_ILE; "Serial No.")
                {
                    IncludeCaption = true;
                }
                column(ExpirationDate_ILE; "Expiration Date")
                {
                    IncludeCaption = true;
                }
                column(RemQty_ILE; "Remaining Quantity")
                {
                    IncludeCaption = true;
                }
                column(SerNoErtek_ILE; SerNoErtek)
                {
                }
                column(ItemNo_ILE; ILESerialNo."Item No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    SerNoCost := 0;
                    SerNoErtek := 0;
                    Clear(VESerNo);
                    VESerNo.Reset;
                    VESerNo.SetCurrentkey("Item Ledger Entry No.", "Entry Type");
                    VESerNo.SetRange("Item Ledger Entry No.", ILE."Entry No.");
                    if VESerNo.FindFirst then
                        repeat
                            SerNoErtek += VESerNo."Cost per Unit";
                        until VESerNo.Next = 0;
                end;
            }
            dataitem(ItemLocation; Location)
            {
                DataItemTableView = sorting(Code);
                column(ReportForNavId_46; 46)
                {
                }
                column(LocationCode; ItemLocation.Code)
                {
                }
                column(LocationName; ItemLocation.Name)
                {
                }
                column(NetChange; NetChange)
                {
                    DecimalPlaces = 0 : 5;
                }

                trigger OnAfterGetRecord()
                begin
                    ItemLoc := Item;
                    ItemLoc.SetRange("Location Filter", ItemLocation.Code);
                    ItemLoc.CalcFields("Net Change");

                    NetChange := ItemLoc."Net Change";
                end;

                trigger OnPreDataItem()
                begin
                    if not ShowLocations then
                        CurrReport.Break;
                end;
            }

            trigger OnAfterGetRecord()
            var
                bShow: Boolean;
                decW: Decimal;
            begin
                Clear(vendor);
                vendor.Reset;
                if vendor.Get(Item."Vendor No.") then;

                CalcFields("Net Change");
                CalcFields(Inventory);
                //CALCFIELDS("Receipt (Qty.)");
                //CALCFIELDS("Shipped (Qty.)");

                if ShowOnlyItemsWithInventory then begin
                    if ("Net Change" = 0) and ("Qty. on Sales Order" = 0) then
                        CurrReport.Skip;
                end;

                PurchasePrice := 0;
                NAGYKERPrice := 0;
                CikkErtek := 0;

                PurchasePrice := Item."Last Direct Cost";
                NAGYKERPrice := Item."Unit Price";

                ValuePurchasePrice := PurchasePrice * Item."Net Change";

                CikkErtek := 0;

                Clear(VE);
                VE.Reset;

                VE.SetCurrentkey("Item No.",
                                 "Posting Date",
                                 "Item Ledger Entry Type",
                                 "Entry Type",
                                 "Variance Type",
                                 "Item Charge No.",
                                 "Location Code",
                                 "Variant Code");
                VE.SetRange("Item No.", "No.");
                VE.SetFilter("Posting Date", '..%1', DateFilter);
                VE.SetFilter("Location Code", raktar);
                VE.CalcSums("Cost Amount (Actual)", "Invoiced Quantity");
                if VE."Invoiced Quantity" <> 0 then
                    ItemCost := VE."Cost Amount (Actual)" / VE."Invoiced Quantity"
                else begin
                    if VE.FindFirst then
                        ItemCost := VE."Cost per Unit";
                end;
                CikkErtek += ItemCost * VE."Invoiced Quantity";

                TotalPurchase += ValuePurchasePrice;
                TotalFIFOertek += CikkErtek;

                Clear(ItemSales);
                ItemSales.Reset;
                ItemSales.SetFilter("Location Filter", raktar);
                if ItemSales.Get("No.") then begin
                    ItemSales.CalcFields("Qty. on Sales Order");
                    "Qty. on Sales Order" := ItemSales."Qty. on Sales Order";
                end;
            end;

            trigger OnPreDataItem()
            begin
                if (GetFilter("Date Filter") = '') then begin
                    SetFilter("Date Filter", '..%1', WorkDate);
                end;

                DateFilter := GetRangemax("Date Filter");

                if ShowOnlyItemsWithInventory then
                    Item.SetFilter("Net Change", '<>0');

                raktar := Item.GetFilter("Location Filter");

                ItemFilter := Item.GetFilters;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Beállítások';
                    field(ShowLocationCtrl; ShowLocations)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Show Locations';
                    }
                    field(ShowOnlyItemsWithInventoryCtrl; ShowOnlyItemsWithInventory)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Show Only Items With Inventory';
                    }
                    field(ShowPurchasePriceCtrl; ShowPurchasePrice)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Show Purchase Price';
                    }
                    field(ShowSerialNoCtrl; ShowSerialNo)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Show Serial No';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        ShowOnlyItemsWithInventory := true;
        ShowLocations := true;
        ShowPurchasePrice := true;

        TotalPurchase := 0;
        TotalNAGYKER := 0;
    end;

    var
        ItemFilter: Text;
        InventoryListCaptionLbl: label 'Inventory - List';
        CurrReportPageNoCaptionLbl: label 'Page';
        ItemAssemblyBOMCaptionLbl: label 'BOM';
        ItemBlockedCaptionLbl: label 'Blocked';
        ItemCR: Record "Item Cross Reference";
        bOnlyMOLItems: Boolean;
        dFrom: Date;
        dTo: Date;
        oKiszallitas: Option "Eladás","Kiszállítás";
        text000: label 'Inventory Lookout';
        tItemFilter: Text[250];
        tSettings: Text[80];
        decPurchPrice: Decimal;
        ItemUoM: Record "Item Unit of Measure";
        decQtyPerUoM: Decimal;
        decSaleTransferQty: Decimal;
        decQtyToReceive: Decimal;
        decQtyToSale: Decimal;
        decInventory: Decimal;
        decInvDay: Decimal;
        decInvDay2: Decimal;
        intWorkDays: Integer;
        bOnlyWorkDays: Boolean;
        txtInvDay: Text[18];
        txtInvDay2: Text[18];
        CikkLista: Code[20];
        vendor: Record Vendor;
        exceptNull: Boolean;
        receivedQty: Decimal;
        onlyIfReceivedNotNull: Boolean;
        PurchType: Option Purchase,"Positive Adjmt.","Negative Adjmt.";
        PurchasePrice: Decimal;
        NAGYKERPrice: Decimal;
        PriceCalcMgt: Codeunit "Sales Price Calc. Mgt.";
        ShowOnlyItemsWithInventory: Boolean;
        ValuePurchasePrice: Decimal;
        ValueNAGYKERPrice: Decimal;
        TotalPurchase: Decimal;
        TotalNAGYKER: Decimal;
        xlLineNo: Integer;
        CreateExcel: Boolean;
        raktar: Code[100];
        ShowPurchasePrice: Boolean;
        DateFilter: Date;
        VE: Record "Value Entry";
        CikkErtek: Decimal;
        TotalFIFOertek: Decimal;
        ItemSales: Record Item;
        ILE: Record "Item Ledger Entry";
        ItemCost: Decimal;
        Location: Record Location;
        ExcelCol: Text[10];
        i: Integer;
        Window: Dialog;
        WindowText001: label 'Exportálás: @1@@@@@@@@@@@@@\Raktár:     #2#############\Cikkek:     @3@@@@@@@@@@@@@';
        TotalCount1: Integer;
        TotalCount2: Integer;
        j: Integer;
        k: Integer;
        ShowSerialNo: Boolean;
        VESerNo: Record "Value Entry";
        SerNoCost: Decimal;
        SerNoErtek: Decimal;
        NyitottErtek: Decimal;
        LastPurchPriceTxt: label 'Last Purch. Price';
        InvPurchValueTxt: label 'Inventory Purchase Value';
        InvFifoValueTxt: label 'Inventory FIFO Value';
        TotalInvPurchValueTxt: label 'Total Inventory Purchase Value';
        TotalInvFifoValueTxt: label 'Total Inventory FIFO Value';
        ShippedNotInvTxt: label 'Shipped, not invoiced Purch. Value';
        UomTxt: label 'UOM';
        QtyOnPurchTxt: label 'Qty. on Purchase';
        NetChange: Decimal;
        ItemLoc: Record Item;
        ShowLocations: Boolean;
}

