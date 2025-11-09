/// <summary>
/// Report DEFAULT DIM (ID 56009).
/// </summary>
Report 56009 "DEFAULT DIM"
{
    RDLCLayout = './Layouts/DEFAULTDIM.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Default Dimension"; "Default Dimension")
        {
            trigger OnAfterGetRecord();
            begin
                "Default Dimension"."Value Posting" := "Default Dimension"."value posting"::"Same Code";
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
