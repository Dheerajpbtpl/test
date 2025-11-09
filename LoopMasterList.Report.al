/// <summary>
/// Report Loop Master List (ID 50200).
/// </summary>
Report 50200 "Loop Master List"
{
    RDLCLayout = './Layouts/LoopMasterList.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Loop Master"; "Loop Master")
        {
            column(Loopcode_LoopMaster; "Loop Master"."Loop code")
            {
            }
            column(LoopDetails_LoopMaster; "Loop Master"."Loop Details")
            {
            }
            column(LoopSubject_LoopMaster; "Loop Master"."Loop Subject")
            {
            }
            column(Loopproducts_LoopMaster; "Loop Master"."Loop products")
            {
            }
            dataitem("Loop Product master"; "Loop Product master")
            {
                DataItemLink = "Loop Master" = field("Loop code");
                column(Productcode_LoopProductmaster; "Loop Product master"."Product code")
                {
                }
                column(ProductName_LoopProductmaster; "Loop Product master"."Product Name")
                {
                }
                column(LoopMaster_LoopProductmaster; "Loop Product master"."Loop Master")
                {
                }
                dataitem("Loop Keywords"; "Loop Keywords")
                {
                    DataItemLink = "Loop Code" = field("Loop Master");
                    column(Keywords_LoopKeywords; "Loop Keywords".Keywords)
                    {
                    }
                    column(LoopCode_LoopKeywords; "Loop Keywords"."Loop Code")
                    {
                    }
                }
            }
        }
    }

    requestpage
    {


        SaveValues = false;
        layout
        {
            area(content)
            {
                field("Loop Master"; LoopMaster)
                {
                    ApplicationArea = Basic;
                    TableRelation = "Loop Master"."Loop code";
                }

            }
        }

        actions
        {
        }
    }



    var
        LoopMaster: Text;


}
