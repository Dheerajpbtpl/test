Report 50064 "Vendor Balances"
{
    UsageCategory = Lists;
    RDLCLayout = './Layouts/VendorBalances.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            DataItemTableView = where(Balance = filter(<> 0));
            column(No; Vendor."No.")
            {
            }
            column(Name_Vendor; Vendor.Name)
            {
            }
            column(Balance_Vendor; Vendor.Balance)
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