Table 50201 "Loop Product master"
{

    fields
    {
        field(1; "Product code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Product Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Loop Master"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Loop Master"."Loop code";
        }
    }

    keys
    {
        key(Key1; "Product code", "Loop Master")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Product code", "Product Name", "Loop Master")
        {
        }
    }
}

