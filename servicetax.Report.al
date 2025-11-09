Report 50037 "service tax"
{
    Permissions = TableData "G/L Entry" = rimd;
    RDLCLayout = './Layouts/servicetax.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            DataItemTableView = where("G/L Account No." = filter('5922'), "Credit Amount" = filter(> 0));
            trigger OnAfterGetRecord();
            begin
                "G/L Entry"."G/L Account No." := '5925';
                Modify;
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