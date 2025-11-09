// Report 50021 "Vendor Ledger"
// {
//     Caption = 'Vendor Ledger';
//     UsageCategory = Lists;
//     RDLCLayout = './Layouts/VendorLedger.rdlc';
//     DefaultLayout = RDLC;

//     dataset
//     {
//         dataitem(Vendor; Vendor)
//         {
//             DataItemTableView = sorting("No.");
//             PrintOnlyIfDetail = true;
//             RequestFilterFields = "No.", "Search Name", "Vendor Posting Group", "Date Filter";
//             column(CompanyInfo_Name; CompanyInfo.Name)
//             {
//             }
//             column(VendFilter; VendFilter)
//             {
//             }
//             column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
//             {
//             }
//             column(STRSUBSTNO_Text000_VendDateFilter_; StrSubstNo(Text000, VendDateFilter))
//             {
//             }
//             column(COMPANYNAME; COMPANYNAME)
//             {
//             }
//             column(Vendor_Ledger_Entry__GETFILTER__Vendor_Ledger_Entry___TDS_Nature_of_Deduction__; "Vendor Ledger Entry".GetFilter("Vendor Ledger Entry"."TDS Nature of Deduction"))
//             {
//             }

//             column(UserId; UserId)
//             {
//             }
//             column(Vendor_TABLECAPTION__________VendFilter; Vendor.TableCaption + ': ' + VendFilter)
//             {
//             }
//             column(Vendor__No__; Vendor."No.")
//             {
//             }
//             column(Vendor_City; Vendor.City)
//             {
//             }
//             column(Vendor_Name; Vendor.Name)
//             {
//             }
//             column(ABS_StartBalanceLCY_; Abs(StartBalanceLCY))
//             {
//                 AutoFormatType = 1;
//             }
//             column(ABS_CrAmt_; Abs(CrAmt))
//             {
//             }
//             column(DrAmt; DrAmt)
//             {
//             }
//             column(Drtext; Drtext)
//             {
//             }
//             column(StartBalAdjLCY; StartBalAdjLCY)
//             {
//                 AutoFormatType = 1;
//             }
//             column(ABS_VendBalanceLCY_; Abs(VendBalanceLCY))
//             {
//                 AutoFormatType = 1;
//             }
//             column(Vendor___LedgerCaption; Vendor___LedgerCaptionLbl)
//             {
//             }
//             column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
//             {
//             }
//             column(All_amounts_are_in_LCYCaption; All_amounts_are_in_LCYCaptionLbl)
//             {
//             }
//             column(Report_Filter__Caption; Report_Filter__CaptionLbl)
//             {
//             }
//             column(Balance_LCY_Caption; Balance_LCY_CaptionLbl)
//             {
//             }
//             column(CreditCaption; CreditCaptionLbl)
//             {
//             }
//             column(DebitCaption; DebitCaptionLbl)
//             {
//             }
//             column(Cheq_DateCaption; Cheq_DateCaptionLbl)
//             {
//             }
//             column(Cheq_No_Caption; Cheq_No_CaptionLbl)
//             {
//             }
//             column(Branch_CodeCaption; Branch_CodeCaptionLbl)
//             {
//             }
//             column(Document_No_Caption; Document_No_CaptionLbl)
//             {
//             }
//             column(Document_TypeCaption; Document_TypeCaptionLbl)
//             {
//             }
//             column(DateCaption; DateCaptionLbl)
//             {
//             }
//             column(This_report_also_includes_vendors_that_only_have_balances_Caption; This_report_also_includes_vendors_that_only_have_balances_CaptionLbl)
//             {
//             }
//             column(Opening_Balance__Caption; Opening_Balance__CaptionLbl)
//             {
//             }
//             column(Adj__of_Opening_BalanceCaption; Adj__of_Opening_BalanceCaptionLbl)
//             {
//             }
//             column(Vendor_Date_Filter; Vendor."Date Filter")
//             {
//             }
//             column(Vendor_Global_Dimension_1_Filter; Vendor."Global Dimension 1 Filter")
//             {
//             }
//             column(Vendor_Global_Dimension_2_Filter; Vendor."Global Dimension 2 Filter")
//             {
//             }
//             column(VendDateFilter; VendDateFilter)
//             {
//             }
//             dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
//             {
//                 DataItemLink = "Vendor No." = field("No."), "Posting Date" = field("Date Filter"), "Global Dimension 1 Code" = field("Global Dimension 1 Filter"), "Global Dimension 2 Code" = field("Global Dimension 2 Filter"), "Date Filter" = field("Date Filter");
//                 DataItemTableView = sorting("Posting Date") order(ascending);
//                 RequestFilterFields = "Posting Date", "TDS Nature of Deduction", "TDS Group";

