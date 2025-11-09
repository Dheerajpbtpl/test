
Report 50096 "Vat Entry modify"
{
    Permissions = TableData "G/L Entry" = rimd;
    RDLCLayout = './Layouts/VatEntrymodify.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            DataItemTableView = where("G/L Account No." = filter('5911'), "Entry No." = filter(4977 | 4979));
            trigger OnAfterGetRecord();
            begin
                "G/L Entry"."G/L Account No." := '5914';
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