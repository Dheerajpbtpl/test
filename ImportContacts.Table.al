Table 50014 "Import Contacts"
{

    fields
    {
        field(1; Name; Text[50])
        {
        }
        field(2; Address; Text[250])
        {
        }
        field(3; "Address 2"; Text[250])
        {
        }
        field(4; "Post Code"; Text[10])
        {
        }
        field(5; City; Text[30])
        {
        }
        field(6; Country; Text[10])
        {
        }
        field(7; "Mobile No."; Text[250])
        {
        }
        field(8; "Salesperson Code"; Code[10])
        {
            TableRelation = "Salesperson/Purchaser";
        }
        field(9; "Contact Group"; Code[20])
        {
            TableRelation = "Contacts Group";
        }
        field(10; Email; Text[250])
        {
        }
        field(11; Imported; Boolean)
        {
        }
        field(12; "Company Name"; Text[100])
        {
        }
        field(20; "Entry No."; Integer)
        {
            AutoIncrement = true;
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

