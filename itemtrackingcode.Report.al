/// <summary>
/// Report item tracking code (ID 58000).
/// </summary>
Report 58000 "item tracking code"
{
    RDLCLayout = './Layouts/itemtrackingcode.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Item; Item)
        {
            trigger OnAfterGetRecord();
            begin
                Item."Item Category Code" := '';
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
