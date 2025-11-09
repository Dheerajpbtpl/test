/// <summary>
/// Report Location Wise Test Report (ID 50068).
/// </summary>
/// taneesh
Report 50068 "Location Wise Test Report"
{
    RDLCLayout = './Layouts/LocationWiseTestReport.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = sorting("No.") order(ascending) where(Inventory = filter(<> 0));
            RequestFilterFields = "Date Filter";
            column(ProductGroupCode; 'Item."Product Group Code"')
            {
            }
            column(ItemDes; Item.Description)
            {
            }
            column(VendorItemNo; Item."Vendor Item No.")
            {
            }
            column(Inventory; Item.Inventory)
            {
            }
            column(unitocst; Item."Unit Cost")
            {
            }
            column(ItemNo; Item."No.")
            {
            }
            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                DataItemLink = "Item No." = field("No."), "Location Code" = field("Location Filter");
                DataItemTableView = sorting("Item No.") order(ascending) where(Open = filter(true), "Remaining Quantity" = filter(<> 0));
                RequestFilterFields = "Document No.", "Location Code", "Posting Date";
                column(Location; "Item Ledger Entry"."Location Code")
                {
                }
                column(Qty; "Item Ledger Entry"."Remaining Quantity")
                {
                }
                column(cost; "Cost Amount (Actual)")
                {
                }
                column(Showdetail; "Show Detail")
                {
                }
                column(EntryNo_ItemLedgerEntry; "Item Ledger Entry"."Entry No.")
                {
                }
            }
        }
    }

    requestpage
    {


        SaveValues = false;
        layout
        {
            area(content)
            {
                group(option)
                {
                    Caption = 'option';
                    field("Show Detail"; "Show Detail")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Show Detail';
                    }

                }
            }
        }

        actions
        {
        }
    }



    var
        "Show Detail": Boolean;
        UnitAmt: Decimal;


}
