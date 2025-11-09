/// <summary>
/// Report Module 2 (ID 50093).
/// </summary>
Report 50093 "Module 2"
{
    RDLCLayout = './Layouts/Module2.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
        {
            RequestFilterFields = "Posting Date";
            column(CustLedgEntryFilter; CustLedgerEntryFilter)
            {
            }
            column(CustomerPostingGroup_CustLedgerEntry; "Cust. Ledger Entry"."Customer Posting Group")
            {
            }
            column(RemainingAmount_CustLedgerEntry; "Cust. Ledger Entry"."Remaining Amount")
            {
            }
            column(GLAccotNumber; GLAccotNumber)
            {
            }
            column(GLAccotAmount; GLAccotAmount)
            {
            }
            dataitem("Company Information"; "Company Information")
            {
                column(Name_CompanyInformation; "Company Information".Name)
                {
                }
                column(Address_CompanyInformation; "Company Information".Address)
                {
                }
                column(Address2_CompanyInformation; "Company Information"."Address 2")
                {
                }
                column(City_CompanyInformation; "Company Information".City)
                {
                }
                column(PhoneNo_CompanyInformation; "Company Information"."Phone No.")
                {
                }
                column(Picture_CompanyInformation; "Company Information".Picture)
                {
                }
                column(EMail_CompanyInformation; "Company Information"."E-Mail")
                {
                }
            }
            trigger OnAfterGetRecord();
            begin
                CPG.Reset;
                CPG.SetRange(CPG.Code, "Cust. Ledger Entry"."Customer Posting Group");
                if CPG.FindFirst then
                    GLAccotNumber := CPG."Receivables Account";
                GLACC.Reset;
                GLACC.SetRange(GLACC."No.", GLAccotNumber);
                if GLACC.FindFirst then
                    GLACC.CalcFields(GLACC.Balance);
                GLAccotAmount := GLACC.Balance;
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
        CustLedgerEntryFilter := GetTableFilters("Cust. Ledger Entry".GetFilters);
        // "Cust. Ledger Entry".TABLECAPTION,

    end;

    var
        CPG: Record "Customer Posting Group";
        GLACC: Record "G/L Account";
        GLAccotNumber: Code[20];
        GLAccotAmount: Decimal;
        CustLedgerEntryFilter: Text;

    local procedure GetTableFilters(Filters: Text): Text
    begin
        if Filters <> '' then
            exit(StrSubstNo('%1', Filters));
        exit('');
        // TableName,
    end;


}
