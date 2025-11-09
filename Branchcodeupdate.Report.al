/// <summary>
/// Report Branch code update (ID 50065).
/// </summary>
/// Taneesh
Report 50065 "Branch code update"
{
    Permissions = TableData "G/L Entry" = rimd;
    RDLCLayout = './Layouts/Branchcodeupdate.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            // DataItemTableView = where("Global Dimension 1 Code" = filter(''), "Location Code" = filter(<> ''));
            trigger OnAfterGetRecord();
            begin
                loc.Reset;
                //   loc.SetRange(loc.Code, "G/L Entry"."Location Code");
                if loc.FindFirst then
                    "G/L Entry"."Global Dimension 1 Code" := loc."Responsibility Center";
                "G/L Entry".Modify;
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



    var
        loc: Record Location;
        abc: Code[10];


}
