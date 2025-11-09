Report 50050 "Product Group Wise Sales"
{
    UsageCategory = Lists;
    RDLCLayout = './Layouts/ProductGroupWiseSales.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Value Entry"; "Value Entry")
        {
            DataItemTableView = where("Item Ledger Entry Type" = filter(Sale));
            column(GlobalDimension2Code_ValueEntry; "Value Entry"."Global Dimension 2 Code")
            {
            }
            column(salesamount; "Value Entry"."Sales Amount (Actual)")
            {
            }
            column(CostAmountActual_ValueEntry; "Value Entry"."Cost Amount (Actual)")
            {
            }
            column(toalsales; tosales)
            {
            }
            column(Lstweek; Lwsale)
            {
            }
            column(Lmonthsal; Lmsale)
            {
            }
            column(Lquatersale; Lquatersal)
            {
            }
            column(productname; productname)
            {
            }
            trigger OnPreDataItem();
            begin
                //yesterdaydate:=CALCDATE('-1d',WORKDATE);
                //ldate:=CALCDATE('-7d',WORKDATE);
                // MESSAGE(FORMAT(WORKDATE));
                // MESSAGE(FORMAT(TODAY));
                START := CalcDate('-CM-1M', WorkDate);
                ENDDATE := CalcDate('CM-1M', WorkDate);

            end;

            trigger OnAfterGetRecord();
            begin
                if "Value Entry"."Posting Date" = WorkDate then
                    tosales := "Value Entry"."Sales Amount (Actual)"
                else
                    if ("Value Entry"."Posting Date" > WorkDate - 7) and ("Value Entry"."Posting Date" < WorkDate) then
                        Lwsale := "Value Entry"."Sales Amount (Actual)"
                    else
                        if ("Value Entry"."Posting Date" >= START) and ("Value Entry"."Posting Date" <= ENDDATE) then
                            Lmsale := "Value Entry"."Sales Amount (Actual)";
                // if value.GET("Value Entry"."Item No.") then
                //productname:="Value Entry".Description;
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
        tosales: Decimal;
        yesterdaydate: Date;
        lastweek: Integer;
        ldate: Date;
        Lwsale: Decimal;
        Lmsale: Decimal;
        Lquatersal: Decimal;
        START: Date;
        ENDDATE: Date;
        productname: Text;
        value: Record "Value Entry";


}
