Table 50070 "Quality Test Instruments M"
{

    fields
    {
        field(1; TestInstrument; Code[20])
        {
        }
        field(2; "Test Area"; Code[30])
        {
            TableRelation = Location.Code;
        }
        field(3; Description; Text[200])
        {
        }
        field(4; "Unit of Measure"; Code[10])
        {
            TableRelation = "Unit of Measure".Code;
        }
        field(6; "Created Date"; DateTime)
        {

            trigger OnValidate()
            begin
                //"Created Date":= CURRENTDATETIME();
            end;
        }
        field(7; "Modify Date"; DateTime)
        {
        }
        field(8; "Created By"; Code[100])
        {
        }
        field(9; "Modify By"; Code[100])
        {
        }
    }

    keys
    {
        key(Key1; TestInstrument)
        {
            Clustered = true;
        }
        key(Key2; "Unit of Measure")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; TestInstrument, "Unit of Measure")
        {
        }
        fieldgroup(Brick; "Unit of Measure")
        {
        }
    }

    trigger OnInsert()
    begin
        "Created Date" := CurrentDatetime;
        "Created By" := UserId;
    end;

    trigger OnModify()
    begin
        "Modify Date" := CurrentDatetime;
        "Modify By" := UserId;
    end;
}

