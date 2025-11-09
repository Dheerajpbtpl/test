Table 50067 "Attendance Import-att"
{
    Caption = 'Attendance Import';
    DrillDownPageID = "Leave Details List";
    LookupPageID = "Leave Details List";

    fields
    {
        field(1; "Attendance Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Employee Id"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Employee Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; shift; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "shift Start Time"; Code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "In-Time"; Time)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                timeduration := "Out-Time" - "In-Time";
                if timeduration <> 0 then
                    TotalHrs := ((timeduration / 1000) / 60) / 60;
            end;
        }
        field(7; "Out-Time"; Time)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                timeduration := "Out-Time" - "In-Time";
                if timeduration <> 0 then
                    TotalHrs := ((timeduration / 1000) / 60) / 60;
            end;
        }
        field(8; TotalHrs; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Total Punch"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(10; Department; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(11; Designation; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Card No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(20; Deduct; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Basic Deduct"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "HRA Deduct"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Conv Deduct"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Medical Deduct"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Others Deduct"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(26; Weekday; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(27; Weekdayname; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Sunday,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday';
            OptionMembers = Sunday,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday;
        }
        field(28; "Variable Deduct"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Over Time Hrs"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Card No.", "Employee Id", "Attendance Date", "In-Time", "Out-Time")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        timeduration: Duration;
}

