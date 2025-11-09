/// <summary>
/// Report Negitave Stock (ID 50056).
/// </summary>
Report 50056 "Negitave Stock"
{
    UsageCategory = Lists;
    RDLCLayout = './Layouts/NegitaveStock.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Item; Item)
        {
            PrintOnlyIfDetail = true;
            column(VendorItemNo; Item."Vendor Item No.")
            {
            }
            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                DataItemLink = "Item No." = field("No.");
                DataItemTableView = where("Remaining Quantity" = filter(< 0));
                column(ItemNo; "Item Ledger Entry"."Item No.")
                {
                }
                column(Date; "Item Ledger Entry"."Posting Date")
                {
                }
                column(DocumentNumber; "Item Ledger Entry"."Document No.")
                {
                }
                column(LocationCode; "Item Ledger Entry"."Location Code")
                {
                }
                column(Qty; "Item Ledger Entry".Quantity)
                {
                }
                column(Amount; "Item Ledger Entry"."Cost Amount (Actual)")
                {
                }
                column(SerialNo; "Item Ledger Entry"."Serial No.")
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




}
