Table 50050 "Pay Head-PBTPL(Payroll)"
{
    DrillDownPageID = "Pay Head";
    LookupPageID = "Pay Head";

    fields
    {
        field(1; "Code"; Code[50])
        {
        }
        field(2; Type; Option)
        {
            OptionCaption = ' ,Deduction From Employees,Earning for Employees,Employees Statutory Deduction,Employer''s Statutory Contribution,Gratuity,Loans And Advances,Reimbursements to Employee';
            OptionMembers = " ","Deduction From Employees","Earning for Employees","Employees Statutory Deduction","Employer's Statutory Contribution",Gratuity,"Loans And Advances","Reimbursements to Employee";
        }
        field(3; "Income Type"; Option)
        {
            OptionCaption = 'Fixed,Variable';
            OptionMembers = "Fixed",Variable;
        }
        field(4; "G/L Account"; Code[10])
        {
            TableRelation = "G/L Account";
        }
        field(5; "Statutory Pay Type"; Option)
        {
            OptionCaption = ' ,Employee State Insurance,Income Tax,National Pension Scheme (Tier - I),National Pension Scheme (Tier - II),PF Account (A/c No. 1),Professional Tax,Voluntary PF (A/c No. 1)';
            OptionMembers = " ","Employee State Insurance","Income Tax","National Pension Scheme (Tier - I)","National Pension Scheme (Tier - II)","PF Account (A/c No. 1)","Professional Tax","Voluntary PF (A/c No. 1)";
        }
        field(10; "Affect Net Salary"; Boolean)
        {
        }
        field(15; "Use for Gratuity"; Boolean)
        {
        }
        field(20; "Calculation Type"; Option)
        {
            OptionCaption = 'On Attendance,Flat Rate';
            OptionMembers = "On Attendance","Flat Rate";
        }
        field(21; "Leave Type"; Option)
        {
            OptionCaption = ' ,Leave With Pay, Leave Without Pay';
            OptionMembers = " ","Leave With Pay"," Leave Without Pay";
        }
        field(30; Compute; Option)
        {
            OptionCaption = ' ,On Current Deductions Total,On Current Earning Total,On Current Sub Total,On Specified Formula';
            OptionMembers = " ","On Current Deductions Total","On Current Earning Total","On Current Sub Total","On Specified Formula";
        }
        field(31; "Balance Account No."; Code[10])
        {
            TableRelation = "G/L Account";
        }
        field(50; "End Date Mandatory"; Boolean)
        {
        }
        field(51; "Include In Salary"; Boolean)
        {
        }
        field(100; "Wages G/L Account"; Code[10])
        {
            TableRelation = "G/L Account";
        }
        field(101; "Wages Balance Account No."; Code[10])
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
        key(Key2; Type)
        {
        }
    }

    fieldgroups
    {
    }
}

