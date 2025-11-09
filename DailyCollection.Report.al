/// <summary>
/// Report Daily Collection (ID 50113).
/// </summary>
Report 50113 "Daily Collection"
{
    RDLCLayout = './Layouts/DailyCollection.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
        {
            DataItemTableView = where("Document Type" = filter(" " | Payment));
            RequestFilterFields = "Posting Date";
            column(ChNo; ChNo)
            {
            }
            column(ChkDate; Format(ChkDate))
            {
            }
            column(CustName; CustName)
            {
            }
            column(BankNAme; BankNAme)
            {
            }
            column(AmountLCY; Abs("Cust. Ledger Entry"."Amount (LCY)"))
            {
            }
            column(Narrtion; Narrtion)
            {
            }
            column(CompName; CompInfo.Name)
            {
            }
            column(GetFilters; GetFilters)
            {
            }
            column(Posting_date; "Cust. Ledger Entry"."Posting Date")
            {
            }
            trigger OnAfterGetRecord();
            begin
                BankLedgrEntry.Reset;
                BankLedgrEntry.SetRange(BankLedgrEntry."Document No.", "Cust. Ledger Entry"."Document No.");
                if BankLedgrEntry.FindFirst then begin
                    ChNo := BankLedgrEntry."Cheque No.";
                    ChkDate := BankLedgrEntry."Cheque Date";
                    //BankCode:=BankLedgrEntry."Bank Account No.";
                    BankAct.Reset;
                    BankAct.SetRange("No.", BankLedgrEntry."Bank Account No.");
                    if BankAct.FindFirst then
                        BankNAme := BankAct.Name;
                end;
                "Cust. Ledger Entry".CalcFields("Cust. Ledger Entry"."Amount (LCY)");
                Narrtion := '';
                Custmer.Reset;
                Custmer.SetRange(Custmer."No.", "Cust. Ledger Entry"."Customer No.");
                if Custmer.FindFirst then
                    CustName := Custmer.Name;
                Postednarrtn.Reset;
                Postednarrtn.SetRange("Document No.", "Cust. Ledger Entry"."Document No.");
                if Postednarrtn.FindFirst then
                    Narrtion := Postednarrtn.Narration;
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



    trigger OnPreReport()
    begin
        CompInfo.Get;

    end;

    var
        BankLedgrEntry: Record "Bank Account Ledger Entry";
        ChNo: Code[30];
        ChkDate: Date;
        Custmer: Record Customer;
        CustName: Text;
        BankCode: Code[20];
        BankAct: Record "Bank Account";
        BankNAme: Text;
        Postednarrtn: Record "Posted Narration";
        Narrtion: Text;
        CompName: Text;
        CompInfo: Record "Company Information";


}
