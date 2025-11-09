/// <summary>
/// Report ESI Challan (ID 50066).
/// </summary>
Report 50066 "ESI Challan"
{
    PreviewMode = PrintLayout;
    RDLCLayout = './Layouts/ESIChallan.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Employee Salary Ledger-PBTPL"; "Employee Salary Ledger-PBTPL")
        {
            column(Amount_EmployeeSalaryLedgerPBTPL; "Employee Salary Ledger-PBTPL".Amount)
            {
            }
            column(EmployeeCode_EmployeeSalaryLedgerPBTPL; "Employee Salary Ledger-PBTPL"."Employee Code")
            {
            }
            column(EmployeeName_EmployeeSalaryLedgerPBTPL; "Employee Salary Ledger-PBTPL"."Employee Name")
            {
            }
            column(PeriodStartDate_EmployeeSalaryLedgerPBTPL; "Employee Salary Ledger-PBTPL"."Period Start Date")
            {
            }
            column(PeriodEndDate_EmployeeSalaryLedgerPBTPL; "Employee Salary Ledger-PBTPL"."Period End Date")
            {
            }
            column(PayHead_EmployeeSalaryLedgerPBTPL; "Employee Salary Ledger-PBTPL"."Pay Head")
            {
            }
            column(Compname; CompanyInformation.Name)
            {
            }
            column(compadd; CompanyInformation.Address)
            {
            }
            column(compadd2; CompanyInformation."Address 2")
            {
            }
            column(compcity; CompanyInformation.City)
            {
            }
            column(postcode; CompanyInformation."Post Code")
            {
            }
            column(state; CompanyInformation."State Code")
            {
            }
            column(PFNo; PFNo)
            {
            }
            column(UANNo; UANNo)
            {
            }
            column(GrossSal; GrossSal)
            {
            }
            column(EPFAmt; EPFAmt)
            {
            }
            column(S_No; S_No)
            {
            }
            column(AbsentDays; AbsentDays)
            {
            }
            column(MontlyPresentDay_EmployeeSalaryLedgerPBTPL; "Employee Salary Ledger-PBTPL"."Montly Present Day")
            {
            }
            column(MonthlyOffDay_EmployeeSalaryLedgerPBTPL; "Employee Salary Ledger-PBTPL"."Monthly Off Day")
            {
            }
            column(MonthyExtraDay_EmployeeSalaryLedgerPBTPL; "Employee Salary Ledger-PBTPL"."Monthy Extra Day")
            {
            }
            column(Monthlyholidays_EmployeeSalaryLedgerPBTPL; "Employee Salary Ledger-PBTPL"."Monthly holidays")
            {
            }
            column(NoofDays; NoofDays)
            {
            }
            column(Tot_Abs; Tot_Abs)
            {
            }
            column(Tot_gross; Tot_gross)
            {
            }
            column(StartDate; StartDate)
            {
            }
            column(EndDate; EndDate)
            {
            }
            trigger OnPreDataItem();
            begin
                S_No := 0;
                SetRange("Period Start Date", StartDate);
                SetRange("Period End Date", EndDate);
            end;

            trigger OnAfterGetRecord();
            begin
                S_No += 1;
                Clear(PFNo);
                Clear(UANNo);
                EmployeeMaster.Reset;
                EmployeeMaster.SetRange(Code, "Employee Salary Ledger-PBTPL"."Employee Code");
                if EmployeeMaster.FindFirst then
                    // PFNo:=EmployeeMaster.;
                    UANNo := EmployeeMaster."ESI No.";
                Clear(GrossSal);
                Salarydetails.Reset;
                Salarydetails.SetRange("Employee No.", "Employee Salary Ledger-PBTPL"."Employee Code");
                if Salarydetails.FindFirst then begin
                    repeat
                        GrossSal += Salarydetails.Rate;
                    until Salarydetails.Next = 0;
                end;
                Clear(Tot_gross);
                Tot_gross += GrossSal;
                Clear(EPFAmt);
                EmployeeSalaryLedger.Reset;
                EmployeeSalaryLedger.SetRange("Employee Code", "Employee Salary Ledger-PBTPL"."Employee Code");
                EmployeeSalaryLedger.SetRange("Period Start Date", StartDate);
                EmployeeSalaryLedger.SetRange("Period End Date", EndDate);
                EmployeeSalaryLedger.SetRange("Pay Head", 'ESI');
                if EmployeeSalaryLedger.FindFirst then begin
                    repeat
                        EPFAmt += EmployeeSalaryLedger.Amount;
                    until EmployeeSalaryLedger.Next = 0;
                end;
                Clear(Present_Days);
                Clear(AbsentDays);
                EmployeeSalaryLedger_Rec.Reset;
                EmployeeSalaryLedger_Rec.SetRange("Employee Code", "Employee Salary Ledger-PBTPL"."Employee Code");
                EmployeeSalaryLedger_Rec.SetRange("Period Start Date", StartDate);
                EmployeeSalaryLedger_Rec.SetRange("Period End Date", EndDate);
                EmployeeSalaryLedger_Rec.SetRange("Pay Head", 'BASIC');
                if EmployeeSalaryLedger_Rec.FindFirst then begin
                    Present_Days := EmployeeSalaryLedger_Rec."Montly Present Day" + EmployeeSalaryLedger_Rec."Monthly Off Day" + EmployeeSalaryLedger_Rec."Monthy Extra Day" + EmployeeSalaryLedger_Rec."Monthly holidays";
                    AbsentDays := NoofDays - Present_Days;
                end;
                Clear(Tot_Abs);
                Tot_Abs += AbsentDays;
                PayrollSetup.Get;
                if GrossSal > PayrollSetup."ESI Applicable Amount Upto" then
                    CurrReport.Skip;
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
                field(StartDate; StartDate)
                {
                    ApplicationArea = Basic;
                }
                field(EndDate; EndDate)
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
        CompanyInformation.Get;


    end;



    trigger OnPreReport()
    begin
        if StartDate = 0D then
            Error('StartDate must have value');
        if EndDate = 0D then
            Error('end Date must have value');
        NoofDays := 0;
        NoofDays := Date2dmy(EndDate, 1);

    end;

    var
        StartDate: Date;
        EndDate: Date;
        CompanyInformation: Record "Company Information";
        EmployeeMaster: Record "Employee Master";
        UANNo: Code[30];
        PFNo: Code[50];
        Salarydetails: Record "Employee Salary Details-PBTPL";
        GrossSal: Decimal;
        EmployeeSalaryLedger: Record "Employee Salary Ledger-PBTPL";
        EmployeeSalaryLedger_Rec: Record "Employee Salary Ledger-PBTPL";
        EPFAmt: Decimal;
        S_No: Integer;
        NoofDays: Integer;
        Present_Days: Decimal;
        AbsentDays: Decimal;
        Tot_Abs: Decimal;
        Tot_gross: Decimal;
        PayrollSetup: Record "Payroll Setup-PBTPL";


}
