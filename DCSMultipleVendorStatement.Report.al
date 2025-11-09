Report 50061 "DCS Multiple Vendor Statement"
{
    Caption = 'Vendor Statement';
    UseSystemPrinter = false;
    RDLCLayout = './Layouts/DCSMultipleVendorStatement.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            DataItemTableView = sorting("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Date Filter", "Vendor Posting Group";
            column(PrintOnePrPage_; PrintOnePrPage)
            {
            }
            column(No_Vendor; Vendor."No.")
            {
            }
            column(Name_Vendor; Vendor.Name)
            {
            }
            column(company_information_gRec_Name; CompanyAddr[1])
            {
            }
            column(company_information_gRec_Address; CompanyAddr[2])
            {
            }
            column(company_information_gRec_Post; CompanyAddr[4])
            {
            }
            column(company_information_gRec_City; CompanyAddr[5])
            {
            }
            column(company_information_gRec_Country; CompanyAddr[6])
            {
            }
            column(company_information_gRec_State; CompanyAddr[7])
            {
            }
            column(Address_Vendor; Vendor.Address)
            {
            }
            column(company_information_gRec_Address2; CompanyAddr[3])
            {
            }
            column(Picture_Company; Picture_grec.Picture)
            {
            }
            column(Address2_Vendor; Vendor."Address 2")
            {
            }
            column(City_Vendor; Vendor.City)
            {
            }
            column(EndDate; Format(EndDate, 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(StartDate; Format(StartDate, 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(TotalDebitAmount_gDec_; TotalDebitAmount_gDec)
            {
            }
            column(TotalCreditAmount_gDec_; TotalCreditAmount_gDec)
            {
            }
            column(TotalBalanceAmount_gDec_; Abs(TotalBalanceAmount_gDec))
            {
            }
            column(TotalBalanceDrCrText_gText_; TotalBalanceDrCrText_gText)
            {
            }
            column(TDSAmountTotal_gDec_; TDSAmountTotal_gDec)
            {
            }
            column(DebituptoStartDate_gDec_; DebituptoStartDate_gDec)
            {
            }
            column(CredituptoStartDate_gDec_; CredituptoStartDate_gDec)
            {
            }
            column(DebituptoEndDate_gDec_; DebituptoEndDate_gDec)
            {
            }
            column(CredituptoEndDate_gDec_; CredituptoEndDate_gDec)
            {
            }
            dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
            {
                DataItemLink = "Vendor No." = field("No.");
                DataItemTableView = sorting("Vendor No.", "Posting Date", "Currency Code") where(Reversed = filter(false));
                column(ABSCustomerBalance_gDec; Abs(ABSCustomerBalance_gDec))
                {
                }
                column(OpeningBalDebit_gDec; Abs(OpeningBalDebit_gDec))
                {
                }
                column(OpeningBalCredit_gDec; Abs(OpeningBalCredit_gDec))
                {
                }
                column(BalanceDrCrText_gText_; BalanceDrCrText_gText)
                {
                }
                column(TDSAmount_gDec; TDSAmount_gDec)
                {
                }
                column(EntryNo_VendorLedgerEntry; "Vendor Ledger Entry"."Entry No.")
                {
                }
                column(PostingDate_VendorLedgerEntry; Format("Vendor Ledger Entry"."Posting Date", 0, '<Day,2>/<Month,2>/<Year4>'))
                {
                }
                column(DocumentType_VendorLedgerEntry; "Vendor Ledger Entry"."Document Type")
                {
                }
                column(DocumentNo_VendorLedgerEntry; "Vendor Ledger Entry"."Document No.")
                {
                }
                column(ExternalDocumentNo_VendorLedgerEntry; "Vendor Ledger Entry"."External Document No.")
                {
                }
                column(DebitAmount_VendorLedgerEntry; "Vendor Ledger Entry"."Debit Amount (LCY)")
                {
                }
                column(CreditAmount_VendorLedgerEntry; "Vendor Ledger Entry"."Credit Amount (LCY)")
                {
                }
                column(Doc_Date; Format("Vendor Ledger Entry"."Document Date", 0, '<Day,2>/<Month,2>/<Year4>'))
                {
                }
                column(Amount_gDec; Amount_gDec)
                {
                }
                column(TotalDebitAmount_gDec_2; TotalDebitAmount_gDec)
                {
                }
                column(TotalCreditAmount_gDec_2; TotalCreditAmount_gDec)
                {
                }
                column(TotalBalanceAmount_gDec_2; Abs(TotalBalanceAmount_gDec))
                {
                }
                column(TDSAmountTotal_gDec_2; TDSAmountTotal_gDec)
                {
                }
                column(DebituptoStartDate_gDec_2; DebituptoStartDate_gDec)
                {
                }
                column(CredituptoStartDate_gDec_2; CredituptoStartDate_gDec)
                {
                }
                column(DebituptoEndDate_gDec_2; DebituptoEndDate_gDec)
                {
                }
                column(CredituptoEndDate_gDec_2; CredituptoEndDate_gDec)
                {
                }
                dataitem("G/L Entry"; "G/L Entry")
                {
                    DataItemLink = "Document No." = field("Document No."), "Transaction No." = field("Transaction No.");
                    DataItemTableView = sorting("Entry No.") order(descending);
                    column(GLAccountNo_GLEntry; "G/L Entry"."G/L Account No.")
                    {
                    }
                    column(DocumentNo_GLEntry; "G/L Entry"."Document No.")
                    {
                    }
                    column(Amount_GLEntry; "G/L Entry".Amount)
                    {
                    }
                    column(GLAccountName_; GLAccount_gRec.Name)
                    {
                    }
                    trigger OnPreDataItem();
                    begin
                        if not PrintGLDetails_gBool then
                            CurrReport.Break;
                    end;

                    trigger OnAfterGetRecord();
                    begin
                        // To Get Account Name
                        if GLAccount_gRec.Get("G/L Entry"."G/L Account No.") then;
                    end;


                }
                dataitem("Posted Narration"; "Posted Narration")
                {
                    DataItemLink = "Document No." = field("Document No."), "Transaction No." = field("Transaction No.");
                    DataItemTableView = sorting("Document No.") where("Entry No." = filter(0));
                    column(Posted_Narration__Posted_Narration__Narration; "Posted Narration".Narration)
                    {
                    }
                    column(Posted_Narration_Entry_No_; "Posted Narration"."Entry No.")
                    {
                    }
                    trigger OnPreDataItem();
                    begin
                        if not PrintNarration_gBool then
                            CurrReport.Break;
                    end;

                }
                dataitem("Posted Narration1"; "Posted Narration")
                {
                    DataItemLink = "Entry No." = field("Entry No.");
                    DataItemTableView = sorting("Entry No.", "Transaction No.", "Line No.");
                    column(Posted_Narration1_Narration; "Posted Narration1".Narration)
                    {
                    }
                    column(Posted_Narration1_Transaction_No_; "Posted Narration1"."Transaction No.")
                    {
                    }
                    trigger OnPreDataItem();
                    begin
                        if not PrintNarration_gBool then
                            CurrReport.Break;
                    end;

                }
                dataitem("Purch. Comment Line"; "Purch. Comment Line")
                {
                    DataItemLink = "No." = field("Document No.");
                    DataItemTableView = where("Document Type" = filter("Posted Invoice" | "Posted Credit Memo"));
                    column(No_PurchCommentLine; "Purch. Comment Line"."No.")
                    {
                    }
                    column(LineNo_PurchCommentLine; "Purch. Comment Line"."Line No.")
                    {
                    }
                    column(Comment_PurchCommentLine; "Purch. Comment Line".Comment)
                    {
                    }
                    trigger OnPreDataItem();
                    begin
                        //As-230514
                        if not PrintNarration_gBool then
                            CurrReport.Break;
                    end;

                }
                trigger OnPreDataItem();
                begin
                    "Vendor Ledger Entry".SetRange("Vendor Ledger Entry"."Posting Date", StartDate, EndDate);
                    AppliedBalance_gBool := false;
                    /*IF shortcutDim1_gFilter <> '' THEN
					  SETRANGE("Vendor Ledger Entry"."Global Dimension 1 Code",shortcutDim1_gFilter);*/

                end;

                trigger OnAfterGetRecord();
                var
                    PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
                    PurchInvHeader: Record "Purch. Inv. Header";
                    TDSEntry: Record "TDS Entry";
                    TotalAdd: Boolean;
                begin
                    /*PurchInvHeader.RESET;
					PurchInvHeader.SETRANGE("No.","Vendor Ledger Entry"."Document No.");
					IF PurchInvHeader.FINDFIRST THEN BEGIN
					   PurchInvHeader.CALCFIELDS("Amount to Vendor");
					   IF (PurchInvHeader."Applies-to Doc. No." = '') THEN BEGIN
						 PurchCrMemoHdr.RESET;
						 PurchCrMemoHdr.SETRANGE("Applies-to Doc. No.",PurchInvHeader."No.");
						 PurchCrMemoHdr.SETRANGE("Material Debit Note",FALSE);
						 IF PurchCrMemoHdr.FINDFIRST THEN BEGIN
						   PurchCrMemoHdr.CALCFIELDS("Amount to Vendor");
						   IF ABS(PurchInvHeader."Amount to Vendor")=ABS(PurchCrMemoHdr."Amount to Vendor") THEN
							CurrReport.SKIP;
						 END;
						END ELSE BEGIN
						   IF PurchInvHeader."Applies-to Doc. Type" = PurchInvHeader."Applies-to Doc. Type"::"Credit Memo" THEN BEGIN
							  PurchCrMemoHdr.RESET;
							  PurchCrMemoHdr.SETRANGE("No.",PurchInvHeader."Applies-to Doc. No.");
							  IF PurchCrMemoHdr.FINDFIRST THEN BEGIN
								 PurchCrMemoHdr.CALCFIELDS("Amount to Vendor");
								  IF ABS(PurchInvHeader."Amount to Vendor")=ABS(PurchCrMemoHdr."Amount to Vendor") THEN
									CurrReport.SKIP;
							  END;
						   END;
						END;
					END;
					PurchCrMemoHdr.RESET;
					PurchCrMemoHdr.SETRANGE("No.","Vendor Ledger Entry"."Document No.");
					IF PurchCrMemoHdr.FINDFIRST THEN BEGIN
					   PurchCrMemoHdr.CALCFIELDS("Amount to Vendor");
					   IF (PurchCrMemoHdr."Applies-to Doc. No." = '') THEN BEGIN
						 PurchInvHeader.RESET;
						 PurchInvHeader.SETRANGE("Applies-to Doc. No.",PurchCrMemoHdr."No.");
						 IF PurchInvHeader.FINDFIRST THEN BEGIN
							PurchInvHeader.CALCFIELDS("Amount to Vendor");
							  IF ABS(PurchInvHeader."Amount to Vendor")=ABS(PurchCrMemoHdr."Amount to Vendor") THEN
								 CurrReport.SKIP;
						 END;
						END ELSE BEGIN
						   IF (PurchCrMemoHdr."Applies-to Doc. Type" = PurchCrMemoHdr."Applies-to Doc. Type"::Invoice) AND (PurchCrMemoHdr."Material Debit Note" = FALSE) THEN BEGIN
							  PurchInvHeader.RESET;
							  PurchInvHeader.SETRANGE("No.",PurchCrMemoHdr."Applies-to Doc. No.");
							 IF PurchInvHeader.FINDFIRST THEN BEGIN
								PurchInvHeader.CALCFIELDS("Amount to Vendor");
								IF ABS(PurchInvHeader."Amount to Vendor")=ABS(PurchCrMemoHdr."Amount to Vendor") THEN
								 CurrReport.SKIP;
							END;
						   END ELSE BEGIN
							 PurchInvHeader.RESET;
							 PurchInvHeader.SETRANGE("Applies-to Doc. No.",PurchCrMemoHdr."No.");
							 IF PurchInvHeader.FINDFIRST THEN BEGIN
								PurchInvHeader.CALCFIELDS("Amount to Vendor");
								IF ABS(PurchInvHeader."Amount to Vendor")=ABS(PurchCrMemoHdr."Amount to Vendor") THEN
								 CurrReport.SKIP;
							END;
						   END;
						END;
					END;
					*/
                    /*TDSEntry.RESET;
					TDSEntry.SETRANGE("Document No.","Vendor Ledger Entry"."Document No.");
					TDSEntry.SETRANGE("Document Type",TDSEntry."Document Type"::" ");
					TDSEntry.SETRANGE("Source Code",'');
					IF TDSEntry.FINDFIRST THEN
					  CurrReport.SKIP;*/
                    Clear(Amount_gDec);
                    GLEntry.Reset;
                    GLEntry.SetRange("Document No.", "Vendor Ledger Entry"."Document No.");
                    GLEntry.SetRange("Transaction No.", "Vendor Ledger Entry"."Transaction No.");
                    if GLEntry.FindFirst then begin
                        repeat
                            Amount_gDec += GLEntry."Credit Amount";
                        until GLEntry.Next = 0;
                    end;
                    // To Calculate Opening balance
                    OpeningBal_gDec := 0;
                    OpeningBalDebit_gDec := 0;
                    OpeningBalCredit_gDec := 0;
                    VendorDetLedEntry_gRec.Reset;
                    VendorDetLedEntry_gRec.SetRange("Vendor No.", "Vendor Ledger Entry"."Vendor No.");
                    VendorDetLedEntry_gRec.SetFilter("Entry Type", '<>Application');
                    VendorDetLedEntry_gRec.SetFilter("Posting Date", '<=%1', OpeningBal_gDate);
                    if VendorDetLedEntry_gRec.FindSet then
                        repeat
                            OpeningBal_gDec := OpeningBal_gDec + (VendorDetLedEntry_gRec."Debit Amount (LCY)" - VendorDetLedEntry_gRec."Credit Amount (LCY)");
                        until VendorDetLedEntry_gRec.Next = 0;
                    if OpeningBal_gDec > 0 then begin
                        OpeningBalDebit_gDec := OpeningBal_gDec;
                    end else begin
                        OpeningBalCredit_gDec := OpeningBal_gDec;
                    end;
                    // To Maintain Balance Amount
                    if AppliedBalance_gBool = false then begin
                        AppliedBalance_gBool := true;
                        CustomerBalance_gDec := OpeningBal_gDec;
                    end;
                    CustomerBalance_gDec += "Vendor Ledger Entry"."Debit Amount (LCY)" - "Vendor Ledger Entry"."Credit Amount (LCY)";
                    ABSCustomerBalance_gDec := CustomerBalance_gDec;
                    if CustomerBalance_gDec <> 0 then begin
                        if CustomerBalance_gDec > 0 then begin
                            BalanceDrCrText_gText := ' Dr.';
                        end else begin
                            BalanceDrCrText_gText := ' Cr.';
                        end;
                    end else begin
                        BalanceDrCrText_gText := '';
                    end;
                    // To calculate TDS Amount
                    TDSAmount_gDec := 0;
                    TDSEntry_gRec.Reset;
                    //TDSEntry_gRec.SETRANGE(TDSEntry_gRec."Document Type","Vendor Ledger Entry"."Document Type");
                    TDSEntry_gRec.SetRange(TDSEntry_gRec."Document No.", "Vendor Ledger Entry"."Document No.");
                    TDSEntry_gRec.SetRange(TDSEntry_gRec."G/L Account No.", '5939', '5950');
                    if TDSEntry_gRec.FindSet then begin
                        repeat
                            TDSAmount_gDec += TDSEntry_gRec.Amount;
                        until TDSEntry_gRec.Next = 0;
                    end;
                    TDSAmountTotal_gDec += TDSAmount_gDec;
                    // To calculate total TDS amount vendor wise
                    /*
					TDSEntry_gRec.RESET;
					TDSEntry_gRec.SETRANGE(TDSEntry_gRec."Source No.",Vendor."No.");
					TDSEntry_gRec.SETRANGE(TDSEntry_gRec."Posting Date",StartDate,EndDate);
					TDSEntry_gRec.SETRANGE(TDSEntry_gRec."G/L Account No.",'5939','5950');
					IF TDSEntry_gRec.FINDSET THEN BEGIN
					  REPEAT
						TDSAmountTotal_gDec += TDSEntry_gRec.Amount;
					  UNTIL TDSEntry_gRec.NEXT=0;
					END;
					*/
                    //MESSAGE(FORMAT(TDSAmountTotal_gDec));
                    // To Calculate Total Debit / Credit Amount
                    TotalDebitAmount_gDec := 0;
                    TotalCreditAmount_gDec := 0;
                    TotalBalanceAmount_gDec := 0;
                    VendorDetLedEntry_gRec.Reset;
                    VendorDetLedEntry_gRec.SetRange("Vendor No.", "Vendor Ledger Entry"."Vendor No.");
                    VendorDetLedEntry_gRec.SetFilter("Entry Type", '<>Application');
                    VendorDetLedEntry_gRec.SetRange("Posting Date", StartDate, EndDate);
                    if VendorDetLedEntry_gRec.FindSet then
                        repeat
                            TotalAdd := true;
                            /* PurchInvHeader.RESET;
                             PurchInvHeader.SETRANGE("No.",VendorDetLedEntry_gRec."Document No.");
                             IF PurchInvHeader.FINDFIRST THEN BEGIN
                               PurchInvHeader.CALCFIELDS("Amount to Vendor");
                                IF (PurchInvHeader."Applies-to Doc. No." = '') THEN BEGIN
                                  PurchCrMemoHdr.RESET;
                                  PurchCrMemoHdr.SETRANGE("Applies-to Doc. No.",PurchInvHeader."No.");
                                  PurchCrMemoHdr.SETRANGE("Material Debit Note",FALSE);
                                  IF PurchCrMemoHdr.FINDFIRST THEN BEGIN
                                       PurchCrMemoHdr.CALCFIELDS("Amount to Vendor");
                                       IF ABS(PurchInvHeader."Amount to Vendor")=ABS(PurchCrMemoHdr."Amount to Vendor") THEN
                                         TotalAdd := FALSE;
                                  END;
                                 END ELSE BEGIN
                                    IF PurchInvHeader."Applies-to Doc. Type" = PurchInvHeader."Applies-to Doc. Type"::"Credit Memo" THEN BEGIN
                                       PurchCrMemoHdr.RESET;
                                       PurchCrMemoHdr.SETRANGE("No.",PurchInvHeader."Applies-to Doc. No.");
                                       IF PurchCrMemoHdr.FINDFIRST THEN BEGIN
                                         PurchCrMemoHdr.CALCFIELDS("Amount to Vendor");
                                         IF ABS(PurchInvHeader."Amount to Vendor")=ABS(PurchCrMemoHdr."Amount to Vendor") THEN
                                           TotalAdd := FALSE;
                                       End;
                                    END;
                                 END;
                             END;
                             PurchCrMemoHdr.RESET;
                             PurchCrMemoHdr.SETRANGE("No.",VendorDetLedEntry_gRec."Document No.");
                             IF PurchCrMemoHdr.FINDFIRST THEN BEGIN
                                 PurchCrMemoHdr.CALCFIELDS("Amount to Vendor");
                                IF (PurchCrMemoHdr."Applies-to Doc. No." = '') THEN BEGIN
                                  PurchInvHeader.RESET;
                                  PurchInvHeader.SETRANGE("Applies-to Doc. No.",PurchCrMemoHdr."No.");
                                  IF PurchInvHeader.FINDFIRST THEN BEGIN
                                      PurchInvHeader.CALCFIELDS("Amount to Vendor");
                                         IF ABS(PurchInvHeader."Amount to Vendor")=ABS(PurchCrMemoHdr."Amount to Vendor") THEN
                                           TotalAdd := FALSE;
                                   END;
                                 END ELSE BEGIN
                                    IF (PurchCrMemoHdr."Applies-to Doc. Type" = PurchCrMemoHdr."Applies-to Doc. Type"::Invoice) AND (PurchCrMemoHdr."Material Debit Note" = FALSE) THEN BEGIN
                                       PurchInvHeader.RESET;
                                       PurchInvHeader.SETRANGE("No.",PurchCrMemoHdr."Applies-to Doc. No.");
                                       IF PurchInvHeader.FINDFIRST THEN BEGIN
                                          PurchInvHeader.CALCFIELDS("Amount to Vendor");
                                         IF ABS(PurchInvHeader."Amount to Vendor")=ABS(PurchCrMemoHdr."Amount to Vendor") THEN
                                           TotalAdd := FALSE;
                                        End;
                                    END ELSE BEGIN
                                       PurchInvHeader.RESET;
                                       PurchInvHeader.SETRANGE("Applies-to Doc. No.",PurchCrMemoHdr."No.");
                                       IF PurchInvHeader.FINDFIRST THEN BEGIN
                                          PurchInvHeader.CALCFIELDS("Amount to Vendor");
                                         IF ABS(PurchInvHeader."Amount to Vendor")=ABS(PurchCrMemoHdr."Amount to Vendor") THEN
                                           TotalAdd := FALSE;
                                         END;
                                    END;
                                 END;
                             END;*/
                            /*TDSEntry.RESET;
                            TDSEntry.SETRANGE("Document No.",VendorDetLedEntry_gRec."Document No.");
                            TDSEntry.SETRANGE("Document Type",TDSEntry."Document Type"::" ");
                            TDSEntry.SETRANGE("Source Code",'');
                            IF TDSEntry.FINDFIRST THEN
                              TotalAdd := FALSE;*/
                            if TotalAdd then begin
                                TotalDebitAmount_gDec += VendorDetLedEntry_gRec."Debit Amount (LCY)";
                                TotalCreditAmount_gDec += VendorDetLedEntry_gRec."Credit Amount (LCY)";
                            end;
                        until VendorDetLedEntry_gRec.Next = 0;
                    TotalBalanceAmount_gDec := TotalDebitAmount_gDec - TotalCreditAmount_gDec + OpeningBalDebit_gDec + OpeningBalCredit_gDec;
                    if TotalBalanceAmount_gDec > 0 then
                        TotalBalanceDrCrText_gText := ' Dr.'
                    else
                        TotalBalanceDrCrText_gText := ' Cr.';
                    // To calculate debit / credit upto start date
                    DebituptoStartDate_gDec := 0;
                    CredituptoStartDate_gDec := 0;
                    VendorDetLedEntry_gRec.Reset;
                    VendorDetLedEntry_gRec.SetRange("Vendor No.", "Vendor Ledger Entry"."Vendor No.");
                    VendorDetLedEntry_gRec.SetFilter("Entry Type", '<>Application');
                    VendorDetLedEntry_gRec.SetFilter("Posting Date", '<%1', StartDate);
                    if VendorDetLedEntry_gRec.FindSet then
                        repeat
                            DebituptoStartDate_gDec += VendorDetLedEntry_gRec."Debit Amount (LCY)";
                            CredituptoStartDate_gDec += VendorDetLedEntry_gRec."Credit Amount (LCY)";
                        until VendorDetLedEntry_gRec.Next = 0;
                    // To calculate debit / credit upto End date
                    DebituptoEndDate_gDec := 0;
                    CredituptoEndDate_gDec := 0;
                    VendorDetLedEntry_gRec.Reset;
                    VendorDetLedEntry_gRec.SetRange("Vendor No.", "Vendor Ledger Entry"."Vendor No.");
                    VendorDetLedEntry_gRec.SetFilter("Entry Type", '<>Application');
                    VendorDetLedEntry_gRec.SetFilter("Posting Date", '<%1', EndDate);
                    if VendorDetLedEntry_gRec.FindSet then
                        repeat
                            DebituptoEndDate_gDec += VendorDetLedEntry_gRec."Debit Amount (LCY)";
                            CredituptoEndDate_gDec += VendorDetLedEntry_gRec."Credit Amount (LCY)";
                        until VendorDetLedEntry_gRec.Next = 0;

                end;

            }
            trigger OnPreDataItem();
            begin
                StartDate := GetRangeMin("Date Filter");
                EndDate := GetRangemax("Date Filter");
                OpeningBal_gDate := GetRangeMin("Date Filter");
                OpeningBal_gDate := CalcDate('-1D', OpeningBal_gDate);
            end;

            trigger OnAfterGetRecord();
            var
                CountryRegion_gRec: Record "Country/Region";
                State_gRec: Record State;
            begin
                TotalDebitAmount_gDec := 0;
                TotalCreditAmount_gDec := 0;
                TotalBalanceAmount_gDec := 0;
                TDSAmountTotal_gDec := 0;
                DebituptoStartDate_gDec := 0;
                CredituptoStartDate_gDec := 0;
                DebituptoEndDate_gDec := 0;
                CredituptoEndDate_gDec := 0;
                TDSAmountTotal_gDec := 0;
                //#DCS_01-ASK-NS
                company_information_gRec.Get;
                if RespCenter.Get(Vendor."Responsibility Center") then begin
                    //  FormatAddr.RespCenter(CompanyAddr,RespCenter);
                    company_information_gRec."Phone No." := RespCenter."Phone No.";
                end else
                    FormatAddr.Company(CompanyAddr, company_information_gRec);   //#DCS_01-ASK-NE
                                                                                 //DCS:KC_NS
                if RespCenter.Get(Vendor."Responsibility Center") then begin
                    CompanyAddr[4] := RespCenter."Post Code";
                    CompanyAddr[5] := RespCenter.City;
                    if CountryRegion_gRec.Get(RespCenter."Country/Region Code") then
                        CompanyAddr[6] := CountryRegion_gRec.Name;
                    if State_gRec.Get(company_information_gRec."State Code") then//LK State
                        CompanyAddr[7] := State_gRec.Description;
                end else begin
                    CompanyAddr[4] := company_information_gRec."Post Code";
                    CompanyAddr[5] := company_information_gRec.City;
                    if CountryRegion_gRec.Get(company_information_gRec."Country/Region Code") then
                        CompanyAddr[6] := CountryRegion_gRec.Name;
                    if State_gRec.Get(company_information_gRec."State Code") then //LK State
                        CompanyAddr[7] := State_gRec.Description;
                end;
                //DCS:KC_NE
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
                    field("Show Account Detail"; PrintGLDetails_gBool)
                    {
                        ApplicationArea = Basic;
                        Visible = true;
                    }
                    field(PrintNarration_gBool; PrintNarration_gBool)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Print Narration';
                    }
                    field(PrintOnePrPage; PrintOnePrPage)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Vendor Per New Page';
                    }

                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            PrintNarration_gBool := true;
        end;
    }
    labels
    {
        Pageno = 'Page No :';
    }


    trigger OnPreReport()
    begin
        Picture_grec.Get;
        Picture_grec.CalcFields(Picture);

    end;

    var
        StartDate: Date;
        EndDate: Date;
        PrintNarration_gBool: Boolean;
        PostedNarration1_gRec: Record "Posted Narration";
        PrintGLDetails_gBool: Boolean;
        GLAccount_gRec: Record "G/L Account";
        OpeningBal_gDate: Date;
        AppliedBalance_gBool: Boolean;
        CustomerBalance_gDec: Decimal;
        TotalBalanceAmount_gDec: Decimal;
        ABSCustomerBalance_gDec: Decimal;
        BalanceDrCrText_gText: Text;
        TotalBalanceDrCrText_gText: Text;
        OpeningBal_gDec: Decimal;
        VendorDetLedEntry_gRec: Record "Detailed Vendor Ledg. Entry";
        OpeningBalDebit_gDec: Decimal;
        OpeningBalCredit_gDec: Decimal;
        TDSEntry_gRec: Record "G/L Entry";
        TDSAmount_gDec: Decimal;
        TotalDebitAmount_gDec: Decimal;
        TotalCreditAmount_gDec: Decimal;
        TDSAmountTotal_gDec: Decimal;
        DebituptoStartDate_gDec: Decimal;
        CredituptoStartDate_gDec: Decimal;
        DebituptoEndDate_gDec: Decimal;
        CredituptoEndDate_gDec: Decimal;
        PrintOnePrPage: Boolean;
        company_information_gRec: Record "Company Information";
        RespCenter: Record "Responsibility Center";
        FormatAddr: Codeunit "Format Address";
        CompanyAddr: array[8] of Text[50];
        shortcutDim1_gFilter: Text;
        GLEntry: Record "G/L Entry";
        Amount_gDec: Decimal;
        Picture_grec: Record "Company Information";
        CountryRegion: Record "Country/Region";

    local procedure VendorLedgerEntryReversed(VendorLedgerEntry_Check: Record "Vendor Ledger Entry"): Boolean
    var
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        PurchInvLine: Record "Purch. Inv. Line";
        PurchCrMemoLine: Record "Purch. Cr. Memo Line";
        PILineAmount: Decimal;
        PCLineAmount: Decimal;
    begin
        PurchInvHeader.Reset;
        PurchInvHeader.SetRange("No.", VendorLedgerEntry_Check."Document No.");
        if PurchInvHeader.FindFirst then begin
            PurchInvLine.Reset;
            PurchInvLine.SetRange("Document No.", PurchInvHeader."No.");
            if PurchInvLine.FindSet then
                PurchInvLine.CalcSums("Line Amount");
            PILineAmount := PurchInvLine."Line Amount";
            if PurchInvHeader."Applies-to Doc. No." = '' then begin
                PurchCrMemoHdr.Reset;
                PurchCrMemoHdr.SetRange("Applies-to Doc. No.", PurchInvHeader."No.");
                if PurchCrMemoHdr.FindSet then begin
                    repeat
                        PurchCrMemoLine.Reset;
                        PurchCrMemoLine.SetRange("Document No.", PurchCrMemoHdr."No.");
                        if PurchCrMemoLine.FindSet then begin
                            PurchCrMemoLine.CalcSums("Line Amount");
                            PCLineAmount := PurchCrMemoLine."Line Amount";
                            if (PILineAmount - PCLineAmount) = 0 then
                                exit(true);
                        end;
                    until PurchCrMemoHdr.Next = 0;
                end;
            end else begin
                PurchCrMemoHdr.Reset;
                PurchCrMemoHdr.SetRange("No.", PurchInvHeader."Applies-to Doc. No.");
                if PurchCrMemoHdr.FindFirst then begin
                    PurchCrMemoLine.Reset;
                    PurchCrMemoLine.SetRange("Document No.", PurchCrMemoHdr."No.");
                    if PurchCrMemoLine.FindSet then begin
                        PurchCrMemoLine.CalcSums("Line Amount");
                        PCLineAmount := PurchCrMemoLine."Line Amount";
                        if (PILineAmount - PCLineAmount) = 0 then
                            exit(true);
                    end;
                end;
            end;
        end else begin
            PurchCrMemoHdr.Reset;
            PurchCrMemoHdr.SetRange("No.", VendorLedgerEntry_Check."Document No.");
            if PurchCrMemoHdr.FindFirst then begin
                PurchCrMemoLine.Reset;
                PurchCrMemoLine.SetRange("Document No.", PurchCrMemoHdr."No.");
                if PurchCrMemoLine.FindSet then
                    PurchCrMemoLine.CalcSums("Line Amount");
                PCLineAmount := PurchCrMemoLine."Line Amount";
                PurchInvHeader.Reset;
                PurchInvHeader.SetRange("No.", PurchCrMemoHdr."Applies-to Doc. No.");
                if PurchInvHeader.FindFirst then begin
                    PurchInvLine.Reset;
                    PurchInvLine.SetRange("Document No.", PurchInvHeader."No.");
                    if PurchInvLine.FindSet then
                        PurchInvLine.CalcSums("Line Amount");
                    PILineAmount := PurchInvLine."Line Amount";
                    if (PILineAmount - PCLineAmount) = 0 then
                        exit(true);
                end;
            end;
        end;
        exit(false);
    end;


}
