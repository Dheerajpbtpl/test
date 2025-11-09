Report 50017 "Stock Movement"
{
    Caption = 'Stock Movement';
    UsageCategory = Tasks;
    RDLCLayout = './Layouts/StockMovement.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = sorting("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Date Filter", "Location Filter";
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }

            column(UserId; UserId)
            {
            }
            column(ItemDateFilter; ItemDateFilter)
            {
            }
            column(Item__No__; Item."No.")
            {
            }
            column(Item_Description; Item.Description)
            {
            }
            column(OpeningBalance; OpeningBalance)
            {
            }
            column(Item__Description_2_; Item."Description 2")
            {
            }
            column(Text001; Text001)
            {
            }
            column(Item_Item__Gen__Prod__Posting_Group_; Item."Gen. Prod. Posting Group")
            {
            }
            column(Item_Item__Vendor_Item_No__; Item."Vendor Item No.")
            {
            }
            column(Text002; Text002)
            {
            }
            column(TotalQuantity; TotalQuantity)
            {
            }
            column(TotalPos; TotalPos)
            {
            }
            column(TotalNeg; TotalNeg)
            {
            }
            column(OpeningBalance_Control1500033; OpeningBalance)
            {
            }
            column(Stock_MovementCaption; Stock_MovementCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Item_Ledger_Entry__Posting_Date_Caption; Item_Ledger_Entry__Posting_Date_CaptionLbl)
            {
            }
            column(Item_Ledger_Entry_QuantityCaption; "Item Ledger Entry".FieldCaption(Quantity))
            {
            }
            column(Item_Ledger_Entry__Location_Code_Caption; "Item Ledger Entry".FieldCaption("Location Code"))
            {
            }
            column(Item_Ledger_Entry__Document_No__Caption; "Item Ledger Entry".FieldCaption("Document No."))
            {
            }
            column(Item_Ledger_Entry__Entry_Type_Caption; "Item Ledger Entry".FieldCaption("Entry Type"))
            {
            }
            column(PositiveCaption; PositiveCaptionLbl)
            {
            }
            column(NegativeCaption; NegativeCaptionLbl)
            {
            }
            column(BalanceCaption; BalanceCaptionLbl)
            {
            }
            column(Item_Ledger_Entry__External_Document_No__Caption; "Item Ledger Entry".FieldCaption("External Document No."))
            {
            }
            column(Item_Date_Filter; Item."Date Filter")
            {
            }
            column("Filter"; Filter)
            {
            }
            column(OpeningBAL; OpeningBAL)
            {
            }
            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                DataItemLink = "Item No." = field("No."), "Posting Date" = field("Date Filter");
                DataItemTableView = sorting("Item No.", "Posting Date") order(ascending);
                column(Item_Ledger_Entry__Posting_Date_; Format("Posting Date"))
                {
                }
                column(Item_Ledger_Entry__Entry_Type_; "Item Ledger Entry"."Entry Type")
                {
                }
                column(Item_Ledger_Entry__Document_No__; "Item Ledger Entry"."Document No.")
                {
                }
                column(Item_Ledger_Entry__Location_Code_; "Item Ledger Entry"."Location Code")
                {
                }
                column(CustomerName; custname)
                {
                }
                column(Item_Ledger_Entry_Quantity; "Item Ledger Entry".Quantity)
                {
                }
                column(Pos; Pos)
                {
                }
                column(Neg; Neg)
                {
                }
                column(OpeningBalance_Control1500027; OpeningBalance)
                {
                }
                column(Item_Ledger_Entry__External_Document_No__; "Item Ledger Entry"."External Document No.")
                {
                }
                column(Item_Ledger_Entry_Entry_No_; "Item Ledger Entry"."Entry No.")
                {
                }
                column(Item_Ledger_Entry_Item_No_; "Item Ledger Entry"."Item No.")
                {
                }
                column(Item_Ledger_Entry_Posting_Date; "Item Ledger Entry"."Posting Date")
                {
                }
                column(CostAmountActual_ItemLedgerEntry; "Item Ledger Entry"."Cost Amount (Actual)")
                {
                }
                column(DocumentType_ItemLedgerEntry; "Item Ledger Entry"."Document Type")
                {
                }
                column(Type; Type)
                {
                }
                column(ItemTypeName; ItemTypeName)
                {
                }
                column(customer_name; custname)
                {
                }
                column(SourceType_ItemLedgerEntry; "Item Ledger Entry"."Source Type")
                {
                }
                column(vendor_name; vendername)
                {
                }
                column(TotalQuantity2; TotalQuantity)
                {
                }
                column(TotalPos2; TotalPos)
                {
                }
                column(TotalNeg2; TotalNeg)
                {
                }
                trigger OnPreDataItem();
                begin
                    LocationCode := "Item Ledger Entry"."Location Code";
                    if "Item Ledger Entry"."Location Code" <> '' then
                        SetFilter("Location Code", '%1', LocationCode);
                end;

                trigger OnAfterGetRecord();
                begin
                    Pos := 0;
                    Neg := 0;
                    if "Item Ledger Entry"."Document Type" = "Item Ledger Entry"."document type"::" " then begin
