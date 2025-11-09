Report 50023 "Trial Balance Itek"
{
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './Layouts/TrialBalanceItek.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("G/L Account"; "G/L Account")
        {
            CalcFields = "Net Change", "Balance at Date";
            DataItemTableView = sorting("No.") order(ascending) where("Account Type" = filter(Posting));
            RequestFilterFields = "No.", "Date Filter", "Global Dimension 1 Filter", "Global Dimension 2 Filter";
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }

            column(UserId; UserId)
            {
            }
            column(RepFilter; RepFilter)
            {
            }
            column(G_L_Account__No__; "G/L Account"."No.")
            {
            }
            column(VarTranDr; VarTranDr)
            {
            }
            column(VarTranCr; VarTranCr)
            {
            }
            column(VarCloseDr; VarCloseDr)
            {
            }
            column(VarCloseCr; VarCloseCr)
            {
            }
            column(VarOpenCr; VarOpenCr)
            {
            }
            column(VarOpenDr; VarOpenDr)
            {
            }
            column(TotVarOpenDr; TotVarOpenDr)
            {
            }
            column(TotVarOpenCrS; TotVarOpenCr)
            {
            }
            column(TotVarTranDr; TotVarTranDr)
            {
            }
            column(TotVarTranCr; TotVarTranCr)
            {
            }
            column(TotVarCloseDr; TotVarCloseDr)
            {
            }
            column(TotVarCloseCr; TotVarCloseCr)
            {
            }
            column(Trial_BalanceCaption; Trial_BalanceCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(G_L_Account__No__Caption; FieldCaption("No."))
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(TransactionCaption; TransactionCaptionLbl)
            {
            }
            column(DrCaption; DrCaptionLbl)
            {
            }
            column(CrCaption; CrCaptionLbl)
            {
            }
            column(OpeningCaption; OpeningCaptionLbl)
            {
            }
            column(DrCaption_Control1102159024; DrCaption_Control1102159024Lbl)
            {
            }
            column(CrCaption_Control1102159025; CrCaption_Control1102159025Lbl)
            {
            }
            column(CrCaption_Control1102159026; CrCaption_Control1102159026Lbl)
            {
            }
            column(ClosingCaption; ClosingCaptionLbl)
            {
            }
            column(DrCaption_Control1102159027; DrCaption_Control1102159027Lbl)
            {
            }
            column(End_of_ReportCaption; End_of_ReportCaptionLbl)
            {
            }
            column(Name_GLAccount; "G/L Account".Name)
            {
            }
            trigger OnPreDataItem();
            begin
                VarDate := 0D;
                VarDate := "G/L Account".GetRangeMin("G/L Account"."Date Filter");
                RepFilter := '';
                RepFilter := 'Report Filter : ' + "G/L Account".GetFilters;
                if RepFilter = '' then
                    RepFilter := 'ALL';
                TotVarOpenDr := 0;
                TotVarOpenCr := 0;
                TotVarTranDr := 0;
                TotVarTranCr := 0;
                TotVarCloseDr := 0;
                TotVarCloseCr := 0;
                if PrintToExcel = true then begin
                    ExcelBuf.DeleteAll;
                    Row := 1;
                end;
            end;

            trigger OnAfterGetRecord();
            begin
                CompanyInfo.Get;
                VarOpenDr := 0;
                VarOpenCr := 0;
                VarTranDr := 0;
                VarTranCr := 0;
                VarCloseDr := 0;
                VarCloseCr := 0;
                if "G/L Account"."Net Change" >= 0 then
                    VarTranDr := "G/L Account"."Net Change"
                else
                    VarTranCr := "G/L Account"."Net Change" * -1;
                if "G/L Account"."Balance at Date" >= 0 then
                    VarCloseDr := "G/L Account"."Balance at Date"
                else
                    VarCloseCr := "G/L Account"."Balance at Date" * -1;
                Clear(RsGL);
                RsGL.SetFilter(RsGL."No.", "G/L Account"."No.");
                if RsGL.FindFirst then begin
                    RsGL.SetRange(RsGL."Date Filter", 0D, ClosingDate(VarDate - 1));
                    RsGL.CalcFields(RsGL."Balance at Date");
                    if RsGL."Balance at Date" >= 0 then
                        VarOpenDr := RsGL."Balance at Date"
                    else
                        VarOpenCr := RsGL."Balance at Date" * -1;
                    OpeningAmount := VarOpenDr - VarOpenCr;
                end;
                TotVarOpenDr += VarOpenDr;
                TotVarOpenCr += VarOpenCr;
                TotVarTranDr += VarTranDr;
                TotVarTranCr += VarTranCr;
                TotVarCloseDr += VarCloseDr;
                TotVarCloseCr += VarCloseCr;
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



    trigger OnPostReport()
    begin
        /*
		IF PrintToExcel=TRUE THEN BEGIN
		  ExcelBuf.RESET;
		  ExcelBuf.CreateBook;
		  ExcelBuf.CreateSheet('Trial Balance','Trial Balance',COMPANYNAME,USERID);
		  ExcelBuf.GiveUserControl;
		END;
		*/


    end;

    trigger OnPreReport()
    begin
        //PrintHead:=FALSE;

    end;

    var
        VarOpenDr: Decimal;
        VarOpenCr: Decimal;
        VarTranDr: Decimal;
        VarTranCr: Decimal;
        VarCloseDr: Decimal;
        VarCloseCr: Decimal;
        RsGL: Record "G/L Account";
        VarDate: Date;
        RepFilter: Text[200];
        TotVarOpenDr: Decimal;
        TotVarOpenCr: Decimal;
        TotVarTranDr: Decimal;
        TotVarTranCr: Decimal;
        TotVarCloseDr: Decimal;
        TotVarCloseCr: Decimal;
        ExcelBuf: Record "Excel Buffer";
        PrintToExcel: Boolean;
        Row: Integer;
        PrintHead: Boolean;
        Trial_BalanceCaptionLbl: label 'Trial Balance';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        NameCaptionLbl: label 'Name';
        TransactionCaptionLbl: label 'Transaction';
        DrCaptionLbl: label 'Dr';
        CrCaptionLbl: label 'Cr';
        OpeningCaptionLbl: label 'Opening';
        DrCaption_Control1102159024Lbl: label 'Dr';
        CrCaption_Control1102159025Lbl: label 'Cr';
        CrCaption_Control1102159026Lbl: label 'Cr';
        ClosingCaptionLbl: label 'Closing';
        DrCaption_Control1102159027Lbl: label 'Dr';
        End_of_ReportCaptionLbl: label 'End of Report';
        CompanyInfo: Record "Company Information";
        OpeningAmount: Decimal;

}