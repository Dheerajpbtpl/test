Report 50019 "TDS Details Payable"
{
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './Layouts/TDSDetailsPayable.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            RequestFilterFields = "G/L Account No.", "Posting Date";
            RequestFilterHeading = 'posting date';
            column(DocumentNo; "G/L Entry"."Document No.")
            {
            }
            column(CreditAmount; "G/L Entry"."Credit Amount")
            {
            }
            column(DebitAmount; "G/L Entry"."Debit Amount")
            {
            }
            column(Amount; "G/L Entry".Amount)
            {
            }
            column(PostingDate; "G/L Entry"."Posting Date")
            {
            }
            column(GLAccountName; "G/L Entry"."G/L Account Name")
            {
            }
            column(DocumentDate; "G/L Entry"."Posting Date")
            {
            }
            column(Vendor_Name; Vendor_Name)
            {
            }
            column(vendor_Pan; vendor_Pan)
            {
            }
            column(companyinfoname; Company_Info.Name)
            {
            }
            column(Amount_GLEntry; "G/L Entry".Amount)
            {
            }
            trigger OnAfterGetRecord();
            begin
                GLEntry1.Reset;
                GLEntry1.SetRange("Document No.", "Document No.");
                if GLEntry1.FindFirst then
                    if GLEntry1."System-Created Entry" = true then
                        if GLEntry1."Source No." <> '' then
                            Ven_dor.Reset;
                Ven_dor.SetRange("No.", GLEntry1."Source No.");
                if Ven_dor.FindFirst then
                    Vendor_Name := Ven_dor.Name;
                vendor_Pan := Ven_dor."P.A.N. No.";
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

    trigger OnInitReport()
    begin
        Company_Info.Get;
        Company_Info.CalcFields(Picture);

    end;


    var
        Company_Info: Record "Company Information";
        Ven_dor: Record Vendor;
        Vendor_Name: Text;
        vendor_Pan: Code[30];
        GLEntry1: Record "G/L Entry";

}