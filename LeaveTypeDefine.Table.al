Table 50064 "Leave Type Define"
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
            TableRelation = "Leave Type-PBTPL".ID where(ID = field("Leave Type"));
        }
        field(20; "Leave Allow Days"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Employee Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(22; Division; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(23; "Balance Leave"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Taken Leave"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Employee No.", "Leave Type")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        EmployeeMaster: Record "Employee Master";
}

