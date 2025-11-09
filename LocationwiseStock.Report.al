/// <summary>
/// Report Location wise Stock (ID 50008).
/// </summary>
Report 50008 "Location wise Stock"
{
    RDLCLayout = './Layouts/LocationwiseStock.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Item; Item)
        {
            PrintOnlyIfDetail = true;
            column(Vendoritem; Item."Vendor Item No.")
            {
            }
            column(dis; Item.Description)
            {
            }
            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                DataItemLink = "Item No." = field("No.");
                DataItemTableView = where(Open = filter(true));
                column(ItemNumber; "Item Ledger Entry"."Item No.")
                {
                }
                column(location; "Item Ledger Entry"."Location Code")
                {
                }
                column(qty; "Item Ledger Entry".Quantity)
                {
                }
                column(Serail; "Item Ledger Entry"."Serial No.")
                {
                }
                column(CostAmt; "Item Ledger Entry"."Cost Amount (Actual)")
                {
                }
                column(Canni; "Item Ledger Entry"."Cannibalization Applied")
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



    var
        vl: Record "Value Entry";


}
