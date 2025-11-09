Report 50095 "Profit And Loss"
{
    UsageCategory = Lists;
    RDLCLayout = './Layouts/ProfitAndLoss.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("G/L Account"; "G/L Account")
        {
            CalcFields = "Net Change";
            DataItemTableView = sorting("No.") order(ascending) where("Account Type" = const(Posting));
            column(ComName; CompInfo.Name)
            {
            }
            column(CompAdd; CompInfo."Address 2" + CompInfo.Address)
            {
            }
            column(CompCity; CompInfo.City)
            {
            }
            column(CompPhone; CompInfo."Phone No.")
            {
            }
            column(ProfitAndLossGroup; Format("G/L Account"."Profit & Losss Groups"))
            {
            }
            column(GLAccountNo; "G/L Account"."No.")
            {
            }
            column(IncomeBalance; "G/L Account"."Income/Balance")
            {
            }
            column(Balance; "G/L Account"."Net Change")
            {
            }
            column(AllfilterText; AllfilterText)
            {
            }
            column(GLAccountName; "G/L Account".Name)
            {
            }
            column(ParentAcctNo; ParentAcctNo)
            {
            }
            column(Indentation; "G/L Account".Indentation)
            {
            }
            column(AccountType; "G/L Account"."Account Type")
            {
            }
            column(ItemSpace; ItemSpace)
            {
            }
            column(TypeLeft; TypeLeft)
            {
            }
            column(TypeRight; TypeRight)
            {
            }
            column(Debit_amt; "G/L Account"."Debit Amount")
            {
            }
            column(Credit_Amt; "G/L Account"."Credit Amount")
            {
            }
            column(IncomeAmout; IncomeAmout)
            {
            }
            column(TotalNetChange4; TotalNetChange4)
            {
            }
            column(TotalNetChange5; TotalNetChange5)
            {
            }
            column(DebitAmt4; DebitAmt4)
            {
            }
            column(DebitAmt5; DebitAmt5)
            {
            }
            column(CreditAmt4; CreditAmt4)
            {
            }
            column(CreditAmt5; CreditAmt5)
            {
            }
            column(CreditAmtBol; CreditAmtBol)
            {
            }
            column(DebitAmtBol; DebitAmtBol)
            {
            }
            column(GroupTypeSortNo; GroupTypeSortNo)
            {
            }
            column(ShowDetails; ShowDetails)
            {
            }
            trigger OnPreDataItem();
            begin
                AllfilterText := Format(StartDate) + ' TO ' + Format(EndDate);
                SetRange("G/L Account"."Income/Balance", "G/L Account"."income/balance"::"Income Statement");
                SetRange("G/L Account"."Date Filter", StartDate, EndDate);
                IncomeAmout := 0;
                GLAcc.Reset;
                GLAcc.SetRange(GLAcc."Income/Balance", GLAcc."income/balance"::"Income Statement");
                GLAcc.SetRange(GLAcc."Date Filter", StartDate, EndDate);
                GLAcc.SetRange(GLAcc."Account Type", GLAcc."account type"::Posting);
                //GLAcc.SETRANGE(GLAcc."Control Accounts",FALSE);
                if GLAcc.FindFirst then
                    repeat
                        GLAcc.CalcFields(GLAcc."Net Change");
                        IncomeAmout += GLAcc."Net Change";
                    until GLAcc.Next = 0;
                TotalNetChange5 := 0;
                TotalNetChange4 := 0;
                DebitAmt5 := 0;
                CreditAmt5 := 0;
                DebitAmt4 := 0;
                CreditAmt4 := 0;
            end;

            trigger OnAfterGetRecord();
            begin
                GroupTypeSortNo := 0;
                TypeLeft := false;
                TypeRight := false;
                GroupBool := false;
                FirstValueGLno := CopyStr("G/L Account"."No.", 1, 1);
                if FirstValueGLno = '6' then begin
                    TypeLeft := true;
                    GroupBool := true;
                    TotalNetChange4 += "Net Change";
                    DebitAmt4 += "Debit Amount";
                    CreditAmt4 += "Credit Amount";
                end;
                if (FirstValueGLno = '7') or (FirstValueGLno = '8') or (FirstValueGLno = '9') then begin //OR (FirstValueGLno='7')  OR (FirstValueGLno='6')
                    TypeRight := true;
                    TotalNetChange5 += "Net Change";
                    DebitAmt5 += "Debit Amount";
                    CreditAmt5 += "Credit Amount";
                end;
                VarIndent := "G/L Account".Indentation;
                ItemIndent := "G/L Account".Indentation;
                ItemSpace := '';
                if ("G/L Account"."Profit & Losss Groups" = "G/L Account"."profit & losss groups"::"Sales Accounts") then
                    GroupTypeSortNo := 1
                else
                    if
                 ("G/L Account"."Profit & Losss Groups" = "G/L Account"."profit & losss groups"::"Direct Incomes") then
                        GroupTypeSortNo := 2
                    else
                        if
                     ("G/L Account"."Profit & Losss Groups" = "G/L Account"."profit & losss groups"::"Purchase Accounts") then
                            GroupTypeSortNo := 3
                        else
                            if
                         ("G/L Account"."Profit & Losss Groups" = 1) then
                                GroupTypeSortNo := 4
                            else
                                if
                             ("G/L Account"."Profit & Losss Groups" = "G/L Account"."profit & losss groups"::"Indirect Expenses") then
                                    GroupTypeSortNo := 5
                                else
                                    GroupTypeSortNo := 6;
                if (Indentation = 0) and ("G/L Account"."Account Type" = "G/L Account"."account type"::"Begin-Total") then begin
                    ParentAcctNo := "G/L Account"."No.";
                end;
                repeat
                    ItemSpace := ItemSpace + ' ';
                    ItemIndent := ItemIndent - 1;
                until ItemIndent <> 0;
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
                field(StartDate; StartDate)
                {
                    ApplicationArea = Basic;
                }
                field(EndDate; EndDate)
                {
                    ApplicationArea = Basic;
                }
                field("Show Debit /Credit"; DebitAmtBol)
                {
                    ApplicationArea = Basic;
                }
                field("Show GL Code"; CreditAmtBol)
                {
                    ApplicationArea = Basic;
                }
                field("Show Details"; ShowDetails)
                {
                    ApplicationArea = Basic;
                }

            }
        }

        actions
        {
        }
    }

    trigger OnInitReport()
    begin
        if DebitAmtBol = false then;
        if CreditAmtBol = false then;
        ShowDetails := true;
        ;


    end;


    trigger OnPreReport()
    begin
        CompInfo.Get;

    end;

    var
        CompInfo: Record "Company Information";
        TotalDebitBalanceAtDate: Decimal;
        TotalCreditBalanceAtDate: Decimal;
        TotalDebitNetChange: Decimal;
        TotalCreditNetChange: Decimal;
        StartDate: Date;
        EndDate: Date;
        AllfilterText: Text;
        grouptyp: Text;
        VarIndent: Integer;
        ParentAcctNo: Text;
        ItemSpace: Text;
        ItemIndent: Integer;
        TypeLeft: Boolean;
        TypeRight: Boolean;
        FirstValueGLno: Text;
        GLAcc: Record "G/L Account";
        IncomeAmout: Decimal;
        TotalNetChange4: Decimal;
        TotalNetChange5: Decimal;
        DebitAmt4: Decimal;
        DebitAmt5: Decimal;
        CreditAmt4: Decimal;
        CreditAmt5: Decimal;
        GroupBool: Boolean;
        DebitAmtBol: Boolean;
        ShoGL: Boolean;
        GroupTypeSortNo: Integer;
        CreditAmtBol: Boolean;
        ShowDetails: Boolean;
        UserSetup: Record "User Setup";

}