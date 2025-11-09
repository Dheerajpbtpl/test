
Report 50046 "Transfer order report"
{
    UsageCategory = Lists;
    RDLCLayout = './Layouts/Transferorderreport.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Transfer Shipment Line"; "Transfer Shipment Line")
        {
            RequestFilterFields = "Transfer-from Code", "Shipment Date";
            column(CmpName; CmpInfr.Name)
            {
            }
            column(ItemName; "Transfer Shipment Line"."Item No.")
            {
            }
            column(ItemDesc; "Transfer Shipment Line".Description)
            {
            }
            column(DocumentNumber; "Transfer Shipment Line"."Document No.")
            {
            }
            column(Shipment_Date; Format("Transfer Shipment Line"."Shipment Date"))
            {
            }
            column(LocationCode; "Transfer Shipment Line"."Transfer-from Code")
            {
            }
            column(Qty; "Transfer Shipment Line".Quantity)
            {
            }
            column(Rate; "Transfer Shipment Line"."Unit Price")
            {
            }
            column(Amount; "Transfer Shipment Line".Amount)
            {
            }
            column(VarDateFilter; VarDateFilter)
            {
            }
            column(VarLocFilter; VarLocFilter)
            {
            }
            column(VarAllFilter; VarAllFilter)
            {
            }
            trigger OnPreDataItem();
            begin
                VarAllFilter := "Transfer Shipment Line".GetFilters;
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



    trigger OnPreReport()
    begin
        CmpInfr.Get;
        StDate := "Transfer Shipment Line".GetRangeMin("Shipment Date");
        EndDate := "Transfer Shipment Line".GetRangemax("Shipment Date");
        VarLocFilter := "Transfer Shipment Line".GetFilter("Transfer-from Code");
        VarDateFilter := Format(StDate) + ' To ' + Format(EndDate);
    end;

    var
        TransferRate: Decimal;
        TransferAmount: Decimal;
        transfershipmen: Record "Transfer Receipt Line";
        TransferRate1: Decimal;
        SalesReturnshipment: Record "Return Receipt Line";
        CmpInfr: Record "Company Information";
        VarAllFilter: Text;
        StDate: Date;
        EndDate: Date;
        VarDateFilter: Text;
        VarLocFilter: Text;

}