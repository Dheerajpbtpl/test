Table 50051 "Employee Salary Details-PBTPL"
{

    fields
    {
        field(1; "Employee No."; Code[20])
        {

            trigger OnValidate()
            begin
                if EmployeeMaster.Get("Employee No.") then begin
                    "Employee Name" := EmployeeMaster."First Name";
                    Division := EmployeeMaster.Designation;
                end else begin
                    "Employee Name" := '';
                    Division := '';
                end;
            end;
        }
        field(2; "Employee Name"; Text[50])
        {

            trigger OnValidate()
            begin
                "Employee Name" := UpperCase("Employee Name");
            end;
        }
        field(3; "Effective Date"; Date)
        {
        }
        field(10; "Pay Head"; Code[50])
        {
            TableRelation = "Pay Head-PBTPL(Payroll)".Code;

            trigger OnValidate()
            begin
                if PayHeadMaster.Get("Pay Head") then begin
                    "Calculation Type" := PayHeadMaster."Calculation Type";
                    "Pay Head Type" := PayHeadMaster.Type;
                    "G/L Account" := PayHeadMaster."G/L Account";
                    "Include In Salary" := PayHeadMaster."Include In Salary";
                    if "End Date" = 0D then
                        if PayHeadMaster."End Date Mandatory" then
                            Error('Please insert End Date.')
                end else begin
                    "Pay Head Type" := 0;
                    "G/L Account" := '';
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
        field(16; "G/L Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(20; Rate; Decimal)
        {
        }
        field(30; "End Date"; Date)
        {

            trigger OnValidate()
            begin
                if "End Date" < "Effective Date" then
                    Error('End Date should be greater than effective date.');
            end;
        }
        field(51; "Include In Salary"; Boolean)
        {
            Editable = false;
        }
        field(100; Remark; Text[100])
        {
        }
        field(101; Division; Text[50])
        {

            trigger OnValidate()
            begin
                Division := Division;
            end;
        }
    }

    keys
    {
        key(Key1; "Employee No.", "Effective Date", "Pay Head", "End Date")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        EmployeeMaster: Record "Employee Master";
        PayHeadMaster: Record "Pay Head-PBTPL(Payroll)";
}

