Report 50002 "Receivable PDC"
{
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './Layouts/ReceivablePDC.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Customer; Customer)
        {
            CalcFields = Balance;
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Date Filter";

            column(UserId; UserId)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(Customer_Name; Customer.Name)
            {
            }
            column(Customer_Customer__No__; Customer."No.")
            {
            }
            column(PDC_Report_ReceivableCaption; PDC_Report_ReceivableCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Customer_Date_Filter; Customer."Date Filter")
            {
            }
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                CalcFields = "Remaining Amount", Amount, "PDC Unposted Amount";
                DataItemLink = "Customer No." = field("No."), "Posting Date" = field("Date Filter");
                DataItemTableView = sorting("Customer No.", "Posting Date") where(Open = const(true));
                column(DrText1; DrText1)
                {
                }
                column(Remaining_Amount__; ("Remaining Amount"))
                {
                }
                column(Cust__Ledger_Entry__Document_No__; "Cust. Ledger Entry"."Document No.")
                {
                }
                column(Cust__Ledger_Entry__Document_Type_; "Cust. Ledger Entry"."Document Type")
                {
                }
                column(Cust__Ledger_Entry__Posting_Date_; "Cust. Ledger Entry"."Posting Date")
                {
                }
                column(Cust__Ledger_Entry__Due_Date_; "Cust. Ledger Entry"."Due Date")
                {
                }
                column(Cust__Ledger_Entry__PDC_Unposted_Amount_; "Cust. Ledger Entry"."PDC Unposted Amount")
                {
                }
                column(BalanceFollow; BalanceFollow)
                {
                }
                column(ChkDate; ChkDate)
                {
                }
                column(Remaining_Amount___Control1000000013; ("Remaining Amount"))
                {
                }
                column(Cust__Ledger_Entry__PDC_Unposted_Amount__Control1000000014; "Cust. Ledger Entry"."PDC Unposted Amount")
                {
                }
                column(DrText1_Control1000000021; DrText1)
                {
                }
                column(BalanceFollow_Control1000000022; BalanceFollow)
                {
                }
                column(OutStanding_AmountCaption; OutStanding_AmountCaptionLbl)
                {
                }
                column(Document_No_Caption; Document_No_CaptionLbl)
                {
                }
                column(Document_TypeCaption; Document_TypeCaptionLbl)
                {
                }
                column(DateCaption; DateCaptionLbl)
                {
                }
                column(Cust__Ledger_Entry__Due_Date_Caption; FieldCaption("Due Date"))
                {
                }
                column(PDC_In_HandCaption_Control1000000008; PDC_In_HandCaption_Control1000000008Lbl)
                {
                }
                column(Balance_FollowupCaption; Balance_FollowupCaptionLbl)
                {
                }
                column(Cheque_DateCaption; Cheque_DateCaptionLbl)
                {
                }
                column(Cust__Ledger_Entry_Entry_No_; "Cust. Ledger Entry"."Entry No.")
                {
                }
                column(Cust__Ledger_Entry_Customer_No_; "Cust. Ledger Entry"."Customer No.")
                {
                }
                trigger OnPreDataItem();
                begin
                    /*
					
					 ChkDate:=0D;
					 */

                end;

                trigger OnAfterGetRecord();
                begin
                    /*
                  IF BalanceFollow <0 THEN
                   BalanceFollow:=0
                   ELSE BEGIN
                  IF "Cust. Ledger Entry"."Document Type"="Cust. Ledger Entry"."Document Type"::Invoice THEN
                  BalanceFollow:="Cust. Ledger Entry"."Remaining Amount"-"Cust. Ledger Entry"."PDC Unposted Amount";
                  END ;
                  PDCApplEntry1.RESET;
                  PDC.RESET;
                  PDCApplEntry1.SETRANGE(PDCApplEntry1."Cust Ledger Entry No.","Cust. Ledger Entry"."Entry No.");
                  IF PDCApplEntry1.FINDFIRST THEN BEGIN
                   REPEAT
                     PDC.SETRANGE(PDC."Entry No.",PDCApplEntry."PDC Entry No.");
                     IF PDC.FINDFIRST THEN
                        ChkDate:=PDC."PDC Cheque Date";
                      UNTIL PDCApplEntry1.NEXT=0;
                   END;
                     */

                end;

            }
            dataitem(PDC; PDC)
            {
                DataItemLink = "Account No." = field("No.");
                DataItemTableView = sorting("Entry No.") where("Account Type" = filter(Customer), "PDC Amount Applied" = filter(<> 0), "PDC Deposited" = filter(false));
                trigger OnAfterGetRecord();
                begin
                    /*
                     PDCApplEntry.SETRANGE(PDCApplEntry."PDC Entry No.",PDC."Entry No.");
                      IF PDCApplEntry.FINDFIRST THEN
                      BEGIN
                          docno:=PDCApplEntry."Document No.";
                          InvDate:=PDCApplEntry."Document Date";
                      END;
                     */

                end;

            }
            dataitem("<PDC1>"; PDC)
            {
                DataItemLink = "Account No." = field("No.");
                DataItemTableView = sorting("Entry No.") where("Account Type" = filter(Customer), "PDC Amount Applied" = filter(= 0), "PDC Deposited" = filter(false));
            }
            dataitem(Integer; Integer)
            {
                DataItemTableView = sorting(Number);
                MaxIteration = 1;
            }
            trigger OnPreDataItem();
            begin
                /*
				TotAmount:=0;
				
				"Cust. Ledger Entry".CALCFIELDS("Cust. Ledger Entry"."Remaining Amt. (LCY)") ;
				 */

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
        DrText1: Text[2];
        DrText: Text[2];
        InvDate: Date;
        docno: Code[20];
        "Pdc Table": Record PDC;
        PDCApplEntry: Record "PDC Application Entry";
        CustLedgEntry: Record "Cust. Ledger Entry";
        PDCApplEntry1: Record "PDC Application Entry";
        TotAmount: Decimal;
        BalanceFollow: Decimal;
        ChkDate: Date;
        ExcelBuf: Record "Excel Buffer";
        PrintToExcel: Boolean;
        RowID: Integer;
        UserSetup: Record "User Setup";
        PDC_Report_ReceivableCaptionLbl: label 'PDC Report Receivable';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        OutStanding_AmountCaptionLbl: label 'OutStanding Amount';
        Document_No_CaptionLbl: label 'Document No.';
        Document_TypeCaptionLbl: label 'Document Type';
        DateCaptionLbl: label 'Date';
        PDC_In_HandCaption_Control1000000008Lbl: label 'PDC In Hand';
        Balance_FollowupCaptionLbl: label 'Balance Followup';
        Cheque_DateCaptionLbl: label 'Cheque Date';

}