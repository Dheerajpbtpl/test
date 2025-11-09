/// <summary>
/// Report posting number (ID 50099).
/// </summary>
Report 50099 "posting number"
{
    RDLCLayout = './Layouts/postingnumber.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            trigger OnAfterGetRecord();
            begin
                "Sales Header"."Return Receipt No. Series" := 'psrs-del';
                "Sales Header"."Posting No. Series" := 'psri-del';
                "Sales Header"."Return Receipt No." := '';
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