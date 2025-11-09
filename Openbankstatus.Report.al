/// <summary>
/// Report Open bank status (ID 50087).
/// </summary>
Report 50087 "Open bank status"
{
    RDLCLayout = './Layouts/Openbankstatus.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
        {
            DataItemTableView = where(Open = filter(true));
            column(PostingDate; "Bank Account Ledger Entry"."Posting Date")
            {
            }
            column(DoucmentType; "Bank Account Ledger Entry"."Document Type")
            {
            }
            column(DocumentNumber; "Bank Account Ledger Entry"."Document No.")
            {
            }
            column(Amount; "Bank Account Ledger Entry".Amount)
            {
            }
            column(SourceCode; "Bank Account Ledger Entry"."Source Code")
            {
            }
            column(DebitAmount; "Bank Account Ledger Entry"."Debit Amount")
            {
            }
            column(CreditAmount; "Bank Account Ledger Entry"."Credit Amount")
            {
            }
            column(PartyName; "Bank Account Ledger Entry".Description)
            {
            }
            column(ChequNumber; "Bank Account Ledger Entry"."Cheque No.")
            {
            }
            column(CheueDate; "Bank Account Ledger Entry"."Cheque Date")
            {
            }
            dataitem(PDC; PDC)
            {
                column(PDCDoucmentNumber; PDC."Document No.")
                {
                }
                column(PDCAccountType; PDC."Account Type")
                {
                }
                column(PDCName; PDC.Name)
                {
                }
                column(PDCRDate; PDC."PDC Received Date")
                {
                }
                column(PDCCdate; PDC."PDC Cheque Date")
                {
                }
                column(PDCChequeNumber; PDC."PDC Cheque No.")
                {
                }
                column(PDCAmount; PDC."PDC Amount")
                {
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
