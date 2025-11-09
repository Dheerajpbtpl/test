
Report 50011 "test 123"
{
    RDLCLayout = './Layouts/test123.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Detailed Cust. Ledg. Entry"; "Detailed Cust. Ledg. Entry")
        {
            DataItemTableView = where("Entry Type" = filter("Initial Entry" | "Unrealized Loss" | "Unrealized Gain" | "Realized Loss" | "Realized Gain" | "Payment Discount" | "Payment Discount (VAT Excl.)" | "Payment Discount (VAT Adjustment)" | "Payment Tolerance" | "Payment Discount Tolerance" | "Payment Tolerance (VAT Excl.)" | "Payment Tolerance (VAT Adjustment)" | "Payment Discount Tolerance (VAT Excl.)" | "Payment Discount Tolerance (VAT Adjustment)"));
            trigger OnPreDataItem();
            begin
                "Detailed Cust. Ledg. Entry".SetRange("Detailed Cust. Ledg. Entry"."Posting Date", 0D, 20170630D);
            end;

            trigger OnAfterGetRecord();
            begin
                "Detailed Cust. Ledg. Entry"."Ledger Entry Amount" := true;
                "Detailed Cust. Ledg. Entry".Modify;
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
}