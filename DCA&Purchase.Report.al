/// <summary>
/// Report DCA & Purchase (ID 50164).
/// </summary>
Report 50164 "DCA & Purchase"
{
    RDLCLayout = './Layouts/DCA&Purchase.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Integer; Integer)
        {
            DataItemTableView = where(Number = filter(1));
            column(DCAAmount; Abs(DCAAmount))
            {
            }
            column(PurchaseAmount; PurchaseAmount)
            {
            }
            column(FreightAmount; FreightAmount)
            {
            }
            column(Purchase_Freight; PurchaseAmount + FreightAmount)
            {
            }
            column(DCA_Purchase_Diff; Abs(DCAAmount) - (PurchaseAmount + FreightAmount))
            {
            }
            trigger OnAfterGetRecord();
            begin
                DCAAmount := 0;
                FreightAmount := 0;
                PurchaseAmount := 0;
                GLEntry.Reset;
                GLEntry.SetRange(GLEntry."Posting Date", SDate, EDate);
                GLEntry.SetRange(GLEntry."System-Created Entry", true);
                GLEntry.SetFilter(GLEntry."G/L Account No.", '%1', '7191');//,'400249');
                GLEntry.CalcSums(GLEntry.Amount);
                DCAAmount := GLEntry.Amount;
                GLEntry.Reset;
                GLEntry.SetRange(GLEntry."Posting Date", SDate, EDate);
                GLEntry.SetRange(GLEntry."System-Created Entry", true);
                GLEntry.SetFilter(GLEntry."G/L Account No.", '%1|%2', '7110', '5930');
                GLEntry.CalcSums(GLEntry.Amount);
                PurchaseAmount := GLEntry.Amount;
                GLEntry.Reset;
                GLEntry.SetRange(GLEntry."Posting Date", SDate, EDate);
                //GLEntry.SETRANGE(GLEntry."System-Created Entry",FALSE);
                GLEntry.SetFilter(GLEntry."G/L Account No.", '%1|%2|%3', '4001302', '4001303', '4001309');
                GLEntry.CalcSums(GLEntry.Amount);
                FreightAmount := GLEntry.Amount;
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
                group(Filters)
                {
                    field("Start Date"; SDate)
                    {
                        ApplicationArea = Basic;
                    }
                    field("End Date"; EDate)
                    {
                        ApplicationArea = Basic;
                    }

                }
            }
        }

        actions
        {
        }
    }



    var
        GLEntry: Record "G/L Entry";
        SDate: Date;
        EDate: Date;
        DCAAmount: Decimal;
        PurchaseAmount: Decimal;
        FreightAmount: Decimal;


}
