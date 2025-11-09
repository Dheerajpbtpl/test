Report 50015 "Salary Process-PBTPL"
{
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './Layouts/SalaryProcess-PBTPL.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Employee Master"; "Employee Master")
        {
            trigger OnPreDataItem();
            var
                AttImport: Record "Attendance Import-att";
                timeduration: Duration;
            begin
                AttImport.Reset;
                AttImport.SetRange("Attendance Date", StartDate, EndDate);
                if AttImport.FindFirst then
                    repeat
                        if (AttImport."Out-Time" <> AttImport."In-Time") then begin
                            timeduration := AttImport."Out-Time" - AttImport."In-Time";
                            if timeduration <> 0 then begin
                                AttImport.TotalHrs := ((timeduration / 1000) / 60) / 60;
                                /* IF PayrollSetuppb.GET THEN
                                 IF AttImport.TotalHrs<>0 THEN BEGIN
                                  "Over Time Hrs":=Rec.TotalHrs-PayrollSetuppb."Employee Working Hours";
                                   IF "Over Time Hrs"<=0 THEN
                                     "Over Time Hrs":=0;
                                  END ELSE
                                   "Over Time Hrs":=0;*/
                                AttImport.Modify;
                            end;
                        end;
                    until AttImport.Next = 0;
                Message(EmployeeCode);
                if EmployeeCode <> '' then
                    "Employee Master".SetFilter(Code, EmployeeCode);
                //SETRANGE("Overtime Given",OvertimeCalculation);

            end;

            trigger OnAfterGetRecord();
            var
                DateRec: Record Date;
            begin
                //GL ACCOUNTS
                //MESSAGE("Employee Master".Code);
                BasicGlAcc := '';
                HRGlacc := '';
                BasicBalAcc := '';
                HRBalacc := '';
                Clear(ConvGlacc);
                Clear(ConvGlBalAccNo);
                Clear(MedBallGLAcc);
                Clear(MedGlAcc);
                Clear(OthersGlAcc);
                Clear(OthersGlBalAcc);
                Clear(VariableGl);
                Clear(VariableBalGLAcc);
                PayHead.Reset;
                if PayHead.Get('BASIC') then
                    BasicGlAcc := PayHead."G/L Account";
                BasicBalAcc := PayHead."Balance Account No.";
                if PayHead.Get('HRA') then
                    HRGlacc := PayHead."G/L Account";
                HRBalacc := PayHead."Balance Account No.";
                if PayHead.Get('CONV.') then
                    ConvGlacc := PayHead."G/L Account";
                ConvGlBalAccNo := PayHead."Balance Account No.";
                if PayHead.Get('MEDICAL') then
                    MedGlAcc := PayHead."G/L Account";
                MedBallGLAcc := PayHead."Balance Account No.";
                if PayHead.Get('OTHERS') then
                    OthersGlAcc := PayHead."G/L Account";
                OthersGlBalAcc := PayHead."Balance Account No.";
                if PayHead.Get('VARIABLE') then
                    VariableGl := PayHead."G/L Account";
                VariableBalGLAcc := PayHead."Balance Account No.";
                //periodname
                Clear(DteName);
                AttNotFound := false;
                AttendanceImport13.Reset;
                AttendanceImport13.SetCurrentkey("Attendance Date");
                AttendanceImport13.SetRange("Attendance Date", StartDate, EndDate);
                AttendanceImport13.SetRange("Employee Id", "Employee Master".Code);
                if AttendanceImport13.FindFirst then begin
                    repeat
                        DteName := Date2dwy(AttendanceImport13."Attendance Date", 1);
                        // MESSAGE('%1\%2',AttendanceImport13."Attendance Date",DteName);
                        AttendanceImport13.Weekday := DteName;
                        if DteName = 1 then
                            AttendanceImport13.Weekdayname := AttendanceImport13.Weekdayname::Monday
                        else
                            if DteName = 2 then
                                AttendanceImport13.Weekdayname := AttendanceImport13.Weekdayname::Tuesday
                            else
                                if DteName = 3 then
                                    AttendanceImport13.Weekdayname := AttendanceImport13.Weekdayname::Wednesday
                                else
                                    if DteName = 4 then
                                        AttendanceImport13.Weekdayname := AttendanceImport13.Weekdayname::Thursday
                                    else
                                        if DteName = 5 then
                                            AttendanceImport13.Weekdayname := AttendanceImport13.Weekdayname::Friday
                                        else
                                            if DteName = 6 then
                                                AttendanceImport13.Weekdayname := AttendanceImport13.Weekdayname::Saturday
                                            else
                                                if DteName = 7 then
                                                    AttendanceImport13.Weekdayname := AttendanceImport13.Weekdayname::Sunday;
                        AttendanceImport13.Modify;
                    //MESSAGE('%1',DteName);
                    until AttendanceImport13.Next = 0;
                end else
                    AttNotFound := true;
                //periodname
                //HOLIDAY MASTER
                Clear(holidayPresent);
                holidaysListPBTPL.Reset;
                holidaysListPBTPL.SetRange(Date, StartDate, EndDate);
                if holidaysListPBTPL.FindFirst then
                    holidayPresent := holidaysListPBTPL.Count;
                //MESSAGE('%1',holidayPresent);
                //HOLIDAY MASTER
                //leave
                Clear(LeaveCalculation);
                AttendanceImport_RecLeave.Reset;
                AttendanceImport_RecLeave.SetRange("Attendance Date", StartDate, EndDate);
                AttendanceImport_RecLeave.SetFilter("shift Start Time", '%1|%2|%3|%4', 'EL', 'CL', 'SL', 'C-OFF');
                AttendanceImport_RecLeave.SetFilter(TotalHrs, '%1', 0);
                if AttendanceImport_RecLeave.FindFirst then
                    LeaveCalculation := AttendanceImport_RecLeave.Count;
                //MESSAGE('%1',LeaveCalculation);
                //leave
                //weekdaysalary
                /*
				CLEAR(weekdaysPresent);
				AtttImport_Week.RESET;
				AtttImport_Week.SETRANGE("Employee Id","Employee Master".Code);
				AtttImport_Week.SETRANGE("Attendance Date",StartDate,EndDate);
				AtttImport_Week.SETRANGE(TotalHrs,0);
				AtttImport_Week.SETRANGE(Weekdayname,"Employee Master"."Week Off-Day");
				IF AtttImport_Week.FINDFIRST THEN BEGIN
				  weekdaysPresent:=AtttImport_Week.COUNT;
				  END;
				  */
                Clear(weekdaysPresent);
                DateRec.Reset;
                DateRec.SetRange(DateRec."Period Type", DateRec."period type"::Date);
                DateRec.SetRange(DateRec."Period Start", StartDate, EndDate);
                DateRec.SetRange("Period Name", Format("Employee Master"."Week Off-Day"));
                weekdaysPresent := DateRec.Count;
                //MESSAGE(FORMAT(weekdaysPresent)+'weekdays');
                ApprovedLeave := 0;
                LeaveDetails.Reset;
                LeaveDetails.SetRange("Employee No.", "Employee Master".Code);
                LeaveDetails.SetRange("Leave With Pay", true);
                LeaveDetails.SetRange("Starting Date", StartDate, EndDate);
                LeaveDetails.CalcSums("Leave Days");
                ApprovedLeave := LeaveDetails."Leave Days";
                //MESSAGE(FORMAT(ApprovedLeave)+' ApprovedLeave');
                //weekdaysalary
                //GLACCOUNTS
                Presentdays := 0;
                Totalsalary := 0;
                Clear(Duration_);
                Clear(TotalHalfDur_);
                Clear(Present_slip);
                //present days
                AttendanceImport.Reset;
                AttendanceImport.SetRange("Employee Id", "Employee Master".Code);
                AttendanceImport.SetRange("Attendance Date", StartDate, EndDate);
                AttendanceImport.SetFilter(TotalHrs, '>%1', 6.9);
                if AttendanceImport.FindFirst then begin
                    //MESSAGE(
                    Presentdays := AttendanceImport.Count + weekdaysPresent + holidayPresent + LeaveCalculation + ApprovedLeave;
                    Present_slip := AttendanceImport.Count;
                end;
                // MESSAGE(FORMAT(Presentdays)+'Presentdays');
                Clear(HalfDays);
                AttendanceImport12.Reset;
                AttendanceImport12.SetRange("Employee Id", "Employee Master".Code);
                AttendanceImport12.SetRange("Attendance Date", StartDate, EndDate);
                AttendanceImport12.SetFilter(TotalHrs, '<%1&>%2', 6.9, 0);
                if AttendanceImport12.FindFirst then begin
                    HalfDays := AttendanceImport12.Count;
                end;
                //UNTIL AttendanceImport.NEXT=0;
                //MESSAGE(FORMAT(HalfDays)+'HalfDays');
                Presentdays := Presentdays + HalfDays / 2;
                //Presentdays:=Presentdays+(HalfDays/2);
                //MESSAGE(FORMAT(Presentdays)+'Total Present Days');
                //basic and hra calculation
                BasicAmt := 0;
                BasicAmtPerDay := 0;
                BasicAmtPerDayTot := 0;
                EmployeeSalaryDetails.Reset;
                EmployeeSalaryDetails.SetRange("Employee No.", "Employee Master".Code);
                EmployeeSalaryDetails.SetRange("Effective Date", 0D, StartDate);
                EmployeeSalaryDetails.SetRange("Pay Head", 'BASIC');
                EmployeeSalaryDetails.SetFilter(EmployeeSalaryDetails."End Date", '%1|>=%2', 0D, EndDate);
                if EmployeeSalaryDetails.FindFirst then begin
                    BasicNotFound := true;
                    BasicAmt := EmployeeSalaryDetails.Rate; //
                    if BasicAmt = 0 then
                        Error("Employee Master".Code + '   y');
                    BasicAmtPerDay := BasicAmt / NoofDays;
                    BasicAmtPerDayTot := BasicAmtPerDay * Presentdays;
                    //MESSAGE(FORMAT(BasicAmtPerDayTot));
                end else
                    BasicNotFound := false;
                //MESSAGE(FORMAT(BasicAmtPerDay)+'basic');
                HRAAmt := 0;
                EmpSalary.Reset;
                EmpSalary.SetRange("Employee No.", "Employee Master".Code);
                EmpSalary.SetRange("Effective Date", 0D, StartDate);
                EmpSalary.SetFilter(EmpSalary."End Date", '%1|>=%2', 0D, EndDate);
                EmpSalary.SetRange("Pay Head", 'HRA');
                if EmpSalary.FindFirst then
                    HRAAmt := EmpSalary.Rate;
                //  MESSAGE(FORMAT(BasicAmtPerDay)+'hra');
                //salary_calculation
                //convamt and medical and other
                Clear(ConvAmt);
                Clear(MedicalAmt);
                Clear(OthersAmt);
                EMPsalarydt.Reset;
                EMPsalarydt.SetRange("Employee No.", "Employee Master".Code);
                EMPsalarydt.SetRange("Effective Date", 0D, StartDate);
                EMPsalarydt.SetFilter(EMPsalarydt."End Date", '%1|>=%2', 0D, EndDate);
                EMPsalarydt.SetRange("Pay Head", 'CONV.');
                if EMPsalarydt.FindFirst then begin
                    ConvAmt := EMPsalarydt.Rate;
                end;
                // EMPsalarydt.RESET;
                EMPsalarydt.SetRange("Employee No.", "Employee Master".Code);
                EMPsalarydt.SetRange("Effective Date", 0D, StartDate);
                EMPsalarydt.SetFilter(EMPsalarydt."End Date", '%1|>=%2', 0D, EndDate);
                EMPsalarydt.SetRange("Pay Head", 'MEDICAL');
                if EMPsalarydt.FindFirst then begin
                    MedicalAmt := EMPsalarydt.Rate;
                    //MESSAGE(FORMAT(MedicalAmt));
                end;
                EMPsalarydt12_.Reset;
                EMPsalarydt12_.SetRange("Employee No.", "Employee Master".Code);
                EMPsalarydt12_.SetRange("Effective Date", 0D, StartDate);
                EMPsalarydt12_.SetFilter(EMPsalarydt12_."End Date", '%1|>=%2', 0D, EndDate);
                EMPsalarydt12_.SetRange("Pay Head", 'OTHER');
                if EMPsalarydt12_.FindFirst then begin
                    OthersAmt := EMPsalarydt12_.Rate;
                    //MESSAGE(FORMAT(MedicalAmt));
                end;
                Clear(VarAmt);
                EMPsalarydt12_.Reset;
                EMPsalarydt12_.SetRange("Employee No.", "Employee Master".Code);
                EMPsalarydt12_.SetRange("Effective Date", 0D, StartDate);
                EMPsalarydt12_.SetFilter(EMPsalarydt12_."End Date", '%1|>=%2', 0D, EndDate);
                EMPsalarydt12_.SetRange("Pay Head", 'VARIABLE');
                if EMPsalarydt12_.FindFirst then begin
                    VarAmt := EMPsalarydt12_.Rate;
                    //MESSAGE(FORMAT(MedicalAmt));
                end;
                //MESSAGE(FORMAT(ConvAmt));
                //convamt and medical and other
                Per_DayCost := 0;
                PerHoursalary := 0;
                PerMinuteSalary := 0;
                Per_DayCost := (BasicAmt + HRAAmt + ConvAmt + MedicalAmt + OthersAmt) / NoofDays;
                PerHoursalary := Per_DayCost / 8;
                PerMinuteSalary := PerHoursalary / 60;
                //MESSAGE(FORMAT(PerMinuteSalary));
                //MESSAGE(FORMAT(PerMinuteSalary)+'PerMinuteSalary');
                //salary_calculation
                //MESSAGE(FORMAT(Per_DayCost)+'perday');
                //overtimesalary
                PayrollSetuppb.Get;
                Clear(Overtimehrs);
                Clear(OvertimeAmt);
                if "Employee Master"."Overtime Given" = true then begin
                    AtttImport.Reset;
                    AtttImport.SetRange("Employee Id", "Employee Master".Code);
                    AtttImport.SetRange("Attendance Date", StartDate, EndDate);
                    AtttImport.SetFilter(TotalHrs, '>%1', PayrollSetuppb."Employee Working Hours");
                    if AtttImport.FindFirst then begin
                        repeat
                            if AtttImport.TotalHrs - PayrollSetuppb."Employee Working Hours" > 1 then begin
                                Overtimehrs += (AtttImport.TotalHrs - PayrollSetuppb."Employee Working Hours");
                            end;
                        until AtttImport.Next = 0;
                        //OvertimeAmt:=(Overtimehrs*60)*PerMinuteSalary;
                        OvertimeAmt := PerHoursalary * Overtimehrs;
                        /*MESSAGE(FORMAT(PerMinuteSalary));
                        MESSAGE(FORMAT(OvertimeAmt)+' ll'+FORMAT(Overtimehrs))*/
                        //MESSAGE(FORMAT(PerMinuteSalary));
                    end;
                    //overtimesalary;
                end;
                //MESSAGE(FORMAT(OvertimeAmt)+'Overtimeamt');
                //MESSAGE(FORMAT(Overtimehrs)+'Overtimehrs');
                //short leave
                Clear(lateatt);
                Clear(SalaryDeduct);
                Clear(BasicHalfDay);
                Clear(HRHalfDay);
                Clear(OthersHalfDay);
                Clear(MedicalHalfDay);
                Clear(ConvHalfDay);
                Clear(Shortleave);
                Clear(SH_Minutes);
                AttImportL.Reset;
                AttImportL.SetRange("Employee Id", "Employee Master".Code);
                AttImportL.SetRange("Attendance Date", StartDate, EndDate);
                AttImportL.SetFilter(TotalHrs, '>%1&<%2', 6.9, 9);
                if AttImportL.FindFirst then begin
                    repeat
                        // lateatt+=AttImportL.TotalHrs;
                        Shortleave := 0;
                        Shortleave := 9 - AttImportL.TotalHrs;
                        if (Shortleave <> 0) and (Shortleave > 1) then
                            Shortleave_Mins += Shortleave * 60;
                        if (Shortleave <> 0) and (Shortleave < 1) then
                            SH_Minutes += Shortleave;
                        if Shortleave_Mins + SH_Minutes > 360 then begin
                            AttImportL.Deduct := Per_DayCost / 2;
                            AttImportL."Basic Deduct" := BasicAmtPerDay / 2;
                            AttImportL."HRA Deduct" := (HRAAmt / NoofDays) / 2;
                            AttImportL."Conv Deduct" := (ConvAmt / NoofDays) / 2;
                            AttImportL."Medical Deduct" := (MedicalAmt / NoofDays) / 2;
                            AttImportL."Others Deduct" := (OthersAmt / NoofDays) / 2;
                            AttImportL."Variable Deduct" := (VarAmt / NoofDays) / 2;
                            BasicHalfDay := AttImportL."Basic Deduct";
                            HRHalfDay := AttImportL."HRA Deduct";
                            ConvHalfDay := AttImportL."Conv Deduct";
                            MedicalHalfDay := AttImportL."Medical Deduct";
                            OthersHalfDay := AttImportL."Others Deduct";
                            VarHalfDay := AttImportL."Variable Deduct";
                            SalaryDeduct := AttImportL.Deduct;
                            Shortleave_Mins := 0;
                            SH_Minutes := 0;
                            AttImportL.Modify;
                        end;
                    until AttImportL.Next = 0;
                end;
                //MESSAGE('%1\%2\%3',BasicHalfDay,HRHalfDay,OthersHalfDay,ConvHalfDay,MedicalHalfDay);
                //SHORT LEAVE
                //DepartmentCode
                Clear(DepartmentName);
                Employee_DP.Reset;
                Employee_DP.SetRange(Code, "Employee Master".Department);
                if Employee_DP.FindFirst then
                    DepartmentName := Employee_DP."Dept Name";
                //DepartmentCode
                Clear(FinalBasic);
                Clear(FinalHRA);
                Clear(FinalMedi);
                Clear(Finalothr);
                Clear(FinalConv);
                Clear(FinalVar);
                FinalBasic := BasicAmtPerDayTot - BasicHalfDay;
                FinalHRA := (HRAAmt / NoofDays * Presentdays) - HRHalfDay;
                Finalothr := ((OthersAmt / NoofDays) * Presentdays) - OthersHalfDay;
                FinalMedi := ((MedicalAmt / NoofDays) * Presentdays) - MedicalHalfDay;
                FinalConv := ((ConvAmt / NoofDays) * Presentdays) - ConvHalfDay;
                FinalVar := ((VarAmt / NoofDays) * Presentdays) - VarHalfDay;
                //MESSAGE('FinalBasic %1\FinalHRA%2\Finalothr %3\FinalMedi %4\ FinalConv %5\FinalVar %6',FinalBasic,FinalHRA,Finalothr,FinalMedi,FinalConv,FinalVar);
                //jv process
                AttendanceImport_Rec.Reset;
                AttendanceImport_Rec.SetRange("Employee Id", "Employee Master".Code);
                if AttendanceImport_Rec.FindFirst then begin
                    //MESSAGE('f 0 '+FORMAT(BasicAmt));
                    PayrollSetuppb.TestField("Salary Journal Batch Name");
                    PayrollSetuppb.TestField("Salary Journal Template Name");
                    PayrollSetuppb.TestField("ESI %");
                    PayrollSetuppb.TestField("ESI Applicable Amount Upto");
                    PayrollSetuppb.TestField("ESI G/L Account No.");
                    PayrollSetuppb.TestField("ESI Bal Account No.");
                    PayrollSetuppb.TestField("PF %");
                    PayrollSetuppb.TestField("PF Applicable Amount Upto");
                    PayrollSetuppb.TestField("PF %");
                    PayrollSetuppb.TestField("PF Bal Account No.");
                    PayrollSetuppb.TestField("PF G/L Account No.");
                    GenJournalLine2.Reset;
                    GenJournalLine2.SetRange(GenJournalLine2."Journal Template Name", PayrollSetuppb."Salary Journal Template Name");
                    GenJournalLine2.SetRange(GenJournalLine2."Journal Batch Name", PayrollSetuppb."Salary Journal Batch Name");
                    GenJournalLine2.SetRange("External Document No.", "Employee Master".Code);
                    if GenJournalLine2.FindFirst then
                        repeat
                            //GenJournalLine2.DELETE;
                            ESLP.Reset;
                            ESLP.SetRange("Employee Code", "Employee Master".Code);
                            ESLP.SetRange("Period Start Date", StartDate);
                            if ESLP.FindSet then
                                ESLP.DeleteAll;
                        until GenJournalLine2.Next = 0;
                    Clear(DocNo);
                    Clear(LineNo);
                    GenJournalBatch.Reset;
                    GenJournalBatch.SetRange("Journal Template Name", PayrollSetuppb."Salary Journal Template Name");
                    GenJournalBatch.SetRange(Name, PayrollSetuppb."Salary Journal Batch Name");
                    GenJournalBatch.FindFirst;
                    GenJournalBatch.TestField("No. Series");
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", PayrollSetuppb."Salary Journal Template Name");
                    GenJournalLine.SetRange("Journal Batch Name", PayrollSetuppb."Salary Journal Batch Name");
                    if GenJournalLine.FindLast then
                        DocNo := IncStr(GenJournalLine."Document No.")
                    else
                        DocNo := NoSeriesManagement.GetNextNo(GenJournalBatch."No. Series", WorkDate, false);
                    GenJournalLine2.Reset;
                    GenJournalLine2.SetRange("Journal Template Name", PayrollSetuppb."Salary Journal Template Name");
                    GenJournalLine2.SetRange("Journal Batch Name", PayrollSetuppb."Salary Journal Batch Name");
                    if GenJournalLine2.FindLast then
                        LineNo := GenJournalLine2."Line No." + 1
                    else
                        LineNo := 10000;
                    //basic
                    // MESSAGE(FORMAT(BasicNotFound));
                    // MESSAGE(FORMAT(BasicAmt));
                    if "Employee Master".Code = 'GFM01' then
                        Message(Format(BasicAmt)); //MK2
                    if "Employee Master".Code = 'GFM01' then
                        Message(Format(Presentdays)); //MK2
                    if BasicNotFound and ((BasicAmtPerDayTot - BasicHalfDay) = 0) then begin
                        //MESSAGE(FORMAT(BasicAmtPerDayTot)+' BasicHalfDay  '+FORMAT(BasicHalfDay)+' BasicAmtPerDay '+FORMAT(BasicAmtPerDay)+' Presentdays '+FORMAT(Presentdays));
                        //(BasicAmt = 0) AND BasicNotFound AND
                        //ERROR("Employee Master".Code + ' Wait');
                    end;
                    //IF Presentdays<>0 THEN
                    //MESSAGE(FORMAT(BasicAmt));
                    //   IF BasicAmt<>0 THEN BEGIN
                    GenJournalLine3.Init;
                    GenJournalLine3."Journal Template Name" := PayrollSetuppb."Salary Journal Template Name";
                    GenJournalLine3."Journal Batch Name" := PayrollSetuppb."Salary Journal Batch Name";
                    GenJournalLine3."Document No." := DocNo;
                    GenJournalLine3."Line No." := LineNo;
                    GenJournalLine3.Validate("Account Type", GenJournalLine."account type"::"G/L Account");
                    GenJournalLine3.Validate("Account No.", BasicGlAcc);
                    GenJournalLine3.Validate("Debit Amount", BasicAmtPerDayTot - BasicHalfDay);
                    GenJournalLine3.Validate("Bal. Account Type", GenJournalLine."bal. account type"::"G/L Account");
                    GenJournalLine3.Validate("Bal. Account No.", BasicBalAcc);
                    /*
                      ShortcutDimCode[3]:=DepartmentName;
                      GenJournalLine3.ValidateShortcutDimCode(3,ShortcutDimCode[3]);
                      ShortcutDimCode[4]:="Employee Master".Code;
                      GenJournalLine3.ValidateShortcutDimCode(4,ShortcutDimCode[4]);
                      */
                    GenJournalLine3."Posting Date" := WorkDate;
                    GenJournalLine3."External Document No." := Format("Employee Master".Code) + '-' + "Employee Master"."First Name" + ' ' + "Employee Master"."Last Name";
                    GenJournalLine3.Insert;
                    //basic
                    //  END;
                    //hraamt
                    if HRAAmt <> 0 then begin
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := PayrollSetuppb."Salary Journal Template Name";
                        GenJournalLine."Journal Batch Name" := PayrollSetuppb."Salary Journal Batch Name";
                        GenJournalLine."Document No." := DocNo;
                        GenJournalLine."Line No." := LineNo + 200;
                        GenJournalLine.Validate("Account Type", GenJournalLine."account type"::"G/L Account");
                        GenJournalLine.Validate("Account No.", HRGlacc);
                        GenJournalLine.Validate("Debit Amount", ((HRAAmt / NoofDays) * Presentdays) - HRHalfDay);
                        GenJournalLine.Validate("Bal. Account Type", GenJournalLine."bal. account type"::"G/L Account");
                        GenJournalLine.Validate("Bal. Account No.", HRBalacc);
                        ShortcutDimCode[3] := DepartmentName;
                        GenJournalLine.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                        ShortcutDimCode[4] := "Employee Master".Code;
                        GenJournalLine.ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                        GenJournalLine."Posting Date" := WorkDate;
                        GenJournalLine."External Document No." := Format("Employee Master".Code) + '-' + "Employee Master"."First Name" + ' ' + "Employee Master"."Last Name";
                        GenJournalLine.Insert;
                    end;
                    //hramt
                    //pf amount
                    if ("Employee Master"."PF No." <> '') and (BasicAmt <= PayrollSetuppb."PF Applicable Amount Upto") and ("Employee Master"."PF Applicable" = true) then begin
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := PayrollSetuppb."Salary Journal Template Name";
                        GenJournalLine."Journal Batch Name" := PayrollSetuppb."Salary Journal Batch Name";
                        GenJournalLine."Document No." := DocNo;
                        GenJournalLine."Line No." := LineNo + 300;
                        GenJournalLine.Validate("Account Type", GenJournalLine."account type"::"G/L Account");
                        GenJournalLine.Validate("Account No.", PayrollSetuppb."PF G/L Account No.");
                        GenJournalLine.Validate("Credit Amount", (FinalBasic * PayrollSetuppb."PF %") / 100);
                        GenJournalLine.Validate("Bal. Account Type", GenJournalLine."bal. account type"::"G/L Account");
                        GenJournalLine.Validate("Bal. Account No.", PayrollSetuppb."PF Bal Account No.");
                        ShortcutDimCode[3] := DepartmentName;
                        GenJournalLine.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                        ShortcutDimCode[4] := "Employee Master".Code;
                        GenJournalLine.ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                        GenJournalLine."Posting Date" := WorkDate;
                        GenJournalLine."External Document No." := Format("Employee Master".Code) + '-' + "Employee Master"."First Name" + ' ' + "Employee Master"."Last Name";
                        GenJournalLine.Insert;
                    end;
                    //pf amount
                    //esi
                    if ("Employee Master"."ESI Applicable" = true) and (BasicAmt + HRAAmt + ConvAmt + OthersAmt + MedicalAmt <= PayrollSetuppb."ESI Applicable Amount Upto") then begin
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := PayrollSetuppb."Salary Journal Template Name";
                        ;
                        GenJournalLine."Journal Batch Name" := PayrollSetuppb."Salary Journal Batch Name";
                        //GenJournalLine."Journal Batch Name":=;
                        GenJournalLine."Document No." := DocNo;
                        GenJournalLine."Line No." := LineNo + 400;
                        GenJournalLine.Validate("Account Type", GenJournalLine."account type"::"G/L Account");
                        GenJournalLine.Validate("Account No.", PayrollSetuppb."ESI G/L Account No.");
                        GenJournalLine.Validate("Credit Amount", ((FinalBasic + FinalConv + FinalHRA + FinalMedi + Finalothr) * PayrollSetuppb."ESI %") / 100);
                        GenJournalLine.Validate("Bal. Account Type", GenJournalLine."bal. account type"::"G/L Account");
                        GenJournalLine.Validate("Bal. Account No.", PayrollSetuppb."ESI Bal Account No.");
                        ShortcutDimCode[3] := DepartmentName;
                        GenJournalLine.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                        ShortcutDimCode[4] := "Employee Master".Code;
                        GenJournalLine.ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                        GenJournalLine."Posting Date" := WorkDate;
                        GenJournalLine."External Document No." := Format("Employee Master".Code) + '-' + "Employee Master"."First Name" + ' ' + "Employee Master"."Last Name";
                        GenJournalLine.Insert;
                    end;
                    //esi
                    //conv
                    if ConvAmt <> 0 then begin
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := PayrollSetuppb."Salary Journal Template Name";
                        ;
                        GenJournalLine."Journal Batch Name" := PayrollSetuppb."Salary Journal Batch Name";
                        //GenJournalLine."Journal Batch Name":=;
                        GenJournalLine."Document No." := DocNo;
                        GenJournalLine."Line No." := LineNo + 500;
                        GenJournalLine.Validate("Account Type", GenJournalLine."account type"::"G/L Account");
                        GenJournalLine.Validate("Account No.", ConvGlacc);
                        GenJournalLine.Validate("Debit Amount", ((ConvAmt / NoofDays) * Presentdays) - ConvHalfDay);
                        GenJournalLine.Validate("Bal. Account Type", GenJournalLine."bal. account type"::"G/L Account");
                        GenJournalLine.Validate("Bal. Account No.", ConvGlBalAccNo);
                        ShortcutDimCode[3] := DepartmentName;
                        GenJournalLine.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                        ShortcutDimCode[4] := "Employee Master".Code;
                        GenJournalLine.ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                        GenJournalLine."Posting Date" := WorkDate;
                        GenJournalLine."External Document No." := Format("Employee Master".Code) + '-' + "Employee Master"."First Name" + ' ' + "Employee Master"."Last Name";
                        GenJournalLine.Insert;
                        //MESSAGE('convamtinsert');
                    end;
                    //conv
                    //medical
                    if MedicalAmt <> 0 then begin
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := PayrollSetuppb."Salary Journal Template Name";
                        ;
                        GenJournalLine."Journal Batch Name" := PayrollSetuppb."Salary Journal Batch Name";
                        //GenJournalLine."Journal Batch Name":=;
                        GenJournalLine."Document No." := DocNo;
                        GenJournalLine."Line No." := LineNo + 600;
                        GenJournalLine.Validate("Account Type", GenJournalLine."account type"::"G/L Account");
                        GenJournalLine.Validate("Account No.", MedGlAcc);
                        GenJournalLine.Validate("Debit Amount", ((MedicalAmt / NoofDays) * Presentdays) - MedicalHalfDay);
                        GenJournalLine.Validate("Bal. Account Type", GenJournalLine."bal. account type"::"G/L Account");
                        GenJournalLine.Validate("Bal. Account No.", MedBallGLAcc);
                        ShortcutDimCode[3] := DepartmentName;
                        GenJournalLine.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                        ShortcutDimCode[4] := "Employee Master".Code;
                        GenJournalLine.ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                        GenJournalLine."Posting Date" := WorkDate;
                        GenJournalLine."External Document No." := Format("Employee Master".Code) + '-' + "Employee Master"."First Name" + ' ' + "Employee Master"."Last Name";
                        GenJournalLine.Insert;
                    end;
                    //medical
                    //OTHERS
                    if OthersAmt <> 0 then begin
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := PayrollSetuppb."Salary Journal Template Name";
                        ;
                        GenJournalLine."Journal Batch Name" := PayrollSetuppb."Salary Journal Batch Name";
                        //GenJournalLine."Journal Batch Name":=;
                        GenJournalLine."Document No." := DocNo;
                        GenJournalLine."Line No." := LineNo + 700;
                        GenJournalLine.Validate("Account Type", GenJournalLine."account type"::"G/L Account");
                        GenJournalLine.Validate("Account No.", OthersGlAcc);
                        GenJournalLine.Validate("Debit Amount", ((OthersAmt / NoofDays) * Presentdays) - OthersHalfDay);
                        GenJournalLine.Validate("Bal. Account Type", GenJournalLine."bal. account type"::"G/L Account");
                        GenJournalLine.Validate("Bal. Account No.", OthersGlBalAcc);
                        ShortcutDimCode[3] := DepartmentName;
                        GenJournalLine.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                        ShortcutDimCode[4] := "Employee Master".Code;
                        GenJournalLine.ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                        GenJournalLine."Posting Date" := WorkDate;
                        GenJournalLine."External Document No." := Format("Employee Master".Code) + '-' + "Employee Master"."First Name" + ' ' + "Employee Master"."Last Name";
                        GenJournalLine.Insert;
                    end;
                    //OTHERS
                    //variable
                    if VarAmt <> 0 then begin
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := PayrollSetuppb."Salary Journal Template Name";
                        ;
                        GenJournalLine."Journal Batch Name" := PayrollSetuppb."Salary Journal Batch Name";
                        //GenJournalLine."Journal Batch Name":=;
                        GenJournalLine."Document No." := DocNo;
                        GenJournalLine."Line No." := LineNo + 900;
                        GenJournalLine.Validate("Account Type", GenJournalLine."account type"::"G/L Account");
                        GenJournalLine.Validate("Account No.", VariableGl);
                        GenJournalLine.Validate("Debit Amount", ((VarAmt / NoofDays) * Presentdays) - VarHalfDay);
                        GenJournalLine.Validate("Bal. Account Type", GenJournalLine."bal. account type"::"G/L Account");
                        GenJournalLine.Validate("Bal. Account No.", VariableBalGLAcc);
                        ShortcutDimCode[3] := DepartmentName;
                        GenJournalLine.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                        ShortcutDimCode[4] := "Employee Master".Code;
                        GenJournalLine.ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                        GenJournalLine."Posting Date" := WorkDate;
                        GenJournalLine."External Document No." := Format("Employee Master".Code) + '-' + "Employee Master"."First Name" + ' ' + "Employee Master"."Last Name";
                        GenJournalLine.Insert;
                    end;
                    //variable
                    //overtime
                    if (OvertimeAmt <> 0) and ("Employee Master"."Overtime Given" = true) then begin
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := PayrollSetuppb."Salary Journal Template Name";
                        ;
                        GenJournalLine."Journal Batch Name" := PayrollSetuppb."Salary Journal Batch Name";
                        //GenJournalLine."Journal Batch Name":=;
                        GenJournalLine."Document No." := DocNo;
                        GenJournalLine."Line No." := LineNo + 800;
                        GenJournalLine.Validate("Account Type", GenJournalLine."account type"::"G/L Account");
                        GenJournalLine.Validate("Account No.", PayrollSetuppb.OvertimeGlAcc);
                        GenJournalLine.Validate("Debit Amount", OvertimeAmt);
                        GenJournalLine.Validate("Bal. Account Type", GenJournalLine."bal. account type"::"G/L Account");
                        GenJournalLine.Validate("Bal. Account No.", PayrollSetuppb.OvertimeBalGlAcc);
                        ShortcutDimCode[3] := DepartmentName;
                        GenJournalLine.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                        ShortcutDimCode[4] := "Employee Master".Code;
                        GenJournalLine.ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                        GenJournalLine."Posting Date" := WorkDate;
                        GenJournalLine."External Document No." := Format("Employee Master".Code) + '-' + "Employee Master"."First Name" + ' ' + "Employee Master"."Last Name";
                        GenJournalLine.Insert;
                    end;
                end;
                //EMPLOYESS SALARY LEDGER
                //IF BasicAmt<>0 THEN BEGIN //MK
                //MESSAGE(FORMAT(BasicAmtPerDayTot)+'   '+FORMAT(BasicHalfDay));
                if ((BasicAmtPerDayTot - BasicHalfDay) = 0) and BasicNotFound and not AttNotFound then
                    Message("Employee Master".Code);
                EmployeeSalaryLedgerPBTPL.Init;
                EmployeeSalaryLedgerPBTPL.Validate("Employee Code", "Employee Master".Code);
                EmployeeSalaryLedgerPBTPL.Validate("Employee Name", "Employee Master"."First Name");
                EmployeeSalaryLedgerPBTPL.Validate("Period Start Date", StartDate);
                EmployeeSalaryLedgerPBTPL.Validate("Period End Date", EndDate);
                EmployeeSalaryLedgerPBTPL.Validate("Pay Head", 'BASIC');
                EmployeeSalaryLedgerPBTPL.Validate(Amount, BasicAmtPerDayTot - BasicHalfDay);
                EmployeeSalaryLedgerPBTPL.Validate("User ID", UserId);
                EmployeeSalaryLedgerPBTPL.Validate("Creation Date and Time", CurrentDatetime);
                EmployeeSalaryLedgerPBTPL.Validate("Montly Present Day", (Present_slip + (HalfDays / 2)));
                EmployeeSalaryLedgerPBTPL.Validate("Monthly holidays", holidayPresent);
                EmployeeSalaryLedgerPBTPL.Validate("Monthly Off Day", weekdaysPresent);
                EmployeeSalaryLedgerPBTPL.Validate("Monthy Extra Day", LeaveCalculation);
                EmployeeSalaryLedgerPBTPL.Insert;
                //END;
                if HRAAmt <> 0 then begin
                    EmployeeSalaryLedger.Init;
                    EmployeeSalaryLedger.Validate("Employee Code", "Employee Master".Code);
                    EmployeeSalaryLedger.Validate("Employee Name", "Employee Master"."First Name");
                    EmployeeSalaryLedger.Validate("Period Start Date", StartDate);
                    EmployeeSalaryLedger.Validate("Period End Date", EndDate);
                    EmployeeSalaryLedger.Validate("Pay Head", 'HRA');
                    EmployeeSalaryLedger.Validate(Amount, ((HRAAmt / NoofDays) * Presentdays) - HRHalfDay);
                    EmployeeSalaryLedger.Validate("User ID", UserId);
                    EmployeeSalaryLedger.Validate("Creation Date and Time", CurrentDatetime);
                    EmployeeSalaryLedger.Insert;
                end;
                if MedicalAmt <> 0 then begin
                    EmployeeSalaryLedgerPBTPL.Init;
                    EmployeeSalaryLedgerPBTPL.Validate("Employee Code", "Employee Master".Code);
                    EmployeeSalaryLedgerPBTPL.Validate("Employee Name", "Employee Master"."First Name");
                    EmployeeSalaryLedgerPBTPL.Validate("Period Start Date", StartDate);
                    EmployeeSalaryLedgerPBTPL.Validate("Period End Date", EndDate);
                    EmployeeSalaryLedgerPBTPL.Validate("Pay Head", 'MEDICAL');
                    EmployeeSalaryLedgerPBTPL.Validate(Amount, ((MedicalAmt / NoofDays) * Presentdays) - MedicalHalfDay);
                    EmployeeSalaryLedgerPBTPL.Validate("User ID", UserId);
                    EmployeeSalaryLedgerPBTPL.Validate("Creation Date and Time", CurrentDatetime);
                    EmployeeSalaryLedgerPBTPL.Insert;
                end;
                if ConvAmt <> 0 then begin
                    EmployeeSalaryLedger_conv.Init;
                    EmployeeSalaryLedger_conv.Validate("Employee Code", "Employee Master".Code);
                    EmployeeSalaryLedger_conv.Validate("Employee Name", "Employee Master"."First Name");
                    EmployeeSalaryLedger_conv.Validate("Period Start Date", StartDate);
                    EmployeeSalaryLedger_conv.Validate("Period End Date", EndDate);
                    EmployeeSalaryLedger_conv.Validate("Pay Head", 'CONV.');
                    EmployeeSalaryLedger_conv.Validate(Amount, ((ConvAmt / NoofDays) * Presentdays) - ConvHalfDay);
                    EmployeeSalaryLedger_conv.Validate("User ID", UserId);
                    EmployeeSalaryLedger_conv.Validate("Creation Date and Time", CurrentDatetime);
                    EmployeeSalaryLedger_conv.Insert;
                end;
                if OthersAmt <> 0 then begin
                    EmployeeSalaryLedgerPBTPL.Init;
                    EmployeeSalaryLedgerPBTPL.Validate("Employee Code", "Employee Master".Code);
                    EmployeeSalaryLedgerPBTPL.Validate("Employee Name", "Employee Master"."First Name");
                    EmployeeSalaryLedgerPBTPL.Validate("Period Start Date", StartDate);
                    EmployeeSalaryLedgerPBTPL.Validate("Period End Date", EndDate);
                    EmployeeSalaryLedgerPBTPL.Validate("Pay Head", 'OTHER');
                    EmployeeSalaryLedgerPBTPL.Validate(Amount, ((OthersAmt / NoofDays) * Presentdays) - OthersHalfDay);
                    EmployeeSalaryLedgerPBTPL.Validate("User ID", UserId);
                    EmployeeSalaryLedgerPBTPL.Validate("Creation Date and Time", CurrentDatetime);
                    EmployeeSalaryLedgerPBTPL.Insert;
                end;
                if VarAmt <> 0 then begin
                    //IF  THEN BEGIN
                    EmployeeSalaryLedgerPBTPL.Init;
                    EmployeeSalaryLedgerPBTPL.Validate("Employee Code", "Employee Master".Code);
                    EmployeeSalaryLedgerPBTPL.Validate("Employee Name", "Employee Master"."First Name");
                    EmployeeSalaryLedgerPBTPL.Validate("Period Start Date", StartDate);
                    EmployeeSalaryLedgerPBTPL.Validate("Period End Date", EndDate);
                    EmployeeSalaryLedgerPBTPL.Validate("Pay Head", 'VARIABLE');
                    EmployeeSalaryLedgerPBTPL.Validate(Amount, ((VarAmt / NoofDays) * Presentdays) - VarHalfDay);
                    EmployeeSalaryLedgerPBTPL.Validate("User ID", UserId);
                    EmployeeSalaryLedgerPBTPL.Validate("Creation Date and Time", CurrentDatetime);
                    EmployeeSalaryLedgerPBTPL.Insert;
                end;
                //END;
                //OverTime
                //IF  THEN BEGIN
                if (OvertimeAmt <> 0) and ("Employee Master"."Overtime Given" = true) then begin
                    EmployeeSalaryLedgerPBTPL.Init;
                    EmployeeSalaryLedgerPBTPL.Validate("Employee Code", "Employee Master".Code);
                    EmployeeSalaryLedgerPBTPL.Validate("Employee Name", "Employee Master"."First Name");
                    EmployeeSalaryLedgerPBTPL.Validate("Period Start Date", StartDate);
                    EmployeeSalaryLedgerPBTPL.Validate("Period End Date", EndDate);
                    EmployeeSalaryLedgerPBTPL.Validate("Pay Head", 'INSENTIVE');
                    EmployeeSalaryLedgerPBTPL.Validate(Amount, OvertimeAmt);
                    EmployeeSalaryLedgerPBTPL.Validate("User ID", UserId);
                    EmployeeSalaryLedgerPBTPL.Validate("Creation Date and Time", CurrentDatetime);
                    EmployeeSalaryLedgerPBTPL.Insert;
                end;
                //OverTime
                if ("Employee Master"."PF No." <> '') and (BasicAmt <= PayrollSetuppb."PF Applicable Amount Upto") and ("Employee Master"."PF Applicable" = true) then begin
                    EmployeeSalaryLedgerPBTPL.Init;
                    EmployeeSalaryLedgerPBTPL.Validate("Employee Code", "Employee Master".Code);
                    EmployeeSalaryLedgerPBTPL.Validate("Employee Name", "Employee Master"."First Name");
                    EmployeeSalaryLedgerPBTPL.Validate("Period Start Date", StartDate);
                    EmployeeSalaryLedgerPBTPL.Validate("Period End Date", EndDate);
                    EmployeeSalaryLedgerPBTPL.Validate("Pay Head", 'PF');
                    EmployeeSalaryLedgerPBTPL.Validate(Amount, (FinalBasic * PayrollSetuppb."PF %") / 100);
                    EmployeeSalaryLedgerPBTPL.Validate("User ID", UserId);
                    EmployeeSalaryLedgerPBTPL.Validate("Creation Date and Time", CurrentDatetime);
                    EmployeeSalaryLedgerPBTPL.Insert;
                end;
                if ("Employee Master"."ESI Applicable" = true) and (BasicAmt + HRAAmt + ConvAmt + OthersAmt + MedicalAmt <= PayrollSetuppb."ESI Applicable Amount Upto") then begin
                    EmployeeSalaryLedgerPBTPL.Init;
                    EmployeeSalaryLedgerPBTPL.Validate("Employee Code", "Employee Master".Code);
                    EmployeeSalaryLedgerPBTPL.Validate("Employee Name", "Employee Master"."First Name");
                    EmployeeSalaryLedgerPBTPL.Validate("Period Start Date", StartDate);
                    EmployeeSalaryLedgerPBTPL.Validate("Period End Date", EndDate);
                    EmployeeSalaryLedgerPBTPL.Validate("Pay Head", 'ESI');
                    EmployeeSalaryLedgerPBTPL.Validate(Amount, ROUND(((FinalBasic + FinalConv + FinalHRA + FinalMedi + Finalothr) * PayrollSetuppb."ESI %") / 100, 1, '>'));
                    EmployeeSalaryLedgerPBTPL.Validate("User ID", UserId);
                    EmployeeSalaryLedgerPBTPL.Validate("Creation Date and Time", CurrentDatetime);
                    EmployeeSalaryLedgerPBTPL.Insert;
                end;
                //EMPLOYESS SALARY LEDGER
                //MESSAGE('Data Upload \ PLlease go to General Journals');
                // CLEAR(GeneralJournal);
                // GJL.RESET;
                // GJL.SETRANGE("Journal Template Name",PayrollSetuppb."Salary Journal Template Name");
                // GJL.SETRANGE("Journal Batch Name",PayrollSetuppb."Salary Journal Batch Name");
                // IF GJL.FINDFIRST THEN BEGIN
                //  GeneralJournal.SETTABLEVIEW(GJL);
                //  GeneralJournal.RUN;
                // END;
                // END;
                //overtime
                //jv process

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
                field(EmployeeCode; EmployeeCode)
                {
                    ApplicationArea = Basic;
                    TableRelation = "Employee Master".Code;
                }
                field(StartDate; StartDate)
                {
                    ApplicationArea = Basic;
                }
                field(EndDate; EndDate)
                {
                    ApplicationArea = Basic;
                }
                field(OvertimeCalculation; OvertimeCalculation)
                {
                    ApplicationArea = Basic;
                }

            }
        }

        actions
        {
        }
    }



    trigger OnPostReport()
    begin
        Message('Data Upload Please go GenJournals');

    end;

    trigger OnPreReport()
    begin
        NoofDays := 0;
        if StartDate = 0D then
            Error('Period Start Date must have a Value.');
        if EndDate = 0D then
            Error('Period End Date must have a Value.');
        //NoofDays := DATE2DMY(EndDate,1);
        NoofDays := Date2dmy(CalcDate('CM', Dmy2date(1, Date2dmy(StartDate, 2), Date2dmy(StartDate, 3))), 1);

    end;

    var
        EmployeeCode: Code[30];
        StartDate: Date;
        EndDate: Date;
        AttendanceImport: Record "Attendance Import-att";
        AttendanceImport12: Record "Attendance Import-att";
        AttendanceImport13: Record "Attendance Import-att";
        Presentdays: Decimal;
        NoofDays: Integer;
        EmployeeSalaryDetails: Record "Employee Salary Details-PBTPL";
        EMPsalarydt: Record "Employee Salary Details-PBTPL";
        EMPSal_Rec: Record "Employee Salary Details-PBTPL";
        BasicAmt: Decimal;
        HRAAmt: Decimal;
        VarHalfDay: Decimal;
        VarAmt: Decimal;
        EmpSalary: Record "Employee Salary Details-PBTPL";
        FinalVar: Decimal;
        Totalsalary: Decimal;
        Per_DayCost: Decimal;
        WorkingDays: Decimal;
        GenJournalBatch: Record "Gen. Journal Batch";
        GenJournalLine: Record "Gen. Journal Line";
        Overtimehrs: Decimal;
        VariableGl: Code[30];
        VariableBalGLAcc: Code[30];
        DocNo: Code[30];
        NoSeriesManagement: Codeunit NoSeriesManagement;
        GenJournalLine2: Record "Gen. Journal Line";
        GenJournalLine4: Record "Gen. Journal Line";
        LineNo: Integer;
        GenJournalLine3: Record "Gen. Journal Line";
        AttendanceImport1: Record "Attendance Import-att";
        BasicAmtPerDay: Decimal;
        BasicAmtPerDayTot: Decimal;
        PayHead: Record "Pay Head-PBTPL(Payroll)";
        BasicGlAcc: Code[20];
        HRGlacc: Code[20];
        BasicBalAcc: Code[20];
        HRBalacc: Code[20];
        EmployeeMaster: Record "Employee Master";
        PFAmt: Decimal;
        PayrollSetuppb: Record "Payroll Setup-PBTPL";
        ConvAmt: Decimal;
        ConvGlacc: Code[20];
        ConvGlBalAccNo: Code[20];
        OthersAmt: Decimal;
        OthersGlAcc: Code[20];
        OthersGlBalAcc: Code[20];
        MedicalAmt: Decimal;
        MedGlAcc: Code[10];
        MedBallGLAcc: Code[10];
        HalfDays: Integer;
        PerMinuteSalary: Decimal;
        PerHoursalary: Decimal;
        Duration_: Decimal;
        TotalHalfDur_: Decimal;
        OvertimeCalculation: Boolean;
        AtttImport: Record "Attendance Import-att";
        AtttImport_Week: Record "Attendance Import-att";
        OvertimeAmt: Decimal;
        AttImportL: Record "Attendance Import-att";
        lateatt: Integer;
        EmpMaster: Record "Employee Master";
        Shortleave: Decimal;
        Shortleave_Mins: Decimal;
        AttendanceImport_Rec: Record "Attendance Import-att";
        AttendanceImport_RecLeave: Record "Attendance Import-att";
        LeaveCalculation: Decimal;
        SalaryDeduct: Decimal;
        EMPsalarydt12_: Record "Employee Salary Details-PBTPL";
        BasicHalfDay: Decimal;
        HRHalfDay: Decimal;
        ConvHalfDay: Decimal;
        MedicalHalfDay: Decimal;
        OthersHalfDay: Decimal;
        SH_Minutes: Decimal;
        DteName: Integer;
        weekdaysPresent: Decimal;
        WeekdaySalary: Decimal;
        RoundingMethod: Record "Rounding Method";
        holidaysListPBTPL: Record "Holidays List-PBTPL";
        holidayPresent: Decimal;
        Wekdayname: Option Sunday,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday;
        FinalBasic: Decimal;
        FinalHRA: Decimal;
        FinalConv: Decimal;
        FinalMedi: Decimal;
        Finalothr: Decimal;
        EmployeeSalaryLedgerPBTPL: Record "Employee Salary Ledger-PBTPL";
        EmployeeSalaryLedger: Record "Employee Salary Ledger-PBTPL";
        EmployeeSalaryLedger_conv: Record "Employee Salary Ledger-PBTPL";
        EmployeeSalaryLedger_med: Record "Employee Salary Ledger-PBTPL";
        EmployeeSalaryLedger_others: Record "Employee Salary Ledger-PBTPL";
        Present_slip: Decimal;
        TotaldaysPre: Decimal;
        VarHalf: Decimal;
        GeneralJournal: Page "General Journal";
        GJL: Record "Gen. Journal Line";
        ESLP: Record "Employee Salary Ledger-PBTPL";
        LeaveDetails: Record "Leave Details";
        ApprovedLeave: Integer;
        RoundValueESI: Text;
        Employee_DP: Record "Emp Department-pb";
        ShortcutDimCode: array[8] of Code[20];
        DepartmentName: Text;
        BasicNotFound: Boolean;
        AttNotFound: Boolean;


}
