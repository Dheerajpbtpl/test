/// <summary>
/// Report Data correction tool1 (ID 50051).
/// </summary>
Report 50051 "Data correction tool1"
{
    Permissions = TableData "G/L Entry" = rimd, TableData "Cust. Ledger Entry" = rimd, TableData "Sales Invoice Header" = rimd, TableData "Detailed Cust. Ledg. Entry" = rimd, TableData "Value Entry" = rimd;//, TableData "Tax Entry" = rimd, TableData "Detailed Tax Entry" = rimd
    RDLCLayout = './Layouts/Datacorrectiontool1.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            DataItemTableView = where("Document No." = filter('PBTPL-01-11-0217-029'));
            trigger OnAfterGetRecord();
            begin
                "G/L Entry"."Posting Date" := 20170228D;
                "G/L Entry".Modify;
            end;

        }
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = where("No." = filter('PBTPL-01-11-0217-029'));
            trigger OnAfterGetRecord();
            begin
                "Sales Invoice Header"."Posting Date" := 20170228D;
                "Sales Invoice Header".Modify;
            end;

        }
        /*  dataitem("Tax Entry"; "Tax Entry")
         {
             DataItemTableView = where("Document No." = filter('PBTPL-01-11-0217-029'));
             trigger OnAfterGetRecord();
             begin
                 "Tax Entry"."Posting Date" := 20170228D;
                 "Tax Entry".Modify;
             end;

         } */
        dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
        {
            DataItemTableView = where("Document No." = filter('PBTPL-01-11-0217-029'));
            trigger OnAfterGetRecord();
            begin
                "Cust. Ledger Entry"."Posting Date" := 20170228D;
                "Cust. Ledger Entry".Modify;
            end;

        }
        dataitem("Detailed Cust. Ledg. Entry"; "Detailed Cust. Ledg. Entry")
        {
            DataItemTableView = where("Document No." = filter('PBTPL-01-11-0217-029'));
            trigger OnAfterGetRecord();
            begin
                "Detailed Cust. Ledg. Entry"."Posting Date" := 20170228D;
                "Detailed Cust. Ledg. Entry".Modify;
            end;

        }
        dataitem("Value Entry"; "Value Entry")
        {
            DataItemTableView = where("Document No." = filter('PBTPL-01-11-0217-029'));
            trigger OnAfterGetRecord();
            begin
                "Value Entry"."Posting Date" := 20170228D;
                "Value Entry".Modify;
            end;

        }
        /*    dataitem("Detailed Tax Entry"; "Detailed Tax Entry")
           {
               DataItemTableView = where("Document No." = filter('PBTPL-01-11-0217-029'));
               trigger OnAfterGetRecord();
               begin
                   "Detailed Tax Entry"."Posting Date" := 20170228D;
                   "Detailed Tax Entry".Modify;
               end;

           }
           dataitem("Service Tax Entry"; "Service Tax Entry")
           {
               DataItemTableView = where("Document No." = filter('PBTPL-01-11-0217-029'));
               trigger OnAfterGetRecord();
               begin
                   "Posting Date" := 20170228D;
                   Modify;
               end;

           } */
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
