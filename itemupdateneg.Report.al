/// <summary>
/// Report item update neg (ID 50086).
/// </summary>
Report 50086 "item update neg"
{
    RDLCLayout = './Layouts/itemupdateneg.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Item; Item)
        {
            trigger OnAfterGetRecord();
            begin
                Item."Prevent Negative Inventory" := Item."prevent negative inventory"::Yes;
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
