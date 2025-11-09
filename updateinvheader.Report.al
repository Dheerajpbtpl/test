Report 50083 "update inv header"
{
    Permissions = TableData "Sales Invoice Header" = rimd;
    RDLCLayout = './Layouts/updateinvheader.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = where("No." = filter('02-11-1213-021'));
            trigger OnAfterGetRecord();
            begin
                "Sales Invoice Header"."Location Code" := 'Del-CSt';
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