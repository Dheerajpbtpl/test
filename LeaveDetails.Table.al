Table 50065 "Leave Details"
{

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Employee Master".Code;

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
        field(2; "Leave Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Leave Type-PBTPL".ID;
        }
        field(3; "Starting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Ending Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField("Starting Date");
                TestField("Ending Date");
                if ("Starting Date" > 0D) and ("Ending Date" > 0D) then
                    "Leave Days" := ("Ending Date" - "Starting Date") + 1
                else
                    "Leave Days" := 0;

                if Date2dmy("Starting Date", 2) <> Date2dmy("Ending Date", 2) then
                    Error('Starting Date and Endding Date must be same month.');

                if Date2dmy("Starting Date", 2) < 4 then
                    Year3 := Date2dmy("Starting Date", 3) - 1
                else
                    Year3 := Date2dmy("Starting Date", 3);
                FinanYear := Dmy2date(1, 4, Year3);

                TestField("Leave Type");
                LeaveDetails.Reset;
                LeaveDetails.SetRange("Employee No.", "Employee No.");
                LeaveDetails.SetRange("Leave Type", "Leave Type");
                LeaveDetails.SetRange("Leave With Pay", true);
                LeaveDetails.SetRange("Starting Date", FinanYear, "Starting Date" - 1);
                LeaveDetails.CalcSums("Leave Days");

                LeaveTypeDefine.Reset;
                LeaveTypeDefine.SetRange("Employee No.", "Employee No.");
                LeaveTypeDefine.SetRange("Leave Type", "Leave Type");
                if LeaveTypeDefine.FindFirst then
                    if LeaveTypeDefine."Leave Allow Days" < (LeaveDetails."Leave Days" + "Leave Days") then
                        Error('Leave with pay limit days alreay consumed.');
            end;
        }
        field(10; "Leave With Pay"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            InitValue = true;
        }
        field(50; "Employee Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(51; Division; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(52; "Leave Days"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Employee No.", "Leave Type", "Starting Date")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        EmployeeMaster: Record "Employee Master";
        FinanYear: Date;
        Year3: Integer;
        LeaveDetails: Record "Leave Details";
        LeaveTypeDefine: Record "Leave Type Define";
}

