Table 50013 "Contact Mail Ledger Entry"
{

    fields
    {
        field(1; "Entry No."; Integer)
        {
        }
        field(2; "Contact No."; Code[20])
        {
        }
        field(3; "Contact Name"; Text[50])
        {
        }
        field(4; "E-mail"; Text[100])
        {
        }
        field(5; Subject; Text[250])
        {
        }
        field(6; "Sent By"; Text[30])
        {
        }
        field(7; Date; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