//                 column(ChequeNo1_VendorLedgerEntry; "Vendor Ledger Entry"."Cheque No")
//                 {
//                 }
//                 column(ChequeDate1_VendorLedgerEntry; "Vendor Ledger Entry"."Cheque Date")
//                 {
//                 }
//                 column(ABS_StartBalanceLCY___StartBalAdjLCY____Amount__LCY___; Abs(StartBalanceLCY + StartBalAdjLCY + "Amount (LCY)"))
//                 {
//                     AutoFormatType = 1;
//                 }
//                 column(Vendor_Ledger_Entry__Posting_Date_; "Vendor Ledger Entry"."Posting Date")
//                 {
//                 }
//                 column(EntryNo_VendorLedgerEntry; "Vendor Ledger Entry"."Entry No.")
//                 {
//                 }
//                 column(ABS_VendBalanceLCY__Control40; Abs(VendBalanceLCY))
//                 {
//                     AutoFormatType = 1;
//                 }
//                 column(Vendor_Ledger_Entry__Debit_Amount__LCY__; "Debit Amount (LCY)")
//                 {
//                 }
//                 column(ABS__Credit_Amount__LCY___; Abs("Credit Amount (LCY)"))
//                 {
//                 }
//                 column(Cheque_no; Cheque_no)
//                 {
//                 }
//                 column(Cheque_date; Cheque_date)
//                 {
//                 }
//                 column(Drtext_Control1102159011; Drtext)
//                 {
//                 }
//                 column(Vendor_Ledger_Entry__Vendor_Ledger_Entry___Document_Type_; "Vendor Ledger Entry"."Document Type")
//                 {
//                 }
//                 column(Vendor_Ledger_Entry__Document_No__; "Vendor Ledger Entry"."Document No.")
//                 {
//                 }
//                 column(Vendor_Ledger_Entry__Vendor_Ledger_Entry___Global_Dimension_2_Code_; "Vendor Ledger Entry"."Global Dimension 2 Code")
//                 {
//                 }
//                 column(GlobalDimension1Code_VendorLedgerEntry; "Vendor Ledger Entry"."Global Dimension 1 Code")
//                 {
//                 }
//                 column(StartBalanceLCY___StartBalAdjLCY____Amount__LCY__; StartBalanceLCY + StartBalAdjLCY + "Amount (LCY)")
//                 {
//                     AutoFormatType = 1;
//                 }
//                 column(ContinuedCaption; ContinuedCaptionLbl)
//                 {
//                 }
//                 column(ContinuedCaption_Control46; ContinuedCaption_Control46Lbl)
//                 {
//                 }
//                 column(Vendor_Ledger_Entry_Entry_No_; "Vendor Ledger Entry"."Entry No.")
//                 {
//                 }
//                 column(Vendor_Ledger_Entry_Vendor_No_; "Vendor Ledger Entry"."Vendor No.")
//                 {
//                 }
//                 column(Vendor_Ledger_Entry_Global_Dimension_1_Code; "Vendor Ledger Entry"."Global Dimension 1 Code")
//                 {
//                 }
//                 column(Vendor_Ledger_Entry_Date_Filter; "Vendor Ledger Entry"."Date Filter")
//                 {
//                 }
//                 column(Vendor_Ledger_Entry_Transaction_No_; "Vendor Ledger Entry"."Transaction No.")
//                 {
//                 }
//                 column(Credit_Amount_VLE; CreditAmt)
//                 {
//                 }
//                 column(Dedit_Amount_VLE; DebitAmt)
//                 {
//                 }
//                 column(DocumentDate_VendorLedgerEntry; Format("Vendor Ledger Entry"."Document Date"))
//                 {
//                 }
//                 column(ExternalDocumentNo_VendorLedgerEntry; "Vendor Ledger Entry"."External Document No.")
//                 {
//                 }
//                 column(ChequeDocDate; Format(ChequeDocDate))
//                 {
//                 }
//                 column(ChequeDocNo; ChequeDocNo)
//                 {
//                 }
//                 column(DrCrText; DrCrText)
//                 {
//                 }
//                 column(Narration; Narration)
//                 {
//                 }
//                 column(BalAccountNo_VendorLedgerEntry; "Vendor Ledger Entry"."Bal. Account No.")
//                 {
//                 }
//                 column(BankAccList_Name; BankAccList_Name)
//                 {
//                 }
//                 trigger OnPreDataItem();
//                 begin
//                     VendLedgEntryExists := false;