#pragma warning disable AL0603
                        Type := "Item Ledger Entry"."Entry Type";
#pragma warning restore AL0603
#pragma warning disable AL0603
                        if "Item Ledger Entry"."Entry Type" = 0 then
#pragma warning restore AL0603
                            ItemTypeName := 'Purchase'
                        else
#pragma warning disable AL0603
                            if "Item Ledger Entry"."Entry Type" = 1 then
#pragma warning restore AL0603
                                ItemTypeName := 'Sale'
                            else
#pragma warning disable AL0603
                                if "Item Ledger Entry"."Entry Type" = 2 then
#pragma warning restore AL0603
                                    ItemTypeName := 'Positive Adjmt'
                                else
#pragma warning disable AL0603
                                    if "Item Ledger Entry"."Entry Type" = 3 then
#pragma warning restore AL0603
                                        ItemTypeName := 'Negative Adjmt'
                                    else
#pragma warning disable AL0603
                                        if "Item Ledger Entry"."Entry Type" = 4 then
#pragma warning restore AL0603
                                            ItemTypeName := 'Transfer'
                                        else
#pragma warning disable AL0603
                                            if "Item Ledger Entry"."Entry Type" = 5 then
#pragma warning restore AL0603
                                                ItemTypeName := 'Consumption'
                                            else
#pragma warning disable AL0603
                                                if "Item Ledger Entry"."Entry Type" = 6 then
#pragma warning restore AL0603
                                                    ItemTypeName := 'Output'
                                                else
#pragma warning disable AL0603
                                                    if "Item Ledger Entry"."Entry Type" = 7 then
#pragma warning restore AL0603
                                                        ItemTypeName := 'Assembly Consumption'
                                                    else
#pragma warning disable AL0603
                                                        if "Item Ledger Entry"."Entry Type" = 8 then
#pragma warning restore AL0603
                                                            ItemTypeName := 'Assembly Output'
                    end
                    else begin
#pragma warning disable AL0603
                        Type := "Item Ledger Entry"."Document Type";
#pragma warning restore AL0603
#pragma warning disable AL0603
                        if "Item Ledger Entry"."Document Type" = 0 then
#pragma warning restore AL0603
                            ItemTypeName := ''
                        else
#pragma warning disable AL0603
                            if "Item Ledger Entry"."Document Type" = 1 then
#pragma warning restore AL0603
                                ItemTypeName := 'Sale Shipment'
                            else
#pragma warning disable AL0603
                                if "Item Ledger Entry"."Document Type" = 2 then
#pragma warning restore AL0603
                                    ItemTypeName := 'Sales Invoice'
                                else
#pragma warning disable AL0603
                                    if "Item Ledger Entry"."Document Type" = 3 then
#pragma warning restore AL0603
                                        ItemTypeName := 'Sales Return Receipt'
                                    else
#pragma warning disable AL0603
                                        if "Item Ledger Entry"."Document Type" = 4 then
#pragma warning restore AL0603
                                            ItemTypeName := 'Sales Credit Memo'
                                        else
#pragma warning disable AL0603
                                            if "Item Ledger Entry"."Document Type" = 5 then
#pragma warning restore AL0603
                                                ItemTypeName := 'Purchase Receipt'
                                            else
#pragma warning disable AL0603
                                                if "Item Ledger Entry"."Document Type" = 6 then
#pragma warning restore AL0603
                                                    ItemTypeName := 'Purchase Invoice'
                                                else
#pragma warning disable AL0603
                                                    if "Item Ledger Entry"."Document Type" = 7 then
#pragma warning restore AL0603
                                                        ItemTypeName := 'Purchase Return Shipment'
                                                    else
#pragma warning disable AL0603
                                                        if "Item Ledger Entry"."Document Type" = 8 then
#pragma warning restore AL0603
                                                            ItemTypeName := 'Purchase Credit Memo'
                                                        else
#pragma warning disable AL0603
                                                            if "Item Ledger Entry"."Document Type" = 9 then
#pragma warning restore AL0603
                                                                ItemTypeName := 'Transfer Shipment'
                                                            else
#pragma warning disable AL0603
                                                                if "Item Ledger Entry"."Document Type" = 10 then
#pragma warning restore AL0603
                                                                    ItemTypeName := 'Transfer Receipt'
                                                                else
#pragma warning disable AL0603
                                                                    if "Item Ledger Entry"."Document Type" = 11 then
#pragma warning restore AL0603
                                                                        ItemTypeName := 'Service Shipment'
                                                                    else
#pragma warning disable AL0603
                                                                        if "Item Ledger Entry"."Document Type" = 12 then
#pragma warning restore AL0603
                                                                            ItemTypeName := 'Service Invoice'
                                                                        else
