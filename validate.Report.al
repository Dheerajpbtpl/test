Report 56004 validate
{
    RDLCLayout = './Layouts/validate.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Item; Item)
        {
            trigger OnAfterGetRecord();
            begin
                Item."VAT Prod. Posting Group" := 'National';
                Item."Tax Group Code" := 'VAT5';
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