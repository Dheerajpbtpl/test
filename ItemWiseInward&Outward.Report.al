/// <summary>
/// Report Item Wise Inward & Outward (ID 50136).
/// </summary>
Report 50136 "Item Wise Inward & Outward"
{
    RDLCLayout = './Layouts/ItemWiseInward&Outward.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            DataItemTableView = where("Entry Type" = filter(<> Transfer));
            RequestFilterFields = "Item No.", "Posting Date";
            column(ItemNo; "Item Ledger Entry"."Item No.")
            {
            }
            column(ItemName; Item.Description)
            {
            }
            column(Date; Format("Item Ledger Entry"."Posting Date"))
            {
            }
            column(EntryType; "Item Ledger Entry"."Entry Type")
            {
            }
            column(VendoName; VendorName)
            {
            }
            column(CustomerName; CustomerName)
            {
            }
            column(VchType; "Item Ledger Entry"."Entry Type")
            {
            }
            column(VchNo; "Item Ledger Entry"."Document No.")
            {
            }
            column(Qty; "Item Ledger Entry".Quantity)
            {
            }
            column(OutwordAmnt; "Item Ledger Entry"."Sales Amount (Actual)")
            {
            }
            column(InwordAmnt; "Item Ledger Entry"."Cost Amount (Actual)")
            {
            }
            column(RemaningQty; "Item Ledger Entry"."Remaining Quantity")
            {
            }
            column(RemaningAmnt; CostAmnt_p)
            {
                AutoCalcField = true;
            }
            column(PurBool; PurBool)
            {
            }
            column(SaleBool; SaleBool)
            {
            }
            trigger OnPreDataItem();
            begin
                CustomerName := '';
                VendorName := '';
                CostAmnt_p := 0;
            end;

            trigger OnAfterGetRecord();
            begin
                "Item Ledger Entry".CalcFields("Item Ledger Entry"."Cost Amount (Expected)");
                if Item.Get("Item Ledger Entry"."Item No.") then;
                if Customer.Get("Item Ledger Entry"."Source No.") then
                    CustomerName := Customer.Name;
                if Vendor.Get("Item Ledger Entry"."Source No.") then
                    VendorName := Vendor.Name;
                ValueEntry_gRec.Reset;
                ValueEntry_gRec.SetRange("Item Ledger Entry No.", "Item Ledger Entry"."Entry No.");
                if ValueEntry_gRec.FindFirst then begin
                    CostAmnt_p := ROUND(ValueEntry_gRec."Cost per Unit" * "Item Ledger Entry"."Remaining Quantity", 0.01);
                end;
                PurBool := false;
                SaleBool := false;
                if ("Item Ledger Entry"."Entry Type" = "Item Ledger Entry"."entry type"::"Positive Adjmt.") or ("Item Ledger Entry"."Entry Type" = "Item Ledger Entry"."entry type"::Purchase) then
                    PurBool := true;
                if ("Item Ledger Entry"."Entry Type" = "Item Ledger Entry"."entry type"::"Negative Adjmt.") or ("Item Ledger Entry"."Entry Type" = "Item Ledger Entry"."entry type"::Sale) then
                    SaleBool := true;
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
                group(Options)
                {
                    Caption = 'Options';

                }
            }
        }

        actions
        {
        }
    }



    var
        Item: Record Item;
        Customer: Record Customer;
        Vendor: Record Vendor;
        ItemLedgerEntry: Record "Item Ledger Entry";
        CustInword: Integer;
        CustQty: Decimal;
        VendOutword: Integer;
        VendQty: Decimal;
        ClosingQty: Integer;
        CloseAmnt: Decimal;
        VendorName: Text;
        CustomerName: Text;
        PurBool: Boolean;
        SaleBool: Boolean;
        ValueEntry_gRec: Record "Value Entry";
        CostAmnt_p: Decimal;

}
