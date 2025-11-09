/// <summary>
/// Report Data correction tool3 (ID 50072).
/// </summary>
Report 50072 "Data correction tool3"
{
    Permissions = TableData "G/L Entry" = rimd, TableData "Cust. Ledger Entry" = rimd, TableData "Sales Invoice Header" = rimd, TableData "Detailed Cust. Ledg. Entry" = rimd, TableData "Value Entry" = rimd;
    RDLCLayout = './Layouts/Datacorrectiontool3.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            DataItemTableView = where("Document No." = filter('PBTPL-01-11-0217-029'));
            dataitem("Purch. Inv. Line"; "Purch. Inv. Line")
            {
                dataitem("Purch. Rcpt. Line"; "Purch. Rcpt. Line")
                {
                    dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
                    {
                        dataitem("Purch. Cr. Memo Hdr."; "Purch. Cr. Memo Hdr.")
                        {
                        }
                    }
                }
            }
            trigger OnAfterGetRecord();
            begin
                "G/L Entry"."Posting Date" := 20170228D;
                "G/L Entry".Modify;
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
