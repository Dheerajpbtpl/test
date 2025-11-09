Report 50001 "PDC Received"
{
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './Layouts/PDCReceived.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(PDC; PDC)
        {
            DataItemTableView = sorting("PDC Cheque Date", "Account Type", "Account No.") where("Account Type" = const(Customer));
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(UserId; UserId)
            {
            }

            column(STRSUBSTNO_PeriodText_Text000_; StrSubstNo(PeriodText, Text000))
            {
            }
            column(PDC__PDC_Received_Date_; PDC."PDC Received Date")
            {
            }
            column(PDC_Name; PDC.Name)
            {
            }
            column(PDC_RECEIVEDCaption; PDC_RECEIVEDCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Invoice_Date_FromCaption; Invoice_Date_FromCaptionLbl)
            {
            }
            column(CHEQUE_NOCaption; CHEQUE_NOCaptionLbl)
            {
            }
            column(INVOICE_NOCaption; INVOICE_NOCaptionLbl)
            {
            }
            column(INVOICE_DATECaption; INVOICE_DATECaptionLbl)
            {
            }
            column(INVOICE_AMTCaption; INVOICE_AMTCaptionLbl)
            {
            }
            column(PENDING_AMTCaption; PENDING_AMTCaptionLbl)
            {
            }
            column(CHEQUE_AMTCaption; CHEQUE_AMTCaptionLbl)
            {
            }
            column(PDC_REFERENCECaption; PDC_REFERENCECaptionLbl)
            {
            }
            column(DUE_DATECaption; DUE_DATECaptionLbl)
            {
            }
            column(PDC_Entry_No_; PDC."Entry No.")
            {
            }
            column(PDC_PDC_Cheque_Date; PDC."PDC Cheque Date")
            {
            }
            column(PDC_Account_No_; PDC."Account No.")
            {
            }
            column(PDC_Document_No_; PDC."Document No.")
            {
            }
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                DataItemLink = "Document No." = field("Document No.");
                DataItemTableView = where("Document Type" = const(Payment));
                RequestFilterFields = "Posting Date";
                column(Cust__Ledger_Entry__Document_No__; "Cust. Ledger Entry"."Document No.")
                {
                }
                column(Cust__Ledger_Entry__Cust__Ledger_Entry___Remaining_Amt___LCY__; "Cust. Ledger Entry"."Remaining Amt. (LCY)")
                {
                }
                column(Cust__Ledger_Entry__Posting_Date_; "Cust. Ledger Entry"."Posting Date")
                {
                }
                column(Cust__Ledger_Entry__Due_Date_; "Cust. Ledger Entry"."Due Date")
                {
                }
                column(PDC__PDC_Cheque_No__; PDC."PDC Cheque No.")
                {
                }
                column(PDC__PDC_Amount_; PDC."PDC Amount")
                {
                }
                column(PDC__Applies_to_ID_; PDC."Applies-to ID")
                {
                }
                column(Cust__Ledger_Entry_Amount; "Cust. Ledger Entry".Amount)
                {
                }
                column(Cust__Ledger_Entry_Entry_No_; "Cust. Ledger Entry"."Entry No.")
                {
                }
                dataitem("Detailed Cust. Ledg. Entry"; "Detailed Cust. Ledg. Entry")
                {
                    DataItemLink = "Customer No." = field("Customer No."), "Applied Cust. Ledger Entry No." = field("Entry No.");
                    DataItemTableView = where("Entry Type" = const(Application));
                    trigger OnPreDataItem();
                    begin
                        SetFilter("Cust. Ledger Entry No.", '<>%1', "Cust. Ledger Entry"."Entry No.");
                    end;

                    trigger OnAfterGetRecord();
                    begin
                        CustLegderEntry.Get("Detailed Cust. Ledg. Entry"."Cust. Ledger Entry No.");
                    end;

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





    trigger OnPreReport()
    begin
        PeriodText := "Cust. Ledger Entry".GetFilter("Cust. Ledger Entry"."Posting Date");

    end;

    var
        CustLegderEntry: Record "Cust. Ledger Entry";
        PdcApplBuffer: Record "PDC Application Buffer";
        PendingAmount: Decimal;
        PeriodText: Text[30];
        Text000: label 'Invoice Date From';
        PDC_RECEIVEDCaptionLbl: label 'PDC RECEIVED';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Invoice_Date_FromCaptionLbl: label 'Invoice Date From';
        CHEQUE_NOCaptionLbl: label 'CHEQUE NO';
        INVOICE_NOCaptionLbl: label 'INVOICE NO';
        INVOICE_DATECaptionLbl: label 'INVOICE DATE';
        INVOICE_AMTCaptionLbl: label 'INVOICE AMT';
        PENDING_AMTCaptionLbl: label 'PENDING AMT';
        CHEQUE_AMTCaptionLbl: label 'CHEQUE AMT';
        PDC_REFERENCECaptionLbl: label 'PDC REFERENCE';
        DUE_DATECaptionLbl: label 'DUE DATE';


}
