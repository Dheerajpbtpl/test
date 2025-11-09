
Report 50010 "Sales Bill Printing"
{
    RDLCLayout = './Layouts/SalesBillPrinting.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            column(Cmp_Name; COMPANYNAME)
            {
            }
            column(Cmp_Add1; Cmp.Address)
            {
            }
            column(Cmp_Add2; Cmp."Address 2")
            {
            }
            column(Cmp_City; Cmp.City)
            {
            }
            column(Cmp_Phone; Cmp."Phone No.")
            {
            }
            column(Cmp_Fax; Cmp."Fax No.")
            {
            }
            column(Cmp_Email; Cmp."E-Mail")
            {
            }
            column(Cmp_Tin; ' Cmp."T.I.N. No."') //Lk
            {
            }
            column(Cmp_Stax; Cmp."GST Registration No.")//Lk "Service Tax Registration No."
            {
            }
            column(Inv_No; "Sales Invoice Header"."No.")
            {
            }
            column(SellToNo; "Sales Invoice Header"."Sell-to Customer No.")
            {
            }
            column(BillToNo; "Sales Invoice Header"."Bill-to Customer No.")
            {
            }
            column(BilltoName; "Sales Invoice Header"."Bill-to Name")
            {
            }
            column(BillToName2; "Sales Invoice Header"."Bill-to Name 2")
            {
            }
            column(BilltoAdd1; "Sales Invoice Header"."Bill-to Address")
            {
            }
            column(BillToAddr2; "Sales Invoice Header"."Bill-to Address 2")
            {
            }
            column(BillToCity; "Sales Invoice Header"."Bill-to City")
            {
            }
            column(ShipToAdd; "Sales Invoice Header"."Ship-to Address")
            {
            }
            column(ShiptoAdd2; "Sales Invoice Header"."Ship-to Address 2")
            {
            }
            column(ShipToCity; "Sales Invoice Header"."Ship-to City")
            {
            }
            column(Order_Dt; "Sales Invoice Header"."Order Date")
            {
            }
            column(PostinG_Date; "Sales Invoice Header"."Posting Date")
            {
            }
            column(Shipment_Date; "Sales Invoice Header"."Shipment Date")
            {
            }
            column(Pymt_Terms; "Sales Invoice Header"."Payment Terms Code")
            {
            }
            column(Due_Date; "Sales Invoice Header"."Due Date")
            {
            }
            column(Order_No; "Sales Invoice Header"."Order No.")
            {
            }
            column(Time_Of_Rem; "Sales Invoice Header"."Time of Removal")
            {
            }
            column(Lr_No; "Sales Invoice Header"."LR/RR No.")
            {
            }
            column(LR_Dt; "Sales Invoice Header"."LR/RR Date")
            {
            }
            column(Veh_No; "Sales Invoice Header"."Vehicle No.")
            {
            }
            column(Mode_Tpt; "Sales Invoice Header"."Mode of Transport")
            {
            }
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = field("No.");
                column(Doct_No; "Sales Invoice Line"."Document No.")
                {
                }
                column(Line_No; "Sales Invoice Line"."Line No.")
                {
                }
                column(Item_Type; "Sales Invoice Line".Type)
                {
                }
                column(Item_No; "Sales Invoice Line"."No.")
                {
                }
                column(Item_Desc; "Sales Invoice Line".Description)
                {
                }
                column(Item_Unit; "Sales Invoice Line"."Unit of Measure")
                {
                }
                column(Item_Qty; "Sales Invoice Line".Quantity)
                {
                }
                column(Item_Price; "Sales Invoice Line"."Unit Price")
                {
                }
                column(Item_Disc; "Sales Invoice Line"."Line Discount %")
                {
                }
                column(Item_Amt; "Sales Invoice Line".Amount)
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
        Cmp: Record "Company Information";

}