//                     /*
// 					//CREATETOTALS(TDSAmt);
// 					//CREATETOTALS(TDSBase);
// 					//CREATETOTALS(BillAmt);
// 					*/

//                 end;

//                 trigger OnAfterGetRecord();
//                 begin
//                     //MESSAGE("Vendor Ledger Entry"."Global Dimension 1 Code");
//                     CalcFields(Amount, "Remaining Amount", "Amount (LCY)", "Remaining Amt. (LCY)");
//                     VendLedgEntryExists := true;
//                     PrintAmountsInLCY := true;
//                     if PrintAmountsInLCY then begin
//                         VendAmount := "Amount (LCY)";
//                         VendRemainAmount := "Remaining Amt. (LCY)";
//                         VendCurrencyCode := '';
//                         if VendAmount >= 0 then
//                             DebitAmt := VendAmount
//                         else
//                             CreditAmt := VendAmount - "Vendor Ledger Entry"."Total TDS Including SHE CESS";  //ANKIT
//                                                                                                              //ANKIT
//                         if "Vendor Ledger Entry"."Total TDS Including SHE CESS" > 0 then
//                             DebitAmt := "Vendor Ledger Entry"."Total TDS Including SHE CESS"
//                         /// ELSE
//                         //ANKIT
//                         // MESSAGE(FORMAT(VendAmount));
//                     end else begin
//                         VendAmount := Amount;
//                         VendRemainAmount := "Remaining Amount";
//                         VendCurrencyCode := "Currency Code";
//                         if VendAmount >= 0 then
//                             DebitAmt := VendAmount
//                         else
//                             CreditAmt := VendAmount - "Vendor Ledger Entry"."Total TDS Including SHE CESS";  //ANKIT
//                                                                                                              //ANKIT
//                         if "Vendor Ledger Entry"."Total TDS Including SHE CESS" > 0 then
//                             DebitAmt := "Vendor Ledger Entry"."Total TDS Including SHE CESS"
//                         //	 ELSE
//                         //ANKIT
//                     end;
//                     DebitTotal := DebitTotal + DebitAmt;
//                     CreditTotal := CreditTotal + CreditAmt;
//                     //END ELSE BEGIN
//                     VendBalanceLCY := VendBalanceLCY + "Amount (LCY)";
//                     //MESSAGE(FORMAT(VendBalanceLCY));
//                     if VendBalanceLCY > 0 then
//                         DrCrText := 'Dr'
//                     else
//                         DrCrText := 'Cr';
//                     //  VendAmount := Amount;
//                     //  VendRemainAmount := "Remaining Amount";
//                     //  VendCurrencyCode := "Currency Code";
//                     //  DebitTotal := DebitTotal + DebitAmt;
//                     //  CreditTotal := CreditTotal + CreditAmt;
//                     //END;
//                     //VendBalanceLCY := VendBalanceLCY + "Amount (LCY)";
//                     ////ANKIT
//                     if "Document Type" = "document type"::Payment then begin
//                         ChequeDocNo := "Vendor Ledger Entry"."Cheque No";
//                         ChequeDocDate := "Vendor Ledger Entry"."Cheque Date";
//                     end else
//                         if "Document Type" = "document type"::Invoice then begin
//                             ChequeDocNo := "Vendor Ledger Entry"."External Document No.";
//                             ChequeDocDate := "Vendor Ledger Entry"."Document Date";
//                         end;
//                     ///ANKIT
//                     if ("Document Type" = "document type"::Payment) or ("Document Type" = "document type"::Refund) then
//                         VendEntryDueDate := 0D
//                     else
//                         VendEntryDueDate := "Due Date";
//                     Narration := '';
//                     PostedNarration.Reset;
//                     PostedNarration.SetRange(PostedNarration."Document No.", "Vendor Ledger Entry"."Document No.");
//                     PostedNarration.SetRange(PostedNarration."Entry No.", "Vendor Ledger Entry"."Entry No.");
//                     if PostedNarration.FindFirst then
//                         repeat
//                             Narration += PostedNarration.Narration;
//                         //   MESSAGE(Narration) ;
//                         until PostedNarration.Next = 0;
//                     Clear(BankAccList_Name);
//                     if BankAccList.Get("Vendor Ledger Entry"."Bal. Account No.") then begin
//                         BankAccList_Name := BankAccList.Name;
//                     end;
//                     if "G/LAccList".Get("Vendor Ledger Entry"."Bal. Account No.") then begin
//                         BankAccList_Name := "G/LAccList".Name;
//                     end;
//                 end;

