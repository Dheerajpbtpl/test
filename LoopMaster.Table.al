Table 50200 "Loop Master"
{

    fields
    {
        field(1; "Loop code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Loop Details"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Loop Subject"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Loop products"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Loop Product master"."Product code";
        }
    }

    keys
    {
        key(Key1; "Loop code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Loop code", "Loop Details", "Loop Subject", "Loop products")
        {
        }
    }
}

