//Taneesh
Report 50274 "Profit & loss Report"
{
    RDLCLayout = './Layouts/Profit&lossReport.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Company Information"; "Company Information")
        {
            column(text__; text__)
            {
            }
            column(Salestotal3; Salestotal)
            {
            }
            column(startdate; Format(startdate, 0, '<Day,2>-<Month,2>-<Year4>'))
            {
            }
            column(enddate; Format(enddate, 0, '<Day,2>-<Month,2>-<Year4>'))
            {
            }
            column(TransferAmount; TransferAmount)
            {
            }
            column(ShowUnbuilditems; ShowUnbuilditems)
            {
            }
            dataitem("Balance Sheet Setup"; "G/L Account")
            {
                CalcFields = "Net Change";
                DataItemTableView = sorting(Name) order(ascending) where("Balance Type" = filter(Income | Expence), "Account Type" = filter(Posting), "Balance Sheet Type" = filter(<> "Indirect Expenses" & <> "Indirect Incomes"), "Reconciliation Account" = filter(false));
                RequestFilterFields = "No.", "Global Dimension 1 Code";
                column(LookupPageId_1; '')
                {
                }
                column(PerValueOpening; decOpeningStockInHand)
                {
                }
                column(PerValueClosing; decClosingStockInHand)
                {
                }
                column(BalanceSheetType_BalanceSheetSetup; "Balance Sheet Setup"."Balance Type")
                {
                }
                column(GLAccountNumber_BalanceSheetSetup; "Balance Sheet Setup"."No.")
                {
                }
                column(DebitAmount_BalanceSheetSetup; "Balance Sheet Setup"."Debit Amount")
                {
                }
                column(CreditAmount_BalanceSheetSetup; "Balance Sheet Setup"."Credit Amount")
                {
                }
                column(NetChnage_BalanceSheetSetup; "Balance Sheet Setup"."Net Change")
                {
                }
                column(BalanceType_BalanceSheetSetup; "Balance Sheet Setup"."Balance Sheet Type")
                {
                }
                column(Indentation_BalanceSheetSetup; "Balance Sheet Setup".Indentation)
                {
                }
                column(AccountType_BalanceSheetSetup; "Balance Sheet Setup"."Account Type")
                {
                }
                column(DateFilter_BalanceSheetSetup; "Balance Sheet Setup"."Date Filter")
                {
                }
                column(GlobalDimension1Code_BalanceSheetSetup; "Balance Sheet Setup"."Global Dimension 1 Code")
                {
                }
                column(GlobalDimension2Code_BalanceSheetSetup; "Balance Sheet Setup"."Global Dimension 2 Code")
                {
                }
                column(GLName_BalanceSheetSetup; "Balance Sheet Setup".Name)
                {
                }
                column(TrialIndentation_BalanceSheetSetup; '')
                {
                }
                column(Totaling_BalanceSheetSetup; '')
                {
                }
                column(Balance_BalanceSheetSetup; "Balance Sheet Setup".Balance)
                {
                }
                column(CompanyName; Companyinfo.Name)
                {
                }
                column(CompanyAddress; Companyinfo.Address)
                {
                }
                column(CompayAddress2; Companyinfo."Address 2")
                {
                }
                column(CompanyCity; Companyinfo.City)
                {
                }
                column(Companypostcode; Companyinfo."Post Code")
                {
                }
                column(CompanyGST; Companyinfo."GST Registration No.")
                {
                }
                column(Profit; ProfitToBeAdjusted)
                {
                }
                column(GrossTotal; GrossTotal)
                {
                }
                column(decGrossProfitNeg; decGrossProfitNeg)
                {
                }
                column(decGrossProfitPosit; decGrossProfitPosit)
                {
                }
                column(PurchAmt; PurchAmt + D_Expence)
                {
                }
                column(TotValueIncome; Abs(decSaleAmt) + Abs(decClosingStockInHand) + Abs(decGrossProfitPosit) + Abs(D_Income))
                {
                }
                column(SkipZero; SkipZero)
                {
                }
                column(Expend; Expend)
                {
                }
                column(L_Expend; COllaps_Lavel)
                {
                }
                column(AssestTotal; Abs(AssestTotal))
                {
                }
                column(LibilityTOTAL; Abs(LibilityTOTAL))
                {
                }
                column(ShowThousand; ShowThousand)
                {
                }
                column(TotalValueIncome; TotalValueIncome + D_Income)
                {
                }
                column(TotalValueExpense; TotalValueExpense)
                {
                }
                column(GetUrlForReportDrilldown1; GetURLDrillDown("Balance Sheet Setup"."Balance Sheet Type"))
                {
                }
                column(GetUrlForReportvendor1; GetURLvendor("Balance Sheet Setup"."No."))
                {
                }
                column(PerValue_1; PerValue)
                {
                }
                column(ShowinPer_1; ShowinPer)
                {
                }
                column(Salestotal_1; Salestotal)
                {
                }
                column(BalanceSubGroup_BalanceSheetSetup; '"Balance Sheet Setup"."Balance Sub Group"')
                {
                }
                trigger OnPreDataItem();
                begin
                    AssestTotal := 0;
                    LibilityTOTAL := 0;
                    Int := 0;
                    if startdate <> 0D then
                        "Balance Sheet Setup".SetRange("Balance Sheet Setup"."Date Filter", startdate, enddate);
                    if SkipZero then
                        "Balance Sheet Setup".SetFilter("Balance Sheet Setup"."Net Change", '<>%1', 0);
                end;

                trigger OnAfterGetRecord();
                var
                    GLAccount1: Record "G/L Account";
                    ExpT: Decimal;
                    IncT: Decimal;
                begin
                    decOpeningStockInHand := 0;
                    SIHGLAccount.Reset;
                    SIHGLAccount.SetRange("Balance Sheet Type", SIHGLAccount."balance sheet type"::"Stock-in-hand");
                    SIHGLAccount.SetRange("Account Type", SIHGLAccount."account type"::Posting);
                    SIHGLAccount.SetRange("Date Filter", 0D, startdate - 1);
                    SIHGLAccount.SetRange("Reconciliation Account", false);
                    if SIHGLAccount.FindFirst then
                        repeat
                            SIHGLAccount.CalcFields(SIHGLAccount."Net Change");
                            decOpeningStockInHand += SIHGLAccount."Net Change";
                        until SIHGLAccount.Next = 0;
                    decClosingStockInHand := 0;
                    SIHGLAccount.Reset;
                    SIHGLAccount.SetRange("Balance Sheet Type", SIHGLAccount."balance sheet type"::"Stock-in-hand");
                    SIHGLAccount.SetRange("Date Filter", 0D, enddate);
                    SIHGLAccount.SetRange("Account Type", SIHGLAccount."account type"::Posting);
                    SIHGLAccount.SetRange("Reconciliation Account", false);
                    if SIHGLAccount.FindFirst then
                        repeat
                            SIHGLAccount.CalcFields(SIHGLAccount."Net Change");
                            decClosingStockInHand += SIHGLAccount."Net Change";
                        until SIHGLAccount.Next = 0;
                    PurchAmt := 0;
                    GLAccount1.Reset;
                    GLAccount1.SetRange("Date Filter", startdate, enddate);
                    GLAccount1.SetRange("Account Type", GLAccount1."account type"::Posting);
                    GLAccount1.SetRange("Balance Sheet Type", GLAccount1."balance sheet type"::"Purchase Accounts");
                    GLAccount1.SetRange("Reconciliation Account", false);
                    if GLAccount1.FindFirst then
                        repeat
                            GLAccount1.CalcFields("Net Change");
                            PurchAmt += GLAccount1."Net Change";
                        until GLAccount1.Next = 0;
                    decSaleAmt := 0;
                    GLAccount1.Reset;
                    GLAccount1.SetRange("Date Filter", startdate, enddate);
                    GLAccount1.SetRange("Account Type", GLAccount1."account type"::Posting);
                    GLAccount1.SetRange("Balance Sheet Type", GLAccount1."balance sheet type"::"Sales Accounts");
                    GLAccount1.SetRange("Reconciliation Account", false);
                    if GLAccount1.FindFirst then
                        repeat
                            GLAccount1.CalcFields("Net Change");
                            decSaleAmt += GLAccount1."Net Change";
                        until GLAccount1.Next = 0;
                    D_Expence := 0;
                    D_Income := 0;
                    GLAccount1.Reset;
                    GLAccount1.SetRange("Date Filter", startdate, enddate);
                    GLAccount1.SetRange("Account Type", GLAccount1."account type"::Posting);
                    GLAccount1.SetRange("Balance Sheet Type", GLAccount1."balance sheet type"::"Direct Expenses");
                    GLAccount1.SetRange("Reconciliation Account", false);
                    if GLAccount1.FindFirst then
                        repeat
                            GLAccount1.CalcFields("Net Change");
                            D_Expence += GLAccount1."Net Change";
                        until GLAccount1.Next = 0;
                    GLAccount1.Reset;
                    GLAccount1.SetRange("Date Filter", startdate, enddate);
                    GLAccount1.SetRange("Account Type", GLAccount1."account type"::Posting);
                    GLAccount1.SetRange("Balance Sheet Type", GLAccount1."balance sheet type"::"Direct Incomes");
                    GLAccount1.SetRange("Reconciliation Account", false);
                    if GLAccount1.FindFirst then
                        repeat
                            GLAccount1.CalcFields("Net Change");
                            D_Income += GLAccount1."Net Change";
                        until GLAccount1.Next = 0;
                    Int += 1;
                    if "Balance Sheet Setup"."Balance Type" = "Balance Sheet Setup"."balance type"::Expence then
                        AssestTotal += "Balance Sheet Setup"."Net Change";
                    if "Balance Sheet Setup"."Balance Type" = "Balance Sheet Setup"."balance type"::Income then
                        LibilityTOTAL += "Balance Sheet Setup"."Net Change";
                    decGrossProfit := 0;
                    decGrossProfit := ((decOpeningStockInHand) + (PurchAmt) - Abs(decSaleAmt) - Abs(D_Income) + (D_Expence) - Abs(decClosingStockInHand));
                    if Int = "Balance Sheet Setup".Count then begin
                        //MESSAGE('Op> %1\P> %2\S> %3\I> %4\E> %5\C> %6\Pr> %7',decOpeningStockInHand,PurchAmt,decSaleAmt,D_Income,D_Expence,decClosingStockInHand,decGrossProfit);
                        TotalValueExpense := 0;
                        TotalValueIncome := 0;
                        if decGrossProfit > 0 then begin
                            TotalValueIncome := Abs(LibilityTOTAL) + Abs(decGrossProfit) + Abs(decClosingStockInHand);
                            TotalValueExpense := Abs(AssestTotal);
                        end else begin
                            TotalValueIncome := Abs(LibilityTOTAL) + Abs(decClosingStockInHand);
                            TotalValueExpense := Abs(AssestTotal) + Abs(decGrossProfit);
                        end;
                        if ShowThousand then begin
                            TotalValueIncome := TotalValueIncome / 1000;
                            TotalValueExpense := TotalValueExpense / 1000;
                        end;
                    end;
                    PerValue := 0;
                    if ShowThousand then
                        PerValue := (Abs("Balance Sheet Setup"."Net Change" / 1000) / Salestotal) * 100
                    else
                        PerValue := Abs("Balance Sheet Setup"."Net Change" / Salestotal) * 100;
                    if ShowThousand then
                        if decOpeningStockInHand <> 0 then
                            PerValueOpening := decOpeningStockInHand / 1000
                        else
                            PerValueOpening := decOpeningStockInHand;
                    if ShowThousand then
                        if decClosingStockInHand <> 0 then
                            PerValueClosing := decClosingStockInHand / 1000
                        else
                            PerValueClosing := decClosingStockInHand;
                    decGrossProfitNeg := 0;
                    if decGrossProfit < 0 then begin
                        decGrossProfitNeg := decGrossProfit
                    end;
                    if decGrossProfit > 0 then begin
                        decGrossProfitPosit := decGrossProfit
                    end;
                end;

            }
            dataitem("Balance Sheet"; "G/L Account")
            {
                CalcFields = "Net Change";
                DataItemTableView = sorting(Name) order(ascending) where("Balance Type" = filter(Income | Expence), "Account Type" = filter(Posting), "Balance Sheet Type" = filter("Indirect Expenses" | "Indirect Incomes"), "Reconciliation Account" = filter(false));
                RequestFilterFields = "No.", "Global Dimension 1 Code";
                column(GetUrlForReportDrilldown2; GetURLDrillDown("Balance Sheet"."Balance Sheet Type"))
                {
                }
                column(GetUrlForReportvendor2; GetURLvendor("Balance Sheet"."No."))
                {
                }
                column(ShowThousand1; ShowThousand)
                {
                }
                column(BalanceType_; "Balance Sheet"."Balance Type")
                {
                }
                column(GLName_; "Balance Sheet".Name)
                {
                }
                column(No_BalanceSheet; "Balance Sheet"."No.")
                {
                }
                column(NetChnage_; ("Balance Sheet"."Net Change"))
                {
                }
                column(BalancesheetType_; "Balance Sheet"."Balance Sheet Type")
                {
                }
                column(DIRECTTotal; DIRECTTotal)
                {
                }
                column(indirectTOTAL; indirectTOTAL)
                {
                }
                column(TotalValueDitrect; TotalValueDitrect)
                {
                }
                column(TotalValueIndirect; TotalValueIndirect)
                {
                }
                column(Expend1; Expend)
                {
                }
                column(L_Expend1; COllaps_Lavel)
                {
                }
                column(GrossTotal1; GrossTotal)
                {
                }
                column(PerValue_2; PerValue)
                {
                }
                column(ShowinPer_2; ShowinPer)
                {
                }
                column(Salestotal_2; Salestotal)
                {
                }
                column(GrossTotal2; GrossTotal2)
                {
                }
                column(BalanceSubGroup_BalanceSheet; '"Balance Sheet"."Balance Sub Group"')
                {
                }
                column(F_F; F_F)
                {
                }
                trigger OnPreDataItem();
                begin
                    if startdate <> 0D then
                        "Balance Sheet".SetRange("Balance Sheet"."Date Filter", startdate, enddate);
                    DIRECTTotal := 0;
                    indirectTOTAL := 0;
                    IntValue := 0;
                    if SkipZero then
                        "Balance Sheet".SetFilter("Balance Sheet"."Net Change", '<>%1', 0);
                end;

                trigger OnAfterGetRecord();
                var
                    GLAccount2: Record "G/L Account";
                    DirT: Decimal;
                    IndT: Decimal;
                begin
                    IntValue += 1;
                    decOpeningStockInHand1 := 0;
                    SIHGLAccount.Reset;
                    SIHGLAccount.SetRange("Balance Sheet Type", SIHGLAccount."balance sheet type"::"Stock-in-hand");
                    SIHGLAccount.SetRange("Account Type", SIHGLAccount."account type"::Posting);
                    SIHGLAccount.SetRange("Date Filter", 0D, startdate - 1);
                    SIHGLAccount.SetRange("Reconciliation Account", false);
                    if SIHGLAccount.FindFirst then
                        repeat
                            SIHGLAccount.CalcFields(SIHGLAccount."Net Change");
                            decOpeningStockInHand1 += SIHGLAccount."Net Change";
                        until SIHGLAccount.Next = 0;
                    decClosingStockInHand1 := 0;
                    SIHGLAccount.Reset;
                    SIHGLAccount.SetRange("Balance Sheet Type", SIHGLAccount."balance sheet type"::"Stock-in-hand");
                    SIHGLAccount.SetRange("Account Type", SIHGLAccount."account type"::Posting);
                    SIHGLAccount.SetRange("Date Filter", 0D, enddate);
                    SIHGLAccount.SetRange("Reconciliation Account", false);
                    if SIHGLAccount.FindFirst then
                        repeat
                            SIHGLAccount.CalcFields(SIHGLAccount."Net Change");
                            decClosingStockInHand1 += SIHGLAccount."Net Change";
                        until SIHGLAccount.Next = 0;
                    PurchAmt1 := 0;
                    GLaccount1.Reset;
                    GLaccount1.SetRange("Date Filter", startdate, enddate);
                    GLaccount1.SetRange("Account Type", GLaccount1."account type"::Posting);
                    GLaccount1.SetRange("Balance Sheet Type", GLaccount1."balance sheet type"::"Purchase Accounts");
                    GLaccount1.SetRange("Reconciliation Account", false);
                    if GLaccount1.FindFirst then
                        repeat
                            GLaccount1.CalcFields("Net Change");
                            PurchAmt1 += GLaccount1."Net Change";
                        until GLaccount1.Next = 0;
                    decSaleAmt1 := 0;
                    GLaccount1.Reset;
                    GLaccount1.SetRange("Date Filter", startdate, enddate);
                    GLaccount1.SetRange("Account Type", GLaccount1."account type"::Posting);
                    GLaccount1.SetRange("Balance Sheet Type", GLaccount1."balance sheet type"::"Sales Accounts");
                    GLaccount1.SetRange("Reconciliation Account", false);
                    if GLaccount1.FindFirst then
                        repeat
                            GLaccount1.CalcFields("Net Change");
                            decSaleAmt1 += GLaccount1."Net Change";
                        until GLaccount1.Next = 0;
                    D_Expence1 := 0;
                    GLaccount1.Reset;
                    GLaccount1.SetRange("Date Filter", startdate, enddate);
                    GLaccount1.SetRange("Account Type", GLaccount1."account type"::Posting);
                    GLaccount1.SetRange("Balance Sheet Type", GLaccount1."balance sheet type"::"Direct Expenses");
                    GLaccount1.SetRange("Reconciliation Account", false);
                    if GLaccount1.FindFirst then
                        repeat
                            GLaccount1.CalcFields("Net Change");
                            D_Expence1 += GLaccount1."Net Change";
                        until GLaccount1.Next = 0;
                    D_Income1 := 0;
                    GLaccount1.Reset;
                    GLaccount1.SetRange("Date Filter", startdate, enddate);
                    GLaccount1.SetRange("Account Type", GLaccount1."account type"::Posting);
                    GLaccount1.SetRange("Balance Sheet Type", GLaccount1."balance sheet type"::"Direct Incomes");
                    GLaccount1.SetRange("Reconciliation Account", false);
                    if GLaccount1.FindFirst then
                        repeat
                            GLaccount1.CalcFields("Net Change");
                            D_Income1 += GLaccount1."Net Change";
                        until GLaccount1.Next = 0;
                    decGrossProfit1 := 0;
                    decGrossProfit1 := ((decOpeningStockInHand1) + (PurchAmt1) - Abs(decSaleAmt1) + (D_Expence1) - Abs(D_Income1) - Abs(decClosingStockInHand1));
                    if ("Balance Sheet"."Balance Type" = "Balance Sheet"."balance type"::Expence) then
                        DIRECTTotal += "Balance Sheet"."Net Change";
                    if "Balance Sheet"."Balance Type" = "Balance Sheet"."balance type"::Income then
                        indirectTOTAL += "Balance Sheet"."Net Change";
                    if IntValue = "Balance Sheet".Count then begin
                        TotalValueIndirect := 0;
                        TotalValueDitrect := 0;
                        if decGrossProfit1 > 0 then begin
                            TotalValueIndirect := Abs(indirectTOTAL);
                            TotalValueDitrect := DIRECTTotal + (decGrossProfit1);
                        end else begin
                            TotalValueIndirect := Abs(indirectTOTAL) + Abs(decGrossProfit1);
                            TotalValueDitrect := (DIRECTTotal);
                        end;
                        GrossTotal2 := 0;
                        GrossTotal2 := decGrossProfit1;
                        if ShowThousand then begin
                            TotalValueIndirect := TotalValueIndirect / 1000;
                            TotalValueDitrect := TotalValueDitrect / 1000;
                            GrossTotal := decGrossProfit1 / 1000;
                        end;
                        F_F := Abs(TotalValueIndirect) - Abs(TotalValueDitrect);
                        //MESSAGE('TI-%1\TD-%2',F_F,ABS(TotalValueIndirect)-ABS(TotalValueDitrect));
                    end;
                    if ShowThousand then
                        PerValue := Abs(("Balance Sheet"."Net Change" / 1000) / Salestotal) * 100
                    else
                        PerValue := Abs("Balance Sheet"."Net Change" / Salestotal) * 100;
                end;

            }
            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                DataItemTableView = where("Completely Invoiced" = const(false));
                column(ReportForNavId_1000000068; 1000000068) { } // Autogenerated by ForNav - Do not delete
                column(ItemNo_ItemLedgerEntry; "Item Ledger Entry"."Item No.")
                {
                }
                column(PostingDate_ItemLedgerEntry; "Item Ledger Entry"."Posting Date")
                {
                }
                column(EntryNo_ItemLedgerEntry; "Item Ledger Entry"."Entry No.")
                {
                }
                dataitem("Value Entry"; "Value Entry")
                {
                    DataItemLink = "Item Ledger Entry No." = field("Entry No.");
                    column(ReportForNavId_1000000072; 1000000072) { } // Autogenerated by ForNav - Do not delete
                    column(CostAmountExpected_ValueEntry; "Value Entry"."Cost Amount (Expected)")
                    {
                    }
                    column(ItemLedgerEntryNo_ValueEntry; "Value Entry"."Item Ledger Entry No.")
                    {
                    }
                    column(ItemNo_ValueEntry; "Value Entry"."Item No.")
                    {
                    }
                    column(PostingDate_ValueEntry; "Value Entry"."Posting Date")
                    {
                    }
                    column(ItemDesc; ItemDesc)
                    {
                    }
                    column(Sourcename; Sourcename)
                    {
                    }
                    column(SourceNo_ValueEntry; "Value Entry"."Source No.")
                    {
                    }
                    trigger OnPreDataItem();
                    begin
                        SetRange("Posting Date", startdate, enddate)
                    end;

                    trigger OnAfterGetRecord();
                    begin
                        Clear(ItemDesc);
                        Item.Reset;
                        if Item.Get("Value Entry"."Item No.") then
                            ItemDesc := Item.Description;
                        Clear(Sourcename);
                        if "Value Entry"."Source Type" = "Value Entry"."source type"::Customer then begin
                            Cust_Rec.Reset;
                            if Cust_Rec.Get("Value Entry"."Source No.") then
                                Sourcename := Cust_Rec.Name;
                        end;
                        if "Value Entry"."Source Type" = "Value Entry"."source type"::Vendor then begin
                            Vendor.Reset;
                            if Vendor.Get("Value Entry"."Source No.") then
                                Sourcename := Vendor.Name;
                        end;
                    end;

                }
                trigger OnPreDataItem();
                begin
                    SetRange("Posting Date", startdate, enddate)
                end;

            }
            trigger OnAfterGetRecord();
            var
                GLEntryNew: Record "G/L Entry";
            begin
            end;

        }
    }

    requestpage
    {

        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Filters)
                {
                    field("Skip Zero"; SkipZero)
                    {
                        ApplicationArea = Basic;
                    }
                    field(Collaps; Expend)
                    {
                        ApplicationArea = Basic;
                    }
                    field(COllaps_Lavel; COllaps_Lavel)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Collaps Sub Group';
                    }
                    field("Show in Thousand"; ShowThousand)
                    {
                        ApplicationArea = Basic;
                    }
                    field("Show Percentage"; ShowinPer)
                    {
                        ApplicationArea = Basic;
                    }
                    field("Show Unbuild Items"; ShowUnbuilditems)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Show Unbuild Items';
                    }
                }
                group("Date Filter")
                {
                    field("Start Date"; startdate)
                    {
                        ApplicationArea = Basic;
                    }
                    field("End Date"; enddate)
                    {
                        ApplicationArea = Basic;
                    }

                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            ShowUnbuilditems := true;
        end;

        trigger OnQueryClosePage(CloseAction: action): Boolean
        begin
            //IF startdate = 0D THEN
            //ERROR('Start date should not be blank');
            if ShowinPer then begin
                if not SkipZero then
                    Error('If you want to show in percentage, Skip Zero should be True');
            end;
        end;
    }

    trigger OnInitReport()
    begin
        Companyinfo.Get;
        SkipZero := true;
        Expend := true;
        ShowinPer := true;
        COllaps_Lavel := true;


    end;


    trigger OnPreReport()
    begin
        if enddate = 0D then
            enddate := WorkDate;
        text__ := 'Figures In INR';
        if ShowThousand then
            text__ := 'Figures In Thousand';
        ProfitToBeAdjusted := 0;
        GrossTotal := 0;
        profitecalc;
        selltotall;
        GLS.Get;
        GLS."BS Start Date" := startdate;
        GLS."BS End Date" := enddate;
        GLS.Modify;
        if COMPANYNAME <> 'RB IMPEX' then
            Error('Company Should be RB IMPEX');
    end;

    var
        Companyinfo: Record "Company Information";
        GLaccount: Record "G/L Account";
        ProfitToBeAdjusted: Decimal;
        SkipZero: Boolean;
        Expend: Boolean;
        AssestTotal: Decimal;
        LibilityTOTAL: Decimal;
        tt: Decimal;
        startdate: Date;
        enddate: Date;
        GrossTotal: Decimal;
        GLaccount1: Record "G/L Account";
        DIRECTTotal: Decimal;
        indirectTOTAL: Decimal;
        IntValue: Integer;
        TotalValueIndirect: Decimal;
        TotalValueDitrect: Decimal;
        collaps: Boolean;
        ShowThousand: Boolean;
        TotalValueExpense: Decimal;
        TotalValueIncome: Decimal;
        Int: Integer;
        Customer1: RecordRef;
        Vendor1: RecordRef;
        GLEntry1: RecordRef;
        Customer2: RecordRef;
        Vendor2: RecordRef;
        GLEntry2: RecordRef;
        ShowinPer: Boolean;
        PerValue: Decimal;
        GLAccount2: Record "G/L Account";
        Salestotal: Decimal;
        GrossTotal2: Decimal;
        text__: Text;
        GLS: Record "General Ledger Setup";
        SIHGLAccount: Record "G/L Account";
        decOpeningStockInHand: Decimal;
        decClosingStockInHand: Decimal;
        PerValueOpening: Decimal;
        PerValueClosing: Decimal;
        GrossProfit: Decimal;
        PurchAmt: Decimal;
        decGrossProfit: Decimal;
        decSaleAmt: Decimal;
        decGrossProfitNeg: Decimal;
        decGrossProfitPosit: Decimal;
        decOpeningStockInHand1: Decimal;
        decClosingStockInHand1: Decimal;
        PurchAmt1: Decimal;
        decSaleAmt1: Decimal;
        decGrossProfit1: Decimal;
        CountGLAccount: Record "G/L Account";
        decDIRECTTotal: Decimal;
        decindirectTOTAL: Decimal;
        COllaps_Lavel: Boolean;
        D_Income: Decimal;
        D_Expence: Decimal;
        D_Income1: Decimal;
        D_Expence1: Decimal;
        TransferAmount: Decimal;
        Counter2: Integer;
        ItemLedgerEntry: Record "Item Ledger Entry";
        TransferShipmentLine: Record "Transfer Shipment Line";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        SalesInvoiceLine: Record "Sales Invoice Line";
        ShowUnbuilditems: Boolean;
        Item: Record Item;
        Cust_Rec: Record Customer;
        ItemDesc: Text[50];
        Sourcename: Text[50];
        Vendor: Record Vendor;
        F_F: Decimal;

    local procedure profitecalc()
    var
        int: Integer;
        ExpVa: Text;
    begin
        GLaccount.Reset;
        GLaccount.SetRange("Account Type", GLaccount."account type"::Posting);
        GLaccount.SetRange("Income/Balance", GLaccount."income/balance"::"Income Statement");
        GLaccount1.SetRange("Reconciliation Account", false);
        GLaccount.SetRange("Date Filter", startdate, enddate);
        if GLaccount.FindFirst then
            repeat
                GLaccount.CalcFields("Net Change");
                ProfitToBeAdjusted += GLaccount."Net Change";
            until GLaccount.Next = 0;
    end;

    local procedure GetURLDrillDown(Balancesheetype: Option ,"Branch / Divisions","Capital Account","Reserves & Surplus","Current Assets","Bank Accounts","Cash-in-hand","Deposits (Asset)","Loans & Advances (Asset)","Stock-in-hand","Sundry Debtors","Current Liabilities","Duties & Taxes",Provisions,"Sundry Creditors","Direct Expenses","Direct Incomes","Fixed Assets","Indirect Expenses","Indirect Incomes",Investments,"Loans (Liability)","Bank OD A/c","Secured Loans","Unsecured Loans","Misc. Expenses (ASSET)","Purchase Accounts","Sales Accounts","Suspense A/c"): Text
    var
        GLAccountList: Page "G/L Account List";
        BalanceCode: Text;
    begin
        if Balancesheetype = 0 then
            BalanceCode := '0'
        else
            if Balancesheetype = 1 then
                BalanceCode := '1'
            else
                if Balancesheetype = 2 then
                    BalanceCode := '2'
                else
                    if Balancesheetype = 3 then
                        BalanceCode := '3'
                    else
                        if Balancesheetype = 4 then
                            BalanceCode := '4'
                        else
                            if Balancesheetype = 5 then
                                BalanceCode := '5'
                            else
                                if Balancesheetype = 6 then
                                    BalanceCode := '6'
                                else
                                    if Balancesheetype = 7 then
                                        BalanceCode := '7'
                                    else
                                        if Balancesheetype = 8 then
                                            BalanceCode := '8'
                                        else
                                            if Balancesheetype = 9 then
                                                BalanceCode := '9'
                                            else
                                                if Balancesheetype = 10 then
                                                    BalanceCode := '10'
                                                else
                                                    if Balancesheetype = 11 then
                                                        BalanceCode := '11'
                                                    else
                                                        if Balancesheetype = 12 then
                                                            BalanceCode := '12'
                                                        else
                                                            if Balancesheetype = 13 then
                                                                BalanceCode := '13'
                                                            else
                                                                if Balancesheetype = 14 then
                                                                    BalanceCode := '14'
                                                                else
                                                                    if Balancesheetype = 15 then
                                                                        BalanceCode := '15'
                                                                    else
                                                                        if Balancesheetype = 16 then
                                                                            BalanceCode := '16'
                                                                        else
                                                                            if Balancesheetype = 17 then
                                                                                BalanceCode := '17'
                                                                            else
                                                                                if Balancesheetype = 18 then
                                                                                    BalanceCode := '18'
                                                                                else
                                                                                    if Balancesheetype = 19 then
                                                                                        BalanceCode := '19'
                                                                                    else
                                                                                        if Balancesheetype = 20 then
                                                                                            BalanceCode := '20'
                                                                                        else
                                                                                            if Balancesheetype = 21 then
                                                                                                BalanceCode := '21'
                                                                                            else
                                                                                                if Balancesheetype = 22 then
                                                                                                    BalanceCode := '22'
                                                                                                else
                                                                                                    if Balancesheetype = 23 then
                                                                                                        BalanceCode := '23'
                                                                                                    else
                                                                                                        if Balancesheetype = 24 then
                                                                                                            BalanceCode := '24'
                                                                                                        else
                                                                                                            if Balancesheetype = 25 then
                                                                                                                BalanceCode := '25'
                                                                                                            else
                                                                                                                if Balancesheetype = 26 then
                                                                                                                    BalanceCode := '26'
                                                                                                                else
                                                                                                                    if Balancesheetype = 27 then
                                                                                                                        BalanceCode := '27'
                                                                                                                    else
                                                                                                                        if Balancesheetype = 28 then
                                                                                                                            BalanceCode := '28'
                                                                                                                        else
                                                                                                                            if Balancesheetype = 29 then
                                                                                                                                BalanceCode := '29'
                                                                                                                            else
                                                                                                                                if Balancesheetype = 30 then
                                                                                                                                    BalanceCode := '30'
                                                                                                                                else
                                                                                                                                    if Balancesheetype = 31 then
                                                                                                                                        BalanceCode := '31'
                                                                                                                                    else
                                                                                                                                        BalanceCode := '32';
        exit(GetUrl(CurrentClientType, COMPANYNAME, Objecttype::Page, Page::"G/L Account List")
        + '&$filter=''Balance Sheet Type'' IS ' + '''' + BalanceCode + '''');
    end;

    local procedure GetURLvendor(Vendorcode: Code[10]): Text
    begin
        exit(GetUrl(CurrentClientType, COMPANYNAME, Objecttype::Page, Page::"G/L Account List")
        + '&$filter=''No.'' IS ' + '''' + Vendorcode + '''');
    end;

    local procedure selltotall()
    var
        GLA: Record "G/L Account";
    begin
        Salestotal := 0;
        GLA.Reset;
        GLA.SetFilter("Balance Sheet Type", '%1|%2', GLA."balance sheet type"::"Sales Accounts", GLA."balance sheet type"::"Direct Incomes");
        GLA.SetRange("Date Filter", startdate, enddate);
        GLA.SetRange("Account Type", GLA."account type"::Posting);
        GLA.SetRange("Reconciliation Account", false);
        if GLA.FindFirst then
            repeat
                GLA.CalcFields("Net Change");
                Salestotal += GLA."Net Change";
            until GLA.Next = 0;
        if ShowThousand then
            Salestotal := Abs(Salestotal)
        else
            Salestotal := Abs(Salestotal);
    end;

    local procedure Grouptotal()
    var
        GLAcc: Record "G/L Account";
    begin
        GLAcc.Reset;
    end;

}