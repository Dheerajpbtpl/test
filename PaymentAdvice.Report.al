/// <summary>
/// Report Payment Advice (ID 50089).
/// </summary>
Report 50089 "Payment Advice"
{
    RDLCLayout = './Layouts/PaymentAdvice.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
        {
            DataItemTableView = where("Bal. Account Type" = filter(Vendor));
            RequestFilterFields = "Entry No.";
            column(DocumentNo_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Document No.")
            {
            }
            column(DocumentDate_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Document Date")
            {
            }
            column(DocumentType_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Document Type")
            {
            }
            column(EntryNo_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Entry No.")
            {
            }
            column(PostingDate_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Posting Date")
            {
            }
            column(Amount_BankAccountLedgerEntry; "Bank Account Ledger Entry".Amount)
            {
            }
            column(venderaddress; venderaddress)
            {
            }
            column(ChequeNo_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Cheque No.")
            {
            }
            column(VendorName; vendername)
            {
            }
            column(narration; narration)
            {
            }
            column(venderaddress1; venderaddress1)
            {
            }
            column(venderaddresscity; venderaddresscity)
            {
            }
            column(ChequeDate_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Cheque Date")
            {
            }
            dataitem("Company Information"; "Company Information")
            {
                column(ShiptoAddress2_CompanyInformation; "Company Information"."Ship-to Address 2")
                {
                }
                column(ShiptoAddress_CompanyInformation; "Company Information"."Ship-to Address")
                {
                }
                column(ServiceTaxRegistrationNo_CompanyInformation; "Company Information"."GST Registration No.")//Lk "Service Tax Registration No."
                {
                }
                column(ShiptoName2_CompanyInformation; "Company Information"."Ship-to Name 2")
                {
                }
                column(Name_CompanyInformation; "Company Information".Name)
                {
                }
                column(Name2_CompanyInformation; "Company Information"."Name 2")
                {
                }
                column(Address_CompanyInformation; "Company Information".Address)
                {
                }
                column(Address2_CompanyInformation; "Company Information"."Address 2")
                {
                }
                column(City_CompanyInformations; "Company Information".City)
                {
                }
                column(PhoneNo_CompanyInformation; "Company Information"."Phone No.")
                {
                }
                column(PhoneNo2_CompanyInformation; "Company Information"."Phone No. 2")
                {
                }
                column(EMail_CompanyInformation; "Company Information"."E-Mail")
                {
                }
                column(PANNo_CompanyInformation; "Company Information"."P.A.N. No.")
                {
                }
                column(PrimaryKey_CompanyInformation; "Company Information"."Primary Key")
                {
                }
                column(BankName_CompanyInformation; "Company Information"."Bank Name")
                {
                }
            }
            trigger OnAfterGetRecord();
            begin
                if "Bank Account Ledger Entry"."Bal. Account Type" = "Bank Account Ledger Entry"."bal. account type"::Vendor then begin
                    vendor.Reset;
                    vendor.SetRange(vendor."No.", "Bank Account Ledger Entry"."Bal. Account No.");
                    if vendor.FindFirst then
                        vendername := vendor.Name;
                    venderaddress := vendor.Address;
                    venderaddress1 := vendor."Address 2";
                    venderaddresscity := vendor.City + vendor."Post Code";
                    //MESSAGE(vendername);
                end;
                postednarr.Reset;
                postednarr.SetRange(postednarr."Document No.", "Bank Account Ledger Entry"."Document No.");
                if postednarr.FindFirst then
                    narration := postednarr.Narration;
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
        vendor: Record Vendor;
        vendername: Text[100];
        datalcustLentry: Record "Detailed Vendor Ledg. Entry";
        venderaddress: Text[50];
        venderaddress1: Text[50];
        venderaddresscity: Text[50];
        postednarr: Record "Posted Narration";
        narration: Text[50];


}