//             }
//             dataitem(Integer; Integer)
//             {
//                 DataItemTableView = sorting(Number) where(Number = const(1));
//                 column(Vendor_Name_Control27; Vendor.Name)
//                 {
//                 }
//                 column(ABS_VendBalanceLCY__Control62; Abs(VendBalanceLCY))
//                 {
//                     AutoFormatType = 1;
//                 }
//                 column(DebitTotal; DebitTotal)
//                 {
//                     AutoFormatType = 1;
//                 }
//                 column(ABS_CreditTotal_; Abs(CreditTotal))
//                 {
//                     AutoFormatType = 1;
//                 }
//                 column(Drtext_Control1102159009; Drtext)
//                 {
//                 }
//                 column(Vendor_Name_Control48; Vendor.Name)
//                 {
//                 }
//                 column(VendBalanceLCY__StartBalanceLCY_StartBalAdjLCY; VendBalanceLCY - StartBalanceLCY - StartBalAdjLCY)
//                 {
//                     AutoFormatType = 1;
//                 }
//                 column(ABS_VendBalanceLCY__Control61; Abs(VendBalanceLCY))
//                 {
//                     AutoFormatType = 1;
//                 }
//                 column(DebitTotal_Control10012007; DebitTotal)
//                 {
//                     AutoFormatType = 1;
//                 }
//                 column(ABS_CreditTotal__Control10012012; Abs(CreditTotal))
//                 {
//                     AutoFormatType = 1;
//                 }
//                 column(Drtext_Control1102159010; Drtext)
//                 {
//                 }
//                 column(Total_Amount__Caption; Total_Amount__CaptionLbl)
//                 {
//                 }
//                 column(Total_Amount__Caption_Control1102159013; Total_Amount__Caption_Control1102159013Lbl)
//                 {
//                 }
//                 column(Integer_Number; Integer.Number)
//                 {
//                 }
//                 column(ABS_StartBalanceLCY_2; Abs(StartBalanceLCY))
//                 {
//                 }
//                 trigger OnAfterGetRecord();
//                 begin
//                     if not VendLedgEntryExists and ((StartBalanceLCY = 0) or ExcludeBalanceOnly) then begin
//                         StartBalanceLCY := 0;
//                         CurrReport.Skip;
//                     end;
//                 end;

//             }

