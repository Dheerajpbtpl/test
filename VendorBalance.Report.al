Report 50271 "Vendor Balance"
{
    UsageCategory = Lists;
    RDLCLayout = './Layouts/VendorBalance.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Customer; Vendor)
        {
            RequestFilterFields = "Date Filter";
            column(No_Customer; Customer."No.")
            {
            }
            column(Name_Customer; Customer.Name)
            {
            }
            column(BalanceAsnDate; BalanceAsnDate)
            {
            }
            column(Posting_Group; Customer."Vendor Posting Group")
            {
            }
            trigger OnAfterGetRecord();
            begin
                BalanceAsnDate := 0;
                CustLedgerEntry.Reset;
                CustLedgerEntry.SetFilter("Posting Date", '<=%1', Customer.GetRangemax("Date Filter"));
                CustLedgerEntry.SetRange("Vendor No.", Customer."No.");
                CustLedgerEntry.CalcSums("Amount (LCY)");
                BalanceAsnDate := CustLedgerEntry."Amount (LCY)";
                if SkipZeroBalance then
                    if BalanceAsnDate = 0 then
                        CurrReport.Skip;
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
                    field("Skip Vendors with Zero Balance"; SkipZeroBalance)
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
        CustLedgerEntry: Record "Detailed Vendor Ledg. Entry";
        BalanceAsnDate: Decimal;
        SkipZeroBalance: Boolean;

}