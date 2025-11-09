/// <summary>
/// Report item tax group (ID 50009).
/// </summary>
Report 50009 "item tax group"
{
    RDLCLayout = './Layouts/itemtaxgroup.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Item; Item)
        {
            trigger OnAfterGetRecord();
            begin
                Item."Tax Group Code" := 'IT5%';
                Item."VAT Prod. Posting Group" := 'vat5';
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