//             trigger OnAfterGetRecord();
//             begin
//                 StartBalanceLCY := 0;
//                 StartBalAdjLCY := 0;
//                 if VendDateFilter <> '' then begin
//                     if GetRangeMin("Date Filter") <> 0D then begin
//                         SetRange("Date Filter", 0D, GetRangeMin("Date Filter") - 1);
//                         CalcFields("Net Change (LCY)");
//                         StartBalanceLCY := -"Net Change (LCY)";
//                     end;
//                     SetFilter("Date Filter", VendDateFilter);
//                     CalcFields("Net Change (LCY)");
//                     StartBalAdjLCY := -"Net Change (LCY)";
//                     VendorLedgerEntry.SetCurrentkey("Vendor No.", "Posting Date");
//                     VendorLedgerEntry.SetRange("Vendor No.", Vendor."No.");
//                     VendorLedgerEntry.SetFilter("Posting Date", VendDateFilter);
//                     if VendorLedgerEntry.Find('-') then
//                         repeat
//                             VendorLedgerEntry.SetFilter("Date Filter", VendDateFilter);
//                             VendorLedgerEntry.CalcFields("Amount (LCY)");
//                             StartBalAdjLCY := StartBalAdjLCY - VendorLedgerEntry."Amount (LCY)";
//                         //"Detailed Vendor Ledg. Entry".SETCURRENTKEY("Vendor Ledger Entry No.","Entry Type","Posting Date");
//                         // "Detailed Vendor Ledg. Entry".SETRANGE("Vendor Ledger Entry No.",VendorLedgerEntry."Entry No.");
//                         // "Detailed Vendor Ledg. Entry".SETFILTER("Entry Type",'%1|%2',
//                         //   "Detailed Vendor Ledg. Entry"."Entry Type"::"Correction of Remaining Amount",
//                         //   "Detailed Vendor Ledg. Entry"."Entry Type"::"Appln. Rounding");
//                         // "Detailed Vendor Ledg. Entry".SETFILTER("Posting Date",VendDateFilter);
//                         // IF "Detailed Vendor Ledg. Entry".FIND('-') THEN
//                         //   REPEAT
//                         //	StartBalAdjLCY := StartBalAdjLCY - "Detailed Vendor Ledg. Entry"."Amount (LCY)";
//                         //   UNTIL "Detailed Vendor Ledg. Entry".NEXT = 0;
//                         ///	"Detailed Vendor Ledg. Entry".RESET;
//                         until VendorLedgerEntry.Next = 0;
//                 end;
//                 CompanyInfo.Get;
//                 VendBalanceLCY := StartBalanceLCY + StartBalAdjLCY;
//                 //MESSAGE(FORMAT(VendBalanceLCY));
//             end;

//         }
//         dataitem(ReportEnd; Integer)
//         {
//             DataItemTableView = sorting(Number);
//             MaxIteration = 1;
//             column(ReportForNavId_7124; 7124) { } // Autogenerated by ForNav - Do not delete
//             column(End_Of_The_ReportCaption; End_Of_The_ReportCaptionLbl)
//             {
//             }
//             column(ReportEnd_Number; ReportEnd.Number)
//             {
//             }
//         }
//     }

//     requestpage
//     {


//         SaveValues = false;
//         layout
//         {
//             area(content)
//             {
//                 field(LineNarration; LineNarration)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Line Narration';
//                     Visible = false;
//                 }
//                 field(VoucherNarration; VoucherNarration)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Voucher Narration';
//                     Visible = false;
//                 }

//             }
//         }

//         actions
//         {
//         }
//     }



//     trigger OnPreReport()
//     begin
//         VendFilter := Vendor.GetFilters;
//         VendDateFilter := Vendor.GetFilter("Date Filter");
//         if VendFilter = '' then
//             VendFilter := 'All Filter';
//         if PrintAmountsInLCY then begin
//             AmountCaption := "Vendor Ledger Entry".FieldCaption("Amount (LCY)");
//             RemainingAmtCaption := "Vendor Ledger Entry".FieldCaption("Remaining Amt. (LCY)");
//         end else begin
//             AmountCaption := "Vendor Ledger Entry".FieldCaption(Amount);
//             RemainingAmtCaption := "Vendor Ledger Entry".FieldCaption("Remaining Amount");
//         end;
//         ;
//     end;

