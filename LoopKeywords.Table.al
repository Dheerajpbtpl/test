Table 50202 "Loop Keywords"
{

    fields
    {
        field(1; Keywords; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Loop Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Loop Master"."Loop code";
        }
    }

    keys
    {
        key(Key1; Keywords, "Loop Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Keywords, "Loop Code")
        {
        }
    }
}

