Table 50077 "Employee Group"
{
    DrillDownPageID = "Attendence Type";
    LookupPageID = "Attendence Type";

    fields
    {
        field(1; "Code"; Code[10])
        {
        }
        field(2; Description; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

