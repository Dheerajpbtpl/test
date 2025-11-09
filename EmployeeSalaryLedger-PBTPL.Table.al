Table 50057 "Employee Salary Ledger-PBTPL"
{

    fields
    {
        field(1; "Employee Code"; Code[20])
        {
            TableRelation = "Employee Master".Code;
        }
        field(2; "Employee Name"; Text[50])
        {
        }
        field(3; "Period Start Date"; Date)
        {
        }
        field(4; "Period End Date"; Date)
        {
        }
        field(10; "Pay Head"; Code[50])
        {

            trigger OnValidate()
            begin
                if PayHeadMaster.Get("Pay Head") then begin
                    "Calculation Type" := PayHeadMaster."Calculation Type";
                    "Pay Head Type" := PayHeadMaster.Type;
                end else begin
                    "Pay Head Type" := 0;
                end;
            end;
        }
        field(11; "Pay Head Type"; Option)
        {
            OptionCaption = ' ,Deduction From Employees,Earning for Employees,Employees Statutory Deduction,Employer''s Statutory Contribution,Gratuity,Loans And Advances,Reimbursements to Employee';
            OptionMembers = " ","Deduction From Employees","Earning for Employees","Employees Statutory Deduction","Employer's Statutory Contribution",Gratuity,"Loans And Advances","Reimbursements to Employee";
        }
        field(15; "Calculation Type"; Option)
        {
            OptionCaption = 'On Attendance,Flat Rate';
            OptionMembers = "On Attendance","Flat Rate";
        }
        field(16; Amount; Decimal)
        {
        }
        field(17; "OverTime Entry"; Boolean)
        {
        }
        field(100; "Loan/Adv Document No."; Code[50])
        {
        }
        field(101; "Account No."; Code[20])
        {
        }
        field(102; "Bal. Account No."; Code[20])
        {
        }
        field(103; "Processing Date"; Date)
        {
        }
        field(104; "User ID"; Code[50])
        {
        }
        field(105; "Creation Date and Time"; DateTime)
        {
        }
        field(50109; "Salary Wages Code"; Option)
        {
            OptionCaption = ' ,D01,D03,D04,D06,D07';
            OptionMembers = " ",D01,D03,D04,D06,D07;
        }
        field(50110; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50111; "Montly Present Day"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50112; "Monthly Off Day"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50113; "Monthy Extra Day"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50114; "Monthly holidays"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Employee Code", "Period Start Date", "Period End Date", "Pay Head", "Loan/Adv Document No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if Posted = true then
            Error('You can''t delete posted document.');
    end;

    trigger OnInsert()
    begin
        "User ID" := UserId;
        "Creation Date and Time" := CurrentDatetime;
    end;

    var
        PayHeadMaster: Record "Pay Head-PBTPL(Payroll)";
}

