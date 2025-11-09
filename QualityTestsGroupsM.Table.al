Table 50081 "Quality Tests Groups M"
{

    fields
    {
        field(2; "Test Group Code"; Code[20])
        {
            Width = 20;
        }
        field(3; Description; Text[200])
        {
        }
        field(5; "Accept Q.level"; Code[20])
        {
        }
        field(13; "Passed Q. Order Status"; Code[50])
        {
        }
        field(14; "Created By"; Code[100])
        {
        }
        field(15; "Created Date"; DateTime)
        {
        }
        field(16; "Modify By"; Code[100])
        {
        }
        field(17; "Modify Date"; DateTime)
        {
        }
    }

    keys
    {
        key(Key1; "Test Group Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Created By" := UserId;
        "Created Date" := CurrentDatetime;
    end;

    trigger OnModify()
    begin
        "Modify By" := UserId;
        "Modify Date" := CurrentDatetime;
    end;
}

