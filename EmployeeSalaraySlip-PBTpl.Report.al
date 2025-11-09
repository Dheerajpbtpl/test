/// <summary>
/// Report Employee Salaray Slip-PBTpl (ID 50016).
/// </summary>
Report 50016 "Employee Salaray Slip-PBTpl"
{
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './Layouts/EmployeeSalaraySlip-PBTpl.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Employee Master"; "Employee Master")
        {
            column(Arrear_EmployeeMaster; "Employee Master".Arrear)
            {
            }
            column(Increment_EmployeeMaster; "Employee Master".Increment)
            {
            }
            column(EmpCode; "Employee Master".Code)
            {
            }
            column(EmpName; "Employee Master"."First Name")
            {
            }
            column(LastName; "Employee Master"."Last Name")
            {
            }
            column(Empdivision; "Employee Master".Department)
            {
            }
            column(EmpParentName; "Employee Master"."Parent Name")
            {
            }
            column(UANNO; "Employee Master"."UAN No")
            {
            }
            column(PFNO; "Employee Master"."PF No.")
            {
            }
            column(DOJ; Format("Employee Master"."Date of Joining"))
            {
            }
            column(GBasic; GrossSalary)
            {
            }
            column(HRAP; "Employee Master"."HRA Percentage")
            {
            }
            column(GHRA; GHRA)
            {
            }
            column(Basic; BasicAmountTot)
            {
            }
            column(HRA; HRAAmountTot)
            {
            }
            column(Incentive; IncentiveAmt)
            {
            }
            column(VARAMT; VarAmtTot)
            {
            }
            column(ProductionIncentive; ProdInc)
            {
            }
            column(Insurance; InsuAmt)
            {
            }
            column(LoanEMI; LOANEMI)
            {
            }
            column(ESI; ESIAmountTot)
            {
            }
            column(PF; PFAmountTot)
            {
            }
            column(compinfo; compinfo.Name)
            {
            }
            column(Compadd; compinfo.Address)
            {
            }
            column(compadd2; compinfo."Address 2")
            {
            }
            column(Compstate; compinfo."State Code")
            {
            }
            column(Comppost; compinfo."Post Code")
            {
            }
            column(Enddate; PeriodEndDate)
            {
            }
            column(logo; compinfo.Picture)
            {
            }
            column(PresentDay; PresentDays)
            {
            }
            column(OffDay; offday)
            {
            }
            column(HolidayDays; Holidays)
            {
            }
            column(noofdays; NoofDays)
            {
            }
            column(ADVPaid; Advance1)
            {
            }
            column(SLLeaves; SLLeaves)
            {
            }
            column(Salary_Total; Salary_Total)
            {
            }
            column(AmountInWords; AmountInWords)
            {
            }
            column(designation; "Employee Master".Designation)
            {
            }
            column(dept; dept)
            {
            }
            column(LocationCode_EmployeeMaster; "Employee Master"."Location Code")
            {
            }
            column(BankAccountNo_EmployeeMaster; "Employee Master"."Bank Account No.")
            {
                IncludeCaption = true;
            }
            column(IFSCCode_EmployeeMaster; "Employee Master"."IFSC Code")
            {
            }
            column(PANNo_EmployeeMaster; "Employee Master"."PAN No")
            {
            }
            column(basictot; BasicAmt_rec)
            {
            }
            column(HRAAmt_rec; HRAAmt_rec)
            {
            }
            column(ConAmt_rec; ConAmt_rec)
            {
            }
            column(medical_rec; medical_rec)
            {
            }
            column(others_rec; others_rec)
            {
            }
            column(designation_rec; designation_rec)
            {
            }
            column(ESINo; "Employee Master"."ESI No.")
            {
            }
            column(NoOfMonths; NoOfMonths)
            {
            }
            column(PeriodStartDate; PeriodStartDate)
            {
            }
            column(var_rec; var_rec)
            {
            }
            column(Advance_EmployeeMaster; "Employee Master".Advance)
            {
            }
            column(SLLeaves22; SLLeaves22)
            {
            }
            trigger OnPreDataItem();
            begin
                if EmployeeCode <> '' then
                    SetRange(Code, EmployeeCode)
            end;

            trigger OnAfterGetRecord();
            begin
                PresentDays := 0;
                HolidayDays := 0;
                SLLeaves := 0;
                offday := 0;
                BasicAmountTot := 0;
                HRAAmountTot := 0;
                IncentiveAmt := 0;
                InsuAmt := 0;
                LOANEMI := 0;
                ESIAmountTot := 0;
                PFAmountTot := 0;
                WELFAREAmountTot := 0;
                LUNCHAmountTot := 0;
                ECFAmountTot := 0;
                OTMAmountTot := 0;
                PTAmountTot := 0;
                FMAmountTot := 0;
                ProdInc := 0;
                TAAmountTot := 0;
                DAAmountTot := 0;
                OTDAmountTot := 0;
                TDSAmountTot := 0;
                Advance33 := 0;
                Advance1 := 0;
                GrossSalary := 0;
                GHRA := 0;
                Holidays := 0;
                EmployeeSalaryDetails.Reset;
                EmployeeSalaryDetails.SetRange("Employee No.", Code);
                EmployeeSalaryDetails.SetFilter("Pay Head", '%1', 'BASIC');
                EmployeeSalaryDetails.SetCurrentkey("Effective Date");
                if EmployeeSalaryDetails.FindLast then begin
                    GrossSalary := EmployeeSalaryDetails.Rate;
                end;
                /*
				//IF "Salary Wages Code" <> "Salary Wages Code"::D07 THEN BEGIN
					EmployeeSalaryDetails.RESET;
				  EmployeeSalaryDetails.SETRANGE("Employee No.",Code);
				  EmployeeSalaryDetails.SETFILTER("Pay Head",'%1','HRA');
				  EmployeeSalaryDetails.SETCURRENTKEY("Effective Date");
				  IF EmployeeSalaryDetails.FINDLAST THEN BEGIN
					  PayHeadDetails.RESET;
					  PayHeadDetails.SETFILTER(PayHeadDetails.Code,'HRA');
					   IF PayHeadDetails.FINDFIRST THEN REPEAT
						IF (GrossSalary >= PayHeadDetails.) AND (GrossSalary <= PayHeadDetails."Amount Upto") THEN BEGIN
							GHRA :=  ROUND(((GrossSalary*PayHeadDetails."Value Basis")/100),1);
							END;
						   UNTIL PayHeadDetails.NEXT=0;
					   END;*/
                //END;
                EmployeeSalaryLedgerEntries.Reset;
                EmployeeSalaryLedgerEntries.SetRange(EmployeeSalaryLedgerEntries."Employee Code", EmployeeCode);
                EmployeeSalaryLedgerEntries.SetRange(EmployeeSalaryLedgerEntries."Period Start Date", PeriodStartDate);
                EmployeeSalaryLedgerEntries.SetRange(EmployeeSalaryLedgerEntries."Period End Date", PeriodEndDate);
                EmployeeSalaryLedgerEntries.SetRange("Pay Head", 'BASIC');
                if EmployeeSalaryLedgerEntries.FindFirst then
                    BasicAmountTot := EmployeeSalaryLedgerEntries.Amount;
                PresentDays := EmployeeSalaryLedgerEntries."Montly Present Day";
                offday := EmployeeSalaryLedgerEntries."Monthly Off Day";
                SLLeaves := EmployeeSalaryLedgerEntries."Monthy Extra Day";
                Holidays := EmployeeSalaryLedgerEntries."Monthly holidays";
                EmployeeSalaryLedgerEntries.Reset;
                EmployeeSalaryLedgerEntries.SetRange(EmployeeSalaryLedgerEntries."Employee Code", EmployeeCode);
                EmployeeSalaryLedgerEntries.SetRange(EmployeeSalaryLedgerEntries."Period Start Date", PeriodStartDate);
                EmployeeSalaryLedgerEntries.SetRange(EmployeeSalaryLedgerEntries."Period End Date", PeriodEndDate);
                EmployeeSalaryLedgerEntries.SetRange("Pay Head", 'HRA');
                if EmployeeSalaryLedgerEntries.FindFirst then
                    HRAAmountTot := EmployeeSalaryLedgerEntries.Amount;
                EmployeeSalaryLedgerEntries.Reset;
                EmployeeSalaryLedgerEntries.SetRange(EmployeeSalaryLedgerEntries."Employee Code", EmployeeCode);
                EmployeeSalaryLedgerEntries.SetRange(EmployeeSalaryLedgerEntries."Period Start Date", PeriodStartDate);
                EmployeeSalaryLedgerEntries.SetRange(EmployeeSalaryLedgerEntries."Period End Date", PeriodEndDate);
                EmployeeSalaryLedgerEntries.SetRange("Pay Head", 'OTHER');
                if EmployeeSalaryLedgerEntries.FindFirst then
                    IncentiveAmt := EmployeeSalaryLedgerEntries.Amount;
                EmployeeSalaryLedgerEntries.Reset;
                EmployeeSalaryLedgerEntries.SetRange(EmployeeSalaryLedgerEntries."Employee Code", EmployeeCode);
                EmployeeSalaryLedgerEntries.SetRange(EmployeeSalaryLedgerEntries."Period Start Date", PeriodStartDate);
                EmployeeSalaryLedgerEntries.SetRange(EmployeeSalaryLedgerEntries."Period End Date", PeriodEndDate);
                EmployeeSalaryLedgerEntries.SetRange("Pay Head", 'CONV.');
                if EmployeeSalaryLedgerEntries.FindFirst then
                    InsuAmt := EmployeeSalaryLedgerEntries.Amount;
                EmployeeSalaryLedgerEntries.Reset;
                EmployeeSalaryLedgerEntries.SetRange(EmployeeSalaryLedgerEntries."Employee Code", EmployeeCode);
                EmployeeSalaryLedgerEntries.SetRange(EmployeeSalaryLedgerEntries."Period Start Date", PeriodStartDate);
                EmployeeSalaryLedgerEntries.SetRange(EmployeeSalaryLedgerEntries."Period End Date", PeriodEndDate);
                EmployeeSalaryLedgerEntries.SetRange("Pay Head", 'MEDICAL');
                if EmployeeSalaryLedgerEntries.FindFirst then
                    LOANEMI := EmployeeSalaryLedgerEntries.Amount;
                EmployeeSalaryLedgerEntries.Reset;
                EmployeeSalaryLedgerEntries.SetRange(EmployeeSalaryLedgerEntries."Employee Code", EmployeeCode);
                EmployeeSalaryLedgerEntries.SetRange(EmployeeSalaryLedgerEntries."Period Start Date", PeriodStartDate);
                EmployeeSalaryLedgerEntries.SetRange(EmployeeSalaryLedgerEntries."Period End Date", PeriodEndDate);
                EmployeeSalaryLedgerEntries.SetRange("Pay Head", 'ESI');
                if EmployeeSalaryLedgerEntries.FindFirst then
                    ESIAmountTot := EmployeeSalaryLedgerEntries.Amount;
                EmployeeSalaryLedgerEntries.Reset;
                EmployeeSalaryLedgerEntries.SetRange(EmployeeSalaryLedgerEntries."Employee Code", EmployeeCode);
                EmployeeSalaryLedgerEntries.SetRange(EmployeeSalaryLedgerEntries."Period Start Date", PeriodStartDate);
                EmployeeSalaryLedgerEntries.SetRange(EmployeeSalaryLedgerEntries."Period End Date", PeriodEndDate);
                EmployeeSalaryLedgerEntries.SetRange("Pay Head", 'PF');
                if EmployeeSalaryLedgerEntries.FindFirst then
                    PFAmountTot := EmployeeSalaryLedgerEntries.Amount;
                Clear(VarAmtTot);
                EmployeeSalaryLedgerEntries.Reset;
                EmployeeSalaryLedgerEntries.SetRange(EmployeeSalaryLedgerEntries."Employee Code", EmployeeCode);
                EmployeeSalaryLedgerEntries.SetRange(EmployeeSalaryLedgerEntries."Period Start Date", PeriodStartDate);
                EmployeeSalaryLedgerEntries.SetRange(EmployeeSalaryLedgerEntries."Period End Date", PeriodEndDate);
                EmployeeSalaryLedgerEntries.SetRange("Pay Head", 'VARIABLE');
                if EmployeeSalaryLedgerEntries.FindFirst then
                    VarAmtTot := EmployeeSalaryLedgerEntries.Amount;
                //des
                Clear(designation_rec);
                EmpDesignationpb.Reset;
                EmpDesignationpb.SetRange(Code, "Employee Master".Designation);
                if EmpDesignationpb.FindFirst then begin
                    designation_rec := EmpDesignationpb.Name;
                end;
                //des
                Clear(dept);
                EmpDepartmentpb.Reset;
                EmpDepartmentpb.SetRange(Code, "Employee Master".Department);
                if EmpDepartmentpb.FindFirst then
                    dept := EmpDepartmentpb."Dept Name";
                //salary
                Clear(BasicAmt_rec);
                Clear(HRAAmt_rec);
                Clear(ConAmt_rec);
                Clear(medical_rec);
                Clear(others_rec);
                Clear(var_rec);
                EmployeeSalaryDetails_rec.Reset;
                EmployeeSalaryDetails_rec.SetRange("Employee No.", "Employee Master".Code);
                EmployeeSalaryDetails_rec.SetRange("Pay Head", 'BASIC');
                if EmployeeSalaryDetails_rec.FindFirst then begin
                    BasicAmt_rec := EmployeeSalaryDetails_rec.Rate;
                end;
                EmployeeSalaryDetails_rec.Reset;
                EmployeeSalaryDetails_rec.SetRange("Employee No.", "Employee Master".Code);
                EmployeeSalaryDetails_rec.SetRange("Pay Head", 'HRA');
                if EmployeeSalaryDetails_rec.FindFirst then begin
                    HRAAmt_rec := EmployeeSalaryDetails_rec.Rate;
                end;
                EmployeeSalaryDetails_rec.Reset;
                EmployeeSalaryDetails_rec.SetRange("Employee No.", "Employee Master".Code);
                EmployeeSalaryDetails_rec.SetRange("Pay Head", 'CONV.');
                if EmployeeSalaryDetails_rec.FindFirst then begin
                    ConAmt_rec := EmployeeSalaryDetails_rec.Rate;
                end;
                EmployeeSalaryDetails_rec.Reset;
                EmployeeSalaryDetails_rec.SetRange("Employee No.", "Employee Master".Code);
                EmployeeSalaryDetails_rec.SetRange("Pay Head", 'MEDICAL');
                if EmployeeSalaryDetails_rec.FindFirst then begin
                    medical_rec := EmployeeSalaryDetails_rec.Rate;
                end;
                EmployeeSalaryDetails_rec.Reset;
                EmployeeSalaryDetails_rec.SetRange("Employee No.", "Employee Master".Code);
                EmployeeSalaryDetails_rec.SetRange("Pay Head", 'VARIABLE');
                if EmployeeSalaryDetails_rec.FindFirst then begin
                    var_rec := EmployeeSalaryDetails_rec.Rate;
                end;
                EmployeeSalaryDetails_rec.Reset;
                EmployeeSalaryDetails_rec.SetRange("Employee No.", "Employee Master".Code);
                EmployeeSalaryDetails_rec.SetRange("Pay Head", 'OTHER');
                if EmployeeSalaryDetails_rec.FindFirst then begin
                    others_rec := EmployeeSalaryDetails_rec.Rate;
                end;
                //salary
                //
                //Salary_Total:=(BasicAmt_rec+HRAAmt_rec+ConAmt_recIncentiveAmt+InsuAmt+LOANEMI+VarAmtTot)-(PFAmountTot+ESIAmountTot);
                Salary_Total := (BasicAmt_rec + HRAAmt_rec + ConAmt_rec + medical_rec + others_rec + var_rec + "Employee Master".Arrear + "Employee Master".Increment - (PFAmountTot + ESIAmountTot + "Employee Master".Advance));
                //amount
                RepCheck.InitTextVariable;
                RepCheck.FormatNoText(NoText, Salary_Total, 'INR');
                AmountInWords := NoText[1];
                //amount
                LeaveDetails.Reset;
                LeaveDetails.SetRange("Employee No.", "Employee Master".Code);
                LeaveDetails.SetRange("Starting Date", PeriodStartDate, PeriodEndDate);
                LeaveDetails.SetFilter("Leave Type", '<>%1', 'EL');
                if LeaveDetails.FindFirst then
                    repeat
                        if LeaveDetails."Leave Type" = 'HD' then
                            SLLeaves += LeaveDetails."Leave Days" / 2
                        else
                            SLLeaves += LeaveDetails."Leave Days";
                    until LeaveDetails.Next = 0;

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
                field("Employee Code"; EmployeeCode)
                {
                    ApplicationArea = Basic;
                    DrillDown = true;
                    TableRelation = "Employee Master".Code;
                }
                field("Start Date"; PeriodStartDate)
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        if PeriodStartDate > 0D then
                            PeriodEndDate := CalcDate('CM', PeriodStartDate)
                        else
                            PeriodEndDate := 0D;
                    end;
                }
                field("End Date"; PeriodEndDate)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }

            }
        }

        actions
        {
        }
    }


    trigger OnPreReport()
    begin
        compinfo.Get;
        compinfo.CalcFields(Picture);
        NoofDays := 0;
        NoofDays := Date2dmy(PeriodEndDate, 1);
        //Month
        if PeriodEndDate > PeriodStartDate then
            NoOfMonths := ROUND((PeriodEndDate - PeriodStartDate) / 30, 1);
        NoOfMonths := 1;
        //Month
        ;

    end;

    var
        EmployeeSalaryLedgerEntries: Record "Employee Salary Ledger-PBTPL";
        BasicAmountTot: Decimal;
        HRAAmountTot: Decimal;
        IncentiveAmt: Decimal;
        InsuAmt: Decimal;
        LOANEMI: Decimal;
        ESIAmountTot: Decimal;
        PFAmountTot: Decimal;
        WELFAREAmountTot: Decimal;
        LUNCHAmountTot: Decimal;
        ECFAmountTot: Decimal;
        OTMAmountTot: Decimal;
        PTAmountTot: Decimal;
        FMAmountTot: Decimal;
        ProdInc: Decimal;
        TAAmountTot: Decimal;
        DAAmountTot: Decimal;
        var_rec: Decimal;
        OTDAmountTot: Decimal;
        TDSAmountTot: Decimal;
        Advance33: Decimal;
        VarAmtTot: Decimal;
        PeriodStartDate: Date;
        PeriodEndDate: Date;
        compinfo: Record "Company Information";
        SDT: Date;
        EDT: Date;
        // AttendanceLine: Record "Quality Order Header M";
        // AttendanceLine1: Record "Quality Order Header M";
        DATE: Record Date;
        PresentDays: Decimal;
        HolidayDays: Integer;
        TotalWorkedSun: Decimal;
        DaysWorked: Decimal;
        offday: Decimal;
        HolidayMaster: Record "Holidays List-PBTPL";
        SLLeaves: Decimal;
        NoofDays: Decimal;
        EmployeeCode: Code[10];
        Advance1: Decimal;
        EmployeeSalaryDetails: Record "Employee Salary Details-PBTPL";
        EmployeeSalaryDetails_rec: Record "Employee Salary Details-PBTPL";
        BasicAmt_rec: Decimal;
        HRAAmt_rec: Decimal;
        ConAmt_rec: Decimal;
        medical_rec: Decimal;
        others_rec: Decimal;
        PayHeadDetails: Record "Pay Head-PBTPL(Payroll)";
        GrossSalary: Decimal;
        GHRA: Decimal;
        EmployeeMaster_rec: Record "Employee Master";
        designation_rec: Text;
        dept: Text;
        EmpDepartmentpb: Record "Emp Department-pb";
        EmpDesignationpb: Record "Emp Designation-pb";
        Salary_Total: Decimal;
        Holidays: Decimal;
        RepCheck: Report Check;
        NoText: array[2] of Text;
        AmountInWords: Text;
        NoOfMonths: Integer;
        InputDate: Date;
        Days: Integer;
        MonthText: Text;
        LeaveDetails: Record "Leave Details";
        SLLeaves22: Decimal;

    local procedure TotalWeeklyOff() TotalSun: Integer
    begin
        /*SDT:=0D;
		EDT:=0D;
		AttendanceLine.RESET;
		AttendanceLine.SETCURRENTKEY("Posting Date");
		AttendanceLine.SETRANGE(AttendanceLine."Employee Code","Employee Master".Code);
		AttendanceLine.SETRANGE("Posting Date",PeriodStartDate,PeriodEndDate);
		AttendanceLine.SETFILTER("In Date",'<>%1',0D);
		IF AttendanceLine.FINDFIRST THEN;
		AttendanceLine1.RESET;
		AttendanceLine1.SETCURRENTKEY("Posting Date");
		AttendanceLine1.SETRANGE(AttendanceLine1."Employee Code","Employee Master".Code);
		IF "Employee Master"."On Leave Date" = 0D THEN
		AttendanceLine1.SETRANGE("Posting Date",PeriodStartDate,PeriodEndDate)
		ELSE
		AttendanceLine1.SETRANGE("Posting Date",PeriodStartDate,"Employee Master"."On Leave Date");
		AttendanceLine1.SETFILTER("In Date",'<>%1',0D);
		IF AttendanceLine1.FINDLAST THEN;
		  IF PeriodStartDate<>AttendanceLine."Posting Date" THEN
			   SDT:=AttendanceLine."Posting Date"-1
		  ELSE
			   SDT:=AttendanceLine."Posting Date";
		  IF PeriodEndDate<>AttendanceLine1."Posting Date" THEN
			   EDT:=AttendanceLine1."Posting Date"+1
		  ELSE
			   EDT:=AttendanceLine1."Posting Date";
			  DATE.RESET;
			  DATE.SETRANGE("Period Start",SDT,EDT);
			  DATE.SETRANGE(DATE."Period Type",DATE."Period Type"::Date);
			  DATE.SETRANGE(DATE."Period No.","Employee Master"."Period No.");
			  EXIT(DATE.COUNT);
			  */

    end;

    local procedure TotalWorkSun() Worked: Decimal
    begin
        /*Worked := 0;
		DATE.RESET;
		DATE.SETRANGE("Period Start",PeriodStartDate,PeriodEndDate);
		DATE.SETRANGE(DATE."Period Type",DATE."Period Type"::Date);
		DATE.SETRANGE(DATE."Period No.","Employee Master"."Period No.");
		IF DATE.FINDFIRST THEN REPEAT
		  AttendanceLine.RESET;
		  AttendanceLine.SETRANGE(AttendanceLine."Employee Code","Employee Master".Code);
		  AttendanceLine.SETRANGE("Posting Date",DATE."Period Start");
		  AttendanceLine.SETFILTER("Attendence Type",'PRESENT');
		  IF AttendanceLine.FINDFIRST THEN
			Worked +=1
		  ELSE BEGIN
			AttendanceLine.RESET;
		  AttendanceLine.SETRANGE(AttendanceLine."Employee Code","Employee Master".Code);
		  AttendanceLine.SETRANGE("Posting Date",DATE."Period Start");
		  AttendanceLine.SETFILTER("Attendence Type",'HALF');
		  IF AttendanceLine.FINDFIRST THEN
			Worked+=1/2;
		  END;
		UNTIL DATE.NEXT=0;
		EXIT(Worked);*/

    end;


}
