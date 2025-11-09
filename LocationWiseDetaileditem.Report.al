/// <summary>
/// Report Location Wise Detailed item (ID 50080).
/// </summary>
/// Taneesh
Report 50080 "Location Wise Detailed item"
{
    UsageCategory = Lists;
    RDLCLayout = './Layouts/LocationWiseDetaileditem.rdlc';
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
            dataitem("Value Entry"; "Value Entry")
            {
                DataItemLink = "Item No." = field("No."), "Location Code" = field("Location Filter");
                column(Qty; "Value Entry"."Item Ledger Entry Quantity")
                {
                }
                column(UnitCost; "Value Entry"."Cost per Unit")
                {
                }
                column(Location; "Value Entry"."Location Code")
                {
                }
                column(Total; TotalAmt)
                {
                }
                trigger OnAfterGetRecord();
                begin
                    TotalAmt := "Value Entry"."Item Ledger Entry Quantity" * "Value Entry"."Cost per Unit";
                end;

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

    trigger OnPreReport()
    begin
        /*
		ValueEntryRec.RESET;
		ValueEntryRec.SETRANGE(ValueEntryRec."Item No.",Item."No.");
		ValueEntryRec.SETRANGE(ValueEntryRec."Location Code",Item."Location Filter");
		*/


    end;

    var
        "Show Detail": Boolean;
        TotalAmt: Decimal;


}
