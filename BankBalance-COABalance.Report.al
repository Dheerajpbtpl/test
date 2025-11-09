
Report 50169 "Bank Balance - COA Balance"
{
    RDLCLayout = './Layouts/BankBalance-COABalance.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Bank Account Posting Group"; "Bank Account Posting Group")
        {
            DataItemTableView = sorting(Code) where(Code = filter(<> 'INDENT'));
            column("Code"; "Bank Account Posting Group".Code)
            {
            }
            column(ReceivablesAccount; "Bank Account Posting Group"."G/L Account No.")
            {
            }
            column(COAAmount; Abs(COAAmount))
            {
            }
            column(CustomerBalance; Abs(BankBalance))
            {
            }
            column(Difference; Abs(COAAmount) - Abs(BankBalance))
            {
            }
            column(BankName; BankName)
            {
            }
            trigger OnAfterGetRecord();
            begin
                GlEntry.Reset;
                COAAmount := 0;
                GlEntry.SetRange(GlEntry."G/L Account No.", "G/L Account No.");
                if EDate > 0D then
                    GlEntry.SetRange(GlEntry."Posting Date", 0D, EDate);
                GlEntry.CalcSums(GlEntry.Amount);
                COAAmount := GlEntry.Amount;
                BankBalance := 0;
                BankAccount.Reset;
                BankAccount.SetRange(BankAccount."Bank Acc. Posting Group", Code);
                if EDate > 0D then
                    BankAccount.SetRange(BankAccount."Date Filter", 0D, EDate);
                if BankAccount.FindFirst then
                    repeat
                        BankAccount.CalcFields(BankAccount."Net Change (LCY)");
                        BankBalance += BankAccount."Net Change (LCY)";
                    until BankAccount.Next = 0;
                if BankAccount1.Get("Bank Account Posting Group".Code) then
                    BankName := BankAccount1.Name
                else
                    BankName := '';
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
                    field("As on Date"; EDate)
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
        GlEntry: Record "G/L Entry";
        EDate: Date;
        COAAmount: Decimal;
        BankAccount: Record "Bank Account";
        BankBalance: Decimal;
        BankAccount1: Record "Bank Account";
        BankName: Text;

}