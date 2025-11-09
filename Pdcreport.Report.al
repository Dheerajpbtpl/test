Report 50069 Pdcreport
{
    RDLCLayout = './Layouts/Pdcreport.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(PDC; PDC)
        {
            column(DocumentNo_PDC; PDC."Document No.")
            {
            }
            column(AccountType_PDC; PDC."Account Type")
            {
            }
            column(Name_PDC; PDC.Name)
            {
            }
            column(PDCChequeDate_PDC; PDC."PDC Cheque Date")
            {
            }
            column(PDCChequeNo_PDC; PDC."PDC Cheque No.")
            {
            }
            column(PDCAmount_PDC; PDC."PDC Amount")
            {
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