//     var
//         Text000: label 'Period: %1';
//         VendorLedgerEntry: Record "Vendor Ledger Entry";
//         VendFilter: Text[250];
//         VendDateFilter: Text[30];
//         VendAmount: Decimal;
//         VendRemainAmount: Decimal;
//         VendBalanceLCY: Decimal;
//         VendEntryDueDate: Date;
//         StartBalanceLCY: Decimal;
//         StartBalAdjLCY: Decimal;
//         Correction: Decimal;
//         ApplicationRounding: Decimal;
//         ExcludeBalanceOnly: Boolean;
//         PrintAmountsInLCY: Boolean;
//         PrintOnlyOnePerPage: Boolean;
//         VendLedgEntryExists: Boolean;
//         AmountCaption: Text[30];
//         RemainingAmtCaption: Text[30];
//         VendCurrencyCode: Code[10];
//         DebitTotal: Decimal;
//         CreditTotal: Decimal;
//         TDSEntry: Record "TDS Entry";
//         BillAmt: Decimal;
//         TDSRate: Decimal;
//         TDSAmt: Decimal;
//         TDSBase: Decimal;
//         Cheque_no: Code[20];
//         Cheque_date: Date;
//         Bank_ledg: Record "Bank Account Ledger Entry";
//         Dt1: Variant;
//         ACC: Record "G/L Account";
//         LineNarration: Boolean;
//         VoucherNarration: Boolean;
//         DocNo: Code[10];
//         TransNo: Integer;
//         "G/L Entry": Record "G/L Entry";
//         GLEntry: Record "G/L Entry";
//         DebitAmt: Decimal;
//         CreditAmt: Decimal;
//         Text001: label 'Appln Rounding:';
//         Drtext: Text[30];
//         CrAmt: Decimal;
//         DrAmt: Decimal;
//         Vendor___LedgerCaptionLbl: label 'Vendor - Ledger';
//         CurrReport_PAGENOCaptionLbl: label 'Page';
//         All_amounts_are_in_LCYCaptionLbl: label 'All amounts are in LCY';
//         Report_Filter__CaptionLbl: label 'Report Filter :';
//         Balance_LCY_CaptionLbl: label 'Balance(LCY)';
//         CreditCaptionLbl: label 'Credit';
//         DebitCaptionLbl: label 'Debit';
//         Cheq_DateCaptionLbl: label 'Cheq Date';
//         Cheq_No_CaptionLbl: label 'Cheq No.';
//         Branch_CodeCaptionLbl: label 'Branch Code';
//         Document_No_CaptionLbl: label 'Document No.';
//         Document_TypeCaptionLbl: label 'Document Type';
//         DateCaptionLbl: label 'Date';
//         This_report_also_includes_vendors_that_only_have_balances_CaptionLbl: label 'This report also includes vendors that only have balances.';
//         Opening_Balance__CaptionLbl: label 'Opening Balance :';
//         Adj__of_Opening_BalanceCaptionLbl: label 'Adj. of Opening Balance';
//         ContinuedCaptionLbl: label 'Continued';
//         ContinuedCaption_Control46Lbl: label 'Continued';
//         Total_Amount__CaptionLbl: label 'Total Amount :';
//         Total_Amount__Caption_Control1102159013Lbl: label 'Total Amount :';
//         End_Of_The_ReportCaptionLbl: label 'End Of The Report';
//         CompanyInfo: Record "Company Information";
//         ChequeDocNo: Code[20];
//         ChequeDocDate: Date;
//         DrCrText: Text;
//         Narration: Text;
//         PostedNarration: Record "Posted Narration";
//         BankAccList: Record "Bank Account";
//         "G/LAccList": Record "G/L Account";
//         BankAccList_Name: Text;


// }