#pragma warning disable AL0603
                                                                            if "Item Ledger Entry"."Document Type" = 13 then
#pragma warning restore AL0603
                                                                                ItemTypeName := 'Service Credit Memo'
                                                                            else
#pragma warning disable AL0603
                                                                                if "Item Ledger Entry"."Document Type" = 14 then
#pragma warning restore AL0603
                                                                                    ItemTypeName := 'Posted Assembly'
                    end;
                    if "Item Ledger Entry".Quantity > 0 then
                        Pos := "Item Ledger Entry".Quantity
                    else
                        Neg := "Item Ledger Entry".Quantity;
                    OpeningBalance := OpeningBalance + "Item Ledger Entry".Quantity;
                    TotalPos := TotalPos + Pos;
                    TotalNeg := TotalNeg + Neg;
                    TotalQuantity := TotalQuantity + "Item Ledger Entry".Quantity;
#pragma warning disable AL0603
                    if "Item Ledger Entry"."Entry Type" = 1 then
#pragma warning restore AL0603
                        cust.Reset;
                    cust.SetRange(cust."No.", "Item Ledger Entry"."Source No.");
                    if cust.FindFirst then
                        custname := cust.Name
                    else
#pragma warning disable AL0603
                        if "Item Ledger Entry"."Entry Type" = 0 then
#pragma warning restore AL0603
                            vendr.Reset;
                    vendr.SetRange(vendr."No.", "Item Ledger Entry"."Source No.");
                    if vendr.FindFirst then
                        custname := vendr.Name
                    else
#pragma warning disable AL0603
                        if ("Item Ledger Entry"."Entry Type" = 2) and ("Item Ledger Entry"."Posting Date" <= 20130930D) then
#pragma warning restore AL0603
                            custname := 'Opening Balance'
                        else
#pragma warning disable AL0603
                            if ("Item Ledger Entry"."Entry Type" = 2) and ("Item Ledger Entry"."Posting Date" > 20130930D) then
#pragma warning restore AL0603
                                custname := 'Canniblization'
                            else
#pragma warning disable AL0603
                                if "Item Ledger Entry"."Entry Type" = 3 then
#pragma warning restore AL0603
                                    custname := 'Adjustment'
                                else
#pragma warning disable AL0603
                                    if "Item Ledger Entry"."Entry Type" = 4 then
#pragma warning restore AL0603
                                        custname := 'Transfer'
                    // message(format(custname));
                end;

            }
            trigger OnPreDataItem();
            begin
                //LastFieldNo := FIELDNO("No.");

            end;

            trigger OnAfterGetRecord();
            begin
                //Filter:=  GETFILTERS;
                TotalQuantity := 0;
                TotalPos := 0;
                TotalNeg := 0;
                OpeningBalance := 0;
                if ItemDateFilter <> '' then
                    if GetRangeMin("Date Filter") <> 0D then begin
                        SetRange("Date Filter", 0D, GetRangeMin("Date Filter") - 1);
                        CalcFields("Net Change");
                        OpeningBalance := "Net Change";
                    end;
                SetFilter("Date Filter", ItemDateFilter);
                CalcFields("Net Change");
                OpeningBalance := "Net Change";
                // if ISSERVICETIER then begin
                //     if not FooterPrinted then
                //         LastFieldNo := ReportForNav.TotalsCausedBy;
                //     ReportForNav.ShowOutput := not FooterPrinted;
                //     FooterPrinted := true;
                // end;//LK
            end;

        }
    }

    requestpage
    {


        SaveValues = false;
        layout
        {
            area(content)
            {
                field("Location Code"; "Item Ledger Entry"."Location Code")
                {
                    ApplicationArea = Basic;
                    TableRelation = Location.Code;
                }

            }
        }

        actions
        {
        }
    }



    trigger OnPreReport()
    begin
        ItemDateFilter := Item.GetFilter("Date Filter");
        Filter := Item.GetFilters;
        if Filter = '' then
            Filter := 'ALL FILTER';

    end;

    var
        Item2: Record Item;
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        Pos: Decimal;
        Neg: Decimal;
        OpeningBalance: Decimal;
        TotalQuantity: Decimal;
        TotalPos: Decimal;
        TotalNeg: Decimal;
        ItemDateFilter: Text[60];
        MinRange: Date;
        MaxRange: Date;
        Text001: label 'Opening Balance';
        Text002: label 'Closing Balance';
        Stock_MovementCaptionLbl: label 'Stock Movement';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Item_Ledger_Entry__Posting_Date_CaptionLbl: label 'Posting Date';
        PositiveCaptionLbl: label 'Positive';
        NegativeCaptionLbl: label 'Negative';
        BalanceCaptionLbl: label 'Balance';
        "Filter": Text;
        LocationCode: Code[10];
        Type: Option;
        ItemTypeName: Text;
        OpeningBAL: Decimal;
        StartBalanceLCY: Decimal;
        cust: Record Customer;
        custname: Text;
        vendr: Record Vendor;
        vendername: Text;

